local _G = getfenv()
local L = LibStub("AceLocale-3.0"):GetLocale('ServTr')

----------------tables to generate menu-----------------

ServTr.ReadyDB = {'ruRU'}

ServTr.API = {
	['Container/Bag'] = {'GetBagName'},
	Loot = {
		'GetLootRollItemInfo',
		'GetLootSlotInfo'
	},
	Gossip = {'GetGossipText', 'GetGossipOptions'},
	Mail = {'GetInboxInvoiceInfo'},
	Merchant = {'GetMerchantItemInfo'},
	Trade = {
		'GetTradePlayerItemInfo',
		'GetTradeTargetItemInfo'
	},
	Training = {'GetTrainerGreetingText'},
	Quest = {
		'GetGreetingText',
		'GetTitleText',
		'GetObjectiveText',
		'GetQuestText',
		'GetProgressText',
		'GetRewardText',
		'GetQuestItemInfo',
		'GetQuestLogTitle',
		'GetQuestLogLeaderBoard',
		'GetQuestLogQuestText',
		'GetQuestLogChoiceInfo',
		'GetQuestLogRewardInfo'
	},
	Unit = {'UnitName'}
}

ServTr.Dependences = {
	Quests = {
		ChatFrame_OnEvent = {'quest_title'},
		GossipFrameUpdate = {'quest_title'},
		QuestLogFrame = {
			QuestLog_Update = {'quest_title'},
			QuestLog_UpdateQuestDetails = {'quest_title', 'quest_objectives', 'quest_details', 'quest_ObjectiveText', 'quest_EndText'}
		},
		QuestFrame = {
			QuestFrameDetailPanel_OnShow = {'quest_title', 'quest_objectives', 'quest_details'},
			QuestFrameProgressPanel_OnShow = {'quest_title', 'quest_RequestItemsText'},
			QuestFrameRewardPanel_OnShow = {'quest_title', 'quest_OfferRewardText'},
			QuestFrameGreetingPanel_OnShow = {'quest_title'}
		},
		QuestWatchFrame = {
			QuestWatch_Update = {'quest_title', 'quest_ObjectiveText', 'quest_EndText'},
		},
		StaticPopup_OnUpdate = {'quest_title'},
		UIErrorsFrame_OnEvent = {'quest_ObjectiveText', 'quest_EndText'}
	},
	Items = {
		AuctionFrameAuctions_Update = {'item_name'},
		AuctionFrameBid_Update = {'item_name'},
		AuctionFrameBrowse_Update = {'item_name'},
		AuctionSellItemButton_OnEvent = {'item_name'},
		AddMessage = {object = 'ChatFrameEditBox', 'item_name'},
		ChatFrame_OnEvent = {'item_name'},
		ContainerFrame_GenerateFrame = {'item_name'},
		CraftFrame_SetSelection = {'item_name'},
		GroupLootFrame_OnShow = {'item_name'},
		InboxFrame_Update = {'item_name'},
		ItemTextFrame_OnEvent = {'item_name'},
		LootFrame_Update = {'item_name'},
		MerchantFrame_UpdateBuybackInfo = {'item_name'},
		MerchantFrame_UpdateMerchantInfo = {'item_name'},
		OpenMail_Update = {'item_name'},
		QuestFrameItems_Update = {'item_name'},
		QuestFrameProgressItems_Update = {'item_name'},
		QuestLog_UpdateQuestDetails = {'item_name'},
		QuestWatch_Update = {'item_name'},
		SendMailFrame_Update = {'item_name'},
		StaticPopup_OnUpdate = {'item_name'},
		TradeFrame_UpdatePlayerItem = {'item_name'},
		TradeFrame_UpdateTargetItem = {'item_name'},
		TradeSkillFrame_SetSelection = {'item_name'},
		UIErrorsFrame_OnEvent = {'item_name'}
	},
	NPC = {
		BankFrame_OnEvent = {'creature_Name'},
		ChatFrame_OnEvent = {'creature_Name'},
		ClassTrainerFrame_Update = {'creature_Name', 'mangos_string'},
		CompactUnitFrame_UpdateName = {'creature_Name'},
		GossipFrameUpdate = {'npc_text', 'creature_Name', 'gameobject', 'gossip_menu_option', 'gossip_texts'},
		GuildRegistrar_OnShow = {'creature_Name'},
		ItemTextFrame_OnEvent = {'gameobject'},
		MerchantFrame_UpdateMerchantInfo = {'creature_Name'},
		QuestFrameGreetingPanel_OnShow = {'npc_text'},
		QuestFrame_SetPortrait = {'creature_Name'},
		QuestLog_UpdateQuestDetails = {'creature_Name'},
		QuestWatch_Update = {'creature_Name'},
		TabardFrame_OnEvent = {'creature_Name'},
		TaxiFrame_OnEvent = {'creature_Name'},
		UnitFrame_Update = {'creature_Name'},
		UIErrorsFrame_OnEvent = {'creature_Name'},
	},
	Books = {
		ItemTextFrame_OnEvent = {'page_text'}
	},
	Tooltips = {
		GameTooltip = {'creature_Name', 'gameobject', 'item_name', 'item_description'},
		ItemRefTooltip = {'item_name', 'item_description'},
		ShoppingTooltip1 = {'item_name'},
		ShoppingTooltip2 = {'item_name'}
	},
	['Phrases/Messages'] = {
		ChatFrame_OnEvent = {'creature_ai_texts', 'script_texts', 'dbscript_string', 'creature_Name'}
	},
	Other = {
		ChatFrame_OnEvent = {'mangos_string'}
	}
}

