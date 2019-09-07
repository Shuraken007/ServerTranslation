local AceLocale = LibStub("AceLocale-3.0")
local is_default, errors_turned_of_on_unknown_locale = true, true
local L = AceLocale:NewLocale( "ServTr", "enUS", is_default, errors_turned_of_on_unknown_locale)

if not L then return end

	--global things
	L[" loaded. Type /servtr for help."] = true
	-- article for connecting item with random bonus: sword of the Whale
	L[" of "] = true
	--databases
	L["areatrigger_teleport_desc"] = "Database with messages when the requirements for entering the dungeon are not met."
	L["creature_ai_texts_desc"] = "Database of NPC/Creature phrase."
	L["creature_Name_desc"] = "Database of NPC name."
	L["creature_SubName_desc"] = "Database of NPC signature."
	L["dbscript_string_desc"] = "Database of NPC/Creature phrase."
	L["gameobject_desc"] = "Database of object names."
	L["gossip_menu_option_desc"] = "Database of dialog items with the NPC."
	L["gossip_texts_desc"] = "Database of dialog items with the NPC."
	L["item_description_desc"] = "Database of signature items."
	L["item_name_desc"] = "Database of item names."
	L["mangos_string_desc"] = "Database of MaNGOS strings."
	L["npc_text_desc"] = "Database of NPC text."
	L["page_text_desc"] = "Database of books."
	L["points_of_interest_desc"] = "Database of points of interest"
	L["questgiver_greeting_desc"] = "Database of NPC text."
	L["quest_details_desc"] = "Database of details quest."
	L["quest_EndText_desc"] = "Database of objectives quest."
	L["quest_objectives_desc"] = "Database of objectives quest."
	L["quest_ObjectiveText_desc"] = "Database of objective text quest."
	L["quest_OfferRewardText_desc"] = "Database of progress texts quest."
	L["quest_RequestItemsText_desc"] = "Database of progress texts quest."
	L["quest_title_desc"] = "Database of title quest."
	L["script_texts_desc"] = "Database of NPC/Creature phrase."
	--dependences
	L["Tooltips"] = true
	L["Tooltips_desc"] = "Setting up the translation of tooltips."
	L["Quests"] = true
	L["Quests_desc"] = "Setting up the translation of quests."
	L["QuestLogFrame_desc"] = "QuestLog Frame."
	L["QuestFrame_desc"] = "Quest Frame."
	L["QuestWatchFrame_desc"] = "Quest Watch Frame."
	L["Items"] = true
	L["Items_desc"] = "Setting up the translation of items."
	L["NPC"] = true
	L["NPC_desc"] = "Setting up the translation of NPC."
	L["Books"] = true
	L["Books_desc"] = "Setting up the translation of books."
	L["Phrases/Messages"] = true
	L["Phrases/Messages_desc"] = "Setting up the translation of phrases and messages in ChatFrame."
	L["Other"] = true
	L["Other_desc"] = "What does not fall into categories."
	--blizzard functions
	L["GameTooltip_desc"] = "Usual tooltips."
	L["ItemRefTooltip_desc"] = "Tooltip when you click on its link."
	L["ShoppingTooltip1_desc"] = "Tooltip when comparing the current item to the equipment."
	L["ShoppingTooltip2_desc"] = "Tooltip when comparing the current item to the equipment, if there are two. (For example, weapons in left and right hands or two trinkets)."
	L["AuctionFrameAuctions_Update_desc"] = "Frame of lot auction."
	L["AuctionFrameBid_Update_desc"] = "Frame of bid auction."
	L["AuctionFrameBrowse_Update_desc"] = "Frame of browse auction."
	L["AuctionSellItemButton_OnEvent_desc"] = "Item for sale."
	L["BankFrame_OnEvent_desc"] = "Bank frame."
	L["ChatFrameEditBox:AddMessage_desc"] = "Panel for entering messages into the chat."
	L["ChatFrame_OnEvent_desc"] = "Chat frame."
	L["ClassTrainerFrame_Update_desc"] = "Class trainer frame."
	L["CraftFrame_SetSelection_desc"] = "Profession frame."
	L["GossipFrameUpdate_desc"] = "Gossip frame."
	L["GroupLootFrame_OnShow_desc"] = "Roll frame."
	L["GuildRegistrar_OnShow_desc"] = "Guild registration frame."
	L["InboxFrame_Update_desc"] = "Input mail frame."
	L["ItemTextFrame_OnEvent_desc"] = "Book reading frame."
	L["LootFrame_Update_desc"] = "Loot frame."
	L["MerchantFrame_UpdateBuybackInfo_desc"] = "Frame of buyout frame of merchant."
	L["MerchantFrame_UpdateMerchantInfo_desc"] = "Frame of purchase of merchant."
	L["OpenMail_Update_desc"] = "Frame of open letter."
	L["QuestFrameDetailPanel_OnShow_desc"] = "Frame with quest descriptions of NPC."
	L["QuestFrameGreetingPanel_OnShow_desc"] = "Frame with the text of the NPC greeting."
	L["QuestFrameItems_Update_desc"] = "Items in the frame with description and completion quest text of NPC."
	L["QuestFrameProgressItems_Update_desc"] = "Items in the frame with the progress quest text of NPC."
	L["QuestFrameProgressPanel_OnShow_desc"] = "Frame with the progress text of NPC."
	L["QuestFrameRewardPanel_OnShow_desc"] = "Frame with quest completion text of NPC."
	L["QuestFrame_SetPortrait_desc"] = "Frame with the name of the NPC giving the quest."
	L["QuestLog_UpdateQuestDetails_desc"] = "Description of quests in the QuestLog."
	L["QuestLog_Update_desc"] = "Quest title in the QuestLog."
	L["QuestWatch_Update_desc"] = "Quest tracking frame."
	L["SendMailFrame_Update_desc"] = "Mail sending frame."
	L["StaticPopup_OnUpdate_desc"] = "Pop-up message frame."
	L["TabardFrame_OnEvent_desc"] = "Tabard setting frame."
	L["TaxiFrame_OnEvent_desc"] = "Flight frame."
	L["TradeFrame_UpdatePlayerItem_desc"] = "Trade frame for player items."
	L["TradeFrame_UpdateTargetItem_desc"] = "Trade frame for target's items."
	L["TradeSkillFrame_SetSelection_desc"] = "Frame of standart professions (First Aid etc)."
	L["UIErrorsFrame_OnEvent_desc"] = "Pop-up messages at the top part of screen (red errors, or yellow info message)."
	L["UnitFrame_Update_desc"] = "Unit frame."
	--api functions
	L["Container/Bag Functions"] = true
	L["GetBagName_desc"] = "Returns the name of one of the player's bags."
	L["Loot Functions"] = true
	L["GetLootRollItemInfo_desc"] = "Returns information about an item currently up for loot rolling."
	L["GetLootSlotInfo_desc"] = "Returns icon path, item name, and item quantity for the item in the given loot window."
	L["Gossip Functions"] = true
	L["GetGossipText_desc"] = "Returns greeting or other text to be displayed in an NPC dialog."
	L["Mail Functions"] = true
	L["GetInboxInvoiceInfo_desc"] = "Returns auction house invoice information for a mail."
	L["Merchant Functions"] = true
	L["GetMerchantItemInfo_desc"] = "Returns information about an item available for purchase from a vendor."
	L["Trade Functions"] = true
	L["GetTradePlayerItemInfo_desc"] = "Returns information about items in the player trade window."
	L["GetTradeTargetItemInfo_desc"] = "Returns information about items in the target's trade window."
	L["Training Functions"] = true
	L["GetTrainerGreetingText_desc"] = "Returns the current trainer's greeting text."
	L["Quest Functions"] = true
	L["GetGreetingText_desc"] = "Returns the greeting text displayed for quest NPCs with multiple quests."
	L["GetTitleText_desc"] = "Retrieves the title of the quest while talking to the NPC about it."
	L["GetObjectiveText_desc"] = "Gets the objective of the current quest."
	L["GetQuestText_desc"] = "Gets the description of the current quest."
	L["GetProgressText_desc"] = "Returns the quest progress text presented by a questgiver."
	L["GetRewardText_desc"] = "Returns questgiver dialog to be displayed when completing a quest."
	L["GetQuestItemInfo_desc"] = "Returns basic information about the quest items."
	L["GetQuestLogTitle_desc"] = "Returns the string which is associated with the specific QuestLog quest_title in the game."
	L["GetQuestLogLeaderBoard_desc"] = "Gets information about the objectives for a quest."
	L["GetQuestLogQuestText_desc"] = "Returns the description and objectives required for the specified quest."
	L["GetQuestLogChoiceInfo_desc"] = "Returns a bunch of data about a quest reward choice from the quest log."
	L["GetQuestLogRewardInfo_desc"] = "Returns a pile of reward item info."
	L["Unit Functions"] = true
	L["GetUnitName_desc"] = "Returns name of the unit."
	--other options
	L["Is compensated with following API hooks:"] = true
	L["Databases"] = true
	L["Global database switching.\nATTENTION! If you disable the databases in this menu, they will be disabled throughout the addon and will not be used. Use this menu to quickly enable / disable databases."] = true
	L["Translation"] = true
	L["Select categories to translate."] = true
	L["Refresh intervals"] = true
	L["Set the refresh interval."] = true
	L["Nameplates"] = true
	L["Set refresh interval for nameplates. Zero value will stop updating and translating."] = true
	L["Bubbles"] = true
	L["Set refresh interval for chat bubbles. Zero value will stop updating and translating."] = true
	L["API localization"] = true
	L["Full api translation can translate many things in other addons, but addons, which works with databases, containing original language info won't work."] = true
	--you should create dir for your language (like ruRU) and make same prefixes of all tables names, like ruRU_creature_ai_texts
	L["Language"] = true
	L["Set language."] = true
	L["Databases loading"] = true
	L["Config speed depending on the hardware capabilities."] = true
	L["Delay"] = true
	L["Set delay after after loading the interface and addons.\n(non-negative number of seconds)"] = true
	L["Speed"] = "Скорость"
	L["Set delay between processing of the database blocks."] = true
	L["<Type seconds >= 0.>"] = true
	L["Size of block"] = true
	L["Set size of block that is processed at a time.\n(non-negative number of database strings)"] = true

if GetLocale() == "enUS" then
	EMOTE_LIST = {}
	strlower_hook = function(letter) return nil end
	BINDING_NAME_TRANSLATE = "Toggle translation"
end
