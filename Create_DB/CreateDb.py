#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function
import os
import io
import configparser
from yandex_translate import YandexTranslate, YandexTranslateException
import mysql.connector
from mysql.connector import errorcode
import re


def debug_print(*vargs, **kwargs):
   if debug_mode:
      print(file=debug_log, *vargs, **kwargs)
      debug_log.flush()


def create_dir(path):
   try:
      os.makedirs(path)
   except OSError:
      if not os.path.isdir(path):
         raise


def str_difference(str1, str2):
   diff = abs(len(str1) - len(str2))
   new_str = ""
   for a, b in zip(str1, str2):
      if a != b:
         diff += 1
      elif str.isalpha(a.encode('utf-8')):
         new_str += a
   return diff, new_str


def ConfigGetDict(config, section):
   dict1 = {}
   options = config.options(section)
   for option in options:
      try:
         opt_str = config.get(section, option)
         if ',' in opt_str:
            opt_str = [e.strip() for e in opt_str.split(',')]
         dict1[option] = opt_str
      except:
         dict1[option] = None
   return dict1


def Ya_Trans(language, list):
   res = []
   global ya_key_num, translate, keys_finished
   while ya_key_num < len(yandex_keys):
      try:
         debug_print('try')
         res = translate.translate(list, language)['text']
         break
      except YandexTranslateException as err:
         debug_print(err)
         if err.message in ["ERR_DAILY_CHAR_LIMIT_EXCEEDED", "ERR_BAD_GATEWAY", "ERR_KEY_INVALID", "ERR_KEY_BLOCKED", "ERR_DAILY_REQ_LIMIT_EXCEEDED"]:
            ya_key_num += 1
            if ya_key_num < len(yandex_keys):
               debug_print(yandex_keys[ya_key_num])
               translate = YandexTranslate(yandex_keys[ya_key_num])
         else:
            raise(err)
   if ya_key_num >= len(yandex_keys):
      keys_finished = True
   return res


def Translate(language, list, limit, method):
   length = 0
   last_trans_id = 0
   temp = []
   result = []
   total_l = len(list)
   for i, t in enumerate(list):
      length += len(t)
      if length > limit:
         temp = list[:i - last_trans_id]
         list = list[i - last_trans_id:]
         temp_res = []
         if method == 'yandex':
            temp_res = Ya_Trans(language, temp)
         if keys_finished:
            break
         result += temp_res
         length = len(t)
         debug_print(i, "|", total_l)
         last_trans_id = i
   if len(list) > 0 and not keys_finished:
      result += Ya_Trans(language, list)
   return result


def prepare_str(text, tab, strlower=False):
   text = text.encode('utf8')
   first_time_replaces = [
       [r'\\"', r'"'],   # RequestItemsText Bug Некоторые считают, что у меня параноя, а я вот отвечу: \"Бди! Вирус не дремлет!\"
   ]
   replaces_for_key = [
       [r'"', r'\"'],
       ["\$[nN]", '"..st_n.."', "mangos_string", "%s"],
       ["\$[cC]", '"..st_c.."'],
       ["\$[rR]", '"..st_r.."'],
       ["\$[bB]", r'\n'],
       [r'[\r\n]+', " "],
       ["\$[gG]\s*(.+?)\s*:\s*(.+?)\s*[;,]", r'"..ST_G("\1", "\2").."'],
       ["\s+$", ""],
       ["^\s+", ""],
       [r'(\s)\1+', r' '],
   ]
   replaces_for_value = [
       [r'"', r'\"'],
       ["\$[nN]", '"..ST_N.."', "mangos_string", "%s"],
       ["\$[cC]", '"..ST_C.."'],
       ["\$[rR]", '"..ST_R.."'],
       ["\$[bB]", r'\\n'],
       [r'[\r\n]+', ""],
       ["\$[gG]\s*(.+?)\s*:\s*(.+?)\s*[;,]", r'"..ST_G("\1", "\2").."']
   ]

   replaces = replaces_for_value

   if strlower:
      text = str.lower(text)
      replaces = replaces_for_key
   for d in first_time_replaces:
      text = re.sub(d[0], d[1], text)
   for d in replaces:
      if len(d) > 2 and d[2] == tab:
         text = re.sub(d[0], d[3], text)
      text = re.sub(d[0], d[1], text)
   return text.decode('utf8')


