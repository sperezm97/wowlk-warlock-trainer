-- Database of Warlock Trainer Spells for WoW 3.3.5a (WotLK)
local addonName, WT = ...
WT = WT or {}

-- Structure:
-- id: Spell ID
-- level: Required Level
-- cost: Base training cost in copper (100 copper = 1 silver, 10000 copper = 1 gold)
-- defaultName: Fallback English/Spanish name if not cached
-- defaultRank: Spell Rank
-- defaultIcon: Icon path if not cached
WT.SpellsDatabase = {
    -- Level 1
    { id = 686,   level = 1,  cost = 10,     defaultName = "Shadow Bolt", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 687,   level = 1,  cost = 10,     defaultName = "Demon Skin", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 348,   level = 1,  cost = 10,     defaultName = "Immolate", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Fire_Immolation" },

    -- Level 4
    { id = 172,   level = 4,  cost = 40,     defaultName = "Corruption", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 702,   level = 4,  cost = 40,     defaultName = "Curse of Weakness", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth" },

    -- Level 6
    { id = 695,   level = 6,  cost = 100,    defaultName = "Shadow Bolt", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 1454,  level = 6,  cost = 100,    defaultName = "Life Tap", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },

    -- Level 8
    { id = 5782,  level = 8,  cost = 250,    defaultName = "Fear", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_Possession" },
    { id = 980,   level = 8,  cost = 250,    defaultName = "Curse of Agony", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },

    -- Level 10
    { id = 6201,  level = 10, cost = 500,    defaultName = "Create Healthstone (Minor)", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\INV_Stone_04" },
    { id = 1120,  level = 10, cost = 500,    defaultName = "Drain Soul", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_Haunting" },
    { id = 696,   level = 10, cost = 500,    defaultName = "Demon Skin", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },

    -- Level 12
    { id = 705,   level = 12, cost = 800,    defaultName = "Shadow Bolt", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 6222,  level = 12, cost = 800,    defaultName = "Corruption", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 1108,  level = 12, cost = 800,    defaultName = "Curse of Weakness", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth" },
    { id = 755,   level = 12, cost = 800,    defaultName = "Health Funnel", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },

    -- Level 14
    { id = 689,   level = 14, cost = 1200,   defaultName = "Drain Life", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 1455,  level = 14, cost = 1200,   defaultName = "Life Tap", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },
    { id = 1714,  level = 14, cost = 1200,   defaultName = "Curse of Tongues", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfTounges" },

    -- Level 16
    { id = 2070,  level = 16, cost = 1800,   defaultName = "Create Soulstone (Minor)", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_SoulGem" },
    { id = 5697,  level = 16, cost = 1800,   defaultName = "Unending Breath", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_DemonBreath" },
    { id = 5676,  level = 16, cost = 1800,   defaultName = "Searing Pain", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },

    -- Level 18
    { id = 6223,  level = 18, cost = 2500,   defaultName = "Corruption", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 1014,  level = 18, cost = 2500,   defaultName = "Curse of Agony", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
    { id = 6202,  level = 18, cost = 2500,   defaultName = "Create Healthstone (Lesser)", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\INV_Stone_04" },

    -- Level 20
    { id = 706,   level = 20, cost = 3500,   defaultName = "Demon Armor", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 8288,  level = 20, cost = 3500,   defaultName = "Drain Soul", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_Haunting" },
    { id = 5740,  level = 20, cost = 3500,   defaultName = "Rain of Fire", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_RainOfFire" },
    { id = 698,   level = 20, cost = 3500,   defaultName = "Ritual of Summoning", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_Twilight" },
    { id = 1088,  level = 20, cost = 3500,   defaultName = "Shadow Bolt", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 3698,  level = 20, cost = 3500,   defaultName = "Health Funnel", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },

    -- Level 22
    { id = 7648,  level = 22, cost = 5000,   defaultName = "Corruption", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 6205,  level = 22, cost = 5000,   defaultName = "Curse of Weakness", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth" },
    { id = 699,   level = 22, cost = 5000,   defaultName = "Drain Life", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 126,   level = 22, cost = 5000,   defaultName = "Eye of Kilrogg", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_EvilEye" },

    -- Level 24
    { id = 2075,  level = 24, cost = 7000,   defaultName = "Create Soulstone (Lesser)", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_SoulGem" },
    { id = 5138,  level = 24, cost = 7000,   defaultName = "Drain Mana", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
    { id = 1456,  level = 24, cost = 7000,   defaultName = "Life Tap", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },
    { id = 17919, level = 24, cost = 7000,   defaultName = "Searing Pain", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 1089,  level = 24, cost = 7000,   defaultName = "Shadow Bolt", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 5500,  level = 24, cost = 7000,   defaultName = "Sense Demons", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_Metamorphosis" },

    -- Level 26
    { id = 988,   level = 26, cost = 9000,   defaultName = "Curse of Agony", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
    { id = 11719, level = 26, cost = 9000,   defaultName = "Curse of Tongues", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfTounges" },
    { id = 6213,  level = 26, cost = 9000,   defaultName = "Fear", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_Possession" },

    -- Level 28
    { id = 710,   level = 28, cost = 12000,  defaultName = "Banish", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_Cripple" },
    { id = 5699,  level = 28, cost = 12000,  defaultName = "Create Healthstone", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\INV_Stone_04" },
    { id = 11671, level = 28, cost = 12000,  defaultName = "Corruption", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 1090,  level = 28, cost = 12000,  defaultName = "Shadow Bolt", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },

    -- Level 30
    { id = 1086,  level = 30, cost = 15000,  defaultName = "Demon Armor", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 1098,  level = 30, cost = 15000,  defaultName = "Enslave Demon", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_EnslaveDemon" },
    { id = 1949,  level = 30, cost = 15000,  defaultName = "Hellfire", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Fire_Incinerate" },
    { id = 709,   level = 30, cost = 15000,  defaultName = "Drain Life", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 3699,  level = 30, cost = 15000,  defaultName = "Health Funnel", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },
    { id = 17920, level = 30, cost = 15000,  defaultName = "Searing Pain", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },

    -- Level 32
    { id = 7646,  level = 32, cost = 18000,  defaultName = "Curse of Weakness", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth" },
    { id = 1490,  level = 32, cost = 18000,  defaultName = "Curse of the Elements", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_ChillTouch" },
    { id = 1091,  level = 32, cost = 18000,  defaultName = "Shadow Bolt", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 6366,  level = 32, cost = 18000,  defaultName = "Create Firestone (Lesser)", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\INV_Ammo_FireHearth" },

    -- Level 34
    { id = 2076,  level = 34, cost = 22000,  defaultName = "Create Soulstone", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_SoulGem" },
    { id = 6226,  level = 34, cost = 22000,  defaultName = "Drain Mana", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
    { id = 6219,  level = 34, cost = 22000,  defaultName = "Rain of Fire", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_RainOfFire" },
    { id = 17921, level = 34, cost = 22000,  defaultName = "Searing Pain", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 1457,  level = 34, cost = 22000,  defaultName = "Life Tap", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },

    -- Level 36
    { id = 11672, level = 36, cost = 26000,  defaultName = "Corruption", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 2362,  level = 36, cost = 26000,  defaultName = "Create Spellstone", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\INV_Misc_Gem_Sapphire_01" },
    { id = 6217,  level = 36, cost = 26000,  defaultName = "Curse of Agony", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
    { id = 8289,  level = 36, cost = 26000,  defaultName = "Drain Soul", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_Haunting" },
    { id = 11729, level = 36, cost = 26000,  defaultName = "Create Healthstone (Greater)", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\INV_Stone_04" },

    -- Level 38
    { id = 7651,  level = 38, cost = 30000,  defaultName = "Drain Life", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 5484,  level = 38, cost = 30000,  defaultName = "Howl of Terror", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_DeathScream" },
    { id = 7641,  level = 38, cost = 30000,  defaultName = "Shadow Bolt", defaultRank = "Rank 8", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },

    -- Level 40
    { id = 11733, level = 40, cost = 35000,  defaultName = "Demon Armor", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 17922, level = 40, cost = 35000,  defaultName = "Searing Pain", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 3700,  level = 40, cost = 35000,  defaultName = "Health Funnel", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },
    { id = 5784,  level = 40, cost = 35000,  defaultName = "Summon Felsteed", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Nature_Swiftness" },

    -- Level 42
    { id = 11707, level = 42, cost = 40000,  defaultName = "Curse of Weakness", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth" },
    { id = 11725, level = 42, cost = 40000,  defaultName = "Enslave Demon", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_EnslaveDemon" },
    { id = 11683, level = 42, cost = 40000,  defaultName = "Hellfire", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Fire_Incinerate" },
    { id = 11659, level = 42, cost = 40000,  defaultName = "Shadow Bolt", defaultRank = "Rank 9", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 6789,  level = 42, cost = 40000,  defaultName = "Death Coil", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_DeathCoil" },

    -- Level 44
    { id = 11674, level = 44, cost = 45000,  defaultName = "Corruption", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 2077,  level = 44, cost = 45000,  defaultName = "Create Soulstone (Greater)", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_SoulGem" },
    { id = 11677, level = 44, cost = 45000,  defaultName = "Rain of Fire", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_RainOfFire" },
    { id = 11687, level = 44, cost = 45000,  defaultName = "Life Tap", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },
    { id = 11730, level = 44, cost = 45000,  defaultName = "Create Healthstone (Major)", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\INV_Stone_04" },

    -- Level 46
    { id = 11711, level = 46, cost = 50000,  defaultName = "Curse of Agony", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
    { id = 11693, level = 46, cost = 50000,  defaultName = "Drain Life", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 11703, level = 46, cost = 50000,  defaultName = "Drain Mana", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
    { id = 17923, level = 46, cost = 50000,  defaultName = "Searing Pain", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 17951, level = 46, cost = 50000,  defaultName = "Create Firestone", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\INV_Ammo_FireHearth" },

    -- Level 48
    { id = 18647, level = 48, cost = 55000,  defaultName = "Banish", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_Cripple" },
    { id = 6353,  level = 48, cost = 55000,  defaultName = "Soul Fire", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Fire_Fireball02" },
    { id = 11660, level = 48, cost = 55000,  defaultName = "Shadow Bolt", defaultRank = "Rank 10", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 17727, level = 48, cost = 55000,  defaultName = "Create Spellstone (Greater)", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\INV_Misc_Gem_Sapphire_01" },

    -- Level 50
    { id = 11734, level = 50, cost = 60000,  defaultName = "Demon Armor", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 11675, level = 50, cost = 60000,  defaultName = "Drain Soul", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_Haunting" },
    { id = 11688, level = 50, cost = 60000,  defaultName = "Health Funnel", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },
    { id = 1122,  level = 50, cost = 60000,  defaultName = "Inferno", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_SummonInfernal" },
    { id = 603,   level = 50, cost = 60000,  defaultName = "Curse of Doom", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_AuraOfDarkness" },

    -- Level 52
    { id = 25384, level = 52, cost = 65000,  defaultName = "Corruption", defaultRank = "Rank 8", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 11708, level = 52, cost = 65000,  defaultName = "Curse of Weakness", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth" },
    { id = 11694, level = 52, cost = 65000,  defaultName = "Drain Life", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 11678, level = 52, cost = 65000,  defaultName = "Rain of Fire", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_RainOfFire" },
    { id = 11661, level = 52, cost = 65000,  defaultName = "Shadow Bolt", defaultRank = "Rank 11", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },

    -- Level 54
    { id = 11732, level = 54, cost = 70000,  defaultName = "Create Soulstone (Major)", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_SoulGem" },
    { id = 11684, level = 54, cost = 70000,  defaultName = "Hellfire", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Fire_Incinerate" },
    { id = 17928, level = 54, cost = 70000,  defaultName = "Howl of Terror", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_DeathScream" },
    { id = 17924, level = 54, cost = 70000,  defaultName = "Searing Pain", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 11689, level = 54, cost = 70000,  defaultName = "Life Tap", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },
    { id = 17925, level = 54, cost = 70000,  defaultName = "Death Coil", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_DeathCoil" },

    -- Level 56
    { id = 11712, level = 56, cost = 75000,  defaultName = "Curse of Agony", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
    { id = 17952, level = 56, cost = 75000,  defaultName = "Create Firestone (Major)", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\INV_Ammo_FireHearth" },
    { id = 25307, level = 56, cost = 75000,  defaultName = "Shadow Bolt", defaultRank = "Rank 12", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 11713, level = 56, cost = 75000,  defaultName = "Curse of the Elements", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_ChillTouch" },

    -- Level 58
    { id = 11704, level = 58, cost = 80000,  defaultName = "Drain Mana", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
    { id = 11695, level = 58, cost = 80000,  defaultName = "Drain Life", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 17924, level = 58, cost = 80000,  defaultName = "Soul Fire", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Fire_Fireball02" },
    { id = 11731, level = 58, cost = 80000,  defaultName = "Create Healthstone (Master)", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\INV_Stone_04" },
    { id = 17728, level = 58, cost = 80000,  defaultName = "Create Spellstone (Major)", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\INV_Misc_Gem_Sapphire_01" },

    -- Level 60
    { id = 30910, level = 60, cost = 100000, defaultName = "Curse of Doom", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_AuraOfDarkness" },
    { id = 27260, level = 60, cost = 100000, defaultName = "Demon Armor", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 18540, level = 60, cost = 100000, defaultName = "Ritual of Doom", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_AntiShadow" },
    { id = 27259, level = 60, cost = 100000, defaultName = "Health Funnel", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },
    { id = 23161, level = 60, cost = 100000, defaultName = "Summon Dreadsteed", defaultRank = "", defaultIcon = "Interface\\Icons\\Ability_Mount_Dreadsteed" },
    { id = 27223, level = 60, cost = 100000, defaultName = "Fear", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_Possession" },

    -- Level 62
    { id = 27215, level = 62, cost = 110000, defaultName = "Corruption", defaultRank = "Rank 9", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 29722, level = 62, cost = 110000, defaultName = "Incinerate", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Fire_Burnout" },
    { id = 28176, level = 62, cost = 110000, defaultName = "Fel Armor", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_FelMending" },

    -- Level 64
    { id = 27212, level = 64, cost = 120000, defaultName = "Rain of Fire", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_RainOfFire" },
    { id = 27209, level = 64, cost = 120000, defaultName = "Shadow Bolt", defaultRank = "Rank 13", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 27220, level = 64, cost = 120000, defaultName = "Drain Mana", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
    { id = 27238, level = 64, cost = 120000, defaultName = "Create Soulstone (Master)", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_SoulGem" },

    -- Level 66
    { id = 27210, level = 66, cost = 130000, defaultName = "Searing Pain", defaultRank = "Rank 8", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 27219, level = 66, cost = 130000, defaultName = "Drain Life", defaultRank = "Rank 8", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 27222, level = 66, cost = 130000, defaultName = "Life Tap", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },

    -- Level 68
    { id = 27211, level = 68, cost = 140000, defaultName = "Soul Fire", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Fire_Fireball02" },
    { id = 27213, level = 68, cost = 140000, defaultName = "Hellfire", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Fire_Incinerate" },
    { id = 27218, level = 68, cost = 140000, defaultName = "Curse of Agony", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
    { id = 27243, level = 68, cost = 140000, defaultName = "Seed of Corruption", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_SeedOfDestruction" },
    { id = 27250, level = 68, cost = 140000, defaultName = "Create Firestone", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\INV_Ammo_FireHearth" },
    { id = 27223, level = 68, cost = 140000, defaultName = "Death Coil", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_DeathCoil" },

    -- Level 70
    { id = 30545, level = 70, cost = 160000, defaultName = "Shadow Bolt", defaultRank = "Rank 14", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 31653, level = 70, cost = 160000, defaultName = "Corruption", defaultRank = "Rank 10", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 30482, level = 70, cost = 160000, defaultName = "Fel Armor", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_FelMending" },
    { id = 31656, level = 70, cost = 160000, defaultName = "Demon Armor", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 32231, level = 70, cost = 160000, defaultName = "Incinerate", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Fire_Burnout" },
    { id = 30486, level = 70, cost = 160000, defaultName = "Seed of Corruption", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_SeedOfDestruction" },
    { id = 29893, level = 70, cost = 160000, defaultName = "Ritual of Souls", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Spell_Shadow_Shades" },
    { id = 27230, level = 70, cost = 160000, defaultName = "Create Healthstone", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\INV_Stone_04" },
    { id = 30911, level = 70, cost = 160000, defaultName = "Curse of Doom", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_AuraOfDarkness" },
    { id = 28172, level = 70, cost = 160000, defaultName = "Create Spellstone", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\INV_Misc_Gem_Sapphire_01" },

    -- Level 71
    { id = 47819, level = 71, cost = 170000, defaultName = "Rain of Fire", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_RainOfFire" },
    { id = 47855, level = 71, cost = 170000, defaultName = "Drain Mana", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },

    -- Level 72
    { id = 47808, level = 72, cost = 180000, defaultName = "Shadow Bolt", defaultRank = "Rank 15", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 47814, level = 72, cost = 180000, defaultName = "Searing Pain", defaultRank = "Rank 9", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 47882, level = 72, cost = 180000, defaultName = "Create Soulstone (Demonic)", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_SoulGem" },

    -- Level 73
    { id = 47812, level = 73, cost = 190000, defaultName = "Corruption", defaultRank = "Rank 11", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 47856, level = 73, cost = 190000, defaultName = "Drain Life", defaultRank = "Rank 9", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 47863, level = 73, cost = 190000, defaultName = "Curse of Agony", defaultRank = "Rank 8", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },

    -- Level 74
    { id = 47837, level = 74, cost = 200000, defaultName = "Incinerate", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Fire_Burnout" },
    { id = 47889, level = 74, cost = 200000, defaultName = "Fel Armor", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_FelMending" },
    { id = 47793, level = 74, cost = 200000, defaultName = "Demon Armor", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 47883, level = 74, cost = 200000, defaultName = "Create Firestone (Grand)", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\INV_Ammo_FireHearth" },

    -- Level 75
    { id = 48018, level = 75, cost = 220000, defaultName = "Demonic Circle: Summon", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_DemonicCircleSummon" },
    { id = 48020, level = 75, cost = 220000, defaultName = "Demonic Circle: Teleport", defaultRank = "", defaultIcon = "Interface\\Icons\\Spell_Shadow_DemonicCircleTeleport" },
    { id = 47820, level = 75, cost = 220000, defaultName = "Hellfire", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Fire_Incinerate" },
    { id = 47897, level = 75, cost = 220000, defaultName = "Shadowflame", defaultRank = "Rank 1", defaultIcon = "Interface\\Icons\\Ability_Warlock_ShadowFlame" },

    -- Level 76
    { id = 47835, level = 76, cost = 230000, defaultName = "Seed of Corruption", defaultRank = "Rank 3", defaultIcon = "Interface\\Icons\\Spell_Shadow_SeedOfDestruction" },
    { id = 47824, level = 76, cost = 230000, defaultName = "Soul Fire", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Fire_Fireball02" },
    { id = 47886, level = 76, cost = 230000, defaultName = "Create Spellstone (Grand)", defaultRank = "Rank 6", defaultIcon = "Interface\\Icons\\INV_Misc_Gem_Sapphire_01" },

    -- Level 77
    { id = 47821, level = 77, cost = 240000, defaultName = "Rain of Fire", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\Spell_Shadow_RainOfFire" },
    { id = 47815, level = 77, cost = 240000, defaultName = "Searing Pain", defaultRank = "Rank 10", defaultIcon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
    { id = 47871, level = 77, cost = 240000, defaultName = "Create Healthstone (Fel)", defaultRank = "Rank 7", defaultIcon = "Interface\\Icons\\INV_Stone_04" },

    -- Level 78
    { id = 47857, level = 78, cost = 250000, defaultName = "Drain Life", defaultRank = "Rank 10", defaultIcon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
    { id = 47864, level = 78, cost = 250000, defaultName = "Curse of Agony", defaultRank = "Rank 9", defaultIcon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
    { id = 47856, level = 78, cost = 250000, defaultName = "Drain Soul", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Shadow_Haunting" },
    { id = 47860, level = 78, cost = 250000, defaultName = "Death Coil", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_DeathCoil" },

    -- Level 79
    { id = 47809, level = 79, cost = 260000, defaultName = "Shadow Bolt", defaultRank = "Rank 16", defaultIcon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
    { id = 47813, level = 79, cost = 260000, defaultName = "Corruption", defaultRank = "Rank 12", defaultIcon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
    { id = 47838, level = 79, cost = 260000, defaultName = "Incinerate", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Fire_Burnout" },

    -- Level 80
    { id = 47825, level = 80, cost = 280000, defaultName = "Soul Fire", defaultRank = "Rank 5", defaultIcon = "Interface\\Icons\\Spell_Fire_Fireball02" },
    { id = 47893, level = 80, cost = 280000, defaultName = "Fel Armor", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_FelMending" },
    { id = 47795, level = 80, cost = 280000, defaultName = "Demon Armor", defaultRank = "Rank 8", defaultIcon = "Interface\\Icons\\Spell_Shadow_RagingScream" },
    { id = 61290, level = 80, cost = 280000, defaultName = "Shadowflame", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Ability_Warlock_ShadowFlame" },
    { id = 58887, level = 80, cost = 280000, defaultName = "Ritual of Souls", defaultRank = "Rank 2", defaultIcon = "Interface\\Icons\\Spell_Shadow_Shades" },
    { id = 47867, level = 80, cost = 280000, defaultName = "Curse of Doom", defaultRank = "Rank 4", defaultIcon = "Interface\\Icons\\Spell_Shadow_AuraOfDarkness" },
    { id = 47878, level = 80, cost = 280000, defaultName = "Create Healthstone", defaultRank = "Rank 8", defaultIcon = "Interface\\Icons\\INV_Stone_04" },
}

-- Utility function to populate localized name & rank from client cache if available
function WT:InitializeSpells()
    for _, spell in ipairs(WT.SpellsDatabase) do
        local name, rank, icon = GetSpellInfo(spell.id)
        spell.name = name or spell.defaultName
        spell.rank = (rank and rank ~= "") and rank or spell.defaultRank
        spell.icon = icon or spell.defaultIcon
    end
end
