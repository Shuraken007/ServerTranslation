--NewGlobalStrings for easier work with string.find
local L = LibStub("AceLocale-3.0"):GetLocale('ServTr')

QUEST_LOG_TITLE = '  %s'
QUEST_WATCH_TITLE = '- %s'
QUEST_LOG_OBECTIVE_COMPLETE = '%s ('..COMPLETE..')'
ITEM_BONUS = '%s'..L[" of "]..'%s'
ITEM_SET   = '  %s'
ITEM_LINK = '%s[%s]|h|r'
COLOR_STR = '|cff%x{6}%s|r'

ServTr.EMOTE_TEXT = {}

ServTr.AUCTION_SUBJECT_list = {
	AUCTION_WON_MAIL_SUBJECT = {{ITEM_BONUS = {'item_name'}}},
	AUCTION_EXPIRED_MAIL_SUBJECT = {{ITEM_BONUS = {'item_name'}}},
	AUCTION_SOLD_MAIL_SUBJECT = {{ITEM_BONUS = {'item_name'}}}
}

ServTr.CHAT_MSG_SYSTEM_list = {
	ERR_QUEST_ACCEPTED_S = 'quest_title',
	ERR_QUEST_COMPLETE_S = 'quest_title',
	ERR_QUEST_FAILED_S = 'quest_title',
	ERR_QUEST_REWARD_ITEM_S = 'item_name',
	ERR_AUCTION_WON_S = {'item_name', ITEM_BONUS = {'item_name'}}
}

ServTr.QUESTLOG_MESSAGE_list = {
	'quest_EndText',
	QUEST_ITEMS_NEEDED = 'quest_ObjectiveText',
	QUEST_MONSTERS_KILLED = 'creature_Name',
	QUEST_OBJECTS_FOUND = 'item_name',
}

ServTr.UI_INFO_MESSAGE_list = {
	ERR_QUEST_ADD_ITEM_SII = 'item_name',
	ERR_QUEST_ADD_KILL_SII = 'creature_Name',
	ERR_QUEST_ADD_FOUND_SII = 'quest_ObjectiveText',
	ERR_QUEST_OBJECTIVE_COMPLETE_S = 'quest_EndText'
}

ServTr.UI_ERROR_MESSAGE_list = {
	SPELL_FAILED_REAGENTS = 'item_name',
	ERR_USE_LOCKED_WITH_ITEM_S = 'item_name',
	SPELL_EQUIPPED_ITEM_NOSPACE = 'item_name'
}

ServTr.PopupFrame_list = {'quest_title', 'item_name'}

