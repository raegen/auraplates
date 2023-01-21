local AuraPlates = LibStub("AceAddon-3.0"):NewAddon("AuraPlates", "AceEvent-3.0")

local AuraType = {
    IMMUNITY = "IMMUNITY",
    IMMUNITY_SPELL = "IMMUNITY_SPELL",
    BUFF_DEFENSIVE = "BUFF_DEFENSIVE",
    BUFF_OFFENSIVE = "BUFF_OFFENSIVE",
    BUFF_OTHER = "BUFF_OTHER",
    BUFF_MOBILITY = "BUFF_MOBILITY",
    DEBUFF_MOBILITY = "DEBUFF_MOBILITY",
    DEBUFF_DEFENSIVE = "DEBUFF_DEFENSIVE",
    DEBUFF_OFFENSIVE = "DEBUFF_OFFENSIVE",
    INTERRUPT = "INTERRUPT",
    CROWD_CONTROL = "CROWD_CONTROL",
    ROOT = "ROOT",
}

AuraPlates.Priority = {
    [AuraType.IMMUNITY] = 12,
    [AuraType.IMMUNITY_SPELL] = 11,
    [AuraType.CROWD_CONTROL] = 10,
    [AuraType.INTERRUPT] = 9,
    [AuraType.BUFF_DEFENSIVE] = 7,
    [AuraType.BUFF_OFFENSIVE] = 8,
    [AuraType.DEBUFF_DEFENSIVE] = 6,
    [AuraType.DEBUFF_OFFENSIVE] = 5,
    [AuraType.BUFF_OTHER] = 4,
    [AuraType.ROOT] = 3,
    [AuraType.BUFF_MOBILITY] = 2,
    [AuraType.DEBUFF_MOBILITY] = 1,
}

local function head(array, n)
    local result = {};
    for i = 1, n do
        result[i] = array[i];
    end

    return result;
end

-- Show one of these when a big debuff is displayed
AuraPlates.WarningDebuffs = {
    212183, -- Smoke Bomb
    81261, -- Solar Beam
    316099, -- Unstable Affliction
    342938, -- Unstable Affliction
    34914, -- Vampiric Touch
    375901, -- Mindgames
}

-- Make sure we always see these debuffs, but don't make them bigger
AuraPlates.PriorityDebuffs = {
    316099, -- Unstable Affliction
    342938, -- Unstable Affliction
    34914, -- Vampiric Touch
    209749, -- Faerie Swarm
    117405, -- Binding Shot
    122470, -- Touch of Karma
    208997, -- Counterstrike Totem
    343294, -- Soul Reaper (Unholy)
    375901, -- Mindgames
}

