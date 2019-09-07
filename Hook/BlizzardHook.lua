local _G = getfenv()

ServTr.AutoBlizzardHookData = {
	AuctionFrameAuctions_Update = {
		AuctionsButton = {text_obj_pairs = {p = 'Name'}, {'item_name', ITEM_BONUS = 'item_name'}}
	},
	AuctionFrameBid_Update = {
		BidButton = {text_obj_pairs = {p = 'Name'}, {'item_name', ITEM_BONUS = 'item_name'}}
	},
	AuctionFrameBrowse_Update = {
		BrowseButton = {text_obj_pairs = {p = 'Name'}, {'item_name', ITEM_BONUS = 'item_name'}}
	},
	AuctionSellItemButton_OnEvent = {
		AuctionsItemButtonName = {{'item_name', ITEM_BONUS = 'item_name'}},
		event = 'NEW_AUCTION_UPDATE'
	},
	BankFrame_OnEvent = {
		BankFrameTitleText = 'creature_Name',
		event = 'BANKFRAME_OPENED'
	},
	ClassTrainerFrame_Update = {
		ClassTrainerNameText = 'creature_Name',
		ClassTrainerGreetingText = 'mangos_string'
	},
	CraftFrame_SetSelection = {
		CraftReagent = {text_obj_pairs = {p = 'Name'}, 'item_name'}
	},
	GossipFrameUpdate = {
		GossipFrameNpcNameText = {{'creature_Name', 'gameobject'}},
		GossipGreetingText = 'npc_text',
		GossipTitleButton  = {text_obj_pairs = {f = NUMGOSSIPBUTTONS}, {'quest_title', 'gossip_menu_option', 'gossip_texts'}, todo = GossipResize}
	},
	GuildRegistrar_OnShow = {
		GuildRegistrarFrameNpcNameText = 'creature_Name'
	},
	ItemTextFrame_OnEvent = {
		ItemTextTitleText = {{'item_name', 'gameobject'}},
		ItemTextPageText = 'page_text',
		event = 'ITEM_TEXT_READY'
	},
	LootFrame_Update = {
		LootButton = {text_obj_pairs = {p = 'Text'}, {'item_name', ITEM_BONUS = 'item_name'}}
	},
	MerchantFrame_UpdateBuybackInfo = {
		MerchantItem = {text_obj_pairs = {p = 'Name'}, {'item_name', ITEM_BONUS = 'item_name'}}
	},
	MerchantFrame_UpdateMerchantInfo = {
		MerchantNameText = 'creature_Name',
		MerchantItem = {text_obj_pairs = {p = 'Name'}, 'item_name'},
		MerchantBuyBackItemName = {{'item_name', ITEM_BONUS = 'item_name'}}
	},
	QuestFrameDetailPanel_OnShow = {
		QuestTitleText = 'quest_title',
		QuestObjectiveText = 'quest_objectives',
		QuestDescription = 'quest_details'
	},
	QuestFrameProgressItems_Update = {
		QuestProgressItem = {text_obj_pairs = {p = 'Name'}, 'item_name'},
	},

	QuestFrameProgressPanel_OnShow = {
		QuestProgressTitleText = 'quest_title',
		QuestProgressText = 'quest_RequestItemsText'
	},
	QuestFrameRewardPanel_OnShow = {
		QuestRewardTitleText = 'quest_title',
		QuestRewardText = 'quest_OfferRewardText'
	},
	QuestFrame_SetPortrait = {
		QuestFrameNpcNameText = {{'gameobject', 'creature_Name', 'item_name'}}
	},
	QuestLog_UpdateQuestDetails = {
		QuestLogQuestTitle = 'quest_title',
		QuestLogObjectivesText = 'quest_objectives',
		QuestLogQuestDescription = 'quest_details',
		QuestLogObjective = {text_obj_pairs = true, {'quest_EndText', QUEST_LOG_OBECTIVE_COMPLETE = {ServTr.QUESTLOG_MESSAGE_list}, ["(.+)"] = {ServTr.QUESTLOG_MESSAGE_list}}}
	},
	TabardFrame_OnEvent = {
		TaxiMerchant = 'creature_Name',
		event = 'OPEN_TABARD_FRAME'
	},
	TaxiFrame_OnEvent = {
		TaxiMerchant = 'creature_Name',
		event = 'TAXIMAP_OPENED'
	},
	TradeSkillFrame_SetSelection = {
		TradeSkillReagent = {text_obj_pairs = {p = 'Name'}, 'item_name'}
	}
}