ServTr.COMBAT_LOG_list = {
	AURAADDEDOTHERHARMFUL = 'creature_Name', -- "%s is afflicted by %s."; -- Combat log text for aura events
	AURAADDEDOTHERHELPFUL = 'creature_Name', -- "%s gains %s."; -- Combat log text for aura events
	AURAAPPLICATIONADDEDOTHERHARMFUL = 'creature_Name', -- "%s is afflicted by %s (%d).";
	AURAAPPLICATIONADDEDOTHERHELPFUL = 'creature_Name', -- "%s gains %s (%d).";
	AURACHANGEDOTHER = 'creature_Name', -- "%s replaces %s with %s."; -- Combat log text for aura events
	AURADISPELOTHER = 'creature_Name', -- "%s's %s is removed.";
	AURAREMOVEDOTHER = {nil, 'creature_Name'}, -- "%s fades from %s."; -- Combat log text for aura events
	AURASTOLENOTHEROTHER = {{'creature_Name', all = true}}, -- "%s steals %s's %s.";
	AURASTOLENOTHERSELF = 'creature_Name', -- "%s steals your %s.";
	AURA_END = 'creature_Name', -- "<%s> fades";
	COMBATHITCRITOTHEROTHER = {nil, 'creature_Name'}, -- '%s crits %s for %d.';
	COMBATHITCRITOTHERSELF = 'creature_Name', -- '%s crits you for %d.';
	COMBATHITCRITSCHOOLOTHEROTHER = {nil, 'creature_Name'}, -- '%s crits %s for %d %s damage.';
	COMBATHITCRITSCHOOLOTHERSELF = 'creature_Name', -- '%s crits you for %d %s damage.';
	COMBATHITCRITSCHOOLSELFOTHER = 'creature_Name', -- 'You crit %s for %d %s damage.';
	COMBATHITCRITSELFOTHER = 'creature_Name', -- 'You crit %s for %d.';
	COMBATHITOTHEROTHER = {nil, 'creature_Name'}, -- '%s hits %s for %d.';
	COMBATHITOTHERSELF = 'creature_Name', -- '%s hits you for %d.';
	COMBATHITSCHOOLOTHEROTHER = {nil, 'creature_Name'}, -- '%s hits %s for %d %s damage.';
	COMBATHITSCHOOLOTHERSELF = 'creature_Name', -- '%s hits you for %d %s damage.';
	COMBATHITSCHOOLSELFOTHER = 'creature_Name', -- 'You hit %s for %d %s damage.';
	COMBATHITSELFOTHER = 'creature_Name', -- 'You hit %s for %d.';
	COMBATLOG_XPGAIN_EXHAUSTION1 = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s bonus)';
	COMBATLOG_XPGAIN_EXHAUSTION1_GROUP = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)';
	COMBATLOG_XPGAIN_EXHAUSTION1_RAID = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s bonus, -%d raid penalty)';
	COMBATLOG_XPGAIN_EXHAUSTION2 = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s bonus)';
	COMBATLOG_XPGAIN_EXHAUSTION2_GROUP = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)';
	COMBATLOG_XPGAIN_EXHAUSTION2_RAID = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s bonus, -%d raid penalty)';
	COMBATLOG_XPGAIN_EXHAUSTION4 = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s penalty)';
	COMBATLOG_XPGAIN_EXHAUSTION4_GROUP = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s penalty, +%d group bonus)';
	COMBATLOG_XPGAIN_EXHAUSTION4_RAID = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s penalty, -%d raid penalty)';
	COMBATLOG_XPGAIN_EXHAUSTION5 = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s penalty)';
	COMBATLOG_XPGAIN_EXHAUSTION5_GROUP = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s penalty, +%d group bonus)';
	COMBATLOG_XPGAIN_EXHAUSTION5_RAID = 'creature_Name', -- '%s dies, you gain %d experience. (%s exp %s penalty, -%d raid penalty)';
	COMBATLOG_XPGAIN_FIRSTPERSON = 'creature_Name', -- '%s dies, you gain %d experience.';
	COMBATLOG_XPGAIN_FIRSTPERSON_GROUP = 'creature_Name', -- '%s dies, you gain %d experience. (+%d group bonus)';
	COMBATLOG_XPGAIN_FIRSTPERSON_RAID = 'creature_Name', -- '%s dies, you gain %d experience. (-%d raid penalty)';
	DAMAGESHIELDOTHEROTHER = 'creature_Name', -- '%s reflects %d %s damage to %s.';
	DAMAGESHIELDOTHERSELF = 'creature_Name', -- '%s reflects %d %s damage to you.';
	DISPELFAILEDOTHEROTHER = {{'creature_Name', all = true}}, -- '%s fails to dispel %s's %s.';
	DISPELFAILEDOTHERSELF = 'creature_Name', -- '%s fails to dispel your %s.';
	DISPELFAILEDSELFOTHER = 'creature_Name', -- 'You fail to dispel %s's %s.';
	HEALEDCRITOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s critically heals %s for %d.';
	HEALEDCRITOTHERSELF = 'creature_Name', -- '%s's %s critically heals you for %d.';
	HEALEDCRITSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s critically heals %s for %d.';
	HEALEDOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s heals %s for %d.';
	HEALEDOTHERSELF = 'creature_Name', -- '%s's %s heals you for %d.';
	HEALEDSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s heals %s for %d.';
	IMMUNEDAMAGECLASSOTHEROTHER = {{'creature_Name', all = true}}, -- '%s is immune to %s's %s damage.';
	IMMUNEDAMAGECLASSOTHERSELF = 'creature_Name', -- 'You are immune to %s's %s damage.';
	IMMUNEDAMAGECLASSSELFOTHER = 'creature_Name', -- '%s is immune to your %s damage.';
	IMMUNEOTHEROTHER = {{'creature_Name', all = true}}, -- '%s hits %s, who is  immune.';
	IMMUNEOTHERSELF = 'creature_Name', -- '%s hits you, but you are immune.';
	IMMUNESELFOTHER = 'creature_Name', -- 'You hit %s, who is immune.';
	IMMUNESPELLOTHEROTHER = {{'creature_Name', all = true}}, -- '%s is immune to %s's %s.';
	IMMUNESPELLOTHERSELF = 'creature_Name', -- 'You are immune to %s's %s.';
	IMMUNESPELLSELFOTHER = 'creature_Name', -- '%s is immune to your %s.';
	MISSEDOTHEROTHER = {{'creature_Name', all = true}}, -- '%s misses %s.';
	MISSEDOTHERSELF = 'creature_Name', -- '%s misses you.';
	MISSEDSELFOTHER = 'creature_Name', -- 'You miss %s.';
	PERIODICAURADAMAGEOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 4}}}, -- '%s suffers %d %s damage from %s's %s.';
	PERIODICAURADAMAGEOTHERSELF = {default_db1 = {db = {'creature_Name'}, cells = {3}}}, -- 'You suffer %d %s damage from %s's %s.';
	PERIODICAURADAMAGESELFOTHER = 'creature_Name', -- '%s suffers %d %s damage from your %s.';
	PERIODICAURAHEALOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s gains %d health from %s's %s.';
	PERIODICAURAHEALOTHERSELF = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- 'You gain %d health from %s's %s.';
	PERIODICAURAHEALSELFOTHER = 'creature_Name', -- '%s gains %d health from your %s.';
	POWERGAINOTHEROTHER = {'creature_Name', nil, nil, 'creature_Name'}, -- '%s gains %d %s from %s's %s.'; -- Bob gains 5 mana from Fred's spell.
	POWERGAINOTHERSELF = {default_db1 = {db = {'creature_Name'}, cells = {3}}}, -- 'You gain %d %s from %s's %s.'; -- You gain 5 mana from Bob's spell.
	POWERGAINSELFOTHER = 'creature_Name', -- '%s gains %d %s from %s.'; -- Bob gains 5 mana from spell.
	PROCRESISTOTHEROTHER = {{'creature_Name', all = true}}, -- '%s resists %s's %s.';
	PROCRESISTOTHERSELF = 'creature_Name', -- 'You resist %s's %s.';
	PROCRESISTSELFOTHER = 'creature_Name', -- '%s resists your %s.';
	SELFKILLOTHER = 'creature_Name', -- 'You have slain %s!';
	SIMPLECASTOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s casts %s on %s.';
	SIMPLECASTOTHERSELF = 'creature_Name', -- '%s casts %s on you.';
	SIMPLECASTSELFOTHER = {nil, 'creature_Name'}, -- 'You cast %s on %s.';
	SIMPLEPERFORMOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s performs %s on %s.';
	SIMPLEPERFORMOTHERSELF = 'creature_Name', -- '%s performs %s on you.';
	SIMPLEPERFORMSELFOTHER = {nil, 'creature_Name'}, -- 'You perform %s on %s.';
	SPELLBLOCKEDOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s was blocked by %s.';
	SPELLBLOCKEDOTHERSELF = 'creature_Name', -- '%s's %s was blocked.';
	SPELLBLOCKEDSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s was blocked by %s.';
	SPELLCASTGOOTHER = 'creature_Name', -- '%s casts %s.';
	SPELLCASTGOOTHERTARGETTED = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s casts %s on %s.';
	SPELLCASTGOSELFTARGETTED = {nil, 'creature_Name'}, -- 'You cast %s on %s.';
	SPELLCASTOTHERSTART = 'creature_Name', -- '%s begins to cast %s.';
	SPELLDEFLECTEDOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s was deflected by %s.';
	SPELLDEFLECTEDOTHERSELF = 'creature_Name', -- '%s's %s was deflected.';
	SPELLDEFLECTEDSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s was deflected by %s.';
	SPELLDISMISSPETOTHER = {{'creature_Name', all = true}}, -- '%s's %s is dismissed.';
	SPELLDISMISSPETSELF = 'creature_Name', -- 'Your %s is dismissed.';
	SPELLDODGEDOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s was dodged by %s.';
	SPELLDODGEDOTHERSELF = 'creature_Name', -- '%s's %s was dodged.';
	SPELLDODGEDSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s was dodged by %s.';
	SPELLDURABILITYDAMAGEALLOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s casts %s on %s: all items damaged.';
	SPELLDURABILITYDAMAGEALLOTHERSELF = 'creature_Name', -- '%s casts %s on you: all items damaged.';
	SPELLDURABILITYDAMAGEALLSELFOTHER = {nil, 'creature_Name'}, -- 'You cast %s on %s: all items damaged.';
	SPELLDURABILITYDAMAGEOTHEROTHER = {'creature_Name', nil, 'creature_Name', 'item_name'}, -- '%s casts %s on %s: %s damaged.';
	SPELLDURABILITYDAMAGEOTHERSELF = {'creature_Name', nil, 'item_name'}, -- '%s casts %s on you: %s damaged.';
	SPELLDURABILITYDAMAGESELFOTHER = {nil, 'creature_Name', 'item_name'}, -- 'You cast %s on %s: %s damaged.';
	SPELLEVADEDOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s was evaded by %s.';
	SPELLEVADEDOTHERSELF = 'creature_Name', -- '%s's %s was evaded.';
	SPELLEVADEDSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s was evaded by %s.';
	SPELLEXTRAATTACKSOTHER = 'creature_Name', -- '%s gains %d extra attacks through %s.';
	SPELLEXTRAATTACKSOTHER_SINGULAR = 'creature_Name', -- '%s gains %d extra attack through %s.';
	SPELLFAILCASTOTHER = 'creature_Name', -- '%s fails to cast %s: %s.';
	SPELLFAILCASTSELF = 'creature_Name', -- 'You fail to cast %s: %s.';
	SPELLFAILPERFORMOTHER = 'creature_Name', -- '%s fails to perform %s: %s.';
	SPELLFAILPERFORMSELF = 'creature_Name', -- 'You fail to perform %s: %s.';
	SPELLIMMUNEOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s fails. %s is immune.';
	SPELLIMMUNEOTHERSELF = 'creature_Name', -- '%s's %s failed. You are immune.';
	SPELLIMMUNESELFOTHER = {nil, 'creature_Name'}, -- 'Your %s failed. %s is immune.';
	SPELLINTERRUPTOTHEROTHER = {{'creature_Name', all = true}}, -- '%s interrupts %s's %s.';
	SPELLINTERRUPTOTHERSELF = 'creature_Name', -- '%s interrupts your %s.';
	SPELLINTERRUPTSELFOTHER = 'creature_Name', -- 'You interrupt %s's %s.';
	SPELLLOGABSORBOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s is absorbed by %s.';
	SPELLLOGABSORBOTHERSELF = 'creature_Name', -- 'You absorb %s's %s.';
	SPELLLOGABSORBSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s is absorbed by %s.';
	SPELLLOGCRITOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s crits %s for %d.';
	SPELLLOGCRITOTHERSELF = 'creature_Name', -- '%s's %s crits you for %d.';
	SPELLLOGCRITSCHOOLOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s crits %s for %d %s damage.';
	SPELLLOGCRITSCHOOLOTHERSELF = 'creature_Name', -- '%s's %s crits you for %d %s damage.';
	SPELLLOGCRITSCHOOLSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s crits %s for %d %s damage.';
	SPELLLOGCRITSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s crits %s for %d.';
	SPELLLOGOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s hits %s for %d.';
	SPELLLOGOTHERSELF = 'creature_Name', -- '%s's %s hits you for %d.';
	SPELLLOGSCHOOLOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s hits %s for %d %s damage.';
	SPELLLOGSCHOOLOTHERSELF = 'creature_Name', -- '%s's %s hits you for %d %s damage.';
	SPELLLOGSCHOOLSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s hits %s for %d %s damage.';
	SPELLLOGSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s hits %s for %d.';
	SPELLMISSOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s missed %s.';
	SPELLMISSOTHERSELF = 'creature_Name', -- '%s's %s misses you.';
	SPELLMISSSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s missed %s.';
	SPELLPARRIEDOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s was parried by %s.';
	SPELLPARRIEDOTHERSELF = 'creature_Name', -- '%s's %s was parried.';
	SPELLPARRIEDSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s is parried by %s.';
	SPELLPERFORMGOOTHER = 'creature_Name', -- '%s performs %s.';
	SPELLPERFORMGOOTHERTARGETTED = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s performs %s on %s.';
	SPELLPERFORMGOSELFTARGETTED = {nil, 'creature_Name'}, -- 'You perform %s on %s.';
	SPELLPERFORMOTHERSTART = 'creature_Name', -- '%s begins to perform %s.';
	SPELLPOWERDRAINOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 5}}}, -- '%s's %s drains %d %s from %s.';
	SPELLPOWERDRAINOTHERSELF = 'creature_Name', -- '%s's %s drains %d %s from you.';
	SPELLPOWERDRAINSELFOTHER = {default_db1 = {db = {'creature_Name'}, cells = {4}}}, -- 'Your %s drains %d %s from %s.';
	SPELLPOWERLEECHOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 5, 6}}}, -- '%s's %s drains %d %s from %s. %s gains %d %s.';
	SPELLPOWERLEECHOTHERSELF = {default_db1 = {db = {'creature_Name'}, cells = {1, 5}}}, -- '%s's %s drains %d %s from you. %s gains %d %s.';
	SPELLPOWERLEECHSELFOTHER = {default_db1 = {db = {'creature_Name'}, cells = {4}}}, -- 'Your %s drains %d %s from %s. You gain %d %s.';
	SPELLREFLECTOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s is reflected back by %s.';
	SPELLREFLECTOTHERSELF = 'creature_Name', -- 'You reflect %s's %s.';
	SPELLREFLECTSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s is reflected back by %s.';
	SPELLRESISTOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s was resisted by %s.';
	SPELLRESISTOTHERSELF = 'creature_Name', -- '%s's %s was resisted.';
	SPELLRESISTSELFOTHER = {nil, 'creature_Name'}, -- 'Your %s was resisted by %s.';
	SPELLSPLITDAMAGEOTHEROTHER = {default_db1 = {db = {'creature_Name'}, cells = {1, 3}}}, -- '%s's %s causes %s %d damage.';
	SPELLSPLITDAMAGEOTHERSELF = 'creature_Name', -- '%s's %s causes you %d damage.';
	SPELLSPLITDAMAGESELFOTHER = {nil, 'creature_Name'}, -- 'Your %s causes %s %d damage.';
	UNITDIESOTHER = 'creature_Name', -- '%s dies.';
	VSABSORBOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks. %s absorbs all the damage.';
	VSABSORBOTHERSELF = 'creature_Name', -- '%s attacks. You absorb all the damage.';
	VSABSORBSELFOTHER = 'creature_Name', -- 'You attack. %s absorbs all the damage.';
	VSBLOCKOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks. %s blocks.';
	VSBLOCKOTHERSELF = 'creature_Name', -- '%s attacks. You block.';
	VSBLOCKSELFOTHER = 'creature_Name', -- 'You attack. %s blocks.';
	VSDEFLECTOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks. %s deflects.';
	VSDEFLECTOTHERSELF = 'creature_Name', -- '%s attacks. You deflect.';
	VSDEFLECTSELFOTHER = 'creature_Name', -- 'You attack. %s deflects.';
	VSDODGEOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks. %s dodges.';
	VSDODGEOTHERSELF = 'creature_Name', -- '%s attacks. You dodge.';
	VSDODGESELFOTHER = 'creature_Name', -- 'You attack. %s dodges.';
	VSEVADEOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks. %s evades.';
	VSEVADEOTHERSELF = 'creature_Name', -- '%s attacks. You evade.';
	VSEVADESELFOTHER = 'creature_Name', -- 'You attack. %s evades.';
	VSIMMUNEOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks but %s is immune.';
	VSIMMUNEOTHERSELF = 'creature_Name', -- '%s attacks but you are immune.';
	VSIMMUNESELFOTHER = 'creature_Name', -- 'You attack but %s is immune.';
	VSPARRYOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks. %s parries.';
	VSPARRYOTHERSELF = 'creature_Name', -- '%s attacks. You parry.';
	VSPARRYSELFOTHER = 'creature_Name', -- 'You attack. %s parries.';
	VSRESISTOTHEROTHER = {{'creature_Name', all = true}}, -- '%s attacks. %s resists all the damage.';
	VSRESISTOTHERSELF = 'creature_Name', -- '%s attacks. You resist all the damage.';
	VSRESISTSELFOTHER = 'creature_Name', -- 'You attack. %s resists all the damage.';
}