AuraPlates.Spells = {

    -- Interrupts

    [1766] = { type = AuraType.INTERRUPT, duration = 5 }, -- Kick (Rogue)
    [2139] = { type = AuraType.INTERRUPT, duration = 6 }, -- Counterspell (Mage)
    [6552] = { type = AuraType.INTERRUPT, duration = 4 }, -- Pummel (Warrior)
    [19647] = { type = AuraType.INTERRUPT, duration = 6 }, -- Spell Lock (Warlock)
    [132409] = { type = AuraType.INTERRUPT, duration = 6, parent = 19647 }, -- Spell Lock (Warlock)
    [47528] = { type = AuraType.INTERRUPT, duration = 3 }, -- Mind Freeze (Death Knight)
    [57994] = { type = AuraType.INTERRUPT, duration = 3 }, -- Wind Shear (Shaman)
    [91807] = { type = AuraType.INTERRUPT, duration = 2 }, -- Shambling Rush (Death Knight)
    [96231] = { type = AuraType.INTERRUPT, duration = 4 }, -- Rebuke (Paladin)
    [93985] = { type = AuraType.INTERRUPT, duration = 4 }, -- Skull Bash (Feral/Guardian)
    [116705] = { type = AuraType.INTERRUPT, duration = 4 }, -- Spear Hand Strike (Monk)
    [147362] = { type = AuraType.INTERRUPT, duration = 3 }, -- Counter Shot (Hunter)
    [183752] = { type = AuraType.INTERRUPT, duration = 3 }, -- Disrupt (Demon Hunter)
    [187707] = { type = AuraType.INTERRUPT, duration = 3 }, -- Muzzle (Hunter)
    [212619] = { type = AuraType.INTERRUPT, duration = 6 }, -- Call Felhunter (Warlock)
    [31935] = { type = AuraType.INTERRUPT, duration = 3 }, -- Avenger's Shield (Paladin)
    [217824] = { type = AuraType.INTERRUPT, duration = 4 }, -- Shield of Virtue (Protection PvP Talent)
    [351338] = { type = AuraType.INTERRUPT, duration = 4 }, -- Quell (Evoker)

    -- Death Knight

    [47476] = { type = AuraType.CROWD_CONTROL }, -- Strangulate
    [48707] = { type = AuraType.IMMUNITY_SPELL }, -- Anti-Magic Shell
    [145629] = { type = AuraType.BUFF_DEFENSIVE }, -- Anti-Magic Zone
    [48265] = { type = AuraType.BUFF_MOBILITY }, -- Death's Advance
    [48792] = { type = AuraType.BUFF_DEFENSIVE }, -- Icebound Fortitude
    [49039] = { type = AuraType.BUFF_OTHER }, -- Lichborne
    [81256] = { type = AuraType.BUFF_DEFENSIVE }, -- Dancing Rune Weapon
    [51271] = { type = AuraType.BUFF_OFFENSIVE }, -- Pillar of Frost
    [55233] = { type = AuraType.BUFF_DEFENSIVE }, -- Vampiric Blood
    [77606] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Dark Simulacrum
    [63560] = { type = AuraType.BUFF_OFFENSIVE }, -- Dark Transformation
    [91800] = { type = AuraType.CROWD_CONTROL }, -- Gnaw
    [91797] = { type = AuraType.CROWD_CONTROL, parent = 91800 }, -- Monstrous Blow
    [108194] = { type = AuraType.CROWD_CONTROL }, -- Asphyxiate
    [221562] = { type = AuraType.CROWD_CONTROL, parent = 108194 }, -- Asphyxiate (Blood)
    [152279] = { type = AuraType.BUFF_OFFENSIVE }, -- Breath of Sindragosa
    [194679] = { type = AuraType.BUFF_DEFENSIVE }, -- Rune Tap
    [194844] = { type = AuraType.BUFF_DEFENSIVE }, -- Bonestorm
    [204080] = { type = AuraType.ROOT }, -- Deathchill
    [233395] = { type = AuraType.ROOT, parent = 204080 }, -- when applied by Remorseless Winter
    [204085] = { type = AuraType.ROOT, parent = 204080 }, -- when applied by Chains of Ice
    [47568] = { type = AuraType.BUFF_OFFENSIVE }, -- Empower Rune Weapon
    [207167] = { type = AuraType.CROWD_CONTROL }, -- Blinding Sleet
    [287254] = { type = AuraType.CROWD_CONTROL }, -- Dead of Winter
    [207289] = { type = AuraType.BUFF_OFFENSIVE }, -- Unholy Assault
    [212552] = { type = AuraType.BUFF_MOBILITY }, -- Wraith Walk
    [219809] = { type = AuraType.BUFF_DEFENSIVE }, -- Tombstone
    [223929] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Necrotic Wound
    [343294] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Soul Reaper
    [321995] = { type = AuraType.BUFF_OFFENSIVE }, -- Hypothermic Presence
    [334693] = { type = AuraType.CROWD_CONTROL }, -- Absolute Zero (Frost Legendary)
    [206961] = { type = AuraType.CROWD_CONTROL }, -- Tremble Before Me (Phearamones Legendary)
    -- [91807] = { type = AuraType.ROOT }, -- Shambling Rush (defined as Interrupt)
    [210141] = { type = AuraType.CROWD_CONTROL }, -- Zombie Explosion (Reanimation Unholy PvP Talent)
    [288849] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Crypt Fever (Necromancer's Bargain Unholy PvP Talent)
    [3714] = { type = AuraType.BUFF_OTHER }, -- Path of Frost
    [315443] = { type = AuraType.BUFF_OFFENSIVE }, -- Abomination Limb (Necrolord Ability)
    [311648] = { type = AuraType.BUFF_OFFENSIVE }, -- Swarming Mist (Venthyr Ability)

    -- Demon Hunter

    [179057] = { type = AuraType.CROWD_CONTROL }, -- Chaos Nova
    [187827] = { type = AuraType.BUFF_DEFENSIVE }, -- Metamorphosis - Vengeance
    [162264] = { type = AuraType.BUFF_OFFENSIVE }, -- Metamorphosis - Havoc
    [188501] = { type = AuraType.BUFF_OFFENSIVE }, -- Spectral Sight
    [204490] = { type = AuraType.CROWD_CONTROL }, -- Sigil of Silence
    [205629] = { type = AuraType.BUFF_DEFENSIVE }, -- Demonic Trample
    [213491] = { type = AuraType.CROWD_CONTROL }, -- Demonic Trample (short stun on targets)
    [205630] = { type = AuraType.CROWD_CONTROL }, -- Illidan's Grasp - Grab
    [208618] = { type = AuraType.CROWD_CONTROL, parent = 205630 }, -- Illidan's Grasp - Stun
    [206649] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Eye of Leotheras
    [206804] = { type = AuraType.BUFF_OFFENSIVE }, -- Rain from Above (down)
    [206803] = { type = AuraType.IMMUNITY, parent = 206804 }, -- Rain from Above (up)
    [207685] = { type = AuraType.CROWD_CONTROL }, -- Sigil of Misery
    [209426] = { type = AuraType.BUFF_DEFENSIVE }, -- Darkness
    [211881] = { type = AuraType.CROWD_CONTROL }, -- Fel Eruption
    [212800] = { type = AuraType.BUFF_DEFENSIVE }, -- Blur
    [196555] = { type = AuraType.IMMUNITY }, -- Netherwalk
    [217832] = { type = AuraType.CROWD_CONTROL }, -- Imprison
    [221527] = { type = AuraType.CROWD_CONTROL, parent = 217832 }, -- Imprison (PvP Talent)
    [203704] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Mana Break
    [337567] = { type = AuraType.BUFF_OFFENSIVE }, -- Chaotic Blades (Chaos Theory Legendary)
    [323996] = { type = AuraType.CROWD_CONTROL }, -- The Hunt (Night Fae Ability)

    -- Druid

    [99] = { type = AuraType.CROWD_CONTROL }, -- Incapacitating Roar
    [339] = { type = AuraType.ROOT }, -- Entangling Roots
    [170855] = { type = AuraType.ROOT, parent = 339 }, -- Entangling Roots (Nature's Grasp)
    [1850] = { type = AuraType.BUFF_MOBILITY }, -- Dash
    [252216] = { type = AuraType.BUFF_MOBILITY, parent = 1850 }, -- Tiger Dash
    [2637] = { type = AuraType.CROWD_CONTROL }, -- Hibernate
    [5211] = { type = AuraType.CROWD_CONTROL }, -- Mighty Bash
    [5217] = { type = AuraType.BUFF_OFFENSIVE }, -- Tiger's Fury
    [22812] = { type = AuraType.BUFF_DEFENSIVE }, -- Barkskin
    [22842] = { type = AuraType.BUFF_DEFENSIVE }, -- Frenzied Regeneration
    [29166] = { type = AuraType.BUFF_OFFENSIVE }, -- Innervate
    [33786] = { type = AuraType.CROWD_CONTROL }, -- Cyclone
    [319439] = { type = AuraType.BUFF_OFFENSIVE }, -- Bloodtalons
    [33891] = { type = AuraType.BUFF_OFFENSIVE }, -- Incarnation: Tree of Life (for the menu entry - "Incarnation" tooltip isn't informative)
    [117679] = { type = AuraType.BUFF_OFFENSIVE, parent = 33891 }, -- Incarnation (grants access to Tree of Life form)
    [45334] = { type = AuraType.ROOT }, -- Immobilized (Wild Charge in Bear Form)
    [61336] = { type = AuraType.BUFF_DEFENSIVE }, -- Survival Instincts
    [81261] = { type = AuraType.CROWD_CONTROL }, -- Solar Beam
    [197721] = { type = AuraType.BUFF_DEFENSIVE }, -- Flourish
    [102342] = { type = AuraType.BUFF_DEFENSIVE }, -- Ironbark
    [102359] = { type = AuraType.ROOT }, -- Mass Entanglement
    [102543] = { type = AuraType.BUFF_OFFENSIVE }, -- Incarnation: King of the Jungle
    [102558] = { type = AuraType.BUFF_OFFENSIVE }, -- Incarnation: Guardian of Ursoc
    [102560] = { type = AuraType.BUFF_OFFENSIVE }, -- Incarnation: Chosen of Elune
    [106951] = { type = AuraType.BUFF_OFFENSIVE }, -- Berserk (Feral)
    [132158] = { type = AuraType.BUFF_OFFENSIVE }, -- Nature's Swiftness
    [155835] = { type = AuraType.BUFF_DEFENSIVE }, -- Bristling Fur
    [163505] = { type = AuraType.CROWD_CONTROL }, -- Rake
    [194223] = { type = AuraType.BUFF_OFFENSIVE }, -- Celestial Alignment
    [202425] = { type = AuraType.BUFF_OFFENSIVE }, -- Warrior of Elune
    [209749] = { type = AuraType.CROWD_CONTROL }, -- Faerie Swarm
    [203123] = { type = AuraType.CROWD_CONTROL }, -- Maim
    [305497] = { type = AuraType.BUFF_DEFENSIVE }, -- Thorns (PvP Talent)
    [50334] = { type = AuraType.BUFF_DEFENSIVE }, -- Berserk (Guardian)
    [127797] = { type = AuraType.CROWD_CONTROL, nounitFrames = true, nonameplates = true }, -- Ursol's Vortex
    [202244] = { type = AuraType.CROWD_CONTROL }, -- Overrun (Guardian PvP Talent)
    [247563] = { type = AuraType.BUFF_DEFENSIVE }, -- Nature's Grasp (Resto Entangling Bark PvP Talent)
    [106898] = { type = AuraType.BUFF_MOBILITY }, -- Stampeding Roar (from Human Form)
    [77764] = { type = AuraType.BUFF_MOBILITY, parent = 106898 }, -- from Cat Form
    [77761] = { type = AuraType.BUFF_MOBILITY, parent = 106898 }, -- from Bear Form
    [319454] = { type = AuraType.BUFF_OFFENSIVE }, -- Heart of the Wild
    [108291] = { type = AuraType.BUFF_OFFENSIVE, parent = 319454 }, -- with Balance Affinity
    [108292] = { type = AuraType.BUFF_OFFENSIVE, parent = 319454 }, -- with Feral Affinity
    [108293] = { type = AuraType.BUFF_OFFENSIVE, parent = 319454 }, -- with Guardian Affinity
    [108294] = { type = AuraType.BUFF_OFFENSIVE, parent = 319454 }, -- with Resto Affinity
    [5215] = { type = AuraType.BUFF_OTHER }, -- Prowl
    [323764] = { type = AuraType.BUFF_OFFENSIVE }, -- Convoke the Spirits (Night Fae Ability)
    [323546] = { type = AuraType.BUFF_OFFENSIVE }, -- Ravenous Frenzy (Venthyr Ability)
    [338142] = { type = AuraType.BUFF_OFFENSIVE }, -- Lone Empowerment (Kyrian Ability)
    [327037] = { type = AuraType.BUFF_DEFENSIVE }, -- Kindred Protection (Kyrian Ability)
    [362486] = { type = AuraType.IMMUNITY }, -- Keeper of the Grove
    [274837] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Feral Frenzy
    [363498] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Sickle of the Lion

    -- Hunter

    [136] = { type = AuraType.BUFF_DEFENSIVE }, -- Mend Pet
    [1513] = { type = AuraType.CROWD_CONTROL }, -- Scare Beast
    [3355] = { type = AuraType.CROWD_CONTROL }, -- Freezing Trap
    [356723] = { type = AuraType.CROWD_CONTROL }, -- Scorpid Venom
    [356727] = { type = AuraType.CROWD_CONTROL }, -- Spider Venom
    [324149] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Flayed Shot
    [203337] = { type = AuraType.CROWD_CONTROL, parent = 3355 }, -- Diamond Ice (Survival PvP Talent)
    [5384] = { type = AuraType.BUFF_DEFENSIVE }, -- Feign Death
    [19574] = { type = AuraType.BUFF_OFFENSIVE }, -- Bestial Wrath
    [186254] = { type = AuraType.BUFF_OFFENSIVE, parent = 19574 }, -- Bestial Wrath buff on the pet
    [24394] = { type = AuraType.CROWD_CONTROL }, -- Intimidation
    [53480] = { type = AuraType.BUFF_DEFENSIVE }, -- Roar of Sacrifice (PvP Talent)
    [54216] = { type = AuraType.BUFF_DEFENSIVE }, -- Master's Call
    [117526] = { type = AuraType.ROOT }, -- Binding Shot
    [117405] = { type = AuraType.ROOT, nounitFrames = true, nonameplates = true }, -- Binding Shot - aura when you're in the area
    [118922] = { type = AuraType.BUFF_MOBILITY }, -- Posthaste
    [131894] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- A Murder of Crows
    [162480] = { type = AuraType.ROOT }, -- Steel Trap
    [186257] = { type = AuraType.BUFF_MOBILITY }, -- Aspect of the Cheetah
    [203233] = { type = AuraType.BUFF_MOBILITY, parent = 186257 }, -- Hunting Pack (PvP Talent)
    [186265] = { type = AuraType.IMMUNITY }, -- Aspect of the Turtle
    [186289] = { type = AuraType.BUFF_OFFENSIVE }, -- Aspect of the Eagle
    [193530] = { type = AuraType.BUFF_OFFENSIVE }, -- Aspect of the Wild
    [199483] = { type = AuraType.BUFF_OTHER }, -- Camouflage
    [202914] = { type = AuraType.CROWD_CONTROL }, -- Spider Sting (Armed)
    [202933] = { type = AuraType.CROWD_CONTROL, parent = 202914 }, -- Spider Sting (Silenced)
    [209997] = { type = AuraType.BUFF_DEFENSIVE }, -- Play Dead
    [212638] = { type = AuraType.ROOT }, -- Tracker's Net
    [213691] = { type = AuraType.CROWD_CONTROL }, -- Scatter Shot
    [357021] = { type = AuraType.CROWD_CONTROL }, -- Consecutive Concussion
    [260402] = { type = AuraType.BUFF_OFFENSIVE }, -- Double Tap
    [266779] = { type = AuraType.BUFF_OFFENSIVE }, -- Coordinated Assault
    [288613] = { type = AuraType.BUFF_OFFENSIVE }, -- Trueshot
    [190925] = { type = AuraType.ROOT }, -- Harpoon
    [202748] = { type = AuraType.BUFF_DEFENSIVE }, -- Survival Tactics (PvP Talent)
    [248519] = { type = AuraType.IMMUNITY_SPELL }, -- Interlope (BM PvP Talent)
    [212431] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Explosive Shot

    -- Mage

    [66] = { type = AuraType.BUFF_OFFENSIVE }, -- Invisibility (Countdown)
    [32612] = { type = AuraType.BUFF_OFFENSIVE, parent = 66 }, -- Invisibility
    [113862] = { type = AuraType.BUFF_OFFENSIVE, parent = 66 }, -- Greater Invisibility
    [118] = { type = AuraType.CROWD_CONTROL }, -- Polymorph
    [28271] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Turtle
    [28272] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Pig
    [61025] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Serpent
    [61305] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Black Cat
    [61721] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Rabbit
    [61780] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Turkey
    [126819] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Porcupine
    [161353] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Polar Bear Cub
    [161354] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Monkey
    [161355] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Penguin
    [161372] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Peacock
    [277787] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Direhorn
    [277792] = { type = AuraType.CROWD_CONTROL, parent = 118 }, -- Polymorph Bumblebee
    [122] = { type = AuraType.ROOT }, -- Frost Nova
    [33395] = { type = AuraType.ROOT }, -- Freeze
    [12042] = { type = AuraType.BUFF_OFFENSIVE }, -- Arcane Power
    [12051] = { type = AuraType.BUFF_OFFENSIVE }, -- Evocation
    [12472] = { type = AuraType.BUFF_OFFENSIVE }, -- Icy Veins
    [198144] = { type = AuraType.BUFF_OFFENSIVE }, -- Ice Form
    [31661] = { type = AuraType.CROWD_CONTROL }, -- Dragon's Breath
    [45438] = { type = AuraType.IMMUNITY }, -- Ice Block
    [41425] = { type = AuraType.DEBUFF_DEFENSIVE }, -- Hypothermia
    [342242] = { type = AuraType.BUFF_OFFENSIVE }, -- Time Warp procced by Time Anomality (Arcane Talent)
    [82691] = { type = AuraType.CROWD_CONTROL }, -- Ring of Frost
    [87023] = { type = AuraType.BUFF_OTHER }, -- Cauterize
    [108839] = { type = AuraType.BUFF_OTHER }, -- Ice Floes
    [342246] = { type = AuraType.BUFF_DEFENSIVE }, -- Alter Time (Arcane)
    [110909] = { type = AuraType.BUFF_DEFENSIVE, parent = 342246 }, -- Alter Time (Fire/Frost)
    [157997] = { type = AuraType.ROOT }, -- Ice Nova
    [190319] = { type = AuraType.BUFF_OFFENSIVE }, -- Combustion
    [198111] = { type = AuraType.BUFF_DEFENSIVE }, -- Temporal Shield (Arcane PvP Talent)
    [198158] = { type = AuraType.BUFF_OFFENSIVE }, -- Mass Invisibility (Arcane PvP Talent)
    [198065] = { type = AuraType.BUFF_DEFENSIVE }, -- Prismatic Cloak (PvP Talent)
    [205025] = { type = AuraType.BUFF_OFFENSIVE }, -- Presence of Mind
    [228600] = { type = AuraType.ROOT }, -- Glacial Spike Root
    [317589] = { type = AuraType.CROWD_CONTROL }, -- Tormenting Backlash (Venthyr Ability)
    [198121] = { type = AuraType.ROOT }, -- Frostbite (Frost PvP Talent)
    [130] = { type = AuraType.BUFF_OTHER }, -- Slow Fall
    [333100] = { type = AuraType.BUFF_OFFENSIVE }, -- Firestorm (Fire Legendary)
    [324220] = { type = AuraType.BUFF_OFFENSIVE }, -- Deathborne (Necrolord Ability)
    [228358] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Winter's Chill

    -- Monk

    [115078] = { type = AuraType.CROWD_CONTROL }, -- Paralysis
    [115176] = { type = AuraType.BUFF_DEFENSIVE }, -- Zen Meditation
    [120954] = { type = AuraType.BUFF_DEFENSIVE }, -- Fortifying Brew (Brewmaster)
    [243435] = { type = AuraType.BUFF_DEFENSIVE, parent = 120954 }, -- Fortifying Brew (Windwalker/Mistweaver)
    [116706] = { type = AuraType.ROOT }, -- Disable
    [116841] = { type = AuraType.BUFF_MOBILITY }, -- Tiger's Lust
    [337294] = { type = AuraType.BUFF_DEFENSIVE }, -- Roll Out (Legendary)
    [116849] = { type = AuraType.BUFF_DEFENSIVE }, -- Life Cocoon
    [119381] = { type = AuraType.CROWD_CONTROL }, -- Leg Sweep
    [324382] = { type = AuraType.CROWD_CONTROL }, -- Clash
    [122278] = { type = AuraType.BUFF_DEFENSIVE }, -- Dampen Harm
    [125174] = { type = AuraType.BUFF_DEFENSIVE }, -- Touch of Karma (Buff)
    [122470] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Touch of Karma (Debuff)
    [122783] = { type = AuraType.BUFF_DEFENSIVE }, -- Diffuse Magic
    [137639] = { type = AuraType.BUFF_OFFENSIVE }, -- Storm, Earth, and Fire
    [152173] = { type = AuraType.BUFF_OFFENSIVE }, -- Serenity
    [198909] = { type = AuraType.CROWD_CONTROL }, -- Song of Chi-Ji
    [202162] = { type = AuraType.BUFF_DEFENSIVE }, -- Avert Harm (Brew PvP Talent)
    [202274] = { type = AuraType.CROWD_CONTROL }, -- Incendiary Brew (Brew PvP Talent)
    [209584] = { type = AuraType.BUFF_DEFENSIVE }, -- Zen Focus Tea (MW PvP Talent)
    [233759] = { type = AuraType.CROWD_CONTROL }, -- Grapple Weapon (MW/WW PvP Talent)
    [343249] = { type = AuraType.BUFF_DEFENSIVE }, -- Escape from Reality (MW Monk Legendary)
    [310454] = { type = AuraType.BUFF_OFFENSIVE }, -- Weapons of Order (Kyrian Ability)
    [202335] = { type = AuraType.BUFF_OFFENSIVE }, -- Double Barrel (Brew PvP Talent) - "next cast will..." buff
    [202346] = { type = AuraType.CROWD_CONTROL }, -- Double Barrel (Brew PvP Talent)
    [202248] = { type = AuraType.IMMUNITY_SPELL }, -- Guided Meditation (Brew PvP Talent)
    [213664] = { type = AuraType.BUFF_DEFENSIVE }, -- Nimble Brew (Brew PvP Talent)
    [132578] = { type = AuraType.BUFF_DEFENSIVE }, -- Invoke Niuzao, the Black Ox
    [344021] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Keefer's Skyreach
    [353319] = { type = AuraType.IMMUNITY_SPELL }, -- Peaceweaver

    -- Paladin

    [498] = { type = AuraType.BUFF_DEFENSIVE }, -- Divine Protection
    [642] = { type = AuraType.IMMUNITY }, -- Divine Shield
    [853] = { type = AuraType.CROWD_CONTROL }, -- Hammer of Justice
    [1022] = { type = AuraType.BUFF_DEFENSIVE }, -- Blessing of Protection
    [204018] = { type = AuraType.BUFF_DEFENSIVE }, -- Blessing of Spellwarding
    [1044] = { type = AuraType.BUFF_DEFENSIVE }, -- Blessing of Freedom
    [305395] = { type = AuraType.BUFF_DEFENSIVE, parent = 1044 }, -- Blessing of Freedom with Unbound Freedom (PvP Talent)
    [6940] = { type = AuraType.BUFF_DEFENSIVE }, -- Blessing of Sacrifice
    [199448] = { type = AuraType.BUFF_DEFENSIVE }, -- Blessing of Sacrifice (Ultimate Sacrifice Holy PvP Talent)
    [199450] = { type = AuraType.BUFF_DEFENSIVE, parent = 199448 }, -- Ultimate Sacrifice (Holy PvP Talent) - debuff on the paladin
    [20066] = { type = AuraType.CROWD_CONTROL }, -- Repentance
    [10326] = { type = AuraType.CROWD_CONTROL }, -- Turn Evil
    [25771] = { type = AuraType.DEBUFF_DEFENSIVE }, -- Forbearance
    [31821] = { type = AuraType.BUFF_DEFENSIVE }, -- Aura Mastery
    [31850] = { type = AuraType.BUFF_DEFENSIVE }, -- Ardent Defender
    [31884] = { type = AuraType.BUFF_OFFENSIVE }, -- Avenging Wrath
    [216331] = { type = AuraType.BUFF_OFFENSIVE, parent = 31884 }, -- Avenging Crusader (Holy Talent)
    [231895] = { type = AuraType.BUFF_OFFENSIVE, parent = 31884 }, -- Crusade (Retribution Talent)
    -- [31935] = { type = AuraType.CROWD_CONTROL }, -- Avenger's Shield (defined as Interrupt)
    [86659] = { type = AuraType.BUFF_DEFENSIVE }, -- Guardian of Ancient Kings
    [212641] = { type = AuraType.BUFF_DEFENSIVE, parent = 86659 }, -- Guardian of Ancient Kings (Glyphed)
    [228050] = { type = AuraType.IMMUNITY }, -- Guardian of the Forgotten Queen (Protection PvP Talent)
    [105809] = { type = AuraType.BUFF_OFFENSIVE }, -- Holy Avenger
    [105421] = { type = AuraType.CROWD_CONTROL }, -- Blinding Light
    [152262] = { type = AuraType.BUFF_OFFENSIVE }, -- Seraphim
    [184662] = { type = AuraType.BUFF_DEFENSIVE }, -- Shield of Vengeance
    [199545] = { type = AuraType.BUFF_DEFENSIVE }, -- Steed of Glory (Protection PvP Talent)
    [205191] = { type = AuraType.BUFF_DEFENSIVE }, -- Eye for an Eye
    [210256] = { type = AuraType.BUFF_DEFENSIVE }, -- Blessing of Sanctuary (Ret PvP Talent)
    [210294] = { type = AuraType.BUFF_DEFENSIVE }, -- Divine Favor (Holy PvP Talent)
    [215652] = { type = AuraType.BUFF_OFFENSIVE }, -- Shield of Virtue (Protection PvP Talent) - "next cast will..." buff
    -- [217824] = { type = AuraType.CROWD_CONTROL }, -- Shield of Virtue (Protection PvP Talent) (defined as Interrupt)
    [221883] = { type = AuraType.BUFF_MOBILITY }, -- Divine Steed (Human?) (Each race has its own buff, pulled from wowhead - some might be incorrect)
    [221885] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (Tauren?)
    [221886] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (Blood Elf?)
    [221887] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (Lightforged Draenei)
    [254471] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (?)
    [254472] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (?)
    [254473] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (?)
    [254474] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (?)
    [276111] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (Dwarf?)
    [276112] = { type = AuraType.BUFF_MOBILITY, parent = 221883 }, -- Divine Steed (Dark Iron Dwarf?)
    [343721] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Final Reckoning
    [255941] = { type = AuraType.CROWD_CONTROL }, -- Wake of Ashes stun
    [157128] = { type = AuraType.BUFF_DEFENSIVE }, -- Saved by the Light

    -- Priest

    [327661] = { type = AuraType.BUFF_DEFENSIVE }, -- Fae Guardians
    [337661] = { type = AuraType.BUFF_DEFENSIVE }, -- Translucent Image (Fade defensive Conduit)
    [605] = { type = AuraType.CROWD_CONTROL, priority = true }, -- Mind Control
    [8122] = { type = AuraType.CROWD_CONTROL }, -- Psychic Scream
    [9484] = { type = AuraType.CROWD_CONTROL }, -- Shackle Undead
    [10060] = { type = AuraType.BUFF_OFFENSIVE }, -- Power Infusion
    [15487] = { type = AuraType.CROWD_CONTROL }, -- Silence
    [33206] = { type = AuraType.BUFF_DEFENSIVE }, -- Pain Suppression
    [47536] = { type = AuraType.BUFF_DEFENSIVE }, -- Rapture
    [109964] = { type = AuraType.BUFF_DEFENSIVE, parent = 47536 }, -- Spirit Shell
    [47585] = { type = AuraType.BUFF_DEFENSIVE }, -- Dispersion
    [47788] = { type = AuraType.BUFF_DEFENSIVE }, -- Guardian Spirit
    [64044] = { type = AuraType.CROWD_CONTROL }, -- Psychic Horror
    [64843] = { type = AuraType.BUFF_DEFENSIVE }, -- Divine Hymn
    [81782] = { type = AuraType.BUFF_DEFENSIVE }, -- Power Word: Barrier
    [87204] = { type = AuraType.CROWD_CONTROL }, -- Sin and Punishment
    [194249] = { type = AuraType.BUFF_OFFENSIVE }, -- Voidform
    [232707] = { type = AuraType.BUFF_DEFENSIVE }, -- Ray of Hope (Holy PvP Talent)
    [197862] = { type = AuraType.BUFF_DEFENSIVE }, -- Archangel (Disc PvP Talent)
    [197871] = { type = AuraType.BUFF_OFFENSIVE }, -- Dark Archangel (Disc PvP Talent) - on the priest
    [197874] = { type = AuraType.BUFF_OFFENSIVE, parent = 197871 }, -- Dark Archangel (Disc PvP Talent) - on others
    [199890] = { type = AuraType.ROOT }, -- Curse of Tongues
    [200183] = { type = AuraType.BUFF_DEFENSIVE }, -- Apotheosis
    [200196] = { type = AuraType.CROWD_CONTROL }, -- Holy Word: Chastise
    [200200] = { type = AuraType.CROWD_CONTROL, parent = 200196 }, -- Holy Word: Chastise (Stun)
    [205369] = { type = AuraType.CROWD_CONTROL }, -- Mind Bomb (Countdown)
    [226943] = { type = AuraType.CROWD_CONTROL, parent = 205369 }, -- Mind Bomb (Disorient)
    [213610] = { type = AuraType.IMMUNITY_SPELL }, -- Holy Ward
    --[27827] = { type = AuraType.BUFF_DEFENSIVE }, -- Spirit of Redemption
    [215769] = { type = AuraType.BUFF_DEFENSIVE }, -- Spirit of Redemption (Spirit of the Redeemer Holy PvP Talent)
    [211336] = { type = AuraType.BUFF_DEFENSIVE }, -- Archbishop Benedictus' Restitution (Resurrection Buff)
    [211319] = { type = AuraType.BUFF_DEFENSIVE }, -- Archbishop Benedictus' Restitution (Debuff)
    [289655] = { type = AuraType.BUFF_DEFENSIVE }, -- Holy Word: Concentration
    [319952] = { type = AuraType.BUFF_OFFENSIVE }, -- Surrender to Madness
    [322431] = { type = AuraType.BUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Thoughtsteal (Buff)
    [322459] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Thoughtstolen (Shaman)
    [322464] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Mage)
    [322442] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Druid)
    [322462] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Priest - Holy)
    [322457] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Paladin)
    [322463] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Warlock)
    [322461] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Priest - Discipline)
    [322458] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Monk)
    [322460] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 322459 }, -- Thoughtstolen (Priest - Shadow)
    [375901] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Mindgames
    [329543] = { type = AuraType.BUFF_DEFENSIVE }, -- Divine Ascension (down)
    [328530] = { type = AuraType.IMMUNITY, parent = 329543 }, -- Divine Ascension (up)
    [335467] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Devouring Plague
    [34914] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Vampiric Touch
    [453] = { type = AuraType.BUFF_OTHER, noraidFrames = true }, -- Mind Soothe
    [15286] = { type = AuraType.BUFF_DEFENSIVE }, -- Vampiric Embrace
    [19236] = { type = AuraType.BUFF_DEFENSIVE }, -- Desperate Prayer
    [111759] = { type = AuraType.BUFF_OTHER }, -- Levitate
    [325013] = { type = AuraType.BUFF_OFFENSIVE }, -- Boon of the Ascended (Kyrian)
    [65081] = { type = AuraType.BUFF_MOBILITY }, -- Body and Soul
    [121557] = { type = AuraType.BUFF_MOBILITY }, -- Angelic Feather
    [199845] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Psyflay (Psyfiend) debuff
    [358861] = { type = AuraType.CROWD_CONTROL }, -- Void Volley: Horrify (Shadow PvP Talent)
    [114415] = { type = AuraType.ROOT }, -- Void Tendrils

    -- Rogue

    [408] = { type = AuraType.CROWD_CONTROL }, -- Kidney Shot
    [1330] = { type = AuraType.CROWD_CONTROL }, -- Garrote - Silence
    [1776] = { type = AuraType.CROWD_CONTROL }, -- Gouge
    [1833] = { type = AuraType.CROWD_CONTROL }, -- Cheap Shot
    [1966] = { type = AuraType.BUFF_DEFENSIVE }, -- Feint
    [2094] = { type = AuraType.CROWD_CONTROL }, -- Blind
    [2983] = { type = AuraType.BUFF_MOBILITY }, -- Sprint
    [36554] = { type = AuraType.BUFF_MOBILITY }, -- Shadowstep
    [5277] = { type = AuraType.BUFF_DEFENSIVE }, -- Evasion
    [6770] = { type = AuraType.CROWD_CONTROL }, -- Sap
    [11327] = { type = AuraType.BUFF_DEFENSIVE }, -- Vanish
    [13750] = { type = AuraType.BUFF_OFFENSIVE }, -- Adrenaline Rush
    [31224] = { type = AuraType.IMMUNITY_SPELL }, -- Cloak of Shadows
    [45182] = { type = AuraType.BUFF_DEFENSIVE }, -- Cheating Death
    [51690] = { type = AuraType.BUFF_OFFENSIVE }, -- Killing Spree
    [79140] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Vendetta
    [121471] = { type = AuraType.BUFF_OFFENSIVE }, -- Shadow Blades
    [185422] = { type = AuraType.BUFF_OFFENSIVE }, -- Shadow Dance
    [207736] = { type = AuraType.BUFF_OFFENSIVE }, -- Shadowy Duel
    [212283] = { type = AuraType.BUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Symbols of Death
    [207777] = { type = AuraType.CROWD_CONTROL }, -- Dismantle
    [212183] = { type = AuraType.CROWD_CONTROL }, -- Smoke Bomb (PvP Talent)
    [212150] = { type = AuraType.CROWD_CONTROL }, -- Cheap Tricks (Outlaw PvP Talent)
    [199027] = { type = AuraType.BUFF_DEFENSIVE }, -- Veil of Midnight (Subtlety PvP Talent)
    [197003] = { type = AuraType.BUFF_DEFENSIVE }, -- Maneuverability (PvP Talent)
    [1784] = { type = AuraType.BUFF_OTHER }, -- Stealth
    [115191] = { type = AuraType.BUFF_OTHER, parent = 1784 }, -- Stealth (with Subterfuge talented)
    [115192] = { type = AuraType.BUFF_OFFENSIVE }, -- Subterfuge
    [256735] = { type = AuraType.BUFF_OFFENSIVE }, -- Master Assassin
    [340094] = { type = AuraType.BUFF_OFFENSIVE }, -- Master Assassin's Mark (Legendary)
    [345569] = { type = AuraType.BUFF_OFFENSIVE }, -- Flagellation (Venthyr Ability)
    [347037] = { type = AuraType.BUFF_OFFENSIVE }, -- Sepsis (Night Fae Ability)
    [328305] = { type = AuraType.DEBUFF_OFFENSIVE, priority = true }, -- Sepsis (Night Fae Ability)
    [360194] = { type = AuraType.DEBUFF_OFFENSIVE, priority = true }, -- Deathmark

    -- Shaman

    [2645] = { type = AuraType.BUFF_MOBILITY, nounitFrames = true, nonameplates = true }, -- Ghost Wolf
    [8178] = { type = AuraType.IMMUNITY_SPELL }, -- Grounding Totem Effect (PvP Talent)
    [208997] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Counterstrike Totem (PvP Talent)
    [51514] = { type = AuraType.CROWD_CONTROL }, -- Hex
    [210873] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Compy)
    [211004] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Spider)
    [211010] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Snake)
    [211015] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Cockroach)
    [269352] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Skeletal Hatchling)
    [277778] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Zandalari Tendonripper)
    [277784] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Wicker Mongrel)
    [309328] = { type = AuraType.CROWD_CONTROL, parent = 51514 }, -- Hex (Living Honey)
    [58875] = { type = AuraType.BUFF_MOBILITY }, -- Spirit Walk
    [79206] = { type = AuraType.BUFF_OTHER }, -- Spiritwalker's Grace
    [108281] = { type = AuraType.BUFF_DEFENSIVE }, -- Ancestral Guidance
    [64695] = { type = AuraType.ROOT }, -- Earthgrab Totem
    [77505] = { type = AuraType.CROWD_CONTROL }, -- Earthquake (Stun)
    [325174] = { type = AuraType.BUFF_DEFENSIVE }, -- Spirit Link Totem
    [204293] = { type = AuraType.BUFF_DEFENSIVE, parent = 325174 }, -- Spirit Link (PvP Talent)
    [108271] = { type = AuraType.BUFF_DEFENSIVE }, -- Astral Shift
    [210918] = { type = AuraType.BUFF_DEFENSIVE, parent = 108271 }, -- Ethereal Form (Enhancement PvP Talent)
    [114049] = { type = AuraType.BUFF_OFFENSIVE }, -- Ascendance
    [114050] = { type = AuraType.BUFF_OFFENSIVE, parent = 114049 }, -- Ascendance (Elemental)
    [114051] = { type = AuraType.BUFF_OFFENSIVE, parent = 114049 }, -- Ascendance (Enhancement)
    [114052] = { type = AuraType.BUFF_DEFENSIVE, parent = 114049 }, -- Ascendance (Restoration)
    [118345] = { type = AuraType.CROWD_CONTROL }, -- Pulverize
    [118337] = { type = AuraType.BUFF_DEFENSIVE }, -- Harden Skin
    [118905] = { type = AuraType.CROWD_CONTROL }, -- Static Charge
    [191634] = { type = AuraType.BUFF_OFFENSIVE }, -- Stormkeeper (Ele)
    [320137] = { type = AuraType.BUFF_OFFENSIVE }, -- Stormkeeper (Enh)
    [197214] = { type = AuraType.CROWD_CONTROL }, -- Sundering
    [201633] = { type = AuraType.BUFF_DEFENSIVE }, -- Earthen Wall Totem
    [204366] = { type = AuraType.BUFF_OFFENSIVE }, -- Thundercharge (Enhancement PvP Talent)
    [335903] = { type = AuraType.BUFF_OFFENSIVE }, -- Doom Winds
    [260881] = { type = AuraType.BUFF_DEFENSIVE }, -- Spirit Wolf
    [290641] = { type = AuraType.BUFF_DEFENSIVE }, -- Ancestral Gift
    [305485] = { type = AuraType.CROWD_CONTROL }, -- Lightning Lasso (PvP Talent)
    [305484] = { type = AuraType.CROWD_CONTROL, parent = 305485 }, -- Lightning Lasso on stun-immune NPCs (PvP Talent)
    [320125] = { type = AuraType.BUFF_OFFENSIVE }, -- Echoing Shock
    [546] = { type = AuraType.BUFF_OTHER }, -- Water Walking
    [333957] = { type = AuraType.BUFF_OFFENSIVE }, -- Feral Spirit
    [204361] = { type = AuraType.BUFF_OFFENSIVE }, -- Bloodlust (Enhancement PvP Talent)
    [204362] = { type = AuraType.BUFF_OFFENSIVE, parent = 204361 }, -- Heroism (Enhancement PvP Talent)
    [192082] = { type = AuraType.BUFF_MOBILITY }, -- Windrush Totem
    [338036] = { type = AuraType.BUFF_MOBILITY }, -- Thunderous Paws (Conduit)
    [327164] = { type = AuraType.BUFF_OFFENSIVE }, -- Primordial Wave (Necrolord Ability)
    [207495] = { type = AuraType.BUFF_DEFENSIVE }, -- Ancestral Protection (Totem)
    [207498] = { type = AuraType.BUFF_DEFENSIVE, parent = 207495 }, -- Ancestral Protection (Player)

    -- Warlock
    [325640] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Soul Rot
    [193359] = { type = AuraType.BUFF_OFFENSIVE }, -- True Bearing
    [193357] = { type = AuraType.BUFF_OFFENSIVE }, -- Ruthless Precision
    [710] = { type = AuraType.CROWD_CONTROL }, -- Banish
    [5484] = { type = AuraType.CROWD_CONTROL }, -- Howl of Terror
    [6358] = { type = AuraType.CROWD_CONTROL }, -- Seduction
    [6789] = { type = AuraType.CROWD_CONTROL }, -- Mortal Coil
    [20707] = { type = AuraType.BUFF_OTHER }, -- Soulstone
    [22703] = { type = AuraType.CROWD_CONTROL }, -- Infernal Awakening
    [30283] = { type = AuraType.CROWD_CONTROL }, -- Shadowfury
    [89766] = { type = AuraType.CROWD_CONTROL }, -- Axe Toss
    [104773] = { type = AuraType.BUFF_DEFENSIVE }, -- Unending Resolve
    [108416] = { type = AuraType.BUFF_DEFENSIVE }, -- Dark Pact
    [111400] = { type = AuraType.BUFF_MOBILITY }, -- Burning Rush
    [113860] = { type = AuraType.BUFF_OFFENSIVE }, -- Dark Soul: Misery (Affliction)
    [113858] = { type = AuraType.BUFF_OFFENSIVE }, -- Dark Soul: Instability (Destruction)
    [265273] = { type = AuraType.BUFF_OFFENSIVE }, -- Demonic Power (Demonic Tyrant)
    [118699] = { type = AuraType.CROWD_CONTROL }, -- Fear
    [196364] = { type = AuraType.CROWD_CONTROL }, -- Unstable Affliction (Silence)
    [212295] = { type = AuraType.IMMUNITY_SPELL }, -- Nether Ward (PvP Talent)
    [1098] = { type = AuraType.CROWD_CONTROL }, -- Subjugate Demon
    [234877] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Bane of Shadows (Affliction PvP Talent)
    [316099] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Unstable Affliction
    [342938] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 316099 }, -- Unstable Affliction (Affliction PvP Talent)
    [30213] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Legion Strike
    [200587] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Fel Fissure (PvP Talent)
    [221705] = { type = AuraType.BUFF_DEFENSIVE }, -- Casting Circle (PvP Talent)
    [333889] = { type = AuraType.BUFF_DEFENSIVE }, -- Fel Domination
    [344566] = { type = AuraType.BUFF_OFFENSIVE }, -- Rapid Contagion (Affliction PvP Talent)
    [267171] = { type = AuraType.BUFF_OFFENSIVE }, -- Demonic Strength
    [267218] = { type = AuraType.BUFF_OFFENSIVE }, -- Nether Portal
    [80240] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Havoc
    [200548] = { type = AuraType.DEBUFF_OFFENSIVE, parent = 80240 }, -- Bane of Havoc (Destro PvP Talent)
    [213688] = { type = AuraType.CROWD_CONTROL }, -- Fel Cleave - Fel Lord stun (Demo PvP Talent)
    [339412] = { type = AuraType.BUFF_MOBILITY }, -- Demonic Momentum (Conduit)

    -- Warrior

    [871] = { type = AuraType.BUFF_DEFENSIVE }, -- Shield Wall
    [198817] = { type = AuraType.DEBUFF_OFFENSIVE }, -- Sharpen Blade
    [1719] = { type = AuraType.BUFF_OFFENSIVE }, -- Recklessness
    [52437] = { type = AuraType.BUFF_OFFENSIVE }, -- Sudden Impact
    [5246] = { type = AuraType.CROWD_CONTROL }, -- Intimidating Shout
    [316593] = { type = AuraType.CROWD_CONTROL, parent = 5246 }, -- Menace (Prot Talent), main target
    [316595] = { type = AuraType.CROWD_CONTROL, parent = 5246 }, -- Menace (Prot Talent), other targets
    [12975] = { type = AuraType.BUFF_DEFENSIVE }, -- Last Stand
    [18499] = { type = AuraType.BUFF_OTHER }, -- Berserker Rage
    [23920] = { type = AuraType.IMMUNITY_SPELL }, -- Spell Reflection
    [330279] = { type = AuraType.IMMUNITY_SPELL, parent = 23920 }, -- Overwatch (PvP Talent)
    [335255] = { type = AuraType.IMMUNITY_SPELL, parent = 23920 }, -- Spell Reflection (Misshapen Mirror Legendary)
    [132168] = { type = AuraType.CROWD_CONTROL }, -- Shockwave
    [97463] = { type = AuraType.BUFF_DEFENSIVE }, -- Rallying Cry
    [105771] = { type = AuraType.ROOT }, -- Charge
    [107574] = { type = AuraType.BUFF_OFFENSIVE }, -- Avatar
    [118038] = { type = AuraType.BUFF_DEFENSIVE }, -- Die by the Sword
    [132169] = { type = AuraType.CROWD_CONTROL }, -- Storm Bolt
    [147833] = { type = AuraType.BUFF_DEFENSIVE }, -- Intervene
    [184364] = { type = AuraType.BUFF_DEFENSIVE }, -- Enraged Regeneration
    [197690] = { type = AuraType.BUFF_DEFENSIVE }, -- Defensive Stance
    [208086] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Colossus Smash
    [213871] = { type = AuraType.BUFF_DEFENSIVE }, -- Bodyguard (Prot PvP Talent)
    [227847] = { type = AuraType.IMMUNITY }, -- Bladestorm (Arms)
    [46924] = { type = AuraType.IMMUNITY, parent = 227847 }, -- Bladestorm (Fury)
    [236077] = { type = AuraType.CROWD_CONTROL }, -- Disarm (PvP Talent)
    [199042] = { type = AuraType.ROOT }, -- Thunderstruck (Prot PvP Talent)
    [236273] = { type = AuraType.CROWD_CONTROL }, -- Duel (Arms PvP Talent)
    [236321] = { type = AuraType.BUFF_DEFENSIVE }, -- War Banner (PvP Talent)
    [262228] = { type = AuraType.BUFF_OFFENSIVE }, -- Deadly Calm
    [199085] = { type = AuraType.CROWD_CONTROL }, -- Warpath (Prot PvP Talent)
    [198819] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Mortal Strike when applied with Sharpen Blade (50% healing reduc)
    [202164] = { type = AuraType.BUFF_MOBILITY }, -- Bounding Stride
    [325886] = { type = AuraType.CROWD_CONTROL }, -- Ancient Aftershock (Night Fae Ability)
    [326062] = { type = AuraType.CROWD_CONTROL, parent = 325886 }, -- Ancient Aftershock (Night Fae Ability) - periodic
    [307871] = { type = AuraType.CROWD_CONTROL, nounitFrames = true, nonameplates = true }, -- Spear of Bastion (Kyrian Ability)
    [324143] = { type = AuraType.BUFF_OFFENSIVE }, -- Conqueror's Banner (Necrolord Ability) - on the warrior
    [325862] = { type = AuraType.BUFF_OFFENSIVE, parent = 324143 }, -- Conqueror's Banner (Necrolord Ability) - on others

    -- Evoker

    [360806] = { type = AuraType.CROWD_CONTROL }, -- Sleep Walk
    [355689] = { type = AuraType.ROOT }, -- Landslide
    [375087] = { type = AuraType.BUFF_OFFENSIVE }, -- Dragonrage
    [378464] = { type = AuraType.IMMUNITY_SPELL }, -- Nullifying Shroud
    [363916] = { type = AuraType.BUFF_DEFENSIVE }, -- Obsidian Scales


    -- Other

    [115804] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, nonameplates = true }, -- Mortal Wounds

    [34709] = { type = AuraType.BUFF_OTHER }, -- Shadow Sight
    [345231] = { type = AuraType.BUFF_DEFENSIVE }, -- Gladiator's Emblem
    [314646] = { type = AuraType.BUFF_OTHER }, -- Drink (40k mana vendor item)
    [348436] = { type = AuraType.BUFF_OTHER, parent = 314646 }, -- (20k mana vendor item)
    [167152] = { type = AuraType.BUFF_OTHER, parent = 314646 }, -- Refreshment (mage food)

    -- Racials

    [20549] = { type = AuraType.CROWD_CONTROL }, -- War Stomp
    [107079] = { type = AuraType.CROWD_CONTROL }, -- Quaking Palm
    [255723] = { type = AuraType.CROWD_CONTROL }, -- Bull Rush
    [287712] = { type = AuraType.CROWD_CONTROL }, -- Haymaker
    [256948] = { type = AuraType.BUFF_OTHER }, -- Spatial Rift
    [65116] = { type = AuraType.BUFF_DEFENSIVE }, -- Stoneform
    [273104] = { type = AuraType.BUFF_DEFENSIVE }, -- Fireblood
    [58984] = { type = AuraType.BUFF_DEFENSIVE }, -- Shadowmeld

    -- Dragonflight: Dragonriding

    [388673] = { type = AuraType.CROWD_CONTROL }, -- Dragonrider's Initiative
    [388380] = { type = AuraType.BUFF_MOBILITY }, -- Dragonrider's Compassion

    -- Shadowlands: Covenant/Soulbind

    [310143] = { type = AuraType.BUFF_MOBILITY }, -- Soulshape
    [320224] = { type = AuraType.BUFF_DEFENSIVE }, -- Podtender (Night Fae - Dreamweaver Trait)
    [323524] = { type = AuraType.IMMUNITY }, -- Ultimate Form (Necrolord - Marileth Trait)
    [324263] = { type = AuraType.CROWD_CONTROL }, -- Sulfuric Emission (Necrolord - Emeni Trait)
    [327140] = { type = AuraType.BUFF_OTHER }, -- Forgeborne Reveries (Necrolord - Bonesmith Heirmir Trait)
    [330752] = { type = AuraType.BUFF_DEFENSIVE }, -- Ascendant Phial (Kyrian - Kleia Trait)
    [331866] = { type = AuraType.CROWD_CONTROL }, -- Agent of Chaos (Venthyr - Nadjia Trait)
    [332505] = { type = AuraType.BUFF_OTHER }, -- Soulsteel Clamps (Kyrian - Mikanikos Trait)
    [332506] = { type = AuraType.BUFF_OTHER, parent = 332505 }, -- Soulsteel Clamps (Kyrian - Mikanikos Trait) - when moving
    [332423] = { type = AuraType.CROWD_CONTROL }, -- Sparkling Driftglobe Core (Kyrian - Mikanikos Trait)
    [354051] = { type = AuraType.ROOT }, -- Nimble Steps

    -- Trinkets
    [356567] = { type = AuraType.CROWD_CONTROL }, -- Shackles of Malediction
    [358259] = { type = AuraType.CROWD_CONTROL }, -- Gladiator's Maledict
    [362699] = { type = AuraType.IMMUNITY_SPELL }, -- Gladiator's Resolve
    [363522] = { type = AuraType.BUFF_DEFENSIVE }, -- Gladiator's Eternal Aegis

    -- Special
    [6788] = { type = AuraType.DEBUFF_OFFENSIVE, nounitFrames = true, noraidFrames = true }, -- Weakened Soul

    [31589] = { type = AuraType.DEBUFF_MOBILITY },

}