-- self:PrintTab(ServTr.AutoBlizzardHookData)

function ServTr:AutoCheckObject(obj, list, method, object)
	local gettext_db = {}
	local translate_text = {}
	if type(obj) == 'string' then
		-- Printd("object:"..obj)
		obj = _G[obj]
	end
	if not obj then return end
	local text = obj:GetText()
	if not text then return nil end
	-- Printd("text:"..text)

	local result = self.Translator:Translate(text, list[1], method, object)

	if result then
		obj:SetText(result)
	end
	if list.todo then
		list.todo(obj)
	end
end

function ServTr:AutoBlizzardHook(method, event, ...)
	local data
	local object
	if type(method) == 'string' then
		data = self.AutoBlizzardHookData[method]
	elseif type(method) == 'table' then
		object, method = method[1], method[2]
		data = self.AutoBlizzardHookData[object][method]
	end
	local arg = {...}
	if data.event and (not arg[1] or data.event ~= arg[1]) then return end
	for key, list in pairs(data) do
		if key ~= 'event' then
			if type(list) == 'string' then
				list = {list}
			end
			if list.text_obj_pairs then
				local i = 1 or (type(list.text_obj_pairs) == 'table' and list.text_obj_pairs.i)
				local postfix = (type(list.text_obj_pairs) == 'table' and list.text_obj_pairs.p)
				local finish = (type(list.text_obj_pairs) == 'table' and list.text_obj_pairs.f)
				-- Printd("start TextObjPairs for"..key)
				for _, _, obj in self:TextObjPairs(key, i, postfix, finish) do
					-- Printd("text_obj_pairs: "..key..i..(postfix or ""))
					self:AutoCheckObject(obj, list, method, object)
				end
			else
				self:AutoCheckObject(key, list, method, object)
			end
		end
	end

end

function ServTr:ChatFrame_OnEvent(event)
	if self:IsEventInChatGroup(event, 'monster') then
		if self:IsEventBubble(event) then self:ScheduleEvent('BubbleFrame_Update' , self.db.profile.bubbles) end
		local text = self.Translator:Translate(arg1, {'script_texts', 'creature_ai_texts', 'dbscript_string'}, 'ChatFrame_OnEvent')
		if text then arg1 = text end
		if arg2 then
			local name = self.Translator:Translate(arg2, 'creature_Name', 'ChatFrame_OnEvent')
			if name then arg2 = name end
		end
	elseif self:IsEventInChatGroup(event, 'battleground') then
		local text = self.Translator:Translate(arg1, 'mangos_string', 'ChatFrame_OnEvent')
		if text then arg1 = text end
	elseif self:IsEventInChatGroup(event, 'player') then
		local result = gsub(arg1, '(|%x-|H.-|h%[)(.-)(%]|h|r)',
			function(prefix, item, postfix)
				local trans = self.Translator:Translate(item, 'item_name', 'ChatFrame_OnEvent')
						   or self:ItemsWithBonus(item, 'ChatFrame_OnEvent')
				if trans then item = trans end
				return prefix..item..postfix
			end)
		arg1 = result
	elseif event == 'CHAT_MSG_TEXT_EMOTE' then
		local text = self.Translator:Translate(arg1, self.EMOTE_TEXT, 'ChatFrame_OnEvent')
		if text then arg1 = text end
	elseif event == 'CHAT_MSG_SYSTEM' then
		local text = self.Translator:Translate(arg1, self.CHAT_MSG_SYSTEM_list, 'ChatFrame_OnEvent')
				  or self.Translator:Translate(arg1, 'mangos_string', 'ChatFrame_OnEvent')
		if text then arg1 = text end
	elseif self:IsEventInChatGroup(event, 'combatlog') then
		local text = self.Translator:Translate(arg1, self.COMBAT_LOG_list, 'ChatFrame_OnEvent')
		if text then arg1 = text end
	end
	-- self.hooks.ChatFrame_OnEvent(event)
end

