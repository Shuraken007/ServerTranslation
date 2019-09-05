function chsize(char)
   if not char then
      return 0
   elseif char > 240 then
      return 4
   elseif char > 225 then
      return 3
   elseif char > 192 then
      return 2
   else
      return 1
   end
end

old_strlower = strlower

function strlower(str)
   if not str then return nil end
   local t
   str = gsub(str, ".[\128-\191]*",
      function(w)
         t = strlower_hook(w, chsize(strbyte(w)))
         return t or w
      end
   )
   return old_strlower(str)
end

function string.lower(str)
   return strlower(str)
end

--preload functions
ST_N = UnitName('player')
ST_R = UnitRace('player')
ST_C = UnitClass('player')

st_n = strlower(UnitName('player'))
st_r = strlower(UnitRace('player'))
st_c = strlower(UnitClass('player'))

ST_S = UnitSex('player')
ST_G = function(text1, text2)
   return gsub(gsub(ST_S , "2", text1), "3", text2)
end