AuraPlates.frames = {};

function AuraPlates:CreateFrame()
    local index = #self.frames + 1;
    local button = CreateFrame('Button', "AuraPlates-Aura" .. index);
    button:SetWidth(self:GetSize());
    button:SetHeight(self:GetSize());
    local cooldown = CreateFrame('Cooldown', '$parentCooldown', button, 'CooldownFrameTemplate')
    cooldown:SetAllPoints()
    button.Cooldown = cooldown

    local icon = button:CreateTexture(nil, 'BORDER')
    icon:SetAllPoints()
    button.Icon = icon

    local countFrame = CreateFrame('Frame', nil, button)
    countFrame:SetAllPoints(button)
    countFrame:SetFrameLevel(cooldown:GetFrameLevel() + 1)

    local count = countFrame:CreateFontString(nil, 'OVERLAY', 'NumberFontNormal')
    count:SetPoint('BOTTOMRIGHT', countFrame, 'BOTTOMRIGHT', -1, 0)
    button.Count = count

    local stealable = button:CreateTexture(nil, 'OVERLAY')
    stealable:SetTexture([[Interface\TargetingFrame\UI-TargetingFrame-Stealable]])
    stealable:SetPoint('TOPLEFT', -3, 3)
    stealable:SetPoint('BOTTOMRIGHT', 3, -3)
    stealable:SetBlendMode('ADD')
    button.Stealable = stealable

    button:Hide();

    -- button.UpdateTooltip = UpdateTooltip
    -- button:SetScript('OnEnter', onEnter)
    -- button:SetScript('OnLeave', onLeave)

    return button
