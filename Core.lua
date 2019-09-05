local _G = getfenv()

ServTr = AceLibrary('AceAddon-2.0'):new('AceEvent-2.0', 'AceConsole-2.0', 'AceDB-2.0', 'AceHook-2.1')
local L = AceLibrary('AceLocale-2.2'):new('ServTr')

function ServTr:OnInitialize(name)
	ChatFrame1:AddMessage('Server Translation v'..GetAddOnMetadata('Server_Translation', 'Version')..L[" loaded. Type /servtr for help."], 0.6, 0.8, 0.9)
	self:RegisterDB('ST_DB')
	self:RegisterDefaults('profile', {
		translation = {
			['*'] = {
				['*'] = true
			},
			objects = {
				['*'] = {
					['*'] = {
						['*'] = true
					}
				},
			}
		},
		db = {
			['*'] = true
		},
		ruRU = true,
		language = 'ruRU',
		nameplates = 1,
		bubbles = .01,
		api = {
			['*'] = false
		}
	})
	self:RegisterEvent('ADDON_LOADED')
	self.ScheduleEvents = {}
end

function ServTr:OnEnable()
	self:LoadDb()

	self:RegisterChatCommand({'/servtr', '/servertranslation'}, self.options)
	self:HookScript(GameTooltip, 'OnShow', function() self:TooltipOnUpdate() end)
	self:HookScript(GameTooltip, 'OnSizeChanged', function() self:TooltipOnUpdate() end)
	self:HookScript(ItemRefTooltip, 'OnShow', function() self:ItemTooltip('ItemRefTooltip') end)
	self:HookScript(ItemRefTooltip, 'OnSizeChanged', function() self:ItemTooltip('ItemRefTooltip') end)
	self:HookScript(ShoppingTooltip1, 'OnShow', function() self:ItemTooltip('ShoppingTooltip1') end)
	self:HookScript(ShoppingTooltip1, 'OnSizeChanged', function() self:ItemTooltip('ShoppingTooltip1') end)
	self:HookScript(ShoppingTooltip2, 'OnShow', function() self:ItemTooltip('ShoppingTooltip2') end)
	self:HookScript(ShoppingTooltip2, 'OnSizeChanged', function() self:ItemTooltip('ShoppingTooltip2') end)
	self:LoadEmotePatterns()

	self:RegisterEvent('Nameplate_Update')
	self:RegisterEvent('BubbleFrame_Update')

	if self.db.profile then
		self.ScheduleEvents.Nameplate_Update = self:ScheduleRepeatingEvent('Nameplate_Update' , self.db.profile.nameplates)
		self.ScheduleEvents.BubbleFrame_Update = self:ScheduleRepeatingEvent('BubbleFrame_Update' , self.db.profile.bubbles)
	end

	local db = self.db.profile
	for _, group in pairs(self.API) do
		for _, o in pairs(group) do
			if _G[o] and db[o] and not self:IsHooked(o) then
				self:Hook(o, true)
			end
		end
	end
	self:ToogleAPI()
	self:LoadGlobalStrings()
end

function ServTr:ShotterSecureHook(method)
	local handler
	if self.AutoBlizzardHookData[method] then
		handler = function(...)
			self:AutoBlizzardHook(method, unpack(arg))
		end
	end
	self:SecureHook(method, handler)
end

function ServTr:ADDON_LOADED(name)
	if name == 'Blizzard_AuctionUI' then
		self:ShotterSecureHook('AuctionFrameBrowse_Update')
		self:ShotterSecureHook('AuctionFrameBid_Update')
		self:ShotterSecureHook('AuctionFrameAuctions_Update')
		self:ShotterSecureHook('AuctionSellItemButton_OnEvent')
	elseif name == 'Blizzard_CraftUI' then
		self:ShotterSecureHook('CraftFrame_SetSelection')
	elseif name == 'Blizzard_TradeSkillUI' then
		self:ShotterSecureHook('TradeSkillFrame_SetSelection')
	elseif name == 'Blizzard_TrainerUI' then
		self:ShotterSecureHook('ClassTrainerFrame_Update')
	end
end

---------Utilite functions---------

function ServTr:CopyTable(into, from)
	for key, val in from do
		if( type(val) == 'table' ) then
			if( not into[key] ) then into[key] = {} end
			self:CopyTable(into[key], val)
		else
			into[key] = val
		end
	end

	if (getn(from)) then
		table.setn(into, getn(from))
	end

	return into
