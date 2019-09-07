
local _G = getfenv()
------------Hook base api----------------

ServTr.AutoApiHookData = {
   GetQuestLogQuestText = {'quest_details', 'quest_objectives'},
   GetTradePlayerItemInfo = {{'item_name', ITEM_BONUS = 'item_name'}}
}

function ServTr:AutoApiHook(method, ...)
   local all_args
   local arg = {...}
   if arg then
      all_args = {self.hooks[method](...)}
   else
      all_args = {self.hooks[method]()}
   end
   local trans
   for i, v in pairs(self.AutoApiHookData[method]) do
      trans = self.Translator:Translate(all_args[i], v, method)
      if trans then
         all_args[i] = trans
      end
   end
   self:setn(all_args)
   return unpack(all_args)
end

function ServTr:GetTradePlayerItemInfo(id)
   local name, texture, quantity, quality, isUsable, enchantment = self.hooks.GetTradePlayerItemInfo(id)
   local trans = self.Translator:Translate(name, 'item_name')
            or self:ItemsWithBonus(name, 'GetTradePlayerItemInfo')
   if trans then name = trans end
   return name, texture, quantity, quality, isUsable, enchantment
end

function ServTr:GetTradeTargetItemInfo(id)
   local name, texture, quantity, quality, isUsable, enchantment = self.hooks.GetTradeTargetItemInfo(id)
   local trans = self.Translator:Translate(name, 'item_name')
            or self:ItemsWithBonus(name, 'GetTradeTargetItemInfo')
   if trans then name = trans end
   return name, texture, quantity, quality, isUsable, enchantment
end

function ServTr:GetInboxInvoiceInfo(index)
   local invoiceType, itemName, playerName, bid, buyout, deposit, consignment = self.hooks.GetInboxInvoiceInfo(index)
   local trans = self.Translator:Translate(itemName, 'item_name')
            or self:ItemsWithBonus(itemName, 'GetInboxInvoiceInfo')
   if trans then itemName = trans end
   return invoiceType, itemName, playerName, bid, buyout, deposit, consignment
end

function ServTr:GetBagName(bagID) --?
   local name = self.hooks.GetBagName(bagID)
   local trans = self.Translator:Translate(name, 'item_name')
   if trans then name = trans end
   return name
end

function ServTr:GetLootRollItemInfo(id)
   local texture, name, count, quality, bindOnPickUp = self.hooks.GetLootRollItemInfo(id)
   local trans = self.Translator:Translate(name, 'item_name')
            or self:ItemsWithBonus(name, 'GetLootRollItemInfo')
   if trans then name = trans end
   return texture, name, count, quality, bindOnPickUp
end

function ServTr:GetLootSlotInfo(slot)
   local texture, item, quantity, quality = self.hooks.GetLootSlotInfo(slot)
   local trans = self.Translator:Translate(item, 'item_name')
            or self:ItemsWithBonus(item, 'GetLootSlotInfo')
   if trans then item = trans end
   return texture, item, quantity, quality
end

function ServTr:GetGossipOptions() --?
   local trans
   local data = {self.hooks.GetGossipOptions()}
   for i = 1, getn(data), 2 do
      data[i] = self.Translator:Translate(data[i], {'gossip_menu_option', 'gossip_texts'}) or data[i]
   end
   self:setn(data)
   return unpack(data)
end

function ServTr:GetGossipText() --?
   local text = self.hooks.GetGossipText()
   local trans = self.Translator:Translate(text, {'npc_text'})
   if trans then text = trans end
   return text
end

function ServTr:GetMerchantItemInfo(index)
   local name, texture, price, quantity, numAvailable, isUsable = self.hooks.GetMerchantItemInfo(index)
   local trans = self.Translator:Translate(name, 'item_name')
   if trans then name = trans end
   return name, texture, price, quantity, numAvailable, isUsable
end

function ServTr:GetTrainerGreetingText()
   local text = self.hooks.GetTrainerGreetingText()
   local trans = self.Translator:Translate(text, 'mangos_string')
   if trans then text = trans end
   return text
end

function ServTr:GetGreetingText() --?
   local greetingText = self.hooks.GetGreetingText()
   local trans = self.Translator:Translate(greetingText, 'npc_text')
   if trans then greetingText = trans end
   return greetingText
end

function ServTr:GetTitleText() --?
   local text  = self.hooks.GetTitleText()
   local trans = self.Translator:Translate(text, 'quest_title')
   if trans then text = trans end
   return text
end

function ServTr:GetObjectiveText() --?
   local questObjective  = self.hooks.GetObjectiveText()
   local trans = self.Translator:Translate(questObjective, 'quest_objectives')
   if trans then questObjective = trans end
   return questObjective
end

function ServTr:GetQuestText() --?
   local text  = self.hooks.GetQuestText()
   local trans = self.Translator:Translate(text, 'quest_details')
   if trans then text = trans end
   return text
end

function ServTr:GetProgressText() --?
   local text  = self.hooks.GetProgressText()
   local trans = self.Translator:Translate(text, 'quest_RequestItemsText')
   if trans then text = trans end
   return text
end

function ServTr:GetRewardText() --?
   local text = self.hooks.GetRewardText()
   local trans = self.Translator:Translate(text, 'quest_OfferRewardText')
   if trans then text = trans end
   return text
end

function ServTr:GetQuestItemInfo(type, itemNum)
   local name, texture, numItems, quality, isUsable = self.hooks.GetQuestItemInfo(type, itemNum)
   local trans = self.Translator:Translate(name, 'item_name')
   if trans then name = trans end
   return name, texture, numItems, quality, isUsable
end

function ServTr:GetQuestLogTitle(questLogID)
   local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = self.hooks.GetQuestLogTitle(questLogID)
   local trans = self.Translator:Translate(questLogTitleText, 'quest_title')
   if trans then questLogTitleText = trans end
   return questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete
end

function ServTr:GetQuestLogLeaderBoard(i, questID)
   local text, type, finished = self.hooks.GetQuestLogLeaderBoard(i, questID)
   local trans = self.Translator:Translate(text, self.UI_INFO_MESSAGE_list, 'GetQuestLogLeaderBoard')
   if trans then text = trans end
   return text, type, finished
end

function ServTr:GetQuestLogQuestText()
   local questDescription, questObjectives = self.hooks.GetQuestLogQuestText()
   local trans1 = self.Translator:Translate(questDescription, 'quest_details')
   if trans1 then questDescription = trans1 end
   local trans2 = self.Translator:Translate(questObjectives, 'quest_objectives')
   if trans2 then questObjectives = trans2 end
   return questDescription, questObjectives
end

function ServTr:GetQuestLogChoiceInfo(itemNum)
   local name, texture, numItems, quality, isUsable = self.hooks.GetQuestLogChoiceInfo(itemNum)
   local trans = self.Translator:Translate(name, 'item_name')
   if trans then name = trans end
   return name, texture, numItems, quality, isUsable
end

function ServTr:GetQuestLogRewardInfo(itemNum)
   local name, texture, numItems, quality, isUsable = self.hooks.GetQuestLogRewardInfo(itemNum)
   local trans = self.Translator:Translate(name, 'item_name')
   if trans then name = trans end
   return name, texture, numItems, quality, isUsable
end

function ServTr:UnitName(unit)
   local target, server = self.hooks.UnitName(unit)
   local trans = self.Translator:Translate(target, 'creature_Name')
   if trans then target = trans end
   return target, server
end