end

local FILTER = {
    all = "all",
    relevant = "relevant",
}

function AuraPlates:FreeFrames()
    local frames = {};
    for _, frame in pairs(self.frames) do
        if not frame:IsShown() then
            frames[#frames + 1] = frame;
        end
    end

    return frames;
end

function AuraPlates:GetFrame()
    return self:FreeFrames()[1]
end

function AuraPlates:GetLimit(info)
    return self.db.char.limit or 1;
end

function AuraPlates:SetLimit(info, input)
    self.db.char.limit = tonumber(input);
end

function AuraPlates:GetSize(info)
    return self.db.char.size or 50;
end

function AuraPlates:SetSize(info, input)
    self.db.char.size = tonumber(input);
end

function AuraPlates:GetFilter(info)
    return self.db.char.filter or FILTER.relevant;
end

function AuraPlates:SetFilter(info, input)
    self.db.char.filter = FILTER[input];
end

AuraPlates.clear = {};

function AuraPlates:Render(auras, root)
    local frames = {};

    if not root then
        return function() end;
    end

    for index = 1, #auras do
        local aura = auras[index];
        local frame = self:GetFrame();
    
        if aura.isStealable then
            frame:SetPoint("RIGHT", root, "LEFT", -(5 + (index - 1) * frame:GetWidth()), 0);
        else
            frame:SetPoint("LEFT", root, "RIGHT", 5 + (index - 1) * frame:GetWidth(), 0);
        end

        frame.Cooldown:SetCooldown(aura.expirationTime - aura.duration, aura.duration);
        frame.Icon:SetTexture(aura.icon);
        
        if aura.isStealable then
            frame.Stealable:Show();
        else
            frame.Stealable:Hide();
        end
        frame:Show();
        table.insert(frames, frame);
    end

    return function()
        for index = 1, #frames do
            frames[index]:Hide();
        end
    end
end

local AllAuras = AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Helpful, AuraUtil.AuraFilters.Harmful);