end

function ServTr:setn(arr)
	local max_cell = 0
	for k, _ in pairs(arr) do
		if type(k) == 'number' then
			if max_cell < k then
				max_cell = k
			end
		end
	end
	table.setn(arr, max_cell)
end

-- I(iterate) if table have string keys then return false else it's iterate table - true
function ServTr:IsTableI(tab)
   if not tab then return nil end
   for k, _ in pairs(tab) do
      if type(k) == 'string' then
         return false
      end
   end
   return true
end

function ServTr:GetTableI(tab)
   if not tab then return nil end
   if type(tab) == 'string' then
   	tab = {tab}
   end
   local t = {}
   local flag = false
   for k, v in pairs(tab) do
      if type(k) == 'number' then
      	t[k] = v
      	flag = true
      end
   end
   if not flag then
   	t = nil
   end
   return t
end

function ServTr:SaveGlobalStrings(db_with_keys)
	local save_db = GetLocale()..'_global_strings'
	if not _G[save_db] and db_with_keys then
		_G[save_db] = {}
		for k, _ in pairs(db_with_keys) do
			Printd(k)
			_G[save_db][k] = _G[k]
		end
	end
end

function ServTr:LoadGlobalStrings()
	local db = _G[self.db.profile.language..'_global_strings']
	if not db then return end
	self:SaveGlobalStrings(db)
	for k, v in pairs(db) do
		_G[k] = v
	end
end



function ServTr:LoadEmotePatterns()
	for _, v in ipairs(EMOTE_LIST) do
		if string.find(v, '%%s') then
			self.EMOTE_TEXT[v] = {{'creature_Name', all = true}}
		end
	end
end

-- for dynamic names/ %s in keys

ServTr.DatabaseMenu = {
	'areatrigger_teleport',
	'creature_ai_texts',
	'creature_Name',
	'creature_SubName',
	'dbscript_string',
	'gameobject',
	'gossip_menu_option',
	'gossip_texts',
	'item_description',
	'item_name',
	'mangos_string',
	'npc_text',
	'page_text',
	'points_of_interest',
	'questgiver_greeting',
	'quest_details',
	'quest_EndText',
	'quest_objectives',
	'quest_ObjectiveText',
	'quest_OfferRewardText',
	'quest_RequestItemsText',
	'quest_title',
	'script_texts',
}

ServTr.SpecDbInfo = {
	creature_ai_texts = {'creature_Name', allowed_nil_translate = true},
	dbscript_string = {'creature_Name', allowed_nil_translate = true},
	mangos_string = {'creature_Name', 'mangos_string', allowed_nil_translate = true},
	script_texts = {'creature_Name', allowed_nil_translate = true},
}

function ServTr:LoadDb()
	for _, db_name in ipairs(self.DatabaseMenu) do
		db = _G[self.db.profile.language..'_'..db_name]
		_G[self.db.profile.language..'_'..db_name..'_spec'] = {
			dn = {}, --dynamic names
			dt = {} --dynamic target
		}
		spec = _G[self.db.profile.language..'_'..db_name..'_spec']
		local add_to_spec
		local temp_db = {}

		if not db then
			Printd(self.db.profile.language..'_'..db_name)
		end
		for k, v in pairs(db) do
			add_to_spec = false
			--there are too problems:
			--I  %s - it's dynamic names
			if string.find(k, '%%s') then
				spec.dn[k] = {}
				self:CopyTable(spec.dn[k], self.SpecDbInfo[db_name])
				spec.dn[k].generate_pattern = v
				add_to_spec = true
			--II $dt - it's dynamic target (changes, depending on npc's sex)
			elseif string.find(k, '$dt:.*:.*;') then
				spec.dt[k] = v
				add_to_spec = true
			end
			if not add_to_spec then
				temp_db[k] = v
			end
		end
		local old_db = _G[self.db.profile.language..'_'..db_name]
		_G[self.db.profile.language..'_'..db_name] = temp_db
		temp_db = old_db
		temp_db = {}
	end
end