--fictious field means that function hooked other way,
--but it's easier to locate it here for correct db work,
--not so many such strange functions
ServTr.HookFunctions = {
	GameTooltip = 'fictitious',
	ItemRefTooltip = 'fictitious',
	ShoppingTooltip1 = 'fictitious',
	ShoppingTooltip2 = 'fictitious',
	AuctionFrameAuctions_Update = {},
	AuctionFrameBid_Update = {},
	AuctionFrameBrowse_Update = {},
	AuctionSellItemButton_OnEvent = {},
	BankFrame_OnEvent = {'UnitName'},
	ChatFrameEditBox = {funcs = {Insert = {insecure = true}}},
	ChatFrame_OnEvent = {},
	CompactUnitFrame_UpdateName = {},
	ClassTrainerFrame_Update = {'UnitName', 'GetTrainerGreetingText'},
	ContainerFrame_GenerateFrame = {'GetBagName'},
	CraftFrame_SetSelection = {},
	GossipFrameUpdate = {'UnitName', 'GetGossipText', 'GetGossipOptions'},
	GroupLootFrame_OnShow = {'GetLootRollItemInfo'},
	GuildRegistrar_OnShow = {'UnitName'},
	InboxFrame_Update = {},
	ItemTextFrame_OnEvent = {},
	LootFrame_Update = {'GetLootSlotInfo'},
	MerchantFrame_UpdateBuybackInfo = {},
	MerchantFrame_UpdateMerchantInfo = {'UnitName', 'GetMerchantItemInfo'},
	OpenMail_Update = {'GetInboxInvoiceInfo'},
	QuestFrameDetailPanel = {'GetTitleText', 'GetObjectiveText', 'GetQuestText', funcs = {OnShow = {}}},
	QuestFrameGreetingPanel_OnShow = {'GetGreetingText'},
	QuestFrameItems_Update = {'GetQuestItemInfo', 'GetQuestLogChoiceInfo', 'GetQuestLogRewardInfo'},
	QuestFrameProgressItems_Update = {'GetQuestItemInfo'},
	QuestFrameProgressPanel = {'GetTitleText', 'GetProgressText', funcs = {OnShow = {}}},
	QuestFrameRewardPanel = {'GetTitleText', 'GetRewardText', funcs = {OnShow = {}}},
	QuestFrame_SetPortrait = {'UnitName'},
	QuestLog_Update = {'GetQuestLogTitle'},
	QuestLog_UpdateQuestDetails = {'GetQuestLogTitle', 'GetQuestLogLeaderBoard', 'GetQuestLogQuestText'},
	QuestWatch_Update = {'GetQuestLogTitle', 'GetQuestLogLeaderBoard'},
	SendMailFrame_Update = {},
	StaticPopup_OnUpdate = {},
	TabardFrame_OnEvent = {'UnitName'},
	TaxiFrame_OnEvent = {'UnitName'},
	TradeFrame_UpdatePlayerItem = {'GetTradePlayerItemInfo'},
	TradeFrame_UpdateTargetItem = {'GetTradeTargetItemInfo'},
	TradeSkillFrame_SetSelection = {},
	UIErrorsFrame_OnEvent = {insecure = true},
	UnitFrame_Update = {'UnitName'}
}