function AuraPlates:Auras(unit)
    if not unit then
        return {};
    end

    local auras = {};
    local index = 1;
    AuraUtil.ForEachAura(unit, AllAuras, nil, function(name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll)
        if name == "Power Infusion" then
            print(name, icon, unit, self.Spells[spellId]);
        end
        if self.Spells[spellId] then
            table.insert(auras, {
                index = index,
                name = name,
                icon = icon,
                count = count,
                unit = unit,
                dispelType = dispelType,
                duration = duration,
                expirationTime = expirationTime,
                source = source,
                isStealable = isStealable,
                nameplateShowPersonal = nameplateShowPersonal,
                spellId = spellId,
                canApplyAura = canApplyAura,
                isBossDebuff = isBossDebuff,
                castByPlayer = castByPlayer,
                nameplateShowAll = nameplateShowAll,
            })
        end
        index = index + 1;
    end)

    table.sort(auras, function(a, b)
        local auraA, auraB = self.Spells[a.spellId], self.Spells[b.spellId];
        local priorityA, priorityB = auraA and self.Priority[auraA.type] or 0, auraB and self.Priority[auraB.type] or 0
        return priorityA > priorityB;
    end)

    return auras;
end

function AuraPlates:UpdateAuras(unit)
    if not unit then
        return;
    end
    local guid = UnitGUID(unit);
    local nameplate = C_NamePlate.GetNamePlateForUnit(unit, issecure());

    if not guid then
        return;
    end

    if self.clear[guid] then
        self.clear[guid]();
    end
    
    if not nameplate then return end
 
    local auras = head(self:Auras(unit), self:GetLimit());
    self.clear[guid] = AuraPlates:Render(auras, nameplate.UnitFrame);
