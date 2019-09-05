﻿local L = AceLibrary('AceLocale-2.2'):new('ServTr')

L:RegisterTranslations('enUS', function() return {
	--global things
	[" loaded. Type /servtr for help."] = true,
	-- article for connecting item with random bonus: sword of the Whale
	[" of "] = true,
	--databases
	["areatrigger_teleport_desc"] = "Database with messages when the requirements for entering the dungeon are not met.",
	["creature_ai_texts_desc"] = "Database of NPC/Creature phrase.",
	["creature_Name_desc"] = "Database of NPC name.",
	["creature_SubName_desc"] = "Database of NPC signature.",
	["dbscript_string_desc"] = "Database of NPC/Creature phrase.",
	["gameobject_desc"] = "Database of object names.",
	["gossip_menu_option_desc"] = "Database of dialog items with the NPC.",
	["gossip_texts_desc"] = "Database of dialog items with the NPC.",
	["item_description_desc"] = "Database of signature items.",
	["item_name_desc"] = "Database of item names.",
	["mangos_string_desc"] = "Database of MaNGOS strings.",
	["npc_text_desc"] = "Database of NPC text.",
	["page_text_desc"] = "Database of books.",
	["points_of_interest_desc"] = "Database of points of interest",
	["questgiver_greeting_desc"] = "Database of NPC text.",
	["quest_details_desc"] = "Database of details quest.",
	["quest_EndText_desc"] = "Database of objectives quest.",
	["quest_objectives_desc"] = "Database of objectives quest.",
	["quest_ObjectiveText_desc"] = "Database of objective text quest.",
	["quest_OfferRewardText_desc"] = "Database of progress texts quest.",
	["quest_RequestItemsText_desc"] = "Database of progress texts quest.",
	["quest_title_desc"] = "Database of title quest.",
	["script_texts_desc"] = "Database of NPC/Creature phrase.",
	--dependences
	["Tooltips"] = true,
	["Tooltips_desc"] = "Setting up the translation of tooltips.",
	["Quests"] = true,
	["Quests_desc"] = "Setting up the translation of quests.",
	["QuestLogFrame_desc"] = "QuestLog Frame.",
	["QuestFrame_desc"] = "Quest Frame.",
	["QuestWatchFrame_desc"] = "Quest Watch Frame.",
	["Items"] = true,
	["Items_desc"] = "Setting up the translation of items.",
	["NPC"] = true,
	["NPC_desc"] = "Setting up the translation of NPC.",
	["Books"] = true,
	["Books_desc"] = "Setting up the translation of books.",
	["Phrases/Messages"] = true,
	["Phrases/Messages_desc"] = "Setting up the translation of phrases and messages in ChatFrame.",
	["Other"] = true,
	["Other_desc"] = "What does not fall into categories.",
	--blizzard functions
	["GameTooltip_desc"] = "Usual tooltips.",
	["ItemRefTooltip_desc"] = "Tooltip when you click on its link.",
	["ShoppingTooltip1_desc"] = "Tooltip when comparing the current item to the equipment.",
	["ShoppingTooltip2_desc"] = "Tooltip when comparing the current item to the equipment, if there are two. (For example, weapons in left and right hands or two trinkets).",
	["AuctionFrameAuctions_Update_desc"] = "Frame of lot auction.",
	["AuctionFrameBid_Update_desc"] = "Frame of bid auction.",
	["AuctionFrameBrowse_Update_desc"] = "Frame of browse auction.",
	["AuctionSellItemButton_OnEvent_desc"] = "Item for sale.",
	["BankFrame_OnEvent_desc"] = "Bank frame.",
	["ChatFrameEditBox:AddMessage_desc"] = "Panel for entering messages into the chat.",
	["ChatFrame_OnEvent_desc"] = "Chat frame.",
	["ClassTrainerFrame_Update_desc"] = "Class trainer frame.",
	["CraftFrame_SetSelection_desc"] = "Profession frame.",
	["GossipFrameUpdate_desc"] = "Gossip frame.",
	["GroupLootFrame_OnShow_desc"] = "Roll frame.",
	["GuildRegistrar_OnShow_desc"] = "Guild registration frame.",
	["InboxFrame_Update_desc"] = "Input mail frame.",
	["ItemTextFrame_OnEvent_desc"] = "Book reading frame.",
	["LootFrame_Update_desc"] = "Loot frame.",
	["MerchantFrame_UpdateBuybackInfo_desc"] = "Frame of buyout frame of merchant.",
	["MerchantFrame_UpdateMerchantInfo_desc"] = "Frame of purchase of merchant.",
	["OpenMail_Update_desc"] = "Frame of open letter.",
	["QuestFrameDetailPanel_OnShow_desc"] = "Frame with quest descriptions of NPC.",
	["QuestFrameGreetingPanel_OnShow_desc"] = "Frame with the text of the NPC greeting.",
	["QuestFrameItems_Update_desc"] = "Items in the frame with description and completion quest text of NPC.",
	["QuestFrameProgressItems_Update_desc"] = "Items in the frame with the progress quest text of NPC.",
	["QuestFrameProgressPanel_OnShow_desc"] = "Frame with the progress text of NPC.",
	["QuestFrameRewardPanel_OnShow_desc"] = "Frame with quest completion text of NPC.",
	["QuestFrame_SetPortrait_desc"] = "Frame with the name of the NPC giving the quest.",
	["QuestLog_UpdateQuestDetails_desc"] = "Description of quests in the QuestLog.",
	["QuestLog_Update_desc"] = "Quest title in the QuestLog.",
	["QuestWatch_Update_desc"] = "Quest tracking frame.",
	["SendMailFrame_Update_desc"] = "Mail sending frame.",
	["StaticPopup_OnUpdate_desc"] = "Pop-up message frame.",
	["TabardFrame_OnEvent_desc"] = "Tabard setting frame.",
	["TaxiFrame_OnEvent_desc"] = "Flight frame.",
	["TradeFrame_UpdatePlayerItem_desc"] = "Trade frame for player items.",
	["TradeFrame_UpdateTargetItem_desc"] = "Trade frame for target's items.",
	["TradeSkillFrame_SetSelection_desc"] = "Frame of standart professions (First Aid etc).",
	["UIErrorsFrame_OnEvent_desc"] = "Pop-up messages at the top part of screen (red errors, or yellow info message).",
	["UnitFrame_Update_desc"] = "Unit frame.",
	--api functions
	["Container/Bag Functions"] = true,
	["GetBagName_desc"] = "Returns the name of one of the player's bags.",
	["Loot Functions"] = true,
	["GetLootRollItemInfo_desc"] = "Returns information about an item currently up for loot rolling.",
	["GetLootSlotInfo_desc"] = "Returns icon path, item name, and item quantity for the item in the given loot window.",
	["Gossip Functions"] = true,
	["GetGossipText_desc"] = "Returns greeting or other text to be displayed in an NPC dialog.",
	["Mail Functions"] = true,
	["GetInboxInvoiceInfo_desc"] = "Returns auction house invoice information for a mail.",
	["Merchant Functions"] = true,
	["GetMerchantItemInfo_desc"] = "Returns information about an item available for purchase from a vendor.",
	["Trade Functions"] = true,
	["GetTradePlayerItemInfo_desc"] = "Returns information about items in the player trade window.",
	["GetTradeTargetItemInfo_desc"] = "Returns information about items in the target's trade window.",
	["Training Functions"] = true,
	["GetTrainerGreetingText_desc"] = "Returns the current trainer's greeting text.",
	["Quest Functions"] = true,
	["GetGreetingText_desc"] = "Returns the greeting text displayed for quest NPCs with multiple quests.",
	["GetTitleText_desc"] = "Retrieves the title of the quest while talking to the NPC about it.",
	["GetObjectiveText_desc"] = "Gets the objective of the current quest.",
	["GetQuestText_desc"] = "Gets the description of the current quest.",
	["GetProgressText_desc"] = "Returns the quest progress text presented by a questgiver.",
	["GetRewardText_desc"] = "Returns questgiver dialog to be displayed when completing a quest.",
	["GetQuestItemInfo_desc"] = "Returns basic information about the quest items.",
	["GetQuestLogTitle_desc"] = "Returns the string which is associated with the specific QuestLog quest_title in the game.",
	["GetQuestLogLeaderBoard_desc"] = "Gets information about the objectives for a quest.",
	["GetQuestLogQuestText_desc"] = "Returns the description and objectives required for the specified quest.",
	["GetQuestLogChoiceInfo_desc"] = "Returns a bunch of data about a quest reward choice from the quest log.",
	["GetQuestLogRewardInfo_desc"] = "Returns a pile of reward item info.",
	["Unit Functions"] = true,
	["GetUnitName_desc"] = "Returns name of the unit.",
	--other options
	["Is compensated with following API hooks:"] = true,
	["Databases"] = true,
	["Global database switching.\nATTENTION! If you disable the databases in this menu, they will be disabled throughout the addon and will not be used. Use this menu to quickly enable / disable databases."] = true,
	["Translation"] = true,
	["Select categories to translate."] = true,
	["Refresh intervals"] = true,
	["Set the refresh interval."] = true,
	["Nameplates"] = true,
	["Set refresh interval for nameplates. Zero value will stop updating and translating."] = true,
	["Bubbles"] = true,
	["Set refresh interval for chat bubbles. Zero value will stop updating and translating."] = true,
	["API localization"] = true,
	["Full api translation can translate many things in other addons, but addons, which works with databases, containing original language info won't work."] = true,
	--you should create dir for your language (like ruRU) and make same prefixes of all tables names, like ruRU_creature_ai_texts
	["Language"] = true,
	["Set language."] = true,
	["Databases loading"] = true,
	["Config speed depending on the hardware capabilities."] = true,
	["Delay"] = true,
	["Set delay after after loading the interface and addons.\n(non-negative number of seconds)"] = true,
	["Speed"] = "Скорость",
	["Set delay between processing of the database blocks."] = true,
	["<Type seconds >= 0.>"] = true,
	["Size of block"] = true,
	["Set size of block that is processed at a time.\n(non-negative number of database strings)"] = true,
} end)

if GetLocale() == "enUS" then
	EMOTE_LIST = {}
	strlower_hook = function(letter) return nil end
	BINDING_NAME_TRANSLATE = "Translation"
	BINDING_HEADER_SERVTR = "Server Translation"
end