---------Search in Servtr.HookFunctions and return text with api dependence------
function ServTr:Compensated(method, object)
	local result = ''
	if (not self.HookFunctions[method] and
			(not object or (object and not self.HookFunctions[object].funcs[method]))) or
		(self.HookFunctions[method] and type(self.HookFunctions[method]) == 'string' and
			self.HookFunctions[method] == 'fictitious') then
		-- if object then self:PrintTab(self.HookFunctions[object].funcs[method]) end
		return result
	else
		local api_list

		if not object then
			api_list = self.HookFunctions[method]
		else
			api_list = self.HookFunctions[object].funcs[method]
		end
		if getn(api_list) == 0 then
			return result
		end
		result = '\n\n'..L["Is compensated with following API hooks:"]
		for _, api in ipairs(api_list) do
			result = result..'\n'..api
		end
	end
	return result
end

---------path should looks like 'self.db.profile.translation'
function ServTr:GetPath(path)
	if not path then return nil end
	local db
	local flag = false
	for key in string.gmatch(path, '(.-)%.') do
		if not db then
			db = _G[key]
			flag = true
		elseif db[key] then
			db = db[key]
			flag = true
		else
			db = nil
		end
	end
	if db then
		local _, _, key = string.find(path, '.+%.(.+)')
		if key and db[key] then
			db = db[key]
		elseif key then
			db = nil
		end
	elseif not flag then
		db = _G[path]
	end

	return db
end

---------Add info to options menu with short simple table---------
function ServTr:AddEasyMenu(from, to, path)
	if not to.args or type(to.args) ~= 'table' then
		to.args = {}
	end
	for k, v in pairs(from) do
		if type(v) == 'table' then
			to.args[k] = {
				type = 'group',
				name = L[k] or k,
				desc = L[k..'_desc'] or k,
			}
			self:AddEasyMenu(v, to.args[k], path..'.'..k)
		elseif type(v) == 'string' then
			local path = path
			local opt = v
			to.args[v] = {
				type = 'toggle',
				name = L[v] or v,
				desc = L[v..'_desc'] or v,
				get = function() local db = self:GetPath(path) return db[opt] end,
				set = function() local db = self:GetPath(path) db[opt] = not db[opt] end,
			}
		end
	end
end

function ServTr:AddTranslateMenu(from, to, path)
	if not to.args or type(to.args) ~= 'table' then
		to.args = {}
	end
	for k, v in pairs(from) do
		if type(v) == 'table' and (self.HookFunctions[k]) then
			to.args[k] = {
				type = 'group',
				name = L[k] or k,
				desc = (L[k..'_desc'] or k)..self:Compensated(k),
			}
			self:AddTranslateMenu(v, to.args[k], path..'.'..k)
		elseif type(v) == 'table' and (v.object and self.HookFunctions[v.object]) then
			to.args[k] = {
				type = 'group',
				name = L[v.object..':'..k] or v.object..':'..k,
				desc = (L[v.object..':'..k..'_desc'] or v.object..':'..k)..self:Compensated(k, v.object),
			}
			self:AddTranslateMenu(v, to.args[k], path..'.objects.'..v.object..'.'..k)
		elseif type(v) == 'table' then
			to.args[k] = {
				type = 'group',
				name = L[k] or k,
				desc = L[k..'_desc'] or k,
			}
			self:AddTranslateMenu(v, to.args[k], path)
		elseif k ~= 'object' and type(v) == 'string' then
			local path = path
			local opt = v
			local desc = L[v..'_desc'] or v
			-- spetial for Global Strings
			if _G[v] and type(_G[v]) == 'string' then
				desc = _G[v]
			end
			to.args[v] = {
				type = 'toggle',
				name = L[v] or v,
				desc = desc,
				get = function() local db = self:GetPath(path) return db[opt] end,
				set = function() local db = self:GetPath(path) db[opt] = not db[opt] end,
			}
		end
	end
end