ServTr.ChatFrameGroups = {
	monster = {'CHAT_MSG_MONSTER_SAY', 'CHAT_MSG_MONSTER_YELL', 'CHAT_MSG_MONSTER_EMOTE',
		'CHAT_MSG_MONSTER_WHISPER', 'CHAT_MSG_RAID_BOSS_EMOTE', 'CHAT_MSG_RAID_BOSS_WHISPER'},
	battleground = {'CHAT_MSG_BG_SYSTEM_ALLIANCE', 'CHAT_MSG_BG_SYSTEM_HORDE', 'CHAT_MSG_BG_SYSTEM_NEUTRAL'},
	player = {'CHAT_MSG_SAY', 'CHAT_MSG_YELL', 'CHAT_MSG_WHISPER', 'CHAT_MSG_WHISPER_INFORM', 'CHAT_MSG_LOOT',
		'CHAT_MSG_CHANNEL', 'CHAT_MSG_GUILD', 'CHAT_MSG_OFFICER', 'CHAT_MSG_PARTY', 'CHAT_MSG_PARTY_LEADER',
		'CHAT_MSG_RAID', 'CHAT_MSG_RAID_LEADER', 'CHAT_MSG_RAID_WARNING'},
	combatlog = {'CHAT_MSG_COMBAT_ERROR', 'CHAT_MSG_COMBAT_MISC_INFO', 'CHAT_MSG_COMBAT_SELF_HITS',
		'CHAT_MSG_COMBAT_SELF_MISSES', 'CHAT_MSG_COMBAT_PET_HITS', 'CHAT_MSG_COMBAT_PET_MISSES',
		'CHAT_MSG_COMBAT_PARTY_HITS', 'CHAT_MSG_COMBAT_PARTY_MISSES', 'CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS',
		'CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES', 'CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS', 'CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES',
		'CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS', 'CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES', 'CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS',
		'CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES', 'CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS', 'CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES',
		'CHAT_MSG_COMBAT_FRIENDLY_DEATH', 'CHAT_MSG_COMBAT_HOSTILE_DEATH', 'CHAT_MSG_COMBAT_XP_GAIN', 'CHAT_MSG_COMBAT_HONOR_GAIN',
		'CHAT_MSG_SPELL_SELF_DAMAGE', 'CHAT_MSG_SPELL_SELF_BUFF', 'CHAT_MSG_SPELL_PET_DAMAGE', 'CHAT_MSG_SPELL_PET_BUFF',
		'CHAT_MSG_SPELL_PARTY_DAMAGE', 'CHAT_MSG_SPELL_PARTY_BUFF', 'CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE',
		'CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF', 'CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE', 'CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF',
		'CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE', 'CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF', 'CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE',
		'CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF', 'CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE', 'CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF',
		'CHAT_MSG_SPELL_TRADESKILLS', 'CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF', 'CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS',
		'CHAT_MSG_SPELL_AURA_GONE_SELF', 'CHAT_MSG_SPELL_AURA_GONE_PARTY', 'CHAT_MSG_SPELL_AURA_GONE_OTHER',
		'CHAT_MSG_SPELL_ITEM_ENCHANTMENTS', 'CHAT_MSG_SPELL_BREAK_AURA', 'CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE',
		'CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS', 'CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE', 'CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS',
		'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE', 'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS', 'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE',
		'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS', 'CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE', 'CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS',
		'CHAT_MSG_SPELL_FAILED_LOCALPLAYER', 'CHAT_MSG_COMBAT_FACTION_CHANGE'}
}