function ServTr:ContainerFrame_GenerateFrame(frame, size, id)
	local name = self.Translator:Translate(GetBagName(id), 'item_name', 'ContainerFrame_GenerateFrame')
	if name then  _G[frame:GetName()..'Name']:SetText(name) end
end

function ServTr:GroupLootFrame_OnShow(this, ...)
	local _, item = GetLootRollItemInfo(this.rollID)
	local name = self.Translator:Translate(item, 'item_name', 'GroupLootFrame_OnShow')
			  or self:ItemsWithBonus(item, 'GroupLootFrame_OnShow')
	_G['GroupLootFrame'..this:GetID()..'Name']:SetText(name)
end

function ServTr:InboxFrame_Update()
	for i, text, str in self:TextObjPairs('MailItem', 1, 'Subject') do
		local item = self.Translator:Translate(text, {'item_name', 'mangos_string'}, 'InboxFrame_Update')
				  or self:ItemsWithBonus(text, 'InboxFrame_Update')
				  or self.Translator:Translate(text, self.AUCTION_SUBJECT_list, 'InboxFrame_Update')
		if item then str:SetText(item) end
	end
end

function ServTr:Insert(frame, text) -- for ChatFrameEditBox
	if frame == ChatFrameEditBox then
		text = self.Translator:Translate(text, {ITEM_LINK = {nil, 'item_name'}}, "SetItemRef") or text
	end
	self.hooks[frame].Insert(frame, text)
end

function ServTr:ItemTextFrame_OnEvent(event)
	if event == 'ITEM_TEXT_READY' then
		local name = self.Translator:Translate(ItemTextGetItem(), {'item_name', 'gameobject'}, 'ItemTextFrame_OnEvent')
		if name then ItemTextTitleText:SetText(name) end
		local text = self.Translator:Translate(ItemTextGetText(), 'page_text', 'ItemTextFrame_OnEvent')
		if text then ItemTextPageText:SetText('\n'..text) end
	end
end

function ServTr:OpenMail_Update()
	if not InboxFrame.openMailID then return end

	local _, _, _, subject = GetInboxHeaderInfo(InboxFrame.openMailID)
	if subject then
		local item = self.Translator:Translate(subject, 'item_name', 'OpenMail_Update')
				  or self:ItemsWithBonus(subject, 'OpenMail_Update')
				  or self.Translator:Translate(subject, self.AUCTION_SUBJECT_list, 'OpenMail_Update')
		if item then OpenMailSubject:SetText(item) end
	end

	local invoiceType, itemName, _, bid, buyout = GetInboxInvoiceInfo(InboxFrame.openMailID)
	local item = self.Translator:Translate(itemName, 'item_name', 'OpenMail_Update')
			  or self:ItemsWithBonus(itemName, 'OpenMail_Update')
	if item and invoiceType == 'buyer' then
		local buyMode
		if bid == buyout then
			buyMode = '('..BUYOUT..')'
		else
			buyMode = '('..HIGH_BIDDER..')'
		end
		OpenMailInvoiceItemLabel:SetText(ITEM_PURCHASED_COLON..' '..item..'  '..buyMode)
	elseif item then
		OpenMailInvoiceItemLabel:SetText(ITEM_SOLD_COLON..' '..item)
	end
end

function ServTr:QuestFrameGreetingPanel_OnShow()
	local text = self.Translator:Translate(GetGreetingText(), {'npc_text', 'questgiver_greeting'}, 'QuestFrameGreetingPanel_OnShow')
	if text then GreetingText:SetText(text) end
	for i, text, str in self:TextObjPairs('QuestTitleButton') do
		local title = self.Translator:Translate(text, 'quest_title', 'QuestFrameGreetingPanel_OnShow')
		if title then
			str:SetText(title)
			str:SetHeight(str:GetTextHeight() + 2)
		end
	end
end

function ServTr:QuestFrameItems_Update(questState)
	for i, text, str in self:TextObjPairs(questState..'Item', 1, 'Name') do
		local trans = self.Translator:Translate(text, 'item_name', 'QuestFrameItems_Update')
		if trans then str:SetText(trans) end
	end
end

