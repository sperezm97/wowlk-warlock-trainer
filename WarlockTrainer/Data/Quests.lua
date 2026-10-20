-- Database of Warlock Class Quests for WoW 3.3.5a (WotLK)
local addonName, WT = ...
WT = WT or {}

-- Factions: "Alliance", "Horde", "Both"
WT.ClassQuestsDatabase = {
    -- ==================== LEVEL 10: VOIDWALKER ====================
    {
        id = "voidwalker_human",
        level = 10,
        title = "Invocación del Abisario (Humanos)",
        titleEn = "Summon Voidwalker (Human)",
        petName = "Abisario / Voidwalker",
        faction = "Alliance",
        race = "Human",
        rewardSpellId = 697, -- Summon Voidwalker
        questIds = { 1685, 1688, 1689 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonVoidWalker",
        startNPC = {
            name = "Gakin the Two-Faced",
            nameEs = "Gakin el Dos Caras",
            zone = "Stormwind City",
            zoneEs = "Ciudad de Ventormenta",
            subzone = "The Slaughtered Lamb (The Mage Quarter)",
            x = 39.2, y = 85.0
        },
        endNPC = {
            name = "Gakin the Two-Faced",
            nameEs = "Gakin el Dos Caras",
            zone = "Stormwind City",
            zoneEs = "Ciudad de Ventormenta",
            subzone = "The Slaughtered Lamb",
            x = 39.2, y = 85.0
        },
        steps = {
            "1. Habla con Gakin en el sótano de El Cordero Degollado (Ventormenta).",
            "2. Ve al Huerto de Brackwell en el Bosque de Elwynn (coords 74, 50).",
            "3. Derrota a Surena Caledor y despoja el 'Gargantilla de las Sombras'.",
            "4. Regresa con Gakin, baja a la cripta de invocación del sótano.",
            "5. Usa el tomo para invocar al Abisario, derrótalo en combate y habla con Gakin para aprender la habilidad."
        },
        materials = {}
    },
    {
        id = "voidwalker_gnome",
        level = 10,
        title = "Invocación del Abisario (Gnomos)",
        titleEn = "Summon Voidwalker (Gnome)",
        petName = "Abisario / Voidwalker",
        faction = "Alliance",
        race = "Gnome",
        rewardSpellId = 697,
        questIds = { 1717, 1718, 1720 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonVoidWalker",
        startNPC = {
            name = "Lago Blackshield",
            nameEs = "Lago Escudonegro",
            zone = "Ironforge",
            zoneEs = "Forjaz",
            subzone = "Forlorn Cavern",
            x = 51.6, y = 17.8
        },
        endNPC = {
            name = "Lago Blackshield",
            nameEs = "Lago Escudonegro",
            zone = "Ironforge",
            zoneEs = "Forjaz",
            subzone = "Forlorn Cavern",
            x = 51.6, y = 17.8
        },
        steps = {
            "1. Habla con Lago Escudonegro en la Caverna Forastera en Forjaz.",
            "2. Ve a Loch Modan y busca el campamento de troggs.",
            "3. Consigue la 'Piedra de alma' o el objeto requerido de los troggs.",
            "4. Regresa a Forjaz, realiza el ritual en el círculo de invocación y derrota al Abisario."
        },
        materials = {}
    },
    {
        id = "voidwalker_orc",
        level = 10,
        title = "Invocación del Abisario (Orcos)",
        titleEn = "Summon Voidwalker (Orc)",
        petName = "Abisario / Voidwalker",
        faction = "Horde",
        race = "Orc",
        rewardSpellId = 697,
        questIds = { 1504, 1506, 1507 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonVoidWalker",
        startNPC = {
            name = "Gan'rul Bloodeye",
            nameEs = "Gan'rul Ojosangre",
            zone = "Orgrimmar",
            zoneEs = "Orgrimmar",
            subzone = "Cleft of Shadows",
            x = 48.0, y = 46.4
        },
        endNPC = {
            name = "Gan'rul Bloodeye",
            nameEs = "Gan'rul Ojosangre",
            zone = "Orgrimmar",
            zoneEs = "Orgrimmar",
            subzone = "Cleft of Shadows",
            x = 48.0, y = 46.4
        },
        steps = {
            "1. Habla con Gan'rul Ojosangre en la Hondonada de las Sombras (Orgrimmar).",
            "2. Ve a Durotar y busca a Ghaz'an o a los espíritus en la quebrada del río.",
            "3. Recoge la 'Calabera de Ghaz'an' y llévasela a Gan'rul.",
            "4. Baja al círculo de invocación, invoca al Abisario y véncelo para someterlo."
        },
        materials = {}
    },
    {
        id = "voidwalker_undead",
        level = 10,
        title = "Invocación del Abisario (No-muertos)",
        titleEn = "Summon Voidwalker (Undead)",
        petName = "Abisario / Voidwalker",
        faction = "Horde",
        race = "Undead",
        rewardSpellId = 697,
        questIds = { 1473, 1475, 1476 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonVoidWalker",
        startNPC = {
            name = "Carendin Halgar",
            nameEs = "Carendin Halgar",
            zone = "Undercity",
            zoneEs = "Entrañas",
            subzone = "The Magic Quarter",
            x = 85.0, y = 16.0
        },
        endNPC = {
            name = "Carendin Halgar",
            nameEs = "Carendin Halgar",
            zone = "Undercity",
            zoneEs = "Entrañas",
            subzone = "The Magic Quarter",
            x = 85.0, y = 16.0
        },
        steps = {
            "1. Habla con Carendin Halgar en el Barrio de los Magos de Entrañas.",
            "2. Dirígete a los Claros de Tirisfal, al campamento en las ruinas de Garren.",
            "3. Despoja la 'Hoz de Ager' y regrésala a Carendin.",
            "4. En el círculo de invocación de Entrañas, convoca al Abisario y véncelo."
        },
        materials = {}
    },
    {
        id = "voidwalker_belf",
        level = 10,
        title = "Invocación del Abisario (Elfos de Sangre)",
        titleEn = "Summon Voidwalker (Blood Elf)",
        petName = "Abisario / Voidwalker",
        faction = "Horde",
        race = "BloodElf",
        rewardSpellId = 697,
        questIds = { 8478, 8479 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonVoidWalker",
        startNPC = {
            name = "Talionia",
            nameEs = "Talionia",
            zone = "Silvermoon City",
            zoneEs = "Ciudad de Lunargenta",
            subzone = "Murder Row",
            x = 74.6, y = 44.8
        },
        endNPC = {
            name = "Talionia",
            nameEs = "Talionia",
            zone = "Silvermoon City",
            zoneEs = "Ciudad de Lunargenta",
            subzone = "Murder Row",
            x = 74.6, y = 44.8
        },
        steps = {
            "1. Habla con Talionia en el Callejón del Asesino (Ciudad de Lunargenta).",
            "2. Viaja a las Tierras Fantasma y busca la 'Piedra del Vórtice' en El Enclave del Sol.",
            "3. Despoja la gema requerida y regresa a Lunargenta.",
            "4. Invoca al Abisario en el círculo del sótano, somételo y aprende la habilidad."
        },
        materials = {}
    },

    -- ==================== LEVEL 20: SUCCUBUS ====================
    {
        id = "succubus_alliance",
        level = 20,
        title = "Invocación de la Súcubo (Alianza)",
        titleEn = "Summon Succubus (Alliance)",
        petName = "Súcubo / Succubus",
        faction = "Alliance",
        rewardSpellId = 712, -- Summon Succubus
        questIds = { 1715, 1738, 1739, 1716 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonSuccubus",
        startNPC = {
            name = "Gakin the Two-Faced",
            nameEs = "Gakin el Dos Caras",
            zone = "Stormwind City",
            zoneEs = "Ciudad de Ventormenta",
            subzone = "The Slaughtered Lamb",
            x = 39.2, y = 85.0
        },
        endNPC = {
            name = "Gakin the Two-Faced",
            nameEs = "Gakin el Dos Caras",
            zone = "Stormwind City",
            zoneEs = "Ciudad de Ventormenta",
            subzone = "The Slaughtered Lamb",
            x = 39.2, y = 85.0
        },
        steps = {
            "1. Acepta la misión de Gakin en el sótano de El Cordero Degollado (Ventormenta).",
            "2. Habla con Takar el Vidente en Trinquete (Los Baldíos).",
            "3. Ve a Los Baldíos y encuentra el 'Corazón de la Pureza' en el árbol.",
            "4. Ve a Las Montañas Crestagrana y recupera el segundo corazón.",
            "5. Regresa con Gakin a Ventormenta, desciende al círculo ritual, invoca a la Súcubo y derrótala."
        },
        materials = {}
    },
    {
        id = "succubus_horde",
        level = 20,
        title = "Invocación de la Súcubo (Horda)",
        titleEn = "Summon Succubus (Horde)",
        petName = "Súcubo / Succubus",
        faction = "Horde",
        rewardSpellId = 712,
        questIds = { 1509, 1510, 1511, 1512, 9544 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonSuccubus",
        startNPC = {
            name = "Carendin Halgar / Zevrost",
            nameEs = "Carendin Halgar / Zevrost",
            zone = "Undercity / Orgrimmar",
            zoneEs = "Entrañas / Orgrimmar",
            subzone = "Magic Quarter / Cleft of Shadows",
            x = 48.4, y = 45.8
        },
        endNPC = {
            name = "Carendin Halgar / Zevrost",
            nameEs = "Carendin Halgar / Zevrost",
            zone = "Undercity / Orgrimmar",
            zoneEs = "Entrañas / Orgrimmar",
            subzone = "Magic Quarter / Cleft of Shadows",
            x = 48.4, y = 45.8
        },
        steps = {
            "1. Inicia la misión con tu instructor en Orgrimmar o Entrañas.",
            "2. Te enviarán a hablar con Gazrog en Los Baldíos o los amantes perdidos.",
            "3. Encuentra los restos de Ken'zigla y recupera el colgante y el corazón.",
            "4. Regresa con tu instructor, invoca a la Súcubo en el círculo demoníaco y véncela."
        },
        materials = {}
    },

    -- ==================== LEVEL 30: FELHUNTER ====================
    {
        id = "felhunter",
        level = 30,
        title = "Invocación del Manáfago (Cadena Completa)",
        titleEn = "Summon Felhunter",
        petName = "Manáfago / Felhunter",
        faction = "Both",
        rewardSpellId = 691, -- Summon Felhunter
        questIds = { 1758, 1798, 1799, 1800, 1801, 1802 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonFelHunter",
        startNPC = {
            name = "Strahad Farsan",
            nameEs = "Strahad Farsan",
            zone = "The Barrens",
            zoneEs = "Los Baldíos",
            subzone = "Ratchet (Tower)",
            x = 62.4, y = 35.8
        },
        endNPC = {
            name = "Strahad Farsan",
            nameEs = "Strahad Farsan",
            zone = "The Barrens",
            zoneEs = "Los Baldíos",
            subzone = "Ratchet (Tower)",
            x = 62.4, y = 35.8
        },
        steps = {
            "1. Ve a la torre sobre Trinquete en Los Baldíos y habla con Strahad Farsan.",
            "2. Tomo de la Cábala: Busca el fragmento en Los Humedales (o Las Mil Agujas para Horda) y en Entrañas/Forjaz.",
            "3. Madera Maculada: Dirígete a Vallefresno y derrota a los espíritus en las Ruinas de Polvo de Estrellas.",
            "4. Lágrimas de Tethyr: Ve a Laderas de Trabalomas y despoja las lágrimas sumergidas cerca del río.",
            "5. Regresa a Trinquete, entrega los materiales en el círculo de invocación y derrota al Manáfago."
        },
        materials = {}
    },

    -- ==================== LEVEL 31: ENCHANTED GOLD BLOODROBE ====================
    {
        id = "gold_bloodrobe",
        level = 31,
        title = "Túnica de Sangre Dorada Encantada",
        titleEn = "Enchanted Gold Bloodrobe",
        petName = "Túnica Épica de Leveo (BiS)",
        faction = "Both",
        rewardItemId = 6900, -- Enchanted Gold Bloodrobe
        questIds = { 4965, 4966 },
        icon = "Interface\\Icons\\INV_Chest_Cloth_41",
        startNPC = {
            name = "Menara Voidrender",
            nameEs = "Menara Robaespíritus",
            zone = "The Barrens",
            zoneEs = "Los Baldíos",
            subzone = "Ratchet (Tower)",
            x = 62.4, y = 35.8
        },
        endNPC = {
            name = "Menara Voidrender",
            nameEs = "Menara Robaespíritus",
            zone = "The Barrens",
            zoneEs = "Los Baldíos",
            subzone = "Ratchet (Tower)",
            x = 62.4, y = 35.8
        },
        steps = {
            "1. Habla con Menara Robaespíritus en la torre de Trinquete (Los Baldíos).",
            "2. Reúne los materiales requeridos (ver lista abajo).",
            "3. La Túnica de Arcana puede crearse con Sastrería o comprarse en Casa de Subastas.",
            "4. La Mena de sangrita inferior se mina en los campamentos Kobold de Tierras Altas de Arathi.",
            "5. Entrega todos los componentes a Menara para recibir la túnica con +10 Aguante e Intelecto."
        },
        materials = {
            { itemId = 5770, count = 1, name = "Túnica de arcana", nameEn = "Robe of Arcana", source = "Sastrería / Casa de Subastas" },
            { itemId = 4235, count = 1, name = "Mena de sangrita inferior", nameEn = "Lesser Bloodstone Ore", source = "Campamento Kobold (Arathi)" },
            { itemId = 4291, count = 1, name = "Hilo de oro fino", nameEn = "Fine Gold Thread", source = "Vendedores de suministros de sastrería" },
            { itemId = 4470, count = 2, name = "Carbón humeante", nameEn = "Smoldering Coal", source = "Elementales de fuego (Arathi / Badlands)" },
        }
    },

    -- ==================== LEVEL 50: INFERNO ====================
    {
        id = "inferno",
        level = 50,
        title = "Invocación del Infernal (Inferno)",
        titleEn = "Summon Infernal (Inferno)",
        petName = "Infernal / Inferno",
        faction = "Both",
        rewardSpellId = 1122, -- Inferno
        questIds = { 2801, 2802, 2803 },
        icon = "Interface\\Icons\\Spell_Shadow_SummonInfernal",
        startNPC = {
            name = "Niby the Almighty",
            nameEs = "Niby el Todopoderoso",
            zone = "Felwood",
            zoneEs = "Frondavil",
            subzone = "Jaedenar entrance",
            x = 41.6, y = 44.8
        },
        endNPC = {
            name = "Niby the Almighty",
            nameEs = "Niby el Todopoderoso",
            zone = "Felwood",
            zoneEs = "Frondavil",
            subzone = "Jaedenar entrance",
            x = 41.6, y = 44.8
        },
        steps = {
            "1. Habla con el gnomo Niby el Todopoderoso en Frondavil (cerca de la entrada a Jaedenar).",
            "2. Recoge Esencia vil impecable de los manáfagos en Frondavil o Azshara.",
            "3. Consigue Polvo de azufre de los elementales en Azshara.",
            "4. Despierta a Kroshius en el norte de Frondavil, derrótalo y despoja su Núcleo Infernal.",
            "5. Regresa con Niby para aprender el hechizo Inferno (invoca un Infernal que aturde en área)."
        },
        materials = {}
    },

    -- ==================== LEVEL 60: DREADSTEED OF XOROTH ====================
    {
        id = "dreadsteed",
        level = 60,
        title = "Corcel de la Muerte Épico (Montura 100%)",
        titleEn = "Dreadsteed of Xoroth (Epic Mount)",
        petName = "Corcel de la Muerte / Dreadsteed",
        faction = "Both",
        rewardSpellId = 23161, -- Summon Dreadsteed
        questIds = { 7562, 7563, 7564, 7565, 7566, 7567, 7568, 7569, 7570, 7571, 7572, 7637 },
        icon = "Interface\\Icons\\Ability_Mount_Dreadsteed",
        startNPC = {
            name = "Mor'zul Bloodbringer",
            nameEs = "Mor'zul Sangreabismal",
            zone = "Burning Steppes",
            zoneEs = "Las Estepas Ardientes",
            subzone = "Altar of Storms",
            x = 12.8, y = 31.6
        },
        endNPC = {
            name = "Mor'zul Bloodbringer",
            nameEs = "Mor'zul Sangreabismal",
            zone = "Burning Steppes",
            zoneEs = "Las Estepas Ardientes",
            subzone = "Altar of Storms",
            x = 12.8, y = 31.6
        },
        steps = {
            "1. Ve al Altar de las Tormentas en Estepas Ardientes y habla con Mor'zul Sangreabismal.",
            "2. Reúne todos los materiales requeridos y el oro para los artefactos de Gorzeeki.",
            "3. Ve a Scholomance y usa la poción de Gorzeeki en el laboratorio para liberar al espíritu.",
            "4. Compra la Campana de Deth'ryll, la Rueda y la Vela del Fin del Mundo.",
            "5. Entra a La Masacre Oeste (Dire Maul West) en grupo, limpia la prisión de Immol'thar.",
            "6. Inicia el ritual en el centro: mantén los 3 artefactos activos con fragmentos de alma.",
            "7. Derrota las oleadas, vence a Lord Hel'nurath y al Corcel de Xoroth para someterlo."
        },
        materials = {
            { itemId = 15416, count = 35, name = "Escama de dragón negro", nameEn = "Black Dragonscale", source = "Desuello dragones negros / Subasta" },
            { itemId = 12820, count = 25, name = "Runa oscura", nameEn = "Dark Rune", source = "Scholomance / Subasta" },
            { itemId = 11178, count = 6,  name = "Fragmento radiante grande", nameEn = "Large Radiant Shard", source = "Desencantar nivel 50-60 / Subasta" },
            { itemId = 9264,  count = 2,  name = "Elixir de poder de las sombras", nameEn = "Elixir of Shadow Power", source = "Alquimia / Subasta" },
            { itemId = 12360, count = 1,  name = "Barra de arcanita", nameEn = "Arcanite Bar", source = "Alquimia (Transmutar) / Subasta" },
        }
    },

    -- ==================== LEVEL 60: DOOMGUARD ====================
    {
        id = "doomguard",
        level = 60,
        title = "Ritual de la Fatalidad (Guardia del Apocalipsis)",
        titleEn = "Ritual of Doom (Doomguard)",
        petName = "Guardia del Apocalipsis / Doomguard",
        faction = "Both",
        rewardSpellId = 18540, -- Ritual of Doom
        questIds = { 7583, 7584, 7585 },
        icon = "Interface\\Icons\\Spell_Shadow_AntiShadow",
        startNPC = {
            name = "Daio the Decrepit",
            nameEs = "Daio el Decrépito",
            zone = "Blasted Lands",
            zoneEs = "Las Tierras Devastadas",
            subzone = "Tainted Scar peak",
            x = 35.0, y = 50.0
        },
        endNPC = {
            name = "Daio the Decrepit",
            nameEs = "Daio el Decrépito",
            zone = "Blasted Lands",
            zoneEs = "Las Tierras Devastadas",
            subzone = "Tainted Scar peak",
            x = 35.0, y = 50.0
        },
        steps = {
            "1. Escala la colina sobre la Cicatriz Tenebrosa en Tierras Devastadas y habla con Daio.",
            "2. El Envoltorio de la Prisión: Derrota sátiros en Jaedenar (Frondavil) para conseguir lágrimas.",
            "3. Derrota a los comandantes de la Legión en las Tierras Devastadas para la sangre vil.",
            "4. Regresa con Daio, realiza el ritual para aprisionar al demonio.",
            "5. Recompensa: Ritual de la Fatalidad (requiere 5 miembros de grupo y sacrifica a uno para invocar al temible Doomguard)."
        },
        materials = {}
    }
}