function ServTr:AddApiMenu(from, to)
	for k, v in ipairs(from) do
		to.args[k] = {
			type = 'group',
			name = L[k..' Functions'] or k..' Functions',
			desc = L[k..' Functions'] or k..' Functions',
			args = {}
		}
		for _, opt in pairs(v) do
			local option = opt
			to.args[k].args[opt] = {
				type = 'toggle',
				name = option,
				desc = L[option..'_desc'] or option,
				get = function() return self.db.profile.api[option] end,
				set = function()
					self.db.profile.api[option] = not self.db.profile.api[option]
					self:ToogleAPI(option)
				end,
			}
		end
	end
end

function ServTr:AddLanguages(from, to)
	for _, lang in pairs(from) do
		local l = lang
		to.args[l] = {
			type = 'toggle',
			name = l,
			desc = l,
			get = function() return self.db.profile[l] end,
			set = function()
				for _, _lang in self.ReadyDB do
					self.db.profile[_lang] = false
				end
				self.db.profile[l] = true
				self.db.profile.language = l
				-- self:LoadGlobalStrings()
				self:LoadEmotePatterns()
				self:LoadDb()
			end,
		}
	end
end

ServTr.options = {
		type = 'group',
		args = {
			db = {
				type = 'group',
				name = L["Databases"],
				desc = L["Global database switching.\nATTENTION! If you disable the databases in this menu, they will be disabled throughout the addon and will not be used. Use this menu to quickly enable / disable databases."],
				order = 1,
				args = {}
			},
			translation = {
				type = 'group',
				name = L["Translation"],
				desc = L["Select categories to translate."],
				order = 2,
				args = {}
			},
			interval = {
				type = 'group',
				name = L["Refresh intervals"],
				desc = L["Set the refresh interval."],
				order = 3,
				args = {
					nameplates = {
						type = 'range',
						name = L["Nameplates"],
						desc = L["Set refresh interval for nameplates. Zero value will stop updating and translating."],
						order = 1,
						min = 0,
						max = 2,
						step = .1,
						get = function() return ServTr.db.profile.nameplates end,
						set = function(time)
							ServTr.db.profile.nameplates = time
							if ServTr.ScheduleTimers.Nameplate_Update then
								ServTr:CancelTimer(ServTr.ScheduleTimers.Nameplate_Update)
							end
							if time > 0 then
								ServTr.ScheduleTimers.Nameplate_Update = ServTr:ScheduleRepeatingEvent('Nameplate_Update', time)
							end
						end,
					},
					bubbles = {
						type = 'range',
						name = L["Bubbles"],
						desc = L["Set refresh interval for chat bubbles. Zero value will stop updating and translating."],
						order = 2,
						min = 0,
						max = .5,
						step = .01,
						get = function() return ServTr.db.profile.bubbles end,
						set = function(time)
							ServTr.db.profile.bubbles = time
							if ServTr.ScheduleTimers.BubbleFrame_Update then
								ServTr:CancelTimer(ServTr.ScheduleTimers.BubbleFrame_Update)
							end
							if time > 0 then
								ServTr.ScheduleTimers.BubbleFrame_Update = ServTr:ScheduleRepeatingEvent('BubbleFrame_Update', time)
							end
						end,
					}
				}
			},
			api_translation = {
				type = 'group',
				name = L["API localization"],
				desc = L["Full api translation can translate many things in other addons, but addons, which works with databases, containing original language info won't work."],
				order = 4,
				args = {}
			},
			language = {
				type = 'group',
				name = L["Language"],
				desc = L["Set language."],
				order = 5,
				args = {}
			},
		},
	}
ServTr:AddApiMenu(ServTr.API, ServTr.options.args.api_translation)
ServTr:AddLanguages(ServTr.ReadyDB, ServTr.options.args.language)
ServTr:AddTranslateMenu(ServTr.Dependences, ServTr.options.args.translation, 'ServTr.db.profile.translation')
-- ServTr:AddTranslateMenu(ServTr.TooltipMenu, ServTr.options.args.translation, 'ServTr.db.profile.translation')
ServTr:AddEasyMenu(ServTr.DatabaseMenu, ServTr.options.args.db, 'ServTr.db.profile.db')

function ServTr:SwitchApi(opt, db)
	if opt and _G[opt] then
		if db[opt] and not self:IsHooked(opt) then
			local handler
			if self.AutoApiHookData[opt] then
				handler = function(...)
					return self:AutoApiHook(opt, ...)
				end
			end
			self:Hook(opt, handler, true)
		elseif not db[opt] and self:IsHooked(opt) then
			self:Unhook(opt)
		end
	end