function ServTr:QuestLog_Update()
	for i, text, str in self:TextObjPairs('QuestLogTitle') do
		local questCheck = _G['QuestLogTitle'..i..'Check']
		local questNormalText = _G['QuestLogTitle'..i..'NormalText']
		if text then
			local title = self.Translator:Translate(text, {QUEST_LOG_TITLE = 'quest_title'}, 'QuestLog_Update')
			if title then
				str:SetText(title)
				QuestLogDummyText:SetText(title)
				questNormalText:SetWidth(275 - 15 - _G['QuestLogTitle'..i..'Tag']:GetWidth())
				local width = min(questNormalText:GetWidth(), QuestLogDummyText:GetWidth())
				questCheck:SetPoint('LEFT', str, 'LEFT', width + 24, 0)
			end
		end
	end
end

function ServTr:QuestWatch_Update()
	local questWatchMaxWidth = 0
	local list = {QUEST_WATCH_TITLE = {{'quest_EndText',
		QUEST_ITEMS_NEEDED = 'quest_ObjectiveText',
		QUEST_MONSTERS_KILLED = 'creature_Name',
		QUEST_OBJECTS_FOUND = 'item_name'
	}}}
	for i, text, str in self:TextObjPairs('QuestWatchLine') do
		local obj = self.Translator:Translate(text, 'quest_title', 'QuestWatch_Update')
				 or self.Translator:Translate(text, list, 'QuestWatch_Update')
		if obj then str:SetText(obj) end
		local temp_width = str:GetWidth()
		if temp_width > questWatchMaxWidth then
			questWatchMaxWidth = temp_width
		end
	end
	_G['QuestWatchFrame']:SetWidth(questWatchMaxWidth + 10)
	UIParent_ManageFramePositions()
end

function ServTr:SendMailFrame_Update()
	local itemName, _, stackCount = GetSendMailItem()
	if itemName then
		local name = self.Translator:Translate(itemName, 'item_name', 'SendMailFrame_Update')
				  or self:ItemsWithBonus(itemName, 'SendMailFrame_Update')
		if stackCount ~= "" and name then
			SendMailSubjectEditBox:SetText(name.." ("..stackCount..")")
		elseif name then
			SendMailSubjectEditBox:SetText(name);
		end
	end
end

function ServTr:StaticPopup_OnUpdate(this, dialog, elapsed)
	local PopupString = _G[dialog:GetName()..'Text']
	if PopupString:GetText() == self[this:GetName()] then return end
	local replace = self.Translator:Translate(PopupString:GetText(), self.PopupFrame_list, 'StaticPopup_OnUpdate')
	if replace then
		PopupString:SetText(replace)
		StaticPopup_Resize(dialog, dialog.which)
	end
	self[this:GetName()] = PopupString:GetText()
end

function ServTr:TradeFrame_UpdatePlayerItem(id)
	if id ~= 7 then
		local name = self.Translator:Translate(GetTradePlayerItemInfo(id), 'item_name', 'TradeFrame_UpdatePlayerItem')
				  or self:ItemsWithBonus(GetTradePlayerItemInfo(id), 'TradeFrame_UpdatePlayerItem')
		if name then _G['TradePlayerItem'..id..'Name']:SetText(name) end
	end
end

function ServTr:TradeFrame_UpdateTargetItem(id)
	if id ~= 7 then
		local name = self.Translator:Translate(GetTradeTargetItemInfo(id), 'item_name', 'TradeFrame_UpdateTargetItem')
				  or self:ItemsWithBonus(GetTradeTargetItemInfo(id), 'TradeFrame_UpdateTargetItem')
		if name then _G['TradeRecipientItem'..id..'Name']:SetText(name) end
	end
end

function ServTr:UIErrorsFrame_OnEvent(event, message)
	local list, db
	if event == 'UI_INFO_MESSAGE' then
		list = self.UI_INFO_MESSAGE_list
		db = 'areatrigger_teleport'
	elseif event == 'UI_ERROR_MESSAGE' then
		list = self.UI_ERROR_MESSAGE_list
		db = 'mangos_string'
	end
	message = self.Translator:Translate(message, list, 'UIErrorsFrame_OnEvent') or self.Translator:Translate(message, db, 'UIErrorsFrame_OnEvent') or message
	self.hooks.UIErrorsFrame_OnEvent(event, message)
end

function ServTr:UnitFrame_Update(this, ...)
	local name = self.Translator:Translate(GetUnitName(this.unit), 'creature_Name', 'UnitFrame_Update')
	if name then this.name:SetText(name) end
end