def prepare_for_trans(data):
   find_expr = [
       "(\$[nN])",
       "(\$[cC])",
       "(\$[rR])",
       "(\$[bB])",
       "(\$[gG])",
       "(\$\d+w)",
       "(\$)"
   ]
   pattern = '|'.join(find_expr)
   restore = []
   new_list = []
   for text in data:
      r = re.findall(pattern, text)
      r = [item for t in r for item in filter(lambda x: x != '', t)]
      r = iter(r)
      restore.append(r)
      new_list.append(re.sub(pattern, "<<<>>>", text))
   return new_list, restore


def delete_words_from_text(text):
   replaces = [
       ["_content_default", ""],
       ["_template", ""],
       ["text_text", "text"],
   ]
   for d in replaces:
      text = re.sub(d[0], d[1], text)
   return text


def record_is_correct(key, value):
   key = key.encode('utf8')
   value = value.encode('utf8')
   forbidden = {
       "<HTML>",
   }
   for f in forbidden:
      if re.search(f, key) or re.search(f, value):
         return False
   return True


def restore_after_trans(data, restore):
   result = []
   for i, text in enumerate(data):
      result.append(re.sub("<<<>>>", lambda x: next(restore[i]), text))
   return result


def PrepareMangosTables():
   table_list = ConfigGetDict(config, 'tables')
   for k, v in table_list.items():
      if '|' in v:
         i = v.index('|')
         table_list[k] = {'id': v[:i], 'cols': v[i + 1:]}
      else:
         table_list[k] = {'id': [], 'cols': v}
   return table_list


def PrepareLocaleTables(locale):
   table_list = ConfigGetDict(config, locale)
   loc_col_text = ''
   if 'locale' in table_list:
      loc_col_text = table_list['locale']
      del table_list['locale']
   return table_list, loc_col_text


def create_locale_tables(locale, loc_col_text, from_table='', cols=[], id='', new_names=[]):
   if not isinstance(cols, (list, tuple)):
      cols = [cols]
   if not isinstance(new_names, (list, tuple)):
      new_names = [cols]
   if isinstance(id, (list, tuple)):
      temp_id = ', '.join(id)
   t1 = servtr_db + '.' + from_table
   for i, c in enumerate(cols):
      if i < len(new_names):
         t2 = servtr_db + '.' + locale + from_table + '_' + new_names[i]
      else:
         t2 = servtr_db + '.' + locale + from_table + '_' + c
      all_cols = temp_id + ' , ' + c
      cmd = "create table {0} as select {1}, {2} from {3} where {4} is not null and {4} <> '' group by {4}".format(t2, all_cols, c + ' as ' + c + loc_col_text, t1, c)
      debug_print('create_locale_tables:', cmd)
      try:
         cursor.execute(cmd)
      except mysql.connector.Error as err:
         if err.errno == errorcode.ER_TABLE_EXISTS_ERROR:
            t_id = id
            if not isinstance(t_id, (list, tuple)):
               t_id = [t_id]
            t_id = ', '.join(['t1' + '.' + x for x in t_id])
            all_cols = t_id + ' , t1.' + c + ' , t2.' + c + loc_col_text
            cmd = "drop temporary table if exists {}".format(servtr_db + '.temp')
            debug_print('create_locale_tables:', cmd)
            cursor.execute(cmd)
            cmd = """create temporary table {} as select {}
            from {} as t1 left join {} as t2
            using({}) group by {}""".format(servtr_db + '.temp', all_cols, t1, t2, temp_id, c)
            debug_print('create_locale_tables:', cmd)
            cursor.execute(cmd)
            cmd = "update {0} set {1} = '' where {1} is NULL".format(servtr_db + '.temp', c + loc_col_text)
            debug_print('create_locale_tables:', cmd)
            cursor.execute(cmd)
            cmd = "TRUNCATE {}".format(t2)
            debug_print('create_locale_tables:', cmd)
            cursor.execute(cmd)
            cmd = "INSERT INTO {} SELECT * FROM {}".format(t2, servtr_db + '.temp')
            debug_print('create_locale_tables:', cmd)
            cursor.execute(cmd)
      cmd = "update {0} set {1} = ' ' where {1} = {2};".format(t2, c + loc_col_text, c)
      debug_print(cmd)
      cursor.execute(cmd)