end

function ServTr:CheckFunctionDependence(api_list, db, opt)
	-- flag: dependence exist
	-- unhook: all api from api_list are turned on => unhook blizzard func
	local flag, unhook = false, true
	if getn(api_list) == 0 then
		unhook = false
		flag = true
	end
	for _, o in ipairs(api_list) do
		if not opt or o == opt then
			flag = true
		end
		if not db[o] then
			unhook = false
		end
	end
	return flag, unhook
end

ServTr.IgnoreCallFuncs = {
	"ChatFrame_OnEvent",
	"ContainerFrame_GenerateFrame",
}

function ServTr:SwitchBlizzardFuncHook(unhook, method, object, ...)
--2 cases - simple function like 'LootFrame_Update' and functions of some object like 'AddMessage' from UIErrorsFrame
	-- Printd("SwitchBlizzardFuncHook")
	if not method then Printd('no method') return end
	local insecure
	local handler
	local key = method
	if object then key = object.."."..method end
	if not object then --I case
		if self.AutoBlizzardHookData[method] then
			handler = function(...)
				self:AutoBlizzardHook(method, ...)
				-- local v = {key, ServTr:GetTableI(arg), this = this}
				-- self.CallStack:add(v)
			end
		end
		if not handler and not self:In(method, self.IgnoreCallFuncs) then
			handler = function(...)
				-- local arg = {...}
				self[method](self, ...)
				-- local v = {key, ServTr:GetTableI(arg), this = this}
				-- self.CallStack:add(v)
			end
		end
		if unhook and self:IsHooked(method) then
			self:Unhook(method)
		elseif not unhook and not self:IsHooked(method) and _G[method] then
			insecure = self.HookFunctions[method].insecure
			if insecure then
				self:Hook(method, handler)
			else
				self:SecureHook(method, handler)
			end
		end
	else -- II case
		insecure = self.HookFunctions[object].funcs[method].insecure
		if not _G[object] then
			return
		else
			if self.AutoBlizzardHookData[object] and self.AutoBlizzardHookData[object][method] then
				local object_as_str = object
				handler = function(...)
					-- local arg = {...}
					self:AutoBlizzardHook({object_as_str, method}, ...)
					-- local v = {key, ServTr:GetTableI(arg), this = this}
					-- self.CallStack:add(v)
				end
			end
			object = _G[object]
		end
		if not handler and not self:In(method, self.IgnoreCallFuncs) then
			handler = function(...)
				-- local arg = {...}
				-- local is_object = (type(this) == 'userobject')
				self[method](self, ...)
				-- local v
				-- if is_object then
				-- 	v = {key, ServTr:GetTableI(arg), this = this}
				-- else
				-- 	table.insert(arg, this)
				-- 	v = {key, ServTr:GetTableI(arg)}
				-- end
				-- self.CallStack:add(v)
			end
		end
		if unhook and self:IsHooked(object, method) then
			self:Unhook(object, method)
		elseif not unhook and not self:IsHooked(object, method) then
			if insecure then
				self:Hook(object, method, handler)
			else
				if object then
					self:SecureHookScript(object, method, handler)
				else
					print('secure')
					self:SecureHook(object, method, handler)
				end
			end
		end
	end
end

function ServTr:ToogleAPI(opt)
	local db = self.db.profile.api

	--if opt is defined, then should switch it (Hook or Unhook)
	self:SwitchApi(opt, db)
	--if opt not defind, then turn on working api
	if not opt then
		for k, v in pairs(db) do
			if v then
				self:SwitchApi(k, db)
			end
		end
	end
	--Also should check Blizzard hooked functions, which depends from api (unhook them if all dependences work or hook if not all api turn on)
	local flag, unhook
	for k, v in pairs(self.HookFunctions) do
		if not(type(v) == 'string' and v == 'fictitious') then
			if not v.funcs then --key is not some object, it's global func
				flag, unhook = self:CheckFunctionDependence(v, db, opt)
				if flag then
					self:SwitchBlizzardFuncHook(unhook, k)
				end
			else  --key is object and have list of funcs
				for o_k, o_v in pairs(v.funcs) do
					flag, unhook = self:CheckFunctionDependence(o_v, db, opt)
					if flag then
						self:SwitchBlizzardFuncHook(unhook, o_k, k)
					end
				end
			end
		end
	end
end