---------Iterator for objects with text like QuestWatchLine1 ... QuestWatchLine50
function ServTr.TextObjPairsIter(s, iter)
	iter = iter+1
	local obj = _G[s.prefix..iter..s.postfix]
	if not obj then return nil end
	local text = obj:GetText()
	if not text then
		if not s.finish or iter >= s.finish then
			return nil
		else
			return ServTr.TextObjPairsIter(s, iter)
		end
	end
	return iter, text, obj
end

function ServTr:TextObjPairs(prefix, start, postfix, finish)
	if start then start = start - 1 end
	return self.TextObjPairsIter, {prefix = prefix or '', postfix = postfix or '', finish = finish}, start or 0
end

--use as debug - full view of classes/objects, print table with all fields and metatable
function ServTr:PrintTab(obj, max_depth, level, meta_level)
	if not obj then
		ChatFrame1:AddMessage('Root = nil')
		return
	end
	if not level then level = 0 end
	if not max_depth then max_depth = 299 end
	if level == 0 then
		obj = {Root = obj}
	end

	if not self.Table_stack then
		self.Table_stack = {}
	end
	local inset = strrep('   ', level)
	inset = '\19'..inset
	local close_flag = false
	local meta_flag = false
	for m_key, m_value in pairs(obj) do
		key = m_key
		value = m_value
		if type(key) == 'table' then
			key = 'table_key'
		elseif type(key) == 'function' then
			key = 'function'
		elseif type(key) == 'userdata' then
			key = 'userdata'
		end
		if type(value) == 'table' then
			if not self.Table_stack[value] and (level < max_depth) then
				ChatFrame1:AddMessage(inset..'['..key..'] = {')
				self.Table_stack[value] = true
				self:PrintTab(value, max_depth, level+1, obj, meta_level)
			else
				close_flag = true
				ChatFrame1:AddMessage(inset..'['..key..'] = {...}')
			end
		elseif type(value) == 'function' then
			ChatFrame1:AddMessage(inset..'['..key..'] = function')
		elseif type(value) == 'userdata' then
			local user_data = 'userdata'
			if pcall(function() obj:GetName() end) then
				user_data = obj:GetName() or ''
			end
			ChatFrame1:AddMessage(inset..'['..key..'] = '..user_data)
		elseif type(value) == 'boolean' then
			ChatFrame1:AddMessage(inset..'['..key..'] = '..tostring(value))
		else
			ChatFrame1:AddMessage(inset..'['..key..'] = '..value)
		end
	end
	local meta = getmetatable(obj)
	if meta and meta_level   then
		if not self.Table_stack[meta] and (level < max_depth) then
			ChatFrame1:AddMessage(inset..'[metatable] = {')
			self.Table_stack[meta] = true
			self:PrintTab(meta, max_depth, level+1, obj, meta_level)
		else
			meta_flag = true
			ChatFrame1:AddMessage(inset..'['..key..'] = {...}')
		end
	end
	if not close_flag and level > 0 then
		inset = strrep('   ', level-1)
		inset = '\19'..inset
		ChatFrame1:AddMessage(inset..'}')
	end
	if level == 0 then
		for k, v in pairs(self.Table_stack) do
			self.Table_stack[k] = nil
		end
		self.Table_stack = nil
	end
end

function ServTr:str_in_byte(str)
	str = gsub(str, ".[\128-\191]*", function(w)
	         	local temp = {}
	         	for i = 1, strlen(w) do
	         		temp[i] = strbyte(w, i)
	         	end
	         	w = w..":"..table.concat(temp, ' ')..'\n'
	         	DEFAULT_CHAT_FRAME:AddMessage(w)
	         	return w
	      end)
	return str
end

function ServTr:In(val, tab)
	for _, v in pairs(tab) do
		if v == val then
			return true
		end
	end
	return nil
end

function ServTr:ItemsWithBonus(text, method, object)
	if not text then return nil end
	local name = self.Translator:Translate(text, {ITEM_BONUS = 'item_name'}, method, object)
	return name
end

function ServTr:IsEventInChatGroup(event, group)
	if not group then return nil end

	for _, s in pairs(self.ChatFrameGroups[group]) do
		if s == event then return true end
	end
	return nil
end

function ServTr:GetNoNameFrame(f)
	if f:GetName() or not f:GetRegions() then return end

	local texture = f:GetRegions():GetTexture()
	if texture == 'Interface\\Tooltips\\Nameplate-Border' then
		return 'NameplateFrame'
	elseif texture == 'Interface\\Tooltips\\ChatBubble-Background' then
		return 'ChatBubbleFrame'
	end