def fill_locale_tables(locale, loc_col_text, from_table, into_table, cols=[], id='', new_names=[], new_id='', new_loc_name=''):
   if not isinstance(cols, (list, tuple)):
      cols = [cols]
   if not isinstance(new_names, (list, tuple)):
      new_names = [cols]
   if isinstance(id, (list, tuple)):
      temp_id = ', '.join(id)
   if isinstance(new_id, (list, tuple)):
      new_id = [item for item in filter(lambda x: x != '', new_id)]
      if len(new_id) == 0:
         new_id = ''
   t1 = mangos_db + '.' + from_table
   for i, c in enumerate(cols):
      if i < len(new_names):
         t2 = servtr_db + '.' + locale + from_table + '_' + new_names[i]
      else:
         t2 = servtr_db + '.' + locale + into_table + '_' + c
      debug_print(locale, loc_col_text, t1, t2)
      t_id = id
      if not isinstance(t_id, (list, tuple)):
         t_id = [t_id]
      t_id = ', '.join(['t2' + '.' + x for x in t_id])
      from_loc_text = c + loc_col_text
      if new_loc_name != '':
         from_loc_text = new_loc_name + loc_col_text
      all_cols = t_id + ' , t2.' + c + ' , t1.' + from_loc_text
      if not isinstance(new_id, (list, tuple)):
         gen_id = 'using(' + temp_id + ')'
      else:
         debug_print("i:", i, " new_id:", new_id)
         gen_id = 'ON ' + ' AND '.join(['t1.' + new_id[i] + '=' + 't2.' + p for i, p in enumerate(id)])
      cmd = "drop temporary table if exists {}".format(servtr_db + '.temp')
      debug_print('fill_locale_tables:', cmd)
      cursor.execute(cmd)
      cmd = """create temporary table {0} as select {1}
      from {2} as t2 left join {3} as t1
      {4} where t2.{5} is not null and t2.{5} <> '' group by t2.{5}""".format(servtr_db + '.temp', all_cols, t2, t1, gen_id, c)
      debug_print('fill_locale_tables:', cmd)
      cursor.execute(cmd)
      cmd = "update {0} set {1} = '' where {1} is NULL".format(servtr_db + '.temp', from_loc_text)
      debug_print('fill_locale_tables:', cmd)
      cursor.execute(cmd)
      cmd = "TRUNCATE {}".format(t2)
      debug_print('fill_locale_tables:', cmd)
      cursor.execute(cmd)
      cmd = "INSERT INTO {} SELECT * FROM {}".format(t2, servtr_db + '.temp')
      debug_print('fill_locale_tables:', cmd)
      cursor.execute(cmd)
   pass


