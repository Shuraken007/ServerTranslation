local _G = getfenv()

--[[For automation translate  convert Global strings like
ABANDON_QUEST_CONFIRM = [=[Cancel quest \"%s\"?]=]
to					  [=[Cancel quest \"(.+))\"%?]=]
for using in string.find

examples and syntax of pattern list:
{HELLO = {COLOR = {ITEM_LINK = {BONUS = {"item_db", generate = "....."}}}}}
{TEST = {split_func = {def_temp1 = {}, def_temp2 = {}}}}

k:				[pattern|gs|func] = {v1, v2, ...}
func should take first param: true = extract mode, false = generate mode
vi:			[k|generate_pattern|default_db|db]
generate_pattern: generate = [string|global_string]
default_db:	  default_dbi = {db = {db1, db2, ....}, cells = {2, 3, 5}}
db:			  [string|array of strings]
]]--

local gs_gsub_data = {
	one = {
		['('] = '%(',
		[')'] = '%)',
		['['] = '%[',
		[']'] = '%]',
		['-'] = '%-',
		['?'] = '%?',
		['+'] = '%+',
		['*'] = '%*',
		['%'] = '%%',
		['.'] = '%.',
	},
	two = {
		['%%s'] = '(.+)',
		['%%d'] = '(%d+)',
		['%%c'] = '(%c+)',
		['%%x'] = '(%x)',
	},
}

ServTr.Patternator = {
	-- Pattern is string, prepared for string.find(str, pattern) call - so it must have smth like (.+), (%x+)
	IsPattern = function(self, pattern)
		if string.find(pattern, '%([%%%.].+%)') then
			return true
		end
		return nil
	end,

	-- Global String (GS) are strings, stored in client(also created in addon),
	-- looks like "%s killed somebody", should be converted to Patterns
	-- may include order of arguments (it may change in result generating message)
	GsToPattern = function(self, gs)
		local order = {}
		local pattern = gs
		--first catch order like %3$s or %8$d
		pattern = string.gsub(pattern, '(%%)(%d$)([sd])', function (a,b,c) order[getn(order)+1] = tonumber(strsub(b,1,1)) return a..c end)
		--second replace spec simbols like (;[;+;-;];) and other with % before them
		pattern = string.gsub(pattern, '(.)',  function(w) return gs_gsub_data.one[w] or w end)
		--replace places like %%s to (%s)
		pattern = string.gsub(pattern, '(%%%%.)',  function(w) return gs_gsub_data.two[w] or w end)
		--spetial parce for repeatable simbols like (%x){6} in color strings (I want '(%x%x%x%x%x%x)', not '(%x)(%x)(%x)(%x)(%x)(%x)'
		pattern = string.gsub(pattern, '%((.-)%){(%d+)}', function(w, time) return '('..string.rep(w, time)..')' end)
		return pattern, order
	end,

	-- Return array of extracted data
	PatternExtractData = function(self, str, pattern, order)
		-- Printd(str, pattern)
		local data, new_data
		if not str then return end
		if string.find(str, pattern) then
			data = {string.find(str, pattern)}
			--first 2 value are pointers where pattern was founded
			if data[1] then table.remove(data, 1) end
			if data[1] then table.remove(data, 1) end

			if order and getn(order) > 0 then
				new_data = {}
				for i = 1, getn(order) do
					new_data[order[i]] = data[i]
				end
			end
		end
		return new_data or data
	end,

	-- Same, as PatternExtractData, but convert GS -> pattern
	GsExtractData = function(self, str, gs)
		local pattern, order = self:GsToPattern(gs)
		return self:PatternExtractData(str, pattern, order)
	end,

	--convert %smth -> smth
	PatternPrepareForInsert = function(self, pattern)
		pattern = string.gsub(pattern, '%%([^acdglpsuwx])',  function(w) return w end)
		return pattern
	end,

	--insert data in correct order
	PatternInsertData = function(self, data, pattern, order)
		pattern = self:PatternPrepareForInsert(pattern)
		local new_data

		if order and getn(order) > 0 then
			new_data = {}
			for _, d in ipairs(order) do
				new_data[getn(new_data)+1] = data[d]
			end
			data = new_data
		end
		local result = gsub(pattern, '(%([%%.].-%))', function(w) return tremove(data, 1) end)

		return  result
	end,

	--sames as PatternInsertData
	GsInsertData = function(self, data, gs)
		local pattern, order = self:GsToPattern(gs, true)
		return  self:PatternInsertData(data, pattern, order)
	end,

	--common function to extract data, where
	--k = function ... return extract_data | GS | Pattern
	ExtractDataOnParse = function(self, k, str)
		local data_for_translate
		local key = _G[k] or k
		--key is function
		if type(key) == 'function' then
			data_for_translate = key(true, str)
		--key is global string
		elseif type(key) == 'string' and not self:IsPattern(k) then
			data_for_translate = self:GsExtractData(str, key)
		elseif type(key) == 'string' then
			data_for_translate = self:PatternExtractData(str, key)
		end

		return data_for_translate
	end,

	--common function to insert data
	InsertDataOnParse = function(self, k, data_for_translate)
		if not data_for_translate then
			return nil
		end
		local generate_message
		local key = _G[k] or k
		--key is function
		if type(key) == 'function' then
			generate_message = key(false, data_for_translate)
		--key is global string
		elseif type(key) == 'string' and not self:IsPattern(k) then
			generate_message = self:GsInsertData(data_for_translate, key)
		elseif type(key) == 'string' then
			generate_message = self:PatternInsertData(data_for_translate, key)
		end
		return generate_message
	end,
}

ServTr.Translator = {
	Constructor = function(self, method, object)
		self.method = method
		self.object = object
	end,

	Destructor = function(self)
		self.method = nil
		self.object = nil
		self.unti_stuck_specdb = nil
	end,

	Translate = function(self, text, data, method, object)
		if ServTr.db.profile.ImaginaryModeOff then return nil end
		self:Constructor(method, object)
		local dataI = ServTr:GetTableI(data) --integer part of table
		local result
		if dataI then
			result = self:GetText(text, dataI)
		end
		if not result then
			result = self:Main(text, data)
		end
		self:Destructor()
		return result
	end,

	Main = function(self, text, data, name_text)
		if type(data) == 'string' or ServTr:IsTableI(data) then
			return self:GetText(text, data)
		end
		for k, v in pairs(data) do
			if type(v) == 'string' then
				v = {v}
			end
			-- I extract data
			local data_for_translate = ServTr.Patternator:ExtractDataOnParse(k, text)
			if data_for_translate then
				--II process value table
				local saved_data = data_for_translate
				data_for_translate = self:ProcessDataOnParse(v, data_for_translate)
				if not data_for_translate and v.allowed_nil_translate then
					data_for_translate = saved_data
				end
				if name_text then
					data_for_translate = self:RestoreUpCase(data_for_translate, name_text)
				end
				--III build result message
				local generate_info = k
				if v.generate_pattern then
					generate_info = v.generate_pattern
				end
				-- self:PrintTab({gen = generate_info, data = data_for_translate})
				local result = ServTr.Patternator:InsertDataOnParse(generate_info, data_for_translate)

				if result then return result end
			end
		end
	end,

	ProcessDataOnParse = function(self, v, data_for_translate)
		local default_db_counter = 0
		local db_list = {}

		if type(v) == 'string' then
			v = {v}
		end

		for v_k, v_v in pairs(v) do
			if type(v_k) == 'string' then
				if string.find(v_k, 'default_db1.') then
					default_db_counter = default_db_counter + 1
				end
			elseif type(v_k) == 'number' then
				if type(v_v) == 'string' then
					db_list[v_k] = v_v
				elseif type(v_v) == 'table' then
					if v_v.all then
						v_v.all = nil
						for i = 1, getn(data_for_translate) do
							if not v[i] then
								v[i] = {}
								ServTr:CopyTable(v[i], v_v)
							end
						end
					end
					--first let's check not hash part of table(numeric), and check recurse field in false case
					local test_list = {}
					local recurse
					for k, v in pairs(v_v) do
						if type(k) == 'number' then
							test_list[k] = v
						else
							recurse = true
						end
					end

					db_list[v_k] = {}
					ServTr:CopyTable(db_list[v_k], test_list)
					db_list[v_k].recurse = recurse
				end
			end
		end

		for i = 1, default_db_counter do
			self:FillByDefaults(db_list, v['default_db'..i])
		end

		return self:FillTranslateData(db_list, data_for_translate, v)
	end,

	FillTranslateData = function(self, db_list, data_for_translate, orig_tab)
		local success_flag = false
		local translate
		for db_k, db_v in pairs(db_list) do
			local recurse
			if type(db_v) == 'table' and db_v.recurse then
				recurse = true
				db_v.recurse = nil
			end
			translate = self:GetText(data_for_translate[db_k], db_v)
			if translate then
				data_for_translate[db_k] = translate
				success_flag = true
			elseif recurse then
				translate = self:Main(data_for_translate[db_k], orig_tab[db_k])
				if translate then
					data_for_translate[db_k] = translate
					success_flag = true
				end
			end
		end

		if not success_flag then
			data_for_translate = nil
		end

		return data_for_translate
	end,

	GetText = function(self, text, db_list)
		if not text or not db_list then return nil end

		if type(db_list) == 'string' then
			db_list = {db_list}
		end

		for k, v in pairs(db_list) do
			db = self:CheckFuncDb(v)
			if db then
				local res
				res = self:DbRequest(self:FormatStr(text), v)
				if res then
					return res
				end
			end
		end
		return nil
	end,

	DbRequest = function(self, text, db_name)
		local ltext = strlower(text)
		local db = _G[ServTr.db.profile.language..'_'..db_name]
		local spec = _G[ServTr.db.profile.language..'_'..db_name..'_spec']
		local temp_db = {}
		if db[ltext] then
			return self:ParseDbSpec(db[ltext])
		elseif spec and not self.unti_stuck_specdb then
		--first step - solving dynamic target problem
			for k, v in pairs(spec.dt) do
				new_k, new_v = self:ParseDbSpec(k, true), self:ParseDbSpec(v)
				temp_db[new_k] = new_v
			end
			if temp_db[ltext] then
				return temp_db[ltext]
			else
			--second step - solving names of players/creatures
				self.unti_stuck_specdb = true
				local result = self:Main(ltext, spec.dn, text)
				self.unti_stuck_specdb = nil
				if result then
					return result
				end
			end
		end
		return nil
	end,

	CheckFuncDb = function(self, db)
		method, object = self.method, self.object
		--if this db is false in addon save then go away
		local db_option = ServTr.db.profile.translation
		if object then
			db_option = ServTr.db.profile.translation.objects[object]
		end
		if (method and db_option[method] and not db_option[method][db]) or not ServTr.db.profile.db[db] then
			return nil
		end
		db = _G[ServTr.db.profile.language..'_'..db]
		return db
	end,

	FormatStr = function(self, str)
		if not str then return nil end
		-- delete spaces before and after text
		str = gsub(gsub(str, '%s+$', ''), '^%s+', '')
		-- delete duplicated spaces
		str = gsub(str, '%s+', ' ')
		return str
	end,

	--fill data using default templates
	FillByDefaults = function(self, list, def_temp)
		local ar
		for _, v in ipairs(def_temp.cells) do
			ar = list[v]
			if not ar then
				ar = def_temp.db
			else
				if type(ar) ~= 'table' then
					ar = {ar}
				end
				for _, db_v in pairs(def_temp.db) do
					ar[getn(ar)+1] = db_v
				end
			end
		end
	end,

	RestoreUpCase = function(self, data_for_translate, data)
		for k, v in pairs(data_for_translate) do
			local s, f = string.find(strlower(data), v)
			if s then
				data_for_translate[k] = strsub(data, s, f)
			end
		end
		return data_for_translate
	end,

	ParseDbSpec = function(self, text, downcase)
		local dt = '$dt:(.*):(.*);'

		if string.find(text, dt) then
			text = self:ReplaceDynamicF(text, dt, {UnitSex, 'target', args = {[2] = 1, [3] = 2}})
		end

		return text
	end,

  EvalReplace = function(self, tab, args)
	local result
	if type(tab) == 'string' then
		result = tab
	elseif type(tab) == 'table' and getn(tab) > 0 then
		local temp = {}
		for i = 2, getn(tab) do
		if type(tab[i]) == 'table' then
			tab[i] = self:EvalReplace(tab[i])
		end
		table.insert(temp, tab[i])
		end
		result = tab[1](unpack(temp))
	end
	if args and tab.args then
		result = args[tab.args[result]]
	end
	return result
  end,

  ReplaceDynamicF = function(self, str, key, value)
	result = gsub(str, key,
		function(...)
			local arg={}
			local t={}
			for i=1, #arg do
				table.insert(t,arg[i])
			end
			if getn(t) == 1 then
				t = nil
			end
			return self:EvalReplace(value, t)
		end)
	return result
  end,
}

function Test()
	local list, str
	--TEST_PATTERN and test_func should be global
	TEST_PATTERN = "%s ударил %s, задев %s, использовав %s и %s."
	TEST_GENERATE_PATTERN = "%s вмазал %s, заехав по %s, достав из-за спины %s и %s."
	test_func = function(mode, text)
		if mode then
			local _, _, x, y = string.find(text, "(.+) ударил (.+), задев")
			return {x, y}
		else
			return text[1].." ударил "..text[2]..", а что дальше хрен знает, потеря инфы, если mode=true то функция возвращает набор данных для перевода из строки, иначе склеивает из массива назад."
		end
	end
	-- str = "Kobold Vermin ударил Forest Spider, задев Harvest Golem, использовав Worn Axe и Worn Mace."

	---->>>тест ключей	  k:				[pattern|gs|func] = {v1, v2, ...}

	-- list = { ["(.+) ударил (.+), задев (.+), использовав (.+) и (.+)."] = {"creature_Name", "creature_Name", "creature_Name", "item_name", "item_name"}}
	-- list = { TEST_PATTERN = {"creature_Name", "creature_Name", "creature_Name", "item_name", "item_name"}}
	-- list = { test_func = {"creature_Name", "creature_Name", "creature_Name", "item_name", "item_name"}}


	---->>>тест значение v_i	vi:			[k|generate_pattern|default_db|db]

	-- db like array
	-- list = { TEST_PATTERN = { {"creature_Name", "item_name", "gameobject"}, "creature_Name", "creature_Name", "item_name", "item_name"} }
	-- base default db that will work for all cells with out field db.cells
	-- list = { TEST_PATTERN = { {"item_name", "creature_Name", all = true} }}
	-- one default_db examp
	-- list = { TEST_PATTERN = {{"creature_Name", all = true}, default_db1 = {db = {"item_name"}, cells = {1, 2, 3, 4, 5}} }}
	-- some default_db examp
	-- list = { TEST_PATTERN = {default_db1 = {db = {"creature_Name"}, chainells = {1, 2, 3}}, default_db2 = {db = {"item_name"}, cells = {4, 5}} }}
	-- generate pattern
	-- list = { TEST_PATTERN = {"creature_Name", "creature_Name", "creature_Name", "item_name", "item_name", generate_pattern = "(.+) вмазал (.+), заехав по (.+), достав из-за спины (.+) и (.+)." }}
	-- list = { TEST_PATTERN = {"creature_Name", "creature_Name", "creature_Name", "item_name", "item_name", generate_pattern = "TEST_GENERATE_PATTERN" }}

	--harder example
	-- str = "Вася выигрывает: \124cff9d9d9d\124Hitem:7073:0:0:0\124h[Tundra Necklace]\124h\124r \124cff818181(Бросок \"Не откажусь\": 90)\124r"
	-- list = {LOOT_ROLL_WON_NO_SPAM_GREED = {nil, nil, nil, nil, nil, nil, nil, "item_name"}}

	--with chain
	-- str = "Вася выигрывает: \124cff9d9d9d\124Hitem:7073:0:0:0\124h[Tundra Necklace с духом толстожопа]\124h\124r \124cff818181(Бросок \"Не откажусь\": 90)\124r"
	-- list = {LOOT_ROLL_WON_NO_SPAM_GREED = {nil, nil, nil, nil, nil, nil, nil, {ITEM_BONUS = {"item_name"}}}}
	-- str = "\124cff9d9d9dKobold Vermin\124r\n\124cff1d1d12Forest Spider\124r"
	-- list = {SplitText = { {COLOR_STR = {nil, "creature_Name"}, all = true}} }
-- str = "Devil's remain: 1/1 (Выполнено)"
-- list = {QUEST_LOG_OBECTIVE_COMPLETE = {ServTr.QUESTLOG_MESSAGE_list}}

	list = {["%s"] = {"creature_Name", COLOR_STR = {nil, "creature_Name"}}}

	str = "\124cff9d9d9dKobold Vermin\124r"
	Printd(str)
	Printd(ServTr.Translator:Translate(str, list, "Test"))
end