end

function ServTr:Nameplate_Update()
	local childs = {WorldFrame:GetChildren()}
	for _, f in pairs(childs) do
		if not f.frame and self:GetNoNameFrame(f) == 'NameplateFrame' then
			local _, _, Name = f:GetRegions()
			if self.ImaginaryModeOff then
				if f.restore then
					Name:SetText(f.restore)
					f.restore = nil
				end
			else
				local name = Name:GetText()
				local trans = self.Translator:Translate(name, 'creature_Name')
				if trans then
					f.restore = name
					Name:SetText(trans)
				end
			end
		end
	end
end

function ServTr:IsEventBubble(event)
	local bubbles = {'CHAT_MSG_MONSTER_SAY', 'CHAT_MSG_MONSTER_YELL', 'CHAT_MSG_MONSTER_PARTY'}
	for _, v in pairs(bubbles) do
		if v == event then return true end
	end
	return nil
end

function ServTr:BubbleFrame_Update()
	local db
	local childs = {WorldFrame:GetChildren()}
	for _, f in pairs(childs) do
		if not f.frame and self:GetNoNameFrame(f) == 'ChatBubbleFrame' then
			local textures = {f:GetRegions()}
			for _, object in pairs(textures) do
				if object:GetObjectType() == 'FontString' then
					local text = object:GetText()
					local trans = self.Translator:Translate(text, {'script_texts', 'dbscript_string', 'creature_ai_texts'})
					if trans then object:SetText(trans) end
				end
			end
		end
	end
end

--should check all \n and split text to array
function SplitText(mode, text)
	if mode then
		local text_arr = {}
		for _t in string.gfind(text, '(.-)\10') do
			text_arr[getn(text_arr) + 1] = _t
		end
		if getn(text_arr) > 0 then
			_, _, text_arr[getn(text_arr) + 1] = string.find(text, '.+\10(.-)$')
		else
			text_arr = {text}
		end
		return text_arr
	else
		local result = ''
		for i = 1, getn(text) do
			if i > 1 then result = result..'\n' end
			result = result..text[i]
		end
		return result
	end
end

ServTr.RestoreTooltipData = {}

function ServTr:GameTooltip()
	--info to restore tooltip with out using this func
	ServTr.GT_PrevVal = {}

	--s = GameTooltip start line
	--f = GameTooltip finish line

	local list = {
		quest_title = {'quest_title', s = 1},
		npc_name = {'creature_Name', s = 1},
		object_name = {'gameobject', s = 1},
		item_name = {'item_name', s = 1},
		bonus_items = {
			pattern_list = {ITEM_BONUS = 'item_name'},
			s = 1,
		},
		points = {'points_of_interest', s = 1},
		npc_subname = {'creature_SubName', s = 2},
		item_desc = {'item_description', s = 2, f = GameTooltip:NumLines()},
		item_sets = {
			pattern_list = {
				ITEM_SET = 'item_name'
			},
			s = 10,
			f = GameTooltip:NumLines()
		}
	}

	local replace
	local r_flag
	for i, text, str in self:TextObjPairs('GameTooltipTextLeft') do
		for key, pattern in pairs(list) do
			if pattern.s == i or (pattern.f and pattern.s < i and pattern.f >= i) then
				if not pattern.pattern_list then
					local plist = {SplitText = { {pattern[1], COLOR_STR = {nil, pattern[1]}, all = true}} }
					replace = self.Translator:Translate(text, plist, 'GameTooltip')
				else
					replace = self.Translator:Translate(text, pattern.pattern_list, 'GameTooltip')
				end
				if replace then
					if not r_flag then
						ServTr.RestoreTooltipData.GameTooltip = {}
						ServTr.GT_PrevVal = {}
					end
					self.RestoreTooltipData.GameTooltip[i] = text
					self.GT_PrevVal[i] = replace
					str:SetText(replace)
					r_flag = true
					break
				end
			end
		end
	end
end

function ServTr:ItemTooltip(tooltip)
	local list = {
		item_name = {'item_name', s = 1, f = 2},
		bonus_items = {
			pattern_list = {ITEM_BONUS = 'item_name'},
			s = 1,
			f = 2
		},
		item_desc = {'item_description', s = 2, f = ItemRefTooltip:NumLines()},
		item_sets = {
			pattern_list = {
				ITEM_SET = 'item_name'
			},
			s = 10,
			f = ItemRefTooltip:NumLines()
		}
	}

	local replace
	local r_flag
	for i, text, str in self:TextObjPairs(tooltip..'TextLeft') do
		for key, pattern in pairs(list) do
			if pattern.s == i or (pattern.f and pattern.s < i and pattern.f >= i) then
				if not pattern.pattern_list then
					replace = self.Translator:Translate(text, pattern[1], tooltip)
				else
					replace = self.Translator:Translate(text, pattern.pattern_list, tooltip)
				end
				if replace then
					if not r_flag then
						ServTr.RestoreTooltipData[tooltip] = {}
					end
					self.RestoreTooltipData[tooltip][i] = text
					r_flag = true
					str:SetText(replace)
				end
			end
		end
	end
	_G[tooltip]:Show()
end

function ServTr:RestoreGT()
	for k, v in pairs(self.GT_PrevVal) do
		_G['GameTooltipTextLeft'..k]:SetText(v)
	end
end

function ServTr:TooltipOnUpdate()
	local left_str = GameTooltipTextLeft1:GetText() or ''
	local right_str = (GameTooltipTextRight1:IsVisible() and GameTooltipTextRight1:GetText()) or ''
	local firstline = left_str..right_str
	if not ((firstline == self.PreviousTooltipFirstLine or (self.GT_PrevVal and self.GT_PrevVal[1]
		and self.GT_PrevVal[3] and left_str == self.GT_PrevVal[1]))
		and GameTooltip:NumLines() == self.PreviousGameTooltipNumLines) then

		left_str = GameTooltipTextLeft1:GetText() or ''
		right_str = (GameTooltipTextRight1:IsVisible() and GameTooltipTextRight1:GetText()) or ''
		self.PreviousTooltipFirstLine = left_str..right_str
		self.PreviousGameTooltipNumLines = GameTooltip:NumLines()

		self:GameTooltip()
	else
		self:RestoreGT()
	end
	GameTooltip:Show()
end

function ServTr:RestoreTooltips()
	self.GT_PrevVal = {}
	for tooltip, data in pairs(self.RestoreTooltipData) do
		if _G[tooltip] then
			for k, v in pairs(data) do
				_G[tooltip..'TextLeft'..k]:SetText(v)
			end
		end
	end
	self:GameTooltip()
	self:ItemTooltip('ItemRefTooltip')
	self:ItemTooltip('ShoppingTooltip1')
	self:ItemTooltip('ShoppingTooltip2')
	--ItemTooltip()
end

function ServTr:OnlineTranslate()
	ServTr.ImaginaryModeOff = not ServTr.ImaginaryModeOff
	ServTr:RestoreTooltips()
	self.CallStack:call_all()

	--self:UpdateVisibleTooltips()
end
--				local v = {method, ServTr:GetTableI(arg), this = this}
ServTr.CallStack = {
	stack = {},
	add = function(self, v)
		local key = table.remove(v, 1)
		if not self.stack[key] then
			self.stack[key] = {}
		end
		local next_key = 1
		if v.this then
			next_key = v.this
			v.this = nil
		end
		self.stack[key][next_key] = {}
		--Printd("here1", key)
		self.stack[key][next_key] = v[1] or v
		--Printd("here2")
	end,
	call = function(self, method, v, t_this)
		local _, _, obj, meth = string.find(method, "([^%.]+)%.*(.*)")
		if not(meth and strlen(meth) > 0) then
			meth = obj
			obj = nil
		end

		if t_this then this = t_this end

		--if v then ServTr:PrintTab(v, 2) end
		if not obj then
			meth = _G[meth]
			meth(unpack(v))
			--ServTr:PrintTab({v[1], args})
		else
			obj = _G[obj]
			obj[meth](unpack(v))
			--ServTr:PrintTab({v[1]..":"..v[2], args})
		end
	end,
	call_all = function(self)
		for name, val in self.stack do
			for t_this, args in val do
				if type(t_this) == 'number' then
					self:call(name, args)
				else
					self:call(name, args, t_this)
				end
			end
		end
	end
}