def auto_translate_tables(language, locale, loc_col_text, from_table='', cols=[], id='', new_names=[]):
   if not isinstance(cols, (list, tuple)):
      cols = [cols]
   if not isinstance(new_names, (list, tuple)):
      new_names = [cols]
   if isinstance(id, (list, tuple)):
      temp_id = ', '.join(id)
   t_id = id
   arg_str = '(' + temp_id + ') = (' + ', '.join('%s' for i in t_id) + ')'
   if not isinstance(t_id, (list, tuple)):
      t_id = [t_id]
   for i, c in enumerate(cols):
      if i < len(new_names):
         t2 = servtr_db + '.' + locale + from_table + '_' + new_names[i]
      else:
         t2 = servtr_db + '.' + locale + from_table + '_' + c
      all_cols = temp_id + ' , ' + c
      cmd = "select {0} from {1} where ({2} is not NULL and {2} <> '') and ({3} = '' or {3} is NULL)".format(all_cols, t2, c, c + loc_col_text)
      debug_print('auto_translate_tables:', cmd)
      cursor.execute(cmd)
      data = [list(k) for k in cursor.fetchall()]
      debug_print("DATA", data, "\n")
      if len(data) > 0:
         translate_data = [t.pop(-1) for t in data]
         translate_data, restore = prepare_for_trans(translate_data)
         translate_data = Translate(language, translate_data, 10000, 'yandex')
         translate_data = restore_after_trans(translate_data, restore)
         if keys_finished:
            data = data[:len(translate_data)]
            # debug_print("TRANS_DATA", translate_data, '\n')
            # data = [[' AND '.join([t_id[i] + ' = ' + str(id) for i, id in enumerate(t)])] for t in data]
            # debug_print("NEW_DATA", data, '\n')
         insert_data = [tuple([translate_data[i]] + t) for i, t in enumerate(data)]
         debug_print("INSERT_DATA", insert_data, '\n')
         if len(insert_data) > 0:
            cmd = "update {} set {} = %s where {}".format(t2, c + loc_col_text, arg_str)
            debug_print("INSERT", cmd, '\n')
            try:
               cursor.executemany(cmd, insert_data)
               debug_print(cursor.rowcount)
            except mysql.connector.Error as err:
               print(err)
               print(cursor.statement)
      cnx.commit()
      if keys_finished:
         raise(YandexTranslateException("502"))


def lua_load_table(path, xml_path_file, locale, loc_col_text, from_table='', cols=[], id='', new_names=[]):
   if not isinstance(cols, (list, tuple)):
      cols = [cols]
   if not isinstance(new_names, (list, tuple)):
      new_names = [cols]
   t_id = id
   if not isinstance(t_id, (list, tuple)):
      t_id = [t_id]
   diff_prev = False
   diff_next = False
   cur_file = False
   for i, c in enumerate(cols):
      if i < len(new_names):
         t2 = servtr_db + '.' + locale + from_table + '_' + new_names[i]
      else:
         t2 = servtr_db + '.' + locale + from_table + '_' + c
      cur_path = path
      open_mode = 'w'
      cur_file_name = c
      lua_table_name = from_table
      if len(cols) > 1:
         lua_table_name = from_table + '_' + c
         if i + 1 < len(cols) and str_difference(c, cols[i + 1])[0] <= 2:
            diff_next = str_difference(c, cols[i + 1])[1]
            cur_file_name = diff_next
            lua_table_name = from_table + '_' + cur_file_name
         if i > 0 and str_difference(c, cols[i - 1])[0] <= 2:
            diff_prev = str_difference(c, cols[i - 1])[1]
            open_mode = 'a'
            cur_file_name = diff_prev
            lua_table_name = from_table + '_' + cur_file_name
         cur_path += '/' + from_table
         create_dir(cur_path)
         xml_include = """ <Include file="{}\{}.lua"/>""".format(from_table, cur_file_name)

      else:
         cur_path = path
         cur_file_name = from_table
         xml_include = """ <Include file="{}.lua"/>""".format(cur_file_name)
      lua_table_name = delete_words_from_text(lua_table_name)
      if not diff_prev:
         print(xml_include, file=xml_path_file)
      if not diff_prev:
         cur_file = io.open(cur_path + '/' + cur_file_name + '.lua', open_mode, encoding="utf-8")
         print(locale + '_' + lua_table_name + " = {", file=cur_file)
      cmd = "SELECT {0}, {1} from {2} where {0} is not NULL and {0} <> '' and {1} is not NULL and {1} <> ''".format(c, c + loc_col_text, t2)
      # debug_print('auto_translate_tables:', cmd)
      cursor.execute(cmd)
      data = [list(k) for k in cursor.fetchall()]
      # debug_print("DATA", data, '\n\n\n')
      for (orig_t, locale_t) in data:
         if not record_is_correct(orig_t, locale_t):
            continue
         orig_t = prepare_str(orig_t, from_table, strlower=True)
         locale_t = prepare_str(locale_t, from_table)
         result = u"\t[\"" + orig_t + u"\"] = \"" + locale_t + u"\",\n"
         cur_file.write(result)
      if not diff_next:
         print(u"}\n", file=cur_file)
         cur_file.close()
      diff_prev = False
      diff_next = False


def copy_table_from_mangos(from_table, cols=[], id='', new_name=''):
   if new_name == '':
      new_name = from_table
   from_table = mangos_db + '.' + from_table
   new_name = servtr_db + '.' + new_name
   all_cols = cols
   if isinstance(id, (list, tuple)):
      id = ', '.join(id)
   if isinstance(cols, (list, tuple)):
      all_cols = ', '.join(cols)
   if id != '':
      all_cols = id + ', ' + all_cols
   cmd = "drop table if exists {}".format(new_name)
   debug_print('copy_table_from_mangos:', cmd)
   cursor.execute(cmd)
   cmd = "create table {} as select {} from {}".format(new_name, all_cols, from_table)
   debug_print('copy_table_from_mangos:', cmd)
   cursor.execute(cmd)


def copy_tables():
   for k, v in table_list.items():
      copy_table_from_mangos(k, v['cols'], v['id'])


def create_locale_db(locale, loc_col_text=''):
   for k, v in table_list.items():
      create_locale_tables(locale, loc_col_text, k, v['cols'], v['id'])


def fill_locale_db(locale, loc_col_text=''):
   from_table, loc_col_text = PrepareLocaleTables(locale)
   for k, v in table_list.items():
      cur_from_table = from_table[k]
      new_id = ''
      new_name = ''
      if '|' in cur_from_table:
         i = cur_from_table.index('|')
         new_name = cur_from_table[i + 1:][0]
         cur_from_table = cur_from_table[:i]
      if isinstance(cur_from_table, (list, tuple)):
         if len(cur_from_table) > 1:
            new_id = cur_from_table[1:]
         cur_from_table = cur_from_table[0]
      fill_locale_tables(locale, loc_col_text, cur_from_table, k, v['cols'], v['id'], new_id=new_id, new_loc_name=new_name)


def auto_translate_db(language, locale, loc_col_text=''):
   for k, v in table_list.items():
      auto_translate_tables(language, locale, loc_col_text, k, v['cols'], v['id'])


def lua_load(locale, loc_col_text=''):
   path = config.get('options', 'addon_path') or ''
   path += '/Databases'
   create_dir(path)
   path += '/' + locale
   create_dir(path)
   xml_path_file = open(path + '/' + locale + '.xml', 'w')
   xml_start = """<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/
..\\FrameXML\\UI.xsd">\n"""
   print(xml_start, file=xml_path_file)
   xml_path_file.flush()
   for k, v in table_list.items():
      lua_load_table(path, xml_path_file, locale, loc_col_text, k, v['cols'], v['id'])
   print("</Ui>", file=xml_path_file)
   xml_path_file.close()


debug_log = open('log.txt', 'w')
debug_mode = True

config = configparser.ConfigParser()
config.read("Config.txt")

connector_data = ConfigGetDict(config, 'connector_python')
mangos_db = config.get('options', 'mangos_db')
servtr_db = config.get('options', 'generate_db')
table_list = PrepareMangosTables()
ya_key_num = 0
keys_finished = False
yandex_keys = [e.strip() for e in config.get('keys', 'yandex_key').split(',')]
translate = YandexTranslate(yandex_keys[ya_key_num])

cnx = mysql.connector.connect(**connector_data)
cursor = cnx.cursor(buffered=True)
cursor.execute("CREATE DATABASE IF NOT EXISTS {}".format(servtr_db))
# copy_tables()
# create_locale_db('ruRU', '_loc8')
# fill_locale_db('ruRU')
# auto_translate_db('en-ru', 'ruRU', '_loc8')
lua_load('ruRU', '_loc8')
# str = """..ST_G("brother ", "sister").." "..ST_N.." - your deeds on behalf of the argent dawn are far too numerous to be recounted easily.  as a fitting tribute, i'll part with one of our special chromatic mantles of the dawn - a version that protects the wearer from all forms of resistible magic simultaneously.  chromatic mantles of the dawn are reserved for only the mightiest of the dawn's heroes!\n\nbring to me twenty-five valor tokens as a sign of tribute, and i'll give you the finest of all our mantles."""
# a = Translate('en-ru', [str], 10000, 'yandex')
# print(a[0].encode('utf8'))
cnx.commit()
cnx.close()
debug_log.close()