end

function AuraPlates:UNIT_AURA(event, unit)
    self:UpdateAuras(unit);
end

function AuraPlates:UNIT_PHASE(event, unit)
    self:UpdateAuras(unit);
end

function AuraPlates:NAME_PLATE_UNIT_ADDED(event, unit)
    self:UpdateAuras(unit);
end

function AuraPlates:NAME_PLATE_UNIT_REMOVED(event, unit)
    self:UpdateAuras(unit);
end

function AuraPlates:OnInitialize()
    -- Code that you want to run when the addon is first loaded goes here.
    self.db = LibStub("AceDB-3.0"):New("AuraPlatesDB");

    local clear = function() end;
    local options = {
        name = "AuraPlates",
        handler = AuraPlates,
        type = 'group',
        args = {
            limit = {
                type = 'input',
                name = 'Limit',
                desc = 'Number of buffs shown, ordered by priority',
                validate = function(info, value)
                    if type(value) ~= "number" and not (type(value) == "string" and value:find("^%d+$")) then
                        return "Must be a number, greater than or equal to 1";
                    end
                end,
                set = 'SetLimit',
                get = 'GetLimit',
            },
            size = {
                type = 'input',
                name = 'Size',
                desc = 'Size of aura icons',
                validate = function(info, value)
                    if type(value) ~= "number" and not (type(value) == "string" and value:find("^%d+$")) then
                        return "Must be a number, greater than or equal to 1";
                    end
                end,
                set = 'SetSize',
                get = 'GetSize',
            },
            filter = {
                type = 'input',
                name = 'filter',
                desc = 'Whether to show all or only relevant auras',
                validate = function(info, value)
                    if not FILTER[value] then
                        return "Must be 'all' or 'relevant'";
                    end
                end,
                set = 'SetFilter',
                get = 'GetFilter'
            },
            test = {
                type = 'input',
                name = 'Test',
                desc = 'Simulate aura updates',
                validate = function(info, value)
                    if not value then
                        return "Must be a spell id or 'Stop' to clear test data.";
                    end
                end,
                set = function(info, value)
                    clear();
                    if value == "stop" then
                        return;
                    end
                    local spellId = tonumber(value);
                    if not spellId then
                        return;
                    end
                    local spell = Spell:CreateFromSpellID(spellId);

                    spell:ContinueOnSpellLoad(function()
                        local desc = spell:GetSpellDescription();
                        local unit_mod = {
                            sec = 1,
                            min = 60,
                            hour = 3600,
                        }

                        local value, unit = select(3, string.find(desc, "(%d+)%s+([smh][eio][cnu]r?)"));
                        local duration = tonumber(value) * unit_mod[unit];
                        local aura = {
                            duration = duration,
                            expirationTime = GetTime() + duration,
                            name = spell:GetSpellName(),
                            spellId = spellId,
                            icon = spell:GetSpellTexture(),
                            isStealable = false
                        }

                        local nameplate = C_NamePlate.GetNamePlateForUnit("target", issecure());
                        if nameplate then
                            clear = self:Render({[1] = aura}, nameplate.UnitFrame);
                        end
                    end)
                end,
                get = function()
                end
            }
        },
    }

    for i = 1, 40 do
        table.insert(self.frames, self:CreateFrame());
    end

    LibStub("AceConfig-3.0"):RegisterOptionsTable("AuraPlates", options, { "auraplates" });
    AuraPlates:RegisterEvent("UNIT_AURA");
    AuraPlates:RegisterEvent("UNIT_PHASE");
    AuraPlates:RegisterEvent("NAME_PLATE_UNIT_ADDED");
    AuraPlates:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
end

function AuraPlates:OnEnable()
    -- Called when the addon is enabled
end

function AuraPlates:OnDisable()
    -- Called when the addon is disabled
end