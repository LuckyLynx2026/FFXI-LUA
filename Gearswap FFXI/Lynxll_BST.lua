---------------------------------------
-- Last Revised: February 23rd, 2021 --
---------------------------------------
-- Added Gleti's Armor Set
---------------------------------------------
-- Gearswap Commands Specific to this File --
---------------------------------------------
-- Universal Ready Move Commands -
-- //gs c Ready one
-- //gs c Ready two
-- //gs c Ready three
-- //gs c Ready four
--
-- alt+F8 cycles through designated Jug Pets
-- ctrl+F8 cycles backwards through designated Jug Pets
-- alt+F11 toggles Monster Correlation between Neutral and Favorable
-- alt+= switches between Pet-Only (Axe Swaps) and Master (no Axe Swap) modes
-- ctrl+= switches between Reward Modes (Theta / Roborant)
-- alt+` can swap in the usage of Chaac Belt for Treasure Hunter on common subjob abilities.
-- ctrl+F11 cycles between Magical Defense Modes
--
-------------------------------
-- General Gearswap Commands --
-------------------------------
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes
--
-- Keep in mind that any time you Change Jobs/Subjobs, your Pet/Correlation/etc reset to default options.
-- F12 will list your current options.
--
-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    -- Display and Random Lockstyle Generator options
    DisplayPetBuffTimers = 'false'
    DisplayModeInfo = 'false'
    RandomLockstyleGenerator = 'false'

    PetName = 'None';PetJob = 'None';PetInfo = 'None';ReadyMoveOne = 'None';ReadyMoveTwo = 'None';ReadyMoveThree = 'None';ReadyMoveFour = 'None'
    pet_info_update()

    -- Input Pet:TP Bonus values for Skirmish Axes used during Pet Buffs
    TP_Bonus_Main = 200
    TP_Bonus_Sub = 200

    -- 1200 Job Point Gift Bonus (Set equal to 0 if below 1200 Job Points)
    TP_Gift_Bonus = 40

    -- (Adjust Run Wild Duration based on # of Job Points)
    RunWildDuration = 340;RunWildIcon = 'abilities/00121.png'
    RewardRegenIcon = 'spells/00023.png'
    SpurIcon = 'abilities/00037.png'
    BubbleCurtainDuration = 180;BubbleCurtainIcon = 'spells/00048.png'
    ScissorGuardIcon = 'spells/00043.png'
    SecretionIcon = 'spells/00053.png'
    RageIcon = 'abilities/00002.png'
    RhinoGuardIcon = 'spells/00053.png'
    ZealousSnortIcon = 'spells/00057.png'

    -- Display Mode Info as on-screen Text
    TextBoxX = 1075
    TextBoxY = 47
    TextSize = 10

    -- List of Equipment Sets created for Random Lockstyle Generator
    -- (If you want to have the same Lockstyle every time, reduce the list to a single Equipset #)
    random_lockstyle_list = {1,2,3,4,5,6,7,8,9,10,11,12,13}

    state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false

    if DisplayModeInfo == 'true' then
        DisplayTrue = 1
    end

    get_combat_form()
    get_melee_groups()
end

function user_setup()
    state.OffenseMode:options('Normal', 'MedAcc', 'HighAcc', 'MaxAcc')
    state.WeaponskillMode:options('Normal', 'WSMedAcc', 'WSHighAcc')
    state.HybridMode:options('Normal', 'SubtleBlow')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Reraise', 'Refresh')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PetPDT')
    state.MagicalDefenseMode:options('MDT', 'PetMDT')

    -- Set up Jug Pet cycling and keybind Alt+F8/Ctrl+F8
    -- INPUT PREFERRED JUG PETS HERE
    state.JugMode = M{['description']='Jug Mode', 'Dire Broth', 'Tant. Broth', 'Lyrical Broth'}
    send_command('bind !f8 gs c cycle JugMode')
    send_command('bind ^f8 gs c cycleback JugMode')

    -- Set up Monster Correlation Modes and keybind Alt+F11
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
    send_command('bind !f11 gs c cycle CorrelationMode')

    -- Set up Axe Swapping Modes and keybind alt+=
    state.AxeMode = M{['description']='Axe Mode', 'NoSwaps', 'PetOnly'}
    send_command('bind != gs c cycle AxeMode')

    -- Set up Reward Modes and keybind ctrl+=
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Roborant'}
    send_command('bind ^= gs c cycle RewardMode')

    -- Keybind Ctrl+F11 to cycle Magical Defense Modes
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    -- Set up Treasure Modes and keybind Alt+`
    state.TreasureMode = M{['description']='Treasure Mode', 'Tag', 'Normal'}
    send_command('bind !` gs c cycle TreasureMode')

    -- 'Out of Range' distance; Melee WSs will auto-cancel
    target_distance = 8

-- Categorized list of Ready moves
physical_ready_moves = S{'Foot Kick','Whirl Claws','Sheep Charge','Lamb Chop','Head Butt','Wild Oats',
    'Leaf Dagger','Claw Cyclone','Razor Fang','Crossthrash','Nimble Snap','Cyclotail','Rhino Attack',
    'Power Attack','Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick',
    'Blockhead','Brain Crush','Tail Blow','Scythe Tail','Ripper Fang','Chomp Rush','Needleshot',
    'Recoil Dive','Sudden Lunge','Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel',
    'Fantod','Tortoise Stomp','Sensilla Blades','Tegmina Buffet','Pentapeck','Sweeping Gouge',
    'Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash','Disembowel','Extirpating Salvo',
    'Mega Scissors','Rhinowrecker','Hoof Volley','Fluid Toss','Fluid Spread'}

magic_atk_ready_moves = S{'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
    'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Corrosive Ooze',
    'Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume','Foul Waters',
    'Acid Spray','Infected Leech','Gloom Spray','Venom Shower'}

magic_acc_ready_moves = S{'Sheep Song','Scream','Dream Flower','Roar','Predatory Glare','Gloeosuccus',
    'Palsy Pollen','Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
    'Sandpit','Sandblast','Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom',
    'Infrasonics','Chaotic Eye','Blaster','Purulent Ooze','Intimidate','Noisome Powder','Acid Mist',
    'Choke Breath','Jettatura','Nihility Song','Molting Plumage','Swooping Frenzy','Spider Web'}

multi_hit_ready_moves = S{'Pentapeck','Tickling Tendrils','Sweeping Gouge','Chomp Rush','Wing Slap',
    'Pecking Flurry'}

tp_based_ready_moves = S{'Foot Kick','Dust Cloud','Snow Cloud','Sheep Song','Sheep Charge','Lamb Chop',
    'Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
    'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Somersault','Geist Wall','Numbing Noise',
    'Frogkick','Nimble Snap','Cyclotail','Spoil','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
    'Mandibular Bite','Metallic Body','Bubble Shower','Grapple','Spinning Top','Double Claw','Spore',
    'Filamented Hold','Blockhead','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics',
    'Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive','Water Wall',
    'Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss','Acid Mist',
    'TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker','Purulent Ooze',
    'Corrosive Ooze','Tortoise Stomp','Aqua Breath','Sensilla Blades','Tegmina Buffet','Sweeping Gouge',
    'Tickling Tendrils','Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Gloom Spray',
    'Disembowel','Extirpating Salvo','Rhinowrecker','Venom Shower','Fluid Toss','Fluid Spread','Digest'}

-- List of Pet Buffs and Ready moves exclusively modified by Pet TP Bonus gear.
pet_buff_moves = S{'Wild Carrot','Bubble Curtain','Scissor Guard','Secretion','Rage','Harden Shell',
    'TP Drainkiss','Fantod','Rhino Guard','Zealous Snort','Frenzied Rage','Digest'}

-- List of Jug Modes that will cancel if Call Beast is used (Bestial Loyalty-only jug pets, HQs generally).
call_beast_cancel = S{'Vis. Broth','Ferm. Broth','Bubbly Broth','Windy Greens','Bug-Ridden Broth','Tant. Broth',
    'Glazed Broth','Slimy Webbing','Deepwater Broth','Venomous Broth','Heavenly Broth'}

-- List of abilities to reference for applying Treasure Hunter gear.
abilities_to_check = S{'Feral Howl','Quickstep','Box Step','Stutter Step','Desperate Flourish',
    'Violent Flourish','Animated Flourish','Provoke','Dia','Dia II','Flash','Bio','Bio II',
    'Sleep','Sleep II','Drain','Aspir','Dispel','Stun','Steal','Mug'}

enmity_plus_moves = S{'Provoke','Berserk','Warcry','Aggressor','Holy Circle','Sentinel','Last Resort',
    'Souleater','Vallation','Swordplay'}

-- Random Lockstyle generator.
    if RandomLockstyleGenerator == 'true' then
        local randomLockstyle = random_lockstyle_list[math.random(1, #random_lockstyle_list)]
        send_command('@wait 5;input /lockstyleset '.. randomLockstyle)
    end

    display_mode_info()
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

    -- Unbinds the Reward, Correlation, JugMode, AxeMode and Treasure hotkeys.
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind @f8')
    send_command('unbind ^f11')

    -- Removes any Text Info Boxes
    send_command('text JugPetText delete')
    send_command('text CorrelationText delete')
    send_command('text AxeModeText delete')
    send_command('text AccuracyText delete')
end

-- BST gearsets
function init_gear_sets()
    -------------------------------------------------
    -- AUGMENTED GEAR AND GENERAL GEAR DEFINITIONS --
    -------------------------------------------------

    Pet_Idle_AxeMain = "Pangu"
    Pet_Idle_AxeSub = "Izizoeksi"
    Pet_PDT_AxeMain = "Pangu"
    Pet_PDT_AxeSub = {name="Kumbhakarna", augments={'Pet: DEF+20','Pet: Damage taken -4%','Pet: STR+14 Pet: DEX+14 Pet: VIT+14',}}
    Pet_MDT_AxeMain = "Pangu"
    Pet_MDT_AxeSub = "Izizoeksi"
    Pet_TP_AxeMain = "Skullrender"
    Pet_TP_AxeSub = "Skullrender"
    Pet_Regen_AxeMain = "Buramgh +1"
    Pet_Regen_AxeSub = {name="Kumbhakarna", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','MND+17',}}

    Ready_Atk_Axe = "Guttler"
    Ready_Atk_Axe2 = "Agwu's Axe"
    Ready_Atk_TPBonus_Axe = "Guttler"
    Ready_Atk_TPBonus_Axe2 = {name="Kumbhakarna", augments={'Pet: Attack+25 Pet: Rng.Atk.+25','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: TP Bonus+200',}}

    Ready_Acc_Axe = "Arktoi"
    Ready_Acc_Axe2 = "Agwu's Axe"

    Ready_MAB_Axe = {name="Digirbalag", augments={'Pet: Mag. Acc.+21','Pet: "Mag.Atk.Bns."+30','INT+2 MND+2 CHR+2',}}
    Ready_MAB_Axe2 = "Deacon Tabar"
    Ready_MAB_TPBonus_Axe = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+25','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+200',}}
    Ready_MAB_TPBonus_Axe2 = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+22','Pet: Phys. dmg. taken -5%','Pet: TP Bonus+200',}}

    Ready_MAcc_Axe = {name="Kumbhakarna", augments={'Pet: Mag. Acc.+20','"Cure" potency +15%','Pet: TP Bonus+180',}}
    Ready_MAcc_Axe2 = "Agwu's Axe"

    Reward_Axe = "Farsha"
    Reward_Axe2 = {name="Kumbhakarna", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','MND+17',}}
    Reward_back = {name="Artio's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}

    Pet_PDT_head = "Anwig Salade"
    Pet_PDT_body = "Totemic Jackcoat +3"
    Pet_PDT_hands = "Gleti's Gauntlets"
    Pet_PDT_legs = "Tali'ah Seraweels +2"
    Pet_PDT_feet = "Ankusa Gaiters +3"
    Pet_PDT_back = {name="Artio's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Pet: "Regen"+10','System: 1 ID: 1246 Val: 4',}}

    Pet_MDT_head = "Anwig Salade"
    Pet_MDT_body = "Totemic Jackcoat +3"
    Pet_MDT_hands = "Gleti's Gauntlets"
    Pet_MDT_legs = "Tali'ah Seraweels +2"
    Pet_MDT_feet = {name="Taeon Boots", augments={'Pet: Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    Pet_MDT_back = {name="Artio's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}}

    Pet_DT_head = "Anwig Salade"
    Pet_DT_body = {name="Acro Surcoat", augments={'Pet: DEF+22','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    Pet_DT_hands = {name="Acro Gauntlets", augments={'Pet: DEF+22','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    Pet_DT_legs = {name="Acro Breeches", augments={'Pet: DEF+25','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    Pet_DT_feet = {name="Acro Leggings", augments={'Pet: DEF+25','Pet: "Regen"+3','Pet: Damage taken -4%',}}

    Pet_Regen_head = {name="Valorous Mask", augments={'Pet: "Regen"+5','Pet: Accuracy+13 Pet: Rng. Acc.+13',}}
    Pet_Regen_body = {name="Valorous Mail", augments={'Pet: Accuracy+27 Pet: Rng. Acc.+27','Pet: "Regen"+5','Pet: Attack+4 Pet: Rng.Atk.+4',}}
    Pet_Regen_hands = {name="Valorous Mitts", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Regen"+5','Pet: DEX+7','Pet: Attack+15 Pet: Rng.Atk.+15',}}
    Pet_Regen_legs = {name="Valorous Hose", augments={'Pet: "Regen"+5','Pet: Attack+1 Pet: Rng.Atk.+1',}}
    Pet_Regen_feet = "Emicho Gambieras +1"
    Pet_Regen_back = {name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10','Pet: "Regen"+5',}}

    Ready_Atk_head = "Emicho Coronet +1"
    Ready_Atk_body = {name="Valorous Mail", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: STR+13',}}
    Ready_Atk_hands = "Emicho Gauntlets +1"
    Ready_Atk_legs = "Totemic Trousers +3"
    Ready_Atk_feet = "Gleti's Boots"
    Ready_Atk_back = {name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}}

    Ready_Acc_head = "Gleti's Mask"
    Ready_Acc_body = "Heyoka Harness +1"
    Ready_Acc_hands = "Gleti's Gauntlets"
    Ready_Acc_legs = "Heyoka Subligar +1"
    Ready_Acc_feet = "Gleti's Boots"
    Ready_Acc_back = {name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}}

    Ready_MAB_head = {name="Valorous Mask", augments={'Pet: "Mag.Atk.Bns."+30','Pet: "Store TP"+2','Pet: INT+8','Pet: Attack+6 Pet: Rng.Atk.+6',}}
    Ready_MAB_body = "Udug Jacket"
    Ready_MAB_hands = {name="Valorous Mitts", augments={'Pet: "Mag.Atk.Bns."+29','Pet: "Store TP"+9','Pet: INT+12','Pet: Attack+4 Pet: Rng.Atk.+4',}}
    Ready_MAB_legs = {name="Valorous Hose", augments={'Pet: "Mag.Atk.Bns."+30','Pet: INT+10','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: Attack+6 Pet: Rng.Atk.+6',}}
    Ready_MAB_feet = {name="Valorous Greaves", augments={'Pet: "Mag.Atk.Bns."+30','Pet: INT+13','Pet: Accuracy+9 Pet: Rng. Acc.+9','Pet: Attack+15 Pet: Rng.Atk.+15',}}

    Ready_MAcc_head = "Gleti's Mask"
    Ready_MAcc_body = "Gleti's Cuirass"
    Ready_MAcc_hands = "Gleti's Gauntlets"
    Ready_MAcc_legs = "Gleti's breeches"
    Ready_MAcc_feet = "Gleti's Boots"
    Ready_MAcc_back = {name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10','Pet: "Regen"+5',}}

    Ready_DA_Axe = "Skullrender"
    Ready_DA_Axe2 = "Skullrender"
    Ready_DA_head = "Emicho Coronet +1"
    Ready_DA_body = {name="Valorous Mail", augments={'Pet: Mag. Acc.+27','Pet: "Dbl. Atk."+5','Pet: Accuracy+3 Pet: Rng. Acc.+3','Pet: Attack+15 Pet: Rng.Atk.+15',}}
    Ready_DA_hands = "Emicho Gauntlets +1"
    Ready_DA_legs = "Emicho Hose +1"
    Ready_DA_feet = {name="Valorous Greaves", augments={'Pet: Mag. Acc.+20','Pet: "Dbl. Atk."+5','Pet: STR+9','Pet: Accuracy+13 Pet: Rng. Acc.+13','Pet: Attack+14 Pet: Rng.Atk.+14',}}

    Pet_Melee_head = "Emicho Coronet +1"
    Pet_Melee_body = {name="Valorous Mail", augments={'Pet: Mag. Acc.+27','Pet: "Dbl. Atk."+5','Pet: Accuracy+3 Pet: Rng. Acc.+3','Pet: Attack+15 Pet: Rng.Atk.+15',}}
    Pet_Melee_hands = "Emicho Gauntlets +1"
    Pet_Melee_legs = "Ankusa Trousers +3"
    Pet_Melee_feet = {name="Taeon Boots", augments={'Pet: Attack+23 Pet: Rng.Atk.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}

    Hybrid_head = {name="Valorous Mask", augments={'Pet: "Regen"+5','Pet: Accuracy+13 Pet: Rng. Acc.+13',}}
    Hybrid_body = Pet_PDT_body
    Hybrid_hands = Pet_PDT_hands
    Hybrid_legs = {name="Taeon Tights", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','Pet: Damage taken -4%',}}
    Hybrid_feet = {name="Taeon Boots", augments={'Accuracy+25','"Triple Atk."+2','Pet: Damage taken -4%',}}

    DW_head = {name="Taeon Chapeau", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','STR+3 VIT+3',}}
    DW_body = {name="Taeon Tabard", augments={'Accuracy+20 Attack+20','"Dual Wield"+5','Crit. hit damage +2%',}}
    DW_hands = "Emicho Gauntlets +1"
    DW_legs = {name="Taeon Tights", augments={'Accuracy+22','"Dual Wield"+5','Crit. hit damage +2%',}}
    DW_feet = {name="Taeon Boots", augments={'Accuracy+23','"Dual Wield"+5','Crit. hit damage +2%',}}
    DW_back = {name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}

    MAB_head = {name="Valorous Mask", augments={'AGI+5','"Mag.Atk.Bns."+25','Haste+2','Accuracy+19 Attack+19','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
    MAB_body = "Sacro Breastplate"
    MAB_hands = "Leyline Gloves"
    MAB_legs = {name="Valorous Hose", augments={'"Mag.Atk.Bns."+30','Accuracy+10','Crit.hit rate+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
    MAB_feet = {name="Valorous Greaves", augments={'CHR+8','"Mag.Atk.Bns."+28','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}

    FC_head = {name="Valorous Mask", augments={'"Resist Silence"+2','MND+3','"Fast Cast"+7','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}
    FC_body = "Sacro Breastplate"
    FC_hands = "Leyline Gloves"
    FC_legs = {name="Valorous Hose", augments={'Crit.hit rate+2','"Dual Wield"+1','"Fast Cast"+7',}}
    FC_feet = {name="Valorous Greaves", augments={'"Mag.Atk.Bns."+17','AGI+7','"Fast Cast"+7','Accuracy+14 Attack+14',}}
    FC_back = {name="Artio's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}}

    MAcc_head = "Malignance Chapeau"
    MAcc_body = "Malignance Tabard"
    MAcc_hands = "Malignance Gloves"
    MAcc_legs = "Malignance Tights"
    MAcc_feet = "Malignance Boots"
    MAcc_back = {name="Artio's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Enmity+10','Phys. dmg. taken-10%',}}

    PDT_back = {name="Artio's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity-10','Phys. dmg. taken-10%',}}

    MEva_head = "Malignance Chapeau"
    MEva_body = "Malignance Tabard"
    MEva_hands = "Malignance Gloves"
    MEva_legs = "Malignance Tights"
    MEva_feet = "Malignance Boots"
    MEva_back = {name="Artio's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Occ. inc. resist. to stat. ailments+10',}}

    CB_head = {name="Acro Helm", augments={'Pet: Mag. Acc.+25','"Call Beast" ability delay -5',}}
    CB_body = "Mirke Wardecors"
    CB_hands = "Ankusa Gloves +3"
    CB_legs = {name="Acro Breeches", augments={'Pet: Mag. Acc.+25','"Call Beast" ability delay -5',}}
    CB_feet = "Armada Sollerets"

    Cure_Potency_axe = {name="Kumbhakarna", augments={'Pet: Mag. Acc.+20','"Cure" potency +15%','Pet: TP Bonus+180',}}
    Cure_Potency_head = "Emicho Coronet +1"
    Cure_Potency_body = "Jumalik Mail"
    Cure_Potency_hands = "Buremte Gloves"
    Cure_Potency_legs = "Totemic Trousers +3"
    Cure_Potency_feet = {name="Taeon Boots", augments={'"Cure" potency +5%',}}
    Cure_Potency_back = {name="Artio's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Spell interruption rate down-10%',}}

    Waltz_back = {name="Artio's Mantle", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','Weapon skill damage +10%',}}
    STP_back = {name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    STR_DA_back = {name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    STR_WS_back = {name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Crit_back = {name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
    Onslaught_back = {name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Primal_back = {name="Artio's Mantle", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','Weapon skill damage +10%',}}
    Cloud_back = {name="Artio's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}

    STP_head = {name="Valorous Mask", augments={'Attack+27','"Store TP"+8','Accuracy+1',}}
    STP_feet = {name="Valorous Greaves", augments={'Accuracy+23 Attack+23','"Store TP"+8','AGI+4',}}

    Regain_head = {name="Valorous Mask", augments={'"Cure" spellcasting time -7%','MND+8','Damage taken-4%','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
    Regain_body = "Gleti's Cuirass"
    Regain_hands = "Gleti's Gauntlets"
    Regain_legs = "Gleti's breeches"
    Regain_feet = "Gleti's Boots"

    TH_legs = {name="Valorous Hose", augments={'STR+3','INT+5','"Treasure Hunter"+2','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}

    Enmity_plus_feet = {name="Acro Leggings", augments={'Pet: Mag. Acc.+23','Enmity+10',}}
    Enmity_plus_back = {name="Artio's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Enmity+10','Phys. dmg. taken-10%',}}

    sets.Enmity = {ammo="Paeapua",
        head="Halitus Helm",neck="Unmoving Collar +1",ear1="Trux Earring",ear2="Cryptic Earring",
        body="Emet Harness +1",hands="Macabre Gauntlets +1",ring1="Pernicious Ring",ring2="Eihwaz Ring",
        back=Enmity_plus_back,waist="Trance Belt",legs="Zoar Subligar +1",
        feet=Enmity_plus_feet}
    sets.EnmityNE = set_combine(sets.Enmity, {main="Freydis",sub="Evalach +1"})
    sets.EnmityNEDW = set_combine(sets.Enmity, {main="Freydis",sub="Evalach +1"})

    ---------------------
    -- JA PRECAST SETS --
    ---------------------
    -- Most gearsets are divided into 3 categories:
    -- 1. Default - No Axe swaps involved.
    -- 2. NE (Not engaged) - Axe/Shield swap included, for use with Pet Only mode.
    -- 3. NEDW (Not engaged; Dual-wield) - Axe swaps included, for use with Pet Only mode.

    sets.precast.JA.Familiar = {legs="Ankusa Trousers +3"}
    sets.precast.JA['Call Beast'] = {    
		body={ name="Mirke Wardecors", augments={'"Call Beast" ability delay -15','Enmity-5',}},
		hands={ name="Ankusa Gloves +3", augments={'Enhances "Beast Affinity" effect',}},}
    sets.precast.JA['Bestial Loyalty'] = sets.precast.JA['Call Beast']

    sets.precast.JA.Tame = {head="Totemic Helm +1",ear1="Tamer's Earring",legs="Stout Kecks"}

    sets.precast.JA.Spur = {back="Artio's Mantle",feet="Ferine Ocreae +1"}
    sets.precast.JA.SpurNE = set_combine(sets.precast.JA.Spur, {main="Skullrender"})
    sets.precast.JA.SpurNEDW = set_combine(sets.precast.JA.Spur, {main="Skullrender",sub="Skullrender"})

    sets.precast.JA['Feral Howl'] = {
	    ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		body="Ankusa jackcoat +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Izdubar Mantle",}
    sets.precast.JA['Feral Howl'] = set_combine(sets.Enmity, {body="Ankusa Jackcoat +3"})

    sets.precast.JA['Killer Instinct'] = set_combine(sets.Enmity, {head="Ankusa Helm +3"})

    sets.precast.JA.Reward = {
        head="Khimaira Bonnet",
		body="Tot. Jackcoat +1",
		hands="Malignance Gloves",
		legs="Ankusa Trousers +3",
		feet={ name="Ankusa Gaiters +3", augments={'Enhances "Beast Healer" effect',}},
		neck="Phalaina Locket",
		left_ear="Pratik Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",}
    sets.precast.JA.RewardNE = set_combine(sets.precast.JA.Reward, {main=Reward_Axe,sub="Matamata Shield +1"})
    sets.precast.JA.RewardNEDW = set_combine(sets.precast.JA.RewardNE, {sub=Reward_Axe2})

    sets.precast.JA.Charm = {
	    ammo="Voluspa Tathlum",
		head={ name="Ankusa Helm +3", augments={'Enhances "Killer Instinct" effect',}},
		body="Ankusa jackcoat +3",
		hands={ name="Ankusa Gloves +3", augments={'Enhances "Beast Affinity" effect',}},
		legs="Ankusa Trousers +3",
		feet={ name="Ankusa Gaiters +3", augments={'Enhances "Beast Healer" effect',}},
		waist="Aristo Belt",
		left_ear="Handler's Earring +1",
		right_ear="Enchntr. Earring +1",
		left_ring="Carb. Ring",
		right_ring="Carb. Ring",}
    sets.precast.JA.CharmNE = set_combine(sets.precast.JA.Charm, {main="Buramgh +1",sub="Thuellaic Ecu +1"})
    sets.precast.JA.CharmNEDW = set_combine(sets.precast.JA.CharmNE, {sub="Buramgh"})

    ---------------------------
    -- PET SIC & READY MOVES --
    ---------------------------

    sets.ReadyRecast = {legs="Gleti's breeches"}
    sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +1"}
    sets.midcast.Pet.Neutral = {head="Emicho Coronet +1"}
    sets.midcast.Pet.Favorable = {head="Nukumi Cabasset +1"}

    sets.midcast.Pet.Normal = {    
		ammo="Voluspa Tathlum",
		head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
		body="Nyame Mail",
		hands="Nukumi Manoplas +1",
		legs="Nyame Flanchard",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",}

    sets.midcast.Pet.MedAcc = set_combine(sets.midcast.Pet.Normal, {
		ammo="Voluspa Tathlum",
		head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
		body="Nyame Mail",
		hands="Nukumi Manoplas +1",
		legs="Nyame Flanchard",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",})

    sets.midcast.Pet.HighAcc = set_combine(sets.midcast.Pet.Normal, {
		ammo="Voluspa Tathlum",
		head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
		body="Nyame Mail",
		hands="Nukumi Manoplas +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",})

    sets.midcast.Pet.MaxAcc = set_combine(sets.midcast.Pet.Normal, {   
		ammo="Voluspa Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",})

    sets.midcast.Pet.MagicAtkReady = {}

    sets.midcast.Pet.MagicAtkReady.Normal = {   
		ammo="Voluspa Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Tali'ah Ring",}

    sets.midcast.Pet.MagicAtkReady.MedAcc = set_combine(sets.midcast.Pet.MagicAtkReady.Normal, {
		ammo="Voluspa Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Tali'ah Ring",})

    sets.midcast.Pet.MagicAtkReady.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReady.Normal, {
 		ammo="Voluspa Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Tali'ah Ring",})

    sets.midcast.Pet.MagicAtkReady.MaxAcc = set_combine(sets.midcast.Pet.MagicAtkReady.Normal, {
		ammo="Voluspa Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Tali'ah Ring",})

    sets.midcast.Pet.MagicAccReady = set_combine(sets.midcast.Pet.Normal, {    
		ammo="Voluspa Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Tali'ah Ring",})

    sets.midcast.Pet.MultiStrike = set_combine(sets.midcast.Pet.Normal, {    
		ammo="Voluspa Tathlum",
		head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
		body="Nyame Mail",
		hands="Nukumi Manoplas +1",
		legs={ name="Emicho Hose +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",})

    sets.midcast.Pet.Buff = set_combine(sets.midcast.Pet.TPBonus, {
        body="Emicho Haubert +1"})

    --------------------------------------
    -- SINGLE WIELD PET-ONLY READY SETS --
    --------------------------------------

    -- Physical Ready Attacks w/o TP Modifier for Damage (ex. Sickle Slash, Whirl Claws, Swooping Frenzy, etc.)
    sets.midcast.Pet.ReadyNE = {}
    sets.midcast.Pet.ReadyNE.Normal = set_combine(sets.midcast.Pet.Normal, {main=Ready_Atk_Axe})
    sets.midcast.Pet.ReadyNE.MedAcc = set_combine(sets.midcast.Pet.MedAcc, {main=Ready_Atk_Axe})
    sets.midcast.Pet.ReadyNE.HighAcc = set_combine(sets.midcast.Pet.HighAcc, {main=Ready_Atk_Axe})
    sets.midcast.Pet.ReadyNE.MaxAcc = set_combine(sets.midcast.Pet.MaxAcc, {main=Ready_Acc_Axe})

    -- Physical TP Bonus Ready Attacks (ex. Razor Fang, Tegmina Buffet, Tail Blow, Recoil Dive, etc.)
    sets.midcast.Pet.ReadyNE.TPBonus = {}
    sets.midcast.Pet.ReadyNE.TPBonus.Normal = set_combine(sets.midcast.Pet.ReadyNE.Normal, {main=Ready_Atk_TPBonus_Axe})
    sets.midcast.Pet.ReadyNE.TPBonus.MedAcc = set_combine(sets.midcast.Pet.ReadyNE.MedAcc, {main=Ready_Atk_TPBonus_Axe})
    sets.midcast.Pet.ReadyNE.TPBonus.HighAcc = set_combine(sets.midcast.Pet.ReadyNE.HighAcc, {main=Ready_Atk_TPBonus_Axe})
    sets.midcast.Pet.ReadyNE.TPBonus.MaxAcc = set_combine(sets.midcast.Pet.ReadyNE.MaxAcc, {main=Ready_Acc_Axe})

    -- Multihit Ready Attacks w/o TP Modifier for Damage (Pentapeck, Chomp Rush)
    sets.midcast.Pet.MultiStrikeNE = set_combine(sets.midcast.Pet.MultiStrike, {main=Ready_Atk_Axe2})

    -- Multihit TP Bonus Ready Attacks (Sweeping Gouge, Tickling Tendrils, Pecking Flurry, Wing Slap)
    sets.midcast.Pet.MultiStrikeNE.TPBonus = set_combine(sets.midcast.Pet.MultiStrike, {main=Ready_Atk_TPBonus_Axe})

    -- Magical Ready Attacks w/o TP Modifier for Damage (ex. Molting Plumage, Venom, Stink Bomb, etc.)
    sets.midcast.Pet.MagicAtkReadyNE = {}
    sets.midcast.Pet.MagicAtkReadyNE.Normal = set_combine(sets.midcast.Pet.MagicAtkReady.Normal, {main=Ready_MAB_Axe})
    sets.midcast.Pet.MagicAtkReadyNE.MedAcc = set_combine(sets.midcast.Pet.MagicAtkReady.MedAcc, {main=Ready_MAB_Axe})
    sets.midcast.Pet.MagicAtkReadyNE.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReady.HighAcc, {main=Ready_MAB_Axe})
    sets.midcast.Pet.MagicAtkReadyNE.MaxAcc = set_combine(sets.midcast.Pet.MagicAtkReady.MaxAcc, {main=Ready_MAcc_Axe2})

    -- Magical TP Bonus Ready Attacks (ex. Fireball, Cursed Sphere, Corrosive Ooze, etc.)
    sets.midcast.Pet.MagicAtkReadyNE.TPBonus = {}
    sets.midcast.Pet.MagicAtkReadyNE.TPBonus.Normal = set_combine(sets.midcast.Pet.MagicAtkReadyNE.Normal, {main=Ready_MAB_TPBonus_Axe})
    sets.midcast.Pet.MagicAtkReadyNE.TPBonus.MedAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.MedAcc, {main=Ready_MAB_TPBonus_Axe})
    sets.midcast.Pet.MagicAtkReadyNE.TPBonus.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.HighAcc, {main=Ready_MAB_TPBonus_Axe})
    sets.midcast.Pet.MagicAtkReadyNE.TPBonus.MaxAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.MaxAcc, {main=Ready_MAcc_Axe2})

    -- Magical Ready Enfeebles (ex. Roar, Sheep Song, Infrasonics, etc.)
    sets.midcast.Pet.MagicAccReadyNE = set_combine(sets.midcast.Pet.MagicAccReady, {main="Pangu"})

    -- Pet Buffs/Cures (Bubble Curtain, Scissor Guard, Secretion, Rage, Rhino Guard, Zealous Snort, Wild Carrot)
    sets.midcast.Pet.BuffNE = set_combine(sets.midcast.Pet.Buff, {main=Ready_Atk_TPBonus_Axe})

    -- Axe Swaps for when Pet TP is above a certain value.
    sets.UnleashAtkAxeShield = {}
    sets.UnleashAtkAxeShield.Normal = {main=Ready_Atk_Axe}
    sets.UnleashAtkAxeShield.MedAcc = {main=Ready_Atk_Axe}
    sets.UnleashAtkAxeShield.HighAcc = {main=Ready_Atk_Axe}
    sets.UnleashMultiStrikeAxeShield = {main=Ready_DA_Axe}

    sets.UnleashMABAxeShield = {}
    sets.UnleashMABAxeShield.Normal = {main=Ready_MAB_Axe}
    sets.UnleashMABAxeShield.MedAcc = {main=Ready_MAB_Axe}
    sets.UnleashMABAxeShield.HighAcc = {main=Ready_MAB_Axe}

    ------------------------------------
    -- DUAL WIELD PET-ONLY READY SETS --
    ------------------------------------

    -- DW Axe Swaps for Physical Ready Attacks w/o TP Modifier for Damage (ex. Sickle Slash, Whirl Claws, Swooping Frenzy, etc.)
    sets.midcast.Pet.ReadyDWNE = {}
    sets.midcast.Pet.ReadyDWNE.Normal = set_combine(sets.midcast.Pet.ReadyNE.Normal, {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2})
    sets.midcast.Pet.ReadyDWNE.MedAcc = set_combine(sets.midcast.Pet.ReadyNE.MedAcc, {main=Ready_Atk_Axe,sub=Ready_Acc_Axe})
    sets.midcast.Pet.ReadyDWNE.HighAcc = set_combine(sets.midcast.Pet.ReadyNE.HighAcc, {main=Ready_Atk_Axe,sub=Ready_Acc_Axe})
    sets.midcast.Pet.ReadyDWNE.MaxAcc = set_combine(sets.midcast.Pet.ReadyNE.MaxAcc, {main=Ready_Acc_Axe,sub=Ready_Acc_Axe2})

    -- DW Axe Swaps for Physical TP Bonus Ready Attacks (ex. Razor Fang, Tegmina Buffet, Tail Blow, Recoil Dive, etc.)
    sets.midcast.Pet.ReadyDWNE.TPBonus = {}
    sets.midcast.Pet.ReadyDWNE.TPBonus.Normal = set_combine(sets.midcast.Pet.ReadyNE.Normal, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Atk_Axe2})
    sets.midcast.Pet.ReadyDWNE.TPBonus.MedAcc = set_combine(sets.midcast.Pet.ReadyNE.MedAcc, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Acc_Axe2})
    sets.midcast.Pet.ReadyDWNE.TPBonus.HighAcc = set_combine(sets.midcast.Pet.ReadyNE.HighAcc, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Acc_Axe2})
    sets.midcast.Pet.ReadyDWNE.TPBonus.MaxAcc = set_combine(sets.midcast.Pet.ReadyNE.MaxAcc, {main=Ready_Acc_Axe,sub=Ready_Acc_Axe2})

    -- DW Axe Swaps for Multihit Ready Attacks w/o TP Modifier for Damage (Pentapeck, Chomp Rush)
    sets.midcast.Pet.MultiStrikeDWNE = set_combine(sets.midcast.Pet.MultiStrikeNE, {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2})

    -- DW Axe Swaps for Multihit TP Bonus Ready Attacks (Sweeping Gouge, Tickling Tendrils, Pecking Flurry, Wing Slap)
    sets.midcast.Pet.MultiStrikeDWNE.TPBonus = set_combine(sets.midcast.Pet.MultiStrikeNE, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Atk_TPBonus_Axe2})

    -- DW Axe Swaps for Magical Ready Attacks w/o TP Modifier for Damage (ex. Molting Plumage, Stink Bomb, Venom, etc.)
    sets.midcast.Pet.MagicAtkReadyDWNE = {}
    sets.midcast.Pet.MagicAtkReadyDWNE.Normal = set_combine(sets.midcast.Pet.MagicAtkReadyNE.Normal, {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2})
    sets.midcast.Pet.MagicAtkReadyDWNE.MedAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.MedAcc, {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2})
    sets.midcast.Pet.MagicAtkReadyDWNE.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.HighAcc, {main=Ready_MAB_Axe,sub=Ready_MAcc_Axe})
    sets.midcast.Pet.MagicAtkReadyDWNE.MaxAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.MaxAcc, {main=Ready_MAB_Axe,sub=Ready_MAcc_Axe})

    -- DW Axe Swaps for Magical TP Bonus Ready Attacks (ex. Fireball, Cursed Sphere, Corrosive Ooze, etc.)
    sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus = {}
    sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus.Normal = set_combine(sets.midcast.Pet.MagicAtkReadyNE.Normal, {main=Ready_MAB_TPBonus_Axe,sub=Ready_MAB_TPBonus_Axe2})
    sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus.MedAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.MedAcc, {main=Ready_MAB_TPBonus_Axe,sub=Ready_MAB_TPBonus_Axe2})
    sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.HighAcc, {main=Ready_MAB_TPBonus_Axe,sub=Ready_MAB_TPBonus_Axe2})
    sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus.MaxAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.MaxAcc, {main=Ready_MAB_Axe,sub=Ready_MAcc_Axe})

    -- DW Axe Swaps for Magical Ready Enfeebles (ex. Roar, Sheep Song, Infrasonics, etc.)
    sets.midcast.Pet.MagicAccReadyDWNE = set_combine(sets.midcast.Pet.MagicAccReadyNE, {main="Pangu",sub="Pangu"})

    -- DW Axe Swaps for Pet Buffs/Cures (Bubble Curtain, Scissor Guard, Secretion, Rage, Rhino Guard, Zealous Snort, Wild Carrot)
    sets.midcast.Pet.BuffDWNE = set_combine(sets.midcast.Pet.BuffNE, {main=Ready_Atk_TPBonus_Axe,sub=Ready_MAB_TPBonus_Axe})

    -- Axe Swaps for when Pet TP is above a certain value.
    sets.UnleashAtkAxes = {}
    sets.UnleashAtkAxes.Normal = {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2}
    sets.UnleashAtkAxes.MedAcc = {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2}
    sets.UnleashAtkAxes.HighAcc = {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2}
    sets.UnleashMultiStrikeAxes = {main=Ready_DA_Axe,sub=Ready_DA_Axe2}

    sets.UnleashMABAxes = {}
    sets.UnleashMABAxes.Normal = {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2}
    sets.UnleashMABAxes.MedAcc = {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2}
    sets.UnleashMABAxes.HighAcc = {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2}

    ---------------
    -- IDLE SETS --
    ---------------

    sets.idle = {
	    ammo="Staunch Tathlum +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear="Dawn Earring",
		right_ear="Infused Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

    sets.idle.Refresh = set_combine(sets.idle, {ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
    sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

    sets.idle.Pet = set_combine(sets.idle, {back=Pet_Regen_back})

    --sets.idle.PetRegen = set_combine(sets.idle.Pet, {neck="Empath Necklace",feet=Pet_Regen_feet})

    sets.idle.Pet.Engaged = {    
		ammo="Voluspa Tathlum",
		head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
		body="Ankusa jackcoat +3",
		hands="Gleti's Gauntlets",
		legs="Ankusa Trousers +3",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Handler's Earring +1",
		right_ear="Enmerkar Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",}

    sets.idle.Pet.Engaged.PetSBMNK = set_combine(sets.idle.Pet.Engaged, {
        --ear1="Gelai Earring",body=Pet_SB_body,
        waist="Isa Belt"})

    sets.idle.Pet.Engaged.PetSBNonMNK = set_combine(sets.idle.Pet.Engaged, {
        --ear1="Gelai Earring",body=Pet_SB_body,
        waist="Isa Belt"})

    sets.idle.Pet.Engaged.PetSTP = set_combine(sets.idle.Pet.Engaged, {
        ring1="Varar Ring +1",ring2="Varar Ring +1"})

    sets.resting = {}

    ------------------
    -- DEFENSE SETS --
    ------------------

    -- Pet PDT and MDT sets:
    sets.defense.PetPDT = {
	    ammo="Voluspa Tathlum",
		head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
		body="Nyame Mail",
		hands="Gleti's Gauntlets",
		legs="Tali'ah Sera. +2",
		feet={ name="Ankusa Gaiters +3", augments={'Enhances "Beast Healer" effect',}},
		neck="Empath Necklace",
		waist="Isa Belt",
		left_ear="Handler's Earring +1",
		right_ear="Enmerkar Earring",
		left_ring="Varar Ring +1",
		right_ring="Defending Ring",}

    sets.defense.PetMDT = {    
		ammo="Voluspa Tathlum",
		head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
		body="Nyame Mail",
		hands="Gleti's Gauntlets",
		legs="Tali'ah Sera. +2",
		feet={ name="Ankusa Gaiters +3", augments={'Enhances "Beast Healer" effect',}},
		neck="Empath Necklace",
		waist="Isa Belt",
		left_ear="Handler's Earring +1",
		right_ear="Enmerkar Earring",
		left_ring="Varar Ring +1",
		right_ring="Defending Ring",}

    -- Master PDT and MDT sets:
    sets.defense.PDT = {   
		ammo="Staunch Tathlum +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

    sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

    sets.defense.HybridPDT = {    
		ammo="Staunch Tathlum +1",
		head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
		body="Nyame Mail",
		hands="Gleti's Gauntlets",
		legs="Tali'ah Sera. +2",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Isa Belt",
		left_ear="Handler's Earring +1",
		right_ear="Enmerkar Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",}

    sets.defense.MDT = {    
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

    sets.defense.MEva = {    
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

    sets.defense.Killer = {    
		ammo="Staunch Tathlum +1",
		head={ name="Ankusa Helm +3", augments={'Enhances "Killer Instinct" effect',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back="Moonlight Cape",}

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -------------------------------------------------------
    -- Single-wield Pet Only Mode Idle/Defense Axe Swaps --
    -------------------------------------------------------

    sets.idle.NE = {main="Pangu",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head=Regain_head,neck="Bathy Choker +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body=Regain_body,hands=Regain_hands,ring1="Paguroidea Ring",ring2="Warden's Ring",
        back=PDT_back,waist="Flume Belt +1",legs=Regain_legs,feet="Skadi's Jambeaux +1"}

    sets.idle.NE.PetEngaged = {main=Pet_TP_AxeMain,sub="Sacro Bulwark",ammo="Hesperiidae",
        head=Pet_Melee_head,neck="Beastmaster Collar +2",ear1="Domesticator's Earring",ear2="Enmerkar Earring",
        body=Pet_Melee_body,hands=Pet_Melee_hands,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=Ready_Atk_back,waist="Incarnation Sash",legs=Pet_Melee_legs,feet=Pet_Melee_feet}

    --sets.idle.NE.PetRegen = {main=Pet_Regen_AxeMain,sub="Sacro Bulwark",
    --    neck="Empath Necklace",
    --    feet=Pet_Regen_feet}

    sets.defense.NE = {}

    sets.defense.NE.PDT = {main="Pangu",sub="Sacro Bulwark",ammo="Iron Gobbet",
        head="Gleti's Mask",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Ethereal Earring",
        body="Udug Jacket",hands="Gleti's Gauntlets",ring1="Fortified Ring",ring2="Warden's Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Gleti's breeches",feet="Gleti's Boots"}

    sets.defense.NE.MDT = {main="Pangu",sub="Sacro Bulwark",ammo="Vanir Battery",
        head=MEva_head,neck="Inquisitor Bead Necklace",ear1="Sanare Earring",ear2="Etiolation Earring",
        body="Tartarus Platemail",hands=MEva_hands,ring1="Shadow Ring",ring2="Purity Ring",
        back="Engulfer Cape +1",waist="Asklepian Belt",legs=MEva_legs,feet=MEva_feet}

    sets.defense.NE.MEva = {main=MEva_Axe_main,sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head=MEva_head,neck="Warder's Charm +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Udug Jacket",hands=MEva_hands,ring1="Vengeful Ring",ring2="Purity Ring",
        back=MEva_back,waist="Engraved Belt",legs=MEva_legs,feet=MEva_feet}

    sets.defense.NE.Killer = {main="Pangu",sub="Kaidate",ammo="Iron Gobbet",
        head="Ankusa Helm +3",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Nukumi Gausape +1",hands="Gleti's Gauntlets",ring1="Fortified Ring",ring2="Warden's Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Totemic Trousers +3",feet="Malignance Boots"}

    sets.defense.NE.PetPDT = {main="Pangu",sub="Sacro Bulwark",ammo="Hesperiidae",
        head="Anwig Salade",neck="Shepherd's Chain",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body=Pet_PDT_body,hands=Pet_PDT_hands,ring1="Thurandaut Ring +1",ring2="Defending Ring",
        back=Pet_PDT_back,waist="Isa Belt",legs=Pet_DT_legs,feet=Pet_DT_feet}

    sets.defense.NE.PetMDT = {main="Pangu",sub="Sacro Bulwark",ammo="Hesperiidae",
        head="Anwig Salade",neck="Shepherd's Chain",ear1="Rimeice Earring",ear2="Enmerkar Earring",
        body="Totemic Jackcoat +3",hands=Pet_MDT_hands,ring1="Thurandaut Ring +1",ring2="Defending Ring",
        back=Pet_MDT_back,waist="Isa Belt",legs=Pet_MDT_legs,feet=Pet_MDT_feet}

    -----------------------------------------------------
    -- Dual-wield Pet Only Mode Idle/Defense Axe Swaps --
    -----------------------------------------------------

    sets.idle.DWNE = {main="Pangu",sub="Freydis",ammo="Staunch Tathlum +1",
        head=Regain_head,neck="Bathy Choker +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body=Regain_body,hands=Regain_hands,ring1="Paguroidea Ring",ring2="Warden's Ring",
        back=PDT_back,waist="Flume Belt +1",legs=Regain_legs,feet="Skadi's Jambeaux +1"}

    sets.idle.DWNE.PetEngaged = {main=Pet_TP_AxeMain,sub=Pet_TP_AxeSub,ammo="Hesperiidae",
        head=Pet_Melee_head,neck="Beastmaster Collar +2",ear1="Domesticator's Earring",ear2="Enmerkar Earring",
        body=Pet_Melee_body,hands=Pet_Melee_hands,ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=Ready_Atk_back,waist="Incarnation Sash",legs=Pet_Melee_legs,feet=Pet_Melee_feet}

    --sets.idle.DWNE.PetRegen = {main=Pet_Regen_AxeMain,sub=Pet_Regen_AxeSub,
    --    neck="Empath Necklace",
    --    feet=Pet_Regen_feet}

    sets.defense.DWNE = {}

    sets.defense.DWNE.PDT = {main="Pangu",sub="Arktoi",ammo="Iron Gobbet",
        head="Gleti's Mask",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Udug Jacket",hands="Gleti's Gauntlets",ring1="Fortified Ring",ring2="Warden's Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Gleti's breeches",feet="Gleti's Boots"}

    sets.defense.DWNE.MDT = {main="Pangu",sub="Purgation",ammo="Vanir Battery",
        head=MEva_head,neck="Inquisitor Bead Necklace",ear1="Sanare Earring",ear2="Etiolation Earring",
        body="Tartarus Platemail",hands=MEva_hands,ring1="Shadow Ring",ring2="Purity Ring",
        back="Engulfer Cape +1",waist="Asklepian Belt",legs=MEva_legs,feet=MEva_feet}

    sets.defense.DWNE.MEva = {main=MEva_Axe_main,sub=MEva_Axe_sub,ammo="Staunch Tathlum +1",
        head=MEva_head,neck="Warder's Charm +1",ear1="Hearty Earring",ear2="Eabani Earring",
        body="Udug Jacket",hands=MEva_hands,ring1="Vengeful Ring",ring2="Purity Ring",
        back=MEva_back,waist="Engraved Belt",legs=MEva_legs,feet=MEva_feet}

    sets.defense.DWNE.Killer = {main="Pangu",sub="Arktoi",ammo="Iron Gobbet",
        head="Ankusa Helm +3",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Nukumi Gausape +1",hands="Gleti's Gauntlets",ring1="Fortified Ring",ring2="Warden's Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Totemic Trousers +3",feet="Malignance Boots"}

    sets.defense.DWNE.PetPDT = {main="Pangu",sub=Pet_PDT_AxeSub,ammo="Hesperiidae",
        head="Anwig Salade",neck="Shepherd's Chain",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body=Pet_PDT_body,hands=Pet_PDT_hands,ring1="Thurandaut Ring +1",ring2="Defending Ring",
        back=Pet_PDT_back,waist="Isa Belt",legs=Pet_DT_legs,feet=Pet_DT_feet}

    sets.defense.DWNE.PetMDT = {main="Pangu",sub=Pet_MDT_AxeSub,ammo="Hesperiidae",
        head="Anwig Salade",neck="Shepherd's Chain",ear1="Rimeice Earring",ear2="Enmerkar Earring",
        body="Totemic Jackcoat +3",hands=Pet_MDT_hands,ring1="Thurandaut Ring +1",ring2="Defending Ring",
        back=Pet_MDT_back,waist="Isa Belt",legs=Pet_MDT_legs,feet=Pet_MDT_feet}

    --------------------
    -- FAST CAST SETS --
    --------------------

    sets.precast.FC = {    
		ammo="Impatiens",
		head="Nyame Helm",
		body="Malignance Tabard",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Nyame Flanchard",
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		neck="Voltsurge Torque",
		waist="Eschan Stone",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

    sets.precast.FCNE = set_combine(sets.precast.FC, {main="Shukuyu's Scythe",sub="Vivid Strap +1"})
    sets.precast.FC["Utsusemi: Ichi"] = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
    sets.precast.FC["Utsusemi: Ni"] = set_combine(sets.precast.FC, {ammo="Impatiens",neck="Magoraga Beads",ring1="Lebeche Ring",ring2="Veneficium Ring"})

    ------------------
    -- MIDCAST SETS --
    ------------------

    sets.midcast.FastRecast = {    
		ammo="Sapience Orb",
		head="Nyame Helm",
		body="Malignance Tabard",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Nyame Flanchard",
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		neck="Voltsurge Torque",
		waist="Eschan Stone",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

    sets.midcast.Cure = {ammo="Quartz Tathlum +1",
        head=Cure_Potency_head,neck="Phalaina Locket",ear1="Beatific Earring",ear2="Mendicant's Earring",
        body=Cure_Potency_body,hands=Cure_Potency_hands,ring1="Menelaus's Ring",ring2="Asklepian Ring",
        back=Cure_Potency_back,waist="Gishdubar Sash",legs=Cure_Potency_legs,feet=Cure_Potency_feet}

    sets.midcast.Curaga = sets.midcast.Cure
    sets.CurePetOnly = {main=Cure_Potency_axe,sub="Sacro Bulwark"}

    sets.midcast.Stoneskin = {ammo="Quartz Tathlum +1",
        head="Jumalik Helm",neck="Stone Gorget",ear1="Earthcry Earring",ear2="Lifestorm Earring",
        body="Totemic Jackcoat +3",hands="Stone Mufflers",ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",
        back=Pet_PDT_back,waist="Engraved Belt",legs="Haven Hose"}

    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {neck="Debilis medallion",
        ring1="Eshmun's Ring",ring2="Haoma's Ring",waist="Gishdubar Sash"})

    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {ring2="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
        head=MAcc_head,neck="Sanctity Necklace",ear1="Hermetic Earring",ear2="Dignitary's Earring",
        body=MAcc_body,hands=MAcc_hands,ring1="Rahab Ring",ring2="Sangoma Ring",
        back=MAcc_back,waist="Eschan Stone",legs=MAcc_legs,feet=MAcc_feet}

    sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
        head=MAB_head,neck="Baetyl Pendant",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body=MAB_body,hands=MAB_hands,ring1="Acumen Ring",ring2="Fenrir Ring +1",
        back=MAcc_back,waist="Eschan Stone",legs=MAB_legs,feet=MAB_feet}

    sets.midcast.Flash = sets.Enmity

    --------------------------------------
    -- SINGLE-WIELD MASTER ENGAGED SETS --
    --------------------------------------

    sets.engaged = {    
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Tali'ah Manteel +2",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",}

    sets.engaged.Aftermath = {   
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",}

    sets.engaged.Hybrid = {   
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Tali'ah Manteel +2",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",}

    sets.engaged.SubtleBlow = {ammo="Coiste Bodhar",
        head="Malignance Chapeau",neck="Agasaya's Collar",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Sacro Breastplate",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=STP_back,waist="Sarissaphoroi Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.MaxAcc = {ammo="Aurgelmir Orb +1",
        head="Totemic Helm +3",neck="Beastmaster Collar +2",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Totemic Jackcoat +3",hands="Totemic Gloves +3",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=STP_back,waist="Klouskap Sash +1",legs="Totemic Trousers +3",feet="Totemic Gaiters +3"}

    sets.engaged.Farsha = {ammo="Coiste Bodhar",
        head="Nukumi Cabasset +1",neck="Beastmaster Collar +2",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Nukumi Gausape +1",hands="Nukumi Manoplas +1",ring1="Gere Ring",ring2="Epona's Ring",
        back=STP_back,waist="Windbuffet Belt +1",legs="Nukumi Quijotes +1",feet="Nukumi Ocreae +1"}

    ------------------------------------
    -- DUAL-WIELD MASTER ENGAGED SETS --
    ------------------------------------

    sets.engaged.DW = {    
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Tali'ah Manteel +2",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear="Eabani Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",}

    sets.engaged.DW.Aftermath = {ammo="Aurgelmir Orb +1",
        head="Malignance Chapeau",neck="Ainia Collar",ear1="Dedition Earring",ear2="Eabani Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=STP_back,waist="Reiki Yotai",legs="Malignance Tights",feet=STP_feet}

    sets.engaged.DW.MedAcc = {    
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Tali'ah Manteel +2",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",}

    sets.engaged.DW.HighAcc = {    
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Tali'ah Manteel +2",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",}

    sets.engaged.DW.MaxAcc = {ammo="Aurgelmir Orb +1",
        head="Totemic Helm +3",neck="Beastmaster Collar +2",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Totemic Jackcoat +3",hands="Totemic Gloves +3",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=DW_back,waist="Reiki Yotai",legs="Totemic Trousers +3",feet=DW_feet}

    sets.engaged.DW.SubtleBlow = {ammo="Coiste Bodhar",
        head="Malignance Chapeau",neck="Beastmaster Collar +2",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Sacro Breastplate",hands=DW_hands,ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=DW_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

    sets.ExtraSubtleBlow = {ear1="Sherida Earring"}

    sets.engaged.DW.KrakenClub = {ammo="Aurgelmir Orb +1",
        head="Totemic Helm +3",neck="Beastmaster Collar +2",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Totemic Jackcoat +3",hands="Totemic Gloves +3",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=DW_back,waist="Reiki Yotai",legs="Totemic Trousers +3",feet=DW_feet}

    --------------------
    -- MASTER WS SETS --
    --------------------

    -- AXE WSs --
    sets.precast.WS = {    
		ammo="Aurgelmir Orb +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Regal Ring",
		right_ring="Epona's Ring",}

    sets.precast.WS['Rampage'] = {    
		ammo="Aurgelmir Orb +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Begrudging Ring",}

    sets.precast.WS['Calamity'] = {    
		ammo="Aurgelmir Orb +1",
		head="Ankusa Helm +3",
		body="Gleti's Cuirass",
		hands="Meg. Gloves +2",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",}

    sets.precast.WS['Mistral Axe'] = {    
		ammo="Aurgelmir Orb +1",
		head="Ankusa Helm +3",
		body="Gleti's Cuirass",
		hands="Meg. Gloves +2",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",}

    sets.precast.WS['Decimation'] = {    
		ammo="Aurgelmir Orb +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",}
    
	sets.precast.WS['Decimation'].Gavialis = set_combine(sets.precast.WS['Ruinator'], {head="Gavialis Helm"})

    sets.precast.WS['Bora Axe'] = {ammo="Aurgelmir Orb +1",
        head="Ankusa Helm +3",neck="Beastmaster Collar +2",ear1="Sherida Earring",ear2="Telos Earring",
        body="Gleti's Cuirass",hands="Totemic Gloves +3",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=Onslaught_back,waist="Sailfi Belt +1",legs="Gleti's breeches",feet="Gleti's Boots"}

    sets.precast.WS['Ruinator'] = {ammo="Coiste Bodhar",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Telos Earring",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Epona's Ring",
        back=STR_DA_back,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Gleti's Boots"}
    sets.precast.WS['Ruinator'].Gavialis = set_combine(sets.precast.WS['Ruinator'], {head="Gavialis Helm"})

    sets.precast.WS['Onslaught'] = {    
		ammo="Aurgelmir Orb +1",
		head="Ankusa Helm +3",
		body="Gleti's Cuirass",
		hands="Meg. Gloves +2",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Bst. Collar +2", augments={'Path: A',}},
		waist="Grunfeld Rope",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",}

    sets.precast.WS['Primal Rend'] = {    
		ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Stoicheion Medal",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",}

    sets.precast.WS['Primal Rend'].HighAcc = {   
		ammo="Pemphredo Tathlum",
		head="Ankusa Helm +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Stoicheion Medal",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",}

    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {back=Cloud_back})

    -- DAGGER WSs --
    sets.precast.WS['Evisceration'] = {ammo="Coiste Bodhar",
        head="Blistering Sallet +1",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Begrudging Ring",
        back=Crit_back,waist="Fotia Belt",legs="Heyoka Subligar +1",feet="Gleti's Boots"}

    sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo Tathlum",
        head=MAB_head,neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body=MAB_body,hands=MAB_hands,ring1="Acumen Ring",ring2="Epaminondas's Ring",
        back=Primal_back,waist="Eschan Stone",legs=MAB_legs,feet=MAB_feet}

    sets.precast.WS['Exenterator'] = {ammo="Coiste Bodhar",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Telos Earring",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Epona's Ring",
        back=STR_DA_back,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Gleti's Boots"}
    sets.precast.WS['Exenterator'].Gavialis = set_combine(sets.precast.WS['Exenterator'], {head="Gavialis Helm"})

    -- SWORD WSs --
    sets.precast.WS['Savage Blade'] = {		
		ammo="Aurgelmir Orb +1",
		head="Ankusa Helm +3",
		body="Gleti's Cuirass",
		hands="Meg. Gloves +2",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck="Caro Necklace",
		waist="Grunfeld Rope",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",}

    -- SCYTHE WSs --
    sets.precast.WS['Spiral Hell'] = {ammo="Aurgelmir Orb +1",
        head="Ankusa Helm +3",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Nzingha Cuirass",hands="Totemic Gloves +3",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
        back=STR_WS_back,waist="Sailfi Belt +1",legs="Ankusa Trousers +3",feet="Ankusa Gaiters +3"}

    sets.precast.WS['Cross Reaper'] = {ammo="Aurgelmir Orb +1",
        head="Ankusa Helm +3",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Nzingha Cuirass",hands="Totemic Gloves +3",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
        back=STR_WS_back,waist="Sailfi Belt +1",legs="Ankusa Trousers +3",feet="Ankusa Gaiters +3"}

    sets.precast.WS['Entropy'] = {ammo="Coiste Bodhar",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Telos Earring",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Epona's Ring",
        back=STR_DA_back,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Gleti's Boots"}
    sets.precast.WS['Entropy'].Gavialis = set_combine(sets.precast.WS['Entropy'], {head="Gavialis Helm"})

    sets.midcast.ExtraMAB = {ear1="Hecate's Earring"}
    sets.midcast.ExtraWSDMG = {ear1="Ishvara Earring"}

    ----------------
    -- OTHER SETS --
    ----------------

    --Precast Gear Sets for DNC subjob abilities:
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Totemic Helm +3",neck="Unmoving Collar +1",ear1="Handler's Earring +1",ear2="Enchanter Earring +1",
        body="Gleti's Cuirass",hands="Totemic Gloves +3",ring1="Asklepian Ring",ring2="Valseur's Ring",
        back=Waltz_back,waist="Chaac Belt",legs="Dashing Subligar",feet="Totemic Gaiters +3"}
    sets.precast.Step = {ammo="Aurgelmir Orb +1",
        head="Totemic Helm +3",neck="Beastmaster Collar +2",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Totemic Jackcoat +3",hands="Totemic Gloves +3",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=DW_back,waist="Klouskap Sash +1",legs="Totemic Trousers +3",feet=DW_feet}
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {ammo="Pemphredo Tathlum",
        head=MAcc_head,neck="Sanctity Necklace",ear1="Hermetic Earring",ear2="Dignitary's Earring",
        body=MAcc_body,hands=MAcc_hands,ring1="Rahab Ring",ring2="Sangoma Ring",
        back=MAcc_back,waist="Eschan Stone",legs=MAcc_legs,feet=MAcc_feet}

    --Precast Gear Sets for DRG subjob abilities:
    sets.precast.JA.Jump = {hands="Crusher Gauntlets",feet="Ostro Greaves"}
    sets.precast.JA['High Jump'] = sets.precast.JA.Jump

    --Misc Gear Sets
    sets.FrenzySallet = {head="Frenzy Sallet"}
    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.buff['Killer Instinct'] = {body="Nukumi Gausape +1"}
    sets.THGear = {ammo="Perfect Lucky Egg",legs=TH_legs,waist="Chaac Belt"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell)
    --checkblocking(spell)
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" and not spell.interrupted then
        equip_ready_gear(spell)
        if not buffactive['Unleash'] then
            equip(sets.ReadyRecast)
        end

        eventArgs.handled = true
    end

    if spell.english == 'Reward' then
        RewardAmmo = ''
        if state.RewardMode.value == 'Theta' then
            RewardAmmo = 'Pet Food Theta'
        elseif state.RewardMode.value == 'Roborant' then
            RewardAmmo = 'Pet Roborant'
        else
            RewardAmmo = 'Pet Food Theta'
        end

        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip({ammo=RewardAmmo}, sets.precast.JA.RewardNEDW)
            else
                equip({ammo=RewardAmmo}, sets.precast.JA.RewardNE)
            end
        else
            equip({ammo=RewardAmmo}, sets.precast.JA.Reward)
        end
    end

    if enmity_plus_moves:contains(spell.english) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.EnmityNEDW)
            else
                equip(sets.EnmityNE)
            end
        else
            equip(sets.Enmity)
        end
    end

    if spell.english == 'Spur' then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.precast.JA.SpurNEDW)
            else
                equip(sets.precast.JA.SpurNE)
            end
        else
            equip(sets.precast.JA.Spur)
        end
    end

    if spell.english == 'Charm' then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.precast.JA.CharmNEDW)
            else
                equip(sets.precast.JA.CharmNE)
            end
        else
            equip(sets.precast.JA.Charm)
        end
    end

    if spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
        jug_pet_info()
        if spell.english == "Call Beast" and call_beast_cancel:contains(JugInfo) then
            add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
            return
        end
        equip({ammo=JugInfo})
    end

    if player.equipment.main == 'Aymur' then
        custom_aftermath_timers_precast(spell)
    end

    if spell.type == "WeaponSkill" and spell.name ~= 'Mistral Axe' and spell.name ~= 'Bora Axe' and spell.target.distance > target_distance then
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        handle_equipping_gear(player.status)
        return
    end

    if spell.type == 'CorsairRoll' or spell.english == "Double-Up" then
        equip(sets.precast.LuzafRing)
    end

    if spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song' then
        if state.AxeMode.value == 'PetOnly' then
            equip(sets.precast.FCNE)
        else
            equip(sets.precast.FC)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    --If Killer Instinct is active during WS (except for Primal/Cloudsplitter where Sacro Body is superior), equip Nukumi Gausape +1.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        if spell.english ~= "Primal Rend" and spell.english ~= "Cloudsplitter" then
            equip(sets.buff['Killer Instinct'])
        end
    end

    if spell.english == "Calamity" or spell.english == "Mistral Axe" then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if player.tp > 2750 then
                equip(sets.midcast.ExtraWSDMG)
            end
        else
            if player.tp > 2520 then
                equip(sets.midcast.ExtraWSDMG)
            end
        end
    end

    if spell.english == "Primal Rend" or spell.english == "Cloudsplitter" then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if player.tp > 2750 then
                equip(sets.midcast.ExtraMAB)
            end
        else
            if player.tp > 2520 then
                equip(sets.midcast.ExtraMAB)
            end
        end
    end

-- Equip Chaac Belt for TH+1 on common Subjob Abilities or Spells.
    if abilities_to_check:contains(spell.english) and state.TreasureMode.value == 'Tag' then
        equip(sets.THGear)
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.AxeMode.value == 'PetOnly' then
        if spell.english == "Cure" or spell.english == "Cure II" or spell.english == "Cure III" or spell.english == "Cure IV" then
            equip(sets.CurePetOnly)
        end
        if spell.english == "Curaga" or spell.english == "Curaga II" or spell.english == "Curaga III" then
            equip(sets.CurePetOnly)
        end
    end
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" or spell.name == "Sic" then
        equip_ready_gear(spell)
        eventArgs.handled = true
    end

    if spell.english == 'Fight' or spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
        if not spell.interrupted then
            pet_info_update()
        end
    end

    if spell.english == "Leave" and not spell.interrupted then
        clear_pet_buff_timers()
        PetName = 'None';PetJob = 'None';PetInfo = 'None';ReadyMoveOne = 'None';ReadyMoveTwo = 'None';ReadyMoveThree = 'None';ReadyMoveFour = 'None'
    end

    if player.equipment.main == 'Aymur' then
        custom_aftermath_timers_aftercast(spell)
    end

    if player.status ~= 'Idle' and state.AxeMode.value == 'PetOnly' and spell.type ~= "Monster" then
        pet_only_equip_handling()
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" or spell.name == "Sic" then
        eventArgs.handled = true
    end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
    pet_only_equip_handling()
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hook for idle and melee sets.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if state.AxeMode.value == 'PetOnly' then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if state.DefenseMode.value == "Physical" then
                idleSet = set_combine(idleSet, sets.defense.DWNE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                idleSet = set_combine(idleSet, sets.defense.DWNE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    idleSet = set_combine(idleSet, sets.idle.DWNE.PetEngaged)
                else
                    idleSet = set_combine(idleSet, sets.idle.DWNE)
                end
            end
        else
            if state.DefenseMode.value == "Physical" then
                idleSet = set_combine(idleSet, sets.defense.NE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                idleSet = set_combine(idleSet, sets.defense.NE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    idleSet = set_combine(idleSet, sets.idle.NE.PetEngaged)
                else
                    idleSet = set_combine(idleSet, sets.idle.NE)
                end
            end
        end
    end

    idleSet = apply_kiting(idleSet)
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.AxeMode.value ~= 'PetOnly' and state.DefenseMode.value == "None" then
        if player.equipment.main == 'Farsha' then
            meleeSet = set_combine(meleeSet, sets.engaged.Farsha)
        elseif player.equipment.sub == 'Kraken Club' then
            meleeSet = set_combine(meleeSet, sets.engaged.DW.KrakenClub)
        elseif state.HybridMode.value == 'SubtleBlow' then
            if player.sub_job == 'NIN' then
                meleeSet = set_combine(meleeSet, sets.engaged.DW.SubtleBlow)
            elseif player.sub_job == 'DNC' then
                meleeSet = set_combine(meleeSet, sets.engaged.DW.SubtleBlow, sets.ExtraSubtleBlow)
            else
                meleeSet = set_combine(meleeSet, sets.engaged.SubtleBlow)
            end
        end
    end

    pet_only_equip_handling()
    meleeSet = apply_kiting(meleeSet)
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for Reward, Correlation, Treasure Hunter, and Pet Mode handling.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Correlation Mode' then
        state.CorrelationMode:set(newValue)
    elseif stateField == 'Treasure Mode' then
        state.TreasureMode:set(newValue)
    elseif stateField == 'Reward Mode' then
        state.RewardMode:set(newValue)
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end
end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if default_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Gavialis'
        end
        if spell.english == "Rampage" and world.day_element == 'Earth' then
            return 'Gavialis'
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)

end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_melee_groups()
    pet_info_update()
    update_display_mode_info()
    pet_only_equip_handling()
end

-- Updates gear based on pet status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Idle' or newStatus == 'Engaged' then
        if state.DefenseMode.value ~= "Physical" and state.DefenseMode.value ~= "Magical" then
            handle_equipping_gear(player.status)
        end
    end

    if pet.hpp == 0 then
        clear_pet_buff_timers()
        PetName = 'None';PetJob = 'None';PetInfo = 'None';ReadyMoveOne = 'None';ReadyMoveTwo = 'None';ReadyMoveThree = 'None';ReadyMoveFour = 'None'
    end

    customize_melee_set(meleeSet)
    pet_info_update()
end 

function job_buff_change(status, gain, gain_or_loss)
    --Equip Frenzy Sallet if we're asleep and engaged.
    if (status == "sleep" and gain_or_loss) and player.status == 'Engaged' then
        if gain then
            equip(sets.FrenzySallet)
        else
            handle_equipping_gear(player.status)
        end
    end

   if (status == "Aftermath: Lv.3" and gain_or_loss) and player.status == 'Engaged' then
        if player.equipment.main == 'Aymur' and gain then
            job_update(cmdParams, eventArgs)
            handle_equipping_gear(player.status)
        else
            job_update(cmdParams, eventArgs)
            handle_equipping_gear(player.status)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Ready Move Presets and Pet TP Evaluation Functions - Credit to Bomberto and Verda
-------------------------------------------------------------------------------------------------------------------

pet_tp=0
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ready' then
        if pet.status == "Engaged" then
            ready_move(cmdParams)
        else
            send_command('input /pet "Fight" <t>')
        end
        eventArgs.handled = true
    end
    if cmdParams[1]:lower() == 'gearhandle' then
        pet_only_equip_handling()
    end
    if cmdParams[1] == 'pet_tp' then
	    pet_tp = tonumber(cmdParams[2])
    end
    if cmdParams[1]:lower() == 'charges' then
        charges = 3
        ready = windower.ffxi.get_ability_recasts()[102]
	    if ready ~= 0 then
	        charges = math.floor(((30 - ready) / 10))
	    end
	    add_to_chat(28,'Ready Recast:'..ready..'   Charges Remaining:'..charges..'')
    end
end
 
function ready_move(cmdParams)
    local move = cmdParams[2]:lower()
    local ReadyMove = ''
    if move == 'one' then
        ReadyMove = ReadyMoveOne
    elseif move == 'two' then
        ReadyMove = ReadyMoveTwo
    elseif move == 'three' then
        ReadyMove = ReadyMoveThree
    else
        ReadyMove = ReadyMoveFour
    end
    send_command('input /pet "'.. ReadyMove ..'" <me>')
end

pet_tp = 0
--Fix missing Pet.TP field by getting the packets from the fields lib
packets = require('packets')
function update_pet_tp(id,data)
    if id == 0x068 then
        pet_tp = 0
        local update = packets.parse('incoming', data)
        pet_tp = update["Pet TP"]
        windower.send_command('lua c gearswap c pet_tp '..pet_tp)
    end
end
id = windower.raw_register_event('incoming chunk', update_pet_tp)

-------------------------------------------------------------------------------------------------------------------
-- Current Job State Display
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', Corr.: '..state.CorrelationMode.value

    if state.JugMode.value ~= 'None' then
        add_to_chat(8,'-- Jug Pet: '.. PetName ..' -- (Pet Info: '.. PetInfo ..', '.. PetJob ..')')
    end

    add_to_chat(28,'Ready Moves: 1.'.. ReadyMoveOne ..'  2.'.. ReadyMoveTwo ..'  3.'.. ReadyMoveThree ..'  4.'.. ReadyMoveFour ..'')
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function equip_ready_gear(spell)
    if physical_ready_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if multi_hit_ready_moves:contains(spell.name) then
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.MultiStrikeDWNE.TPBonus)
                    else
                        equip(sets.midcast.Pet.MultiStrikeDWNE)
                    end
                else
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.MultiStrikeNE.TPBonus)
                    else
                        equip(sets.midcast.Pet.MultiStrikeNE)
                    end
                end
            else
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.ReadyDWNE.TPBonus[state.OffenseMode.value])
                    else
                        equip(sets.midcast.Pet.ReadyDWNE[state.OffenseMode.value])
                    end
                else
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.ReadyNE.TPBonus[state.OffenseMode.value])
                    else
                        equip(sets.midcast.Pet.ReadyNE[state.OffenseMode.value])
                    end
                end
            end
        else
            if multi_hit_ready_moves:contains(spell.name) then
                equip(sets.midcast.Pet.MultiStrike)
            else
                equip(sets.midcast.Pet[state.OffenseMode.value])
            end
        end

        -- Equip Headgear based on Neutral or Favorable Correlation Modes:
        if state.OffenseMode.value ~= 'MaxAcc' then
            equip(sets.midcast.Pet[state.CorrelationMode.value])
        end
    end

    if magic_atk_ready_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                if tp_based_ready_moves:contains(spell.name) then
                    equip(sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus[state.OffenseMode.value])
                else
                    equip(sets.midcast.Pet.MagicAtkReadyDWNE[state.OffenseMode.value])
                end
            else
                if tp_based_ready_moves:contains(spell.name) then
                    equip(sets.midcast.Pet.MagicAtkReadyNE.TPBonus[state.OffenseMode.value])
                else
                    equip(sets.midcast.Pet.MagicAtkReadyNE[state.OffenseMode.value])
                end
            end
        else
            equip(sets.midcast.Pet.MagicAtkReady[state.OffenseMode.value])
        end
    end

    if magic_acc_ready_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.midcast.Pet.MagicAccReadyDWNE)
            else
                equip(sets.midcast.Pet.MagicAccReadyNE)
            end
        else
            equip(sets.midcast.Pet.MagicAccReady)
        end
    end

    if pet_buff_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.midcast.Pet.BuffDWNE)
            else
                equip(sets.midcast.Pet.BuffNE)
            end
        else
            equip(sets.midcast.Pet.Buff)
        end
    end

    --If Pet TP, before bonuses, is less than a certain value then equip Nukumi Manoplas +1.
    --Or if Pet TP, before bonuses, is more than a certain value then equip Unleash-specific Axes.
    if (physical_ready_moves:contains(spell.name) or magic_atk_ready_moves:contains(spell.name)) and state.OffenseMode.value ~= 'MaxAcc' then
        if tp_based_ready_moves:contains(spell.name) and PetJob == 'Warrior' then
            if pet_tp < 1300 then
                equip(sets.midcast.Pet.TPBonus)
            elseif pet_tp > 2000 and state.AxeMode.value == 'PetOnly' then
                if multi_hit_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMultiStrikeAxes)
                    else
                        equip(sets.UnleashMultiStrikeAxeShield)
                    end
                elseif physical_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashAtkAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashAtkAxeShield[state.OffenseMode.value])
                    end
                else
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMABAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashMABAxeShield[state.OffenseMode.value])
                    end
                end
            end
        elseif tp_based_ready_moves:contains(spell.name) and PetJob ~= 'Warrior' then
            if pet_tp < 1800 then
                equip(sets.midcast.Pet.TPBonus)
            elseif pet_tp > 2500 and state.AxeMode.value == 'PetOnly' then
                if multi_hit_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMultiStrikeAxes)
                    else
                        equip(sets.UnleashMultiStrikeAxeShield)
                    end
                elseif physical_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashAtkAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashAtkAxeShield[state.OffenseMode.value])
                    end
                else
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMABAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashMABAxeShield[state.OffenseMode.value])
                    end
                end
            end
        end
    end
end

function jug_pet_info()
    JugInfo = ''
    if state.JugMode.value == 'FunguarFamiliar' or state.JugMode.value == 'Seedbed Soil' then
        JugInfo = 'Seedbed Soil'
    elseif state.JugMode.value == 'CourierCarrie' or state.JugMode.value == 'Fish Oil Broth' then
        JugInfo = 'Fish Oil Broth'
    elseif state.JugMode.value == 'AmigoSabotender' or state.JugMode.value == 'Sun Water' then
        JugInfo = 'Sun Water'
    elseif state.JugMode.value == 'NurseryNazuna' or state.JugMode.value == 'Dancing Herbal Broth' or state.JugMode.value == 'D. Herbal Broth' then
        JugInfo = 'D. Herbal Broth'
    elseif state.JugMode.value == 'CraftyClyvonne' or state.JugMode.value == 'Cunning Brain Broth' or state.JugMode.value == 'Cng. Brain Broth' then
        JugInfo = 'Cng. Brain Broth'
    elseif state.JugMode.value == 'PrestoJulio' or state.JugMode.value == 'Chirping Grasshopper Broth' or state.JugMode.value == 'C. Grass Broth' then
        JugInfo = 'C. Grass Broth'
    elseif state.JugMode.value == 'SwiftSieghard' or state.JugMode.value == 'Mellow Bird Broth' or state.JugMode.value == 'Mlw. Bird Broth' then
        JugInfo = 'Mlw. Bird Broth'
    elseif state.JugMode.value == 'MailbusterCetas' or state.JugMode.value == 'Goblin Bug Broth' or state.JugMode.value == 'Gob. Bug Broth' then
        JugInfo = 'Gob. Bug Broth'
    elseif state.JugMode.value == 'AudaciousAnna' or state.JugMode.value == 'Bubbling Carrion Broth' then
        JugInfo = 'B. Carrion Broth'
    elseif state.JugMode.value == 'TurbidToloi' or state.JugMode.value == 'Auroral Broth' then
        JugInfo = 'Auroral Broth'
    elseif state.JugMode.value == 'SlipperySilas' or state.JugMode.value == 'Wormy Broth' then
        JugInfo = 'Wormy Broth'
    elseif state.JugMode.value == 'LuckyLulush' or state.JugMode.value == 'Lucky Carrot Broth' or state.JugMode.value == 'L. Carrot Broth' then
        JugInfo = 'L. Carrot Broth'
    elseif state.JugMode.value == 'DipperYuly' or state.JugMode.value == 'Wool Grease' then
        JugInfo = 'Wool Grease'
    elseif state.JugMode.value == 'FlowerpotMerle' or state.JugMode.value == 'Vermihumus' then
        JugInfo = 'Vermihumus'
    elseif state.JugMode.value == 'DapperMac' or state.JugMode.value == 'Briny Broth' then
        JugInfo = 'Briny Broth'
    elseif state.JugMode.value == 'DiscreetLouise' or state.JugMode.value == 'Deepbed Soil' then
        JugInfo = 'Deepbed Soil'
    elseif state.JugMode.value == 'FatsoFargann' or state.JugMode.value == 'Curdled Plasma Broth' or state.JugMode.value == 'C. Plasma Broth' then
        JugInfo = 'C. Plasma Broth'
    elseif state.JugMode.value == 'FaithfulFalcorr' or state.JugMode.value == 'Lucky Broth' then
        JugInfo = 'Lucky Broth'
    elseif state.JugMode.value == 'BugeyedBroncha' or state.JugMode.value == 'Savage Mole Broth' or state.JugMode.value == 'Svg. Mole Broth' then
        JugInfo = 'Svg. Mole Broth'
    elseif state.JugMode.value == 'BloodclawShasra' or state.JugMode.value == 'Razor Brain Broth' or state.JugMode.value == 'Rzr. Brain Broth' then
        JugInfo = 'Rzr. Brain Broth'
    elseif state.JugMode.value == 'GorefangHobs' or state.JugMode.value == 'Burning Carrion Broth' then
        JugInfo = 'B. Carrion Broth'
    elseif state.JugMode.value == 'GooeyGerard' or state.JugMode.value == 'Cloudy Wheat Broth' or state.JugMode.value == 'Cl. Wheat Broth' then
        JugInfo = 'Cl. Wheat Broth'
    elseif state.JugMode.value == 'CrudeRaphie' or state.JugMode.value == 'Shadowy Broth' then
        JugInfo = 'Shadowy Broth'
    elseif state.JugMode.value == 'DroopyDortwin' or state.JugMode.value == 'Swirling Broth' then
        JugInfo = 'Swirling Broth'
    elseif state.JugMode.value == 'PonderingPeter' or state.JugMode.value == 'Viscous Broth' or state.JugMode.value == 'Vis. Broth' then
        JugInfo = 'Vis. Broth'
    elseif state.JugMode.value == 'SunburstMalfik' or state.JugMode.value == 'Shimmering Broth' then
        JugInfo = 'Shimmering Broth'
    elseif state.JugMode.value == 'AgedAngus' or state.JugMode.value == 'Fermented Broth' or state.JugMode.value == 'Ferm. Broth' then
        JugInfo = 'Ferm. Broth'
    elseif state.JugMode.value == 'WarlikePatrick' or state.JugMode.value == 'Livid Broth' then
        JugInfo = 'Livid Broth'
    elseif state.JugMode.value == 'ScissorlegXerin' or state.JugMode.value == 'Spicy Broth' then
        JugInfo = 'Spicy Broth'
    elseif state.JugMode.value == 'BouncingBertha' or state.JugMode.value == 'Bubbly Broth' then
        JugInfo = 'Bubbly Broth'
    elseif state.JugMode.value == 'RhymingShizuna' or state.JugMode.value == 'Lyrical Broth' then
        JugInfo = 'Lyrical Broth'
    elseif state.JugMode.value == 'AttentiveIbuki' or state.JugMode.value == 'Salubrious Broth' then
        JugInfo = 'Salubrious Broth'
    elseif state.JugMode.value == 'SwoopingZhivago' or state.JugMode.value == 'Windy Greens' then
        JugInfo = 'Windy Greens'
    elseif state.JugMode.value == 'AmiableRoche' or state.JugMode.value == 'Airy Broth' then
        JugInfo = 'Airy Broth'
    elseif state.JugMode.value == 'HeraldHenry' or state.JugMode.value == 'Translucent Broth' or state.JugMode.value == 'Trans. Broth' then
        JugInfo = 'Trans. Broth'
    elseif state.JugMode.value == 'BrainyWaluis' or state.JugMode.value == 'Crumbly Soil' then
        JugInfo = 'Crumbly Soil'
    elseif state.JugMode.value == 'HeadbreakerKen' or state.JugMode.value == 'Blackwater Broth' then
        JugInfo = 'Blackwater Broth'
    elseif state.JugMode.value == 'RedolentCandi' or state.JugMode.value == 'Electrified Broth' then
        JugInfo = 'Electrified Broth'
    elseif state.JugMode.value == 'AlluringHoney' or state.JugMode.value == 'Bug-Ridden Broth' then
        JugInfo = 'Bug-Ridden Broth'
    elseif state.JugMode.value == 'CaringKiyomaro' or state.JugMode.value == 'Fizzy Broth' then
        JugInfo = 'Fizzy Broth'
    elseif state.JugMode.value == 'VivaciousVickie' or state.JugMode.value == 'Tantalizing Broth' or state.JugMode.value == 'Tant. Broth' then
        JugInfo = 'Tant. Broth'
    elseif state.JugMode.value == 'HurlerPercival' or state.JugMode.value == 'Pale Sap' then
        JugInfo = 'Pale Sap'
    elseif state.JugMode.value == 'BlackbeardRandy' or state.JugMode.value == 'Meaty Broth' then
        JugInfo = 'Meaty Broth'
    elseif state.JugMode.value == 'GenerousArthur' or state.JugMode.value == 'Dire Broth' then
        JugInfo = 'Dire Broth'
    elseif state.JugMode.value == 'ThreestarLynn' or state.JugMode.value == 'Muddy Broth' then
        JugInfo = 'Muddy Broth'
    elseif state.JugMode.value == 'BraveHeroGlenn' or state.JugMode.value == 'Wispy Broth' then
        JugInfo = 'Wispy Broth'
    elseif state.JugMode.value == 'SharpwitHermes' or state.JugMode.value == 'Saline Broth' then
        JugInfo = 'Saline Broth'
    elseif state.JugMode.value == 'ColibriFamiliar' or state.JugMode.value == 'Sugary Broth' then
        JugInfo = 'Sugary Broth'
    elseif state.JugMode.value == 'ChoralLeera' or state.JugMode.value == 'Glazed Broth' then
        JugInfo = 'Glazed Broth'
    elseif state.JugMode.value == 'SpiderFamiliar' or state.JugMode.value == 'Sticky Webbing' then
        JugInfo = 'Sticky Webbing'
    elseif state.JugMode.value == 'GussyHachirobe' or state.JugMode.value == 'Slimy Webbing' then
        JugInfo = 'Slimy Webbing'
    elseif state.JugMode.value == 'AcuexFamiliar' or state.JugMode.value == 'Poisonous Broth' then
        JugInfo = 'Poisonous Broth'
    elseif state.JugMode.value == 'FluffyBredo' or state.JugMode.value == 'Venomous Broth' then
        JugInfo = 'Venomous Broth'
    elseif state.JugMode.value == 'SuspiciousAlice' or state.JugMode.value == 'Furious Broth' then
        JugInfo = 'Furious Broth'
    elseif state.JugMode.value == 'AnklebiterJedd' or state.JugMode.value == 'Crackling Broth' then
        JugInfo = 'Crackling Broth'
    elseif state.JugMode.value == 'FleetReinhard' or state.JugMode.value == 'Rapid Broth' then
        JugInfo = 'Rapid Broth'
    elseif state.JugMode.value == 'CursedAnnabelle' or state.JugMode.value == 'Creepy Broth' then
        JugInfo = 'Creepy Broth'
    elseif state.JugMode.value == 'SurgingStorm' or state.JugMode.value == 'Insipid Broth' then
        JugInfo = 'Insipid Broth'
    elseif state.JugMode.value == 'SubmergedIyo' or state.JugMode.value == 'Deepwater Broth' then
        JugInfo = 'Deepwater Broth'
    elseif state.JugMode.value == 'MosquitoFamiliar' or state.JugMode.value == 'Wetlands Broth' then
        JugInfo = 'Wetlands Broth'
    elseif state.JugMode.value == 'Left-HandedYoko' or state.JugMode.value == 'Heavenly Broth' then
        JugInfo = 'Heavenly Broth'
    elseif state.JugMode.value == 'SweetCaroline' or state.JugMode.value == 'Aged Humus' then
        JugInfo = 'Aged Humus'
    elseif state.JugMode.value == 'WeevilFamiliar' or state.JugMode.value == 'Pristine Sap' then
        JugInfo = 'Pristine Sap'
    elseif state.JugMode.value == 'StalwartAngelin' or state.JugMode.value == 'Truly Pristine Sap' or state.JugMode.value == 'T. Pristine Sap' then
        JugInfo = 'Truly Pristine Sap'
    elseif state.JugMode.value == 'P.CrabFamiliar' or state.JugMode.value == 'Rancid Broth' then
        JugInfo = 'Rancid Broth'
    elseif state.JugMode.value == 'JovialEdwin' or state.JugMode.value == 'Pungent Broth' then
        JugInfo = 'Pungent Broth'
    elseif state.JugMode.value == 'Y.BeetleFamiliar' or state.JugMode.value == 'Zestful Sap' then
        JugInfo = 'Zestful Sap'
    elseif state.JugMode.value == 'EnergeticSefina' or state.JugMode.value == 'Gassy Sap' then
        JugInfo = 'Gassy Sap'
    elseif state.JugMode.value == 'LynxFamiliar' or state.JugMode.value == 'Frizzante Broth' then
        JugInfo = 'Frizzante Broth'
    elseif state.JugMode.value == 'VivaciousGaston' or state.JugMode.value == 'Spumante Broth' then
        JugInfo = 'Spumante Broth'
    elseif state.JugMode.value == 'Hip.Familiar' or state.JugMode.value == 'Turpid Broth' then
        JugInfo = 'Turpid Broth'
    elseif state.JugMode.value == 'DaringRoland' or state.JugMode.value == 'Feculent Broth' then
        JugInfo = 'Feculent Broth'
    elseif state.JugMode.value == 'SlimeFamiliar' or state.JugMode.value == 'Decaying Broth' then
        JugInfo = 'Decaying Broth'
    elseif state.JugMode.value == 'SultryPatrice' or state.JugMode.value == 'Putrescent Broth' then
        JugInfo = 'Putrescent Broth'
    end
end

function pet_info_update()
    if pet.isvalid then
        PetName = pet.name

        if pet.name == 'DroopyDortwin' or pet.name == 'PonderingPeter' or pet.name == 'HareFamiliar' or pet.name == 'KeenearedSteffi' then
            PetInfo = "Rabbit, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Foot Kick';ReadyMoveTwo = 'Whirl Claws';ReadyMoveThree = 'Wild Carrot';ReadyMoveFour = 'Dust Cloud'
        elseif pet.name == 'LuckyLulush' then
            PetInfo = "Rabbit, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Foot Kick';ReadyMoveTwo = 'Whirl Claws';ReadyMoveThree = 'Wild Carrot';ReadyMoveFour = 'Snow Cloud'
        elseif pet.name == 'SunburstMalfik' or pet.name == 'AgedAngus' or pet.name == 'HeraldHenry' or pet.name == 'CrabFamiliar' or pet.name == 'CourierCarrie' then
            PetInfo = "Crab, Aquan";PetJob = 'Paladin';ReadyMoveOne = 'Big Scissors';ReadyMoveTwo = 'Scissor Guard';ReadyMoveThree = 'Bubble Curtain';ReadyMoveFour = 'Metallic Body'
        elseif pet.name == 'P.CrabFamiliar' or pet.name == 'JovialEdwin' then
            PetInfo = "Barnacle Crab, Aquan";PetJob = 'Paladin';ReadyMoveOne = 'Mega Scissors';ReadyMoveTwo = 'Venom Shower';ReadyMoveThree = 'Bubble Curtain';ReadyMoveFour = 'Metallic Body'
        elseif pet.name == 'WarlikePatrick' or pet.name == 'LizardFamiliar' or pet.name == 'ColdbloodComo' or pet.name == 'AudaciousAnna' then
            PetInfo = "Lizard, Lizard";PetJob = 'Warrior';ReadyMoveOne = 'Tail Blow';ReadyMoveTwo = 'Fireball';ReadyMoveThree = 'Brain Crush';ReadyMoveFour = 'Blockhead'
        elseif pet.name == 'ScissorlegXerin' or pet.name == 'BouncingBertha' then
            PetInfo = "Chapuli, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Sensilla Blades';ReadyMoveTwo = 'Tegmina Buffet';ReadyMoveThree = 'Tegmina Buffet';ReadyMoveFour = 'Tegmina Buffet'
        elseif pet.name == 'RhymingShizuna' or pet.name == 'SheepFamiliar' or pet.name == 'LullabyMelodia' or pet.name == 'NurseryNazuna' then
            PetInfo = "Sheep, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Sheep Charge';ReadyMoveTwo = 'Rage';ReadyMoveThree = 'Sheep Song';ReadyMoveFour = 'Lamb Chop'
        elseif pet.name == 'AttentiveIbuki' or pet.name == 'SwoopingZhivago' then
            PetInfo = "Tulfaire, Bird";PetJob = 'Warrior';ReadyMoveOne = 'Swooping Frenzy';ReadyMoveTwo = 'Pentapeck';ReadyMoveThree = 'Molting Plumage';ReadyMoveFour = 'Molting Plumage'
        elseif pet.name == 'AmiableRoche' or pet.name == 'TurbidToloi' then
            PetInfo = "Pugil, Aquan";PetJob = 'Warrior';ReadyMoveOne = 'Recoil Dive';ReadyMoveTwo = 'Water Wall';ReadyMoveThree = 'Intimidate';ReadyMoveFour = 'Intimidate'
        elseif pet.name == 'BrainyWaluis' or pet.name == 'FunguarFamiliar' or pet.name == 'DiscreetLouise' then
            PetInfo = "Funguar, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Frogkick';ReadyMoveTwo = 'Spore';ReadyMoveThree = 'Silence Gas';ReadyMoveFour = 'Dark Spore'
        elseif pet.name == 'HeadbreakerKen' or pet.name == 'MayflyFamiliar' or pet.name == 'ShellbusterOrob' or pet.name == 'MailbusterCetas' then
            PetInfo = "Fly, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Somersault';ReadyMoveTwo = 'Cursed Sphere';ReadyMoveThree = 'Venom';ReadyMoveFour = 'Venom'
        elseif pet.name == 'RedolentCandi' or pet.name == 'AlluringHoney' then
            PetInfo = "Snapweed, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Tickling Tendrils';ReadyMoveTwo = 'Stink Bomb';ReadyMoveThree = 'Nectarous Deluge';ReadyMoveFour = 'Nepenthic Plunge'
        elseif pet.name == 'CaringKiyomaro' or pet.name == 'VivaciousVickie' then
            PetInfo = "Raaz, Beast";PetJob = 'Monk';ReadyMoveOne = 'Sweeping Gouge';ReadyMoveTwo = 'Zealous Snort';ReadyMoveThree = 'Zealous Snort';ReadyMoveFour = 'Zealous Snort'
        elseif pet.name == 'HurlerPercival' or pet.name == 'BeetleFamiliar' or pet.name == 'PanzerGalahad' then
            PetInfo = "Beetle, Vermin";PetJob = 'Paladin';ReadyMoveOne = 'Power Attack';ReadyMoveTwo = 'Rhino Attack';ReadyMoveThree = 'Hi-Freq Field';ReadyMoveFour = 'Rhino Guard'
        elseif pet.name == 'Y.BeetleFamilia' or pet.name == 'EnergizedSefina' then
            PetInfo = "Beetle (Horn), Vermin";PetJob = 'Paladin';ReadyMoveOne = 'Rhinowrecker';ReadyMoveTwo = 'Hi-Freq Field';ReadyMoveThree = 'Rhino Attack';ReadyMoveFour = 'Rhino Guard'
        elseif pet.name == 'BlackbeardRandy' or pet.name == 'TigerFamiliar' or pet.name == 'SaberSiravarde' or pet.name == 'GorefangHobs' then
            PetInfo = "Tiger, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Razor Fang';ReadyMoveTwo = 'Crossthrash';ReadyMoveThree = 'Roar';ReadyMoveFour = 'Predatory Glare'
        elseif pet.name == 'ColibriFamiliar' or pet.name == 'ChoralLeera' then
            PetInfo = "Colibri, Bird";PetJob = 'Red Mage';ReadyMoveOne = 'Pecking Flurry';ReadyMoveTwo = 'Pecking Flurry';ReadyMoveThree = 'Pecking Flurry';ReadyMoveFour = 'Pecking Flurry'
        elseif pet.name == 'SpiderFamiliar' or pet.name == 'GussyHachirobe' then
            PetInfo = "Spider, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Sickle Slash';ReadyMoveTwo = 'Acid Spray';ReadyMoveThree = 'Spider Web';ReadyMoveFour = 'Spider Web'
        elseif pet.name == 'GenerousArthur' or pet.name == 'GooeyGerard' then
            PetInfo = "Slug, Amorph";PetJob = 'Warrior';ReadyMoveOne = 'Purulent Ooze';ReadyMoveTwo = 'Corrosive Ooze';ReadyMoveThree = 'Corrosive Ooze';ReadyMoveFour = 'Corrosive Ooze'
        elseif pet.name == 'ThreestarLynn' or pet.name == 'DipperYuly' then
            PetInfo = "Ladybug, Vermin";PetJob = 'Thief';ReadyMoveOne = 'Spiral Spin';ReadyMoveTwo = 'Sudden Lunge';ReadyMoveThree = 'Noisome Powder';ReadyMoveFour = 'Noisome Powder'
        elseif pet.name == 'SharpwitHermes' or pet.name == 'SweetCaroline' or pet.name == 'FlowerpotBill' or pet.name == 'FlowerpotBen' or pet.name == 'Homunculus' or pet.name == 'FlowerpotMerle' then
            PetInfo = "Mandragora, Plantoid";PetJob = 'Monk';ReadyMoveOne = 'Head Butt';ReadyMoveTwo = 'Leaf Dagger';ReadyMoveThree = 'Wild Oats';ReadyMoveFour = 'Scream'
        elseif pet.name == 'AcuexFamiliar' or pet.name == 'FluffyBredo' then
            PetInfo = "Acuex, Amorph";PetJob = 'Black Mage';ReadyMoveOne = 'Foul Waters';ReadyMoveTwo = 'Pestilent Plume';ReadyMoveThree = 'Pestilent Plume';ReadyMoveFour = 'Pestilent Plume'
        elseif pet.name == 'FlytrapFamiliar' or pet.name == 'VoraciousAudrey' or pet.name == 'PrestoJulio' then
            PetInfo = "Flytrap, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Soporific';ReadyMoveTwo = 'Palsy Pollen';ReadyMoveThree = 'Gloeosuccus';ReadyMoveFour = 'Gloeosuccus'
        elseif pet.name == 'EftFamiliar' or pet.name == 'AmbusherAllie' or pet.name == 'BugeyedBroncha' or pet.name == 'SuspiciousAlice' then
            PetInfo = "Eft, Lizard";PetJob = 'Warrior';ReadyMoveOne = 'Nimble Snap';ReadyMoveTwo = 'Cyclotail';ReadyMoveThree = 'Geist Wall';ReadyMoveFour = 'Numbing Noise'
        elseif pet.name == 'AntlionFamiliar' or pet.name == 'ChopsueyChucky' or pet.name == 'CursedAnnabelle' then
            PetInfo = "Antlion, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Mandibular Bite';ReadyMoveTwo = 'Venom Spray';ReadyMoveThree = 'Sandblast';ReadyMoveFour = 'Sandpit'
        elseif pet.name == 'MiteFamiliar' or pet.name == 'LifedrinkerLars' or pet.name == 'AnklebiterJedd' then
            PetInfo = "Diremite, Vermin";PetJob = 'Dark Knight';ReadyMoveOne = 'Double Claw';ReadyMoveTwo = 'Spinning Top';ReadyMoveThree = 'Filamented Hold';ReadyMoveFour = 'Grapple'
        elseif pet.name == 'AmigoSabotender' then
            PetInfo = "Cactuar, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Needle Shot';ReadyMoveTwo = '??? Needles';ReadyMoveThree = '??? Needles';ReadyMoveFour = '??? Needles'
        elseif pet.name == 'CraftyClyvonne' then
            PetInfo = "Coeurl, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Blaster';ReadyMoveTwo = 'Chaotic Eye';ReadyMoveThree = 'Chaotic Eye';ReadyMoveFour = 'Chaotic Eye'
        elseif pet.name == 'BloodclawShasra' then
            PetInfo = "Lynx, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Blaster';ReadyMoveTwo = 'Charged Whisker';ReadyMoveThree = 'Chaotic Eye';ReadyMoveFour = 'Chaotic Eye'
        elseif pet.name == 'LynxFamiliar' or pet.name == 'VivaciousGaston' then
            PetInfo = "Collared Lynx, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Frenzied Rage';ReadyMoveTwo = 'Charged Whisker';ReadyMoveThree = 'Chaotic Eye';ReadyMoveFour = 'Blaster'
        elseif pet.name == 'SwiftSieghard' or pet.name == 'FleetReinhard' then
            PetInfo = "Raptor, Lizard";PetJob = 'Warrior';ReadyMoveOne = 'Scythe Tail';ReadyMoveTwo = 'Ripper Fang';ReadyMoveThree = 'Chomp Rush';ReadyMoveFour = 'Chomp Rush'
        elseif pet.name == 'DapperMac' or pet.name == 'SurgingStorm' or pet.name == 'SubmergedIyo' then
            PetInfo = "Apkallu, Bird";PetJob = 'Monk';ReadyMoveOne = 'Beak Lunge';ReadyMoveTwo = 'Wing Slap';ReadyMoveThree = 'Wing Slap';ReadyMoveFour = 'Wing Slap'
        elseif pet.name == 'FatsoFargann' then
            PetInfo = "Leech, Amorph";PetJob = 'Warrior';ReadyMoveOne = 'Suction';ReadyMoveTwo = 'TP Drainkiss';ReadyMoveThree = 'Drainkiss';ReadyMoveFour = 'Acid Mist'
        elseif pet.name == 'Hip.Familiar' or pet.name == 'DaringRoland' or pet.name == 'FaithfulFalcorr' then
            PetInfo = "Hippogryph, Bird";PetJob = 'Thief';ReadyMoveOne = 'Hoof Volley';ReadyMoveTwo = 'Fantod';ReadyMoveThree = 'Nihility Song';ReadyMoveFour = 'Back Heel'
        elseif pet.name == 'CrudeRaphie' then
            PetInfo = "Adamantoise, Lizard";PetJob = 'Paladin';ReadyMoveOne = 'Tortoise Stomp';ReadyMoveTwo = 'Harden Shell';ReadyMoveThree = 'Aqua Breath';ReadyMoveFour = 'Aqua Breath'
        elseif pet.name == 'MosquitoFamilia' or pet.name == 'Left-HandedYoko' then
            PetInfo = "Mosquito, Vermin";PetJob = 'Dark Knight';ReadyMoveOne = 'Infected Leech';ReadyMoveTwo = 'Gloom Spray';ReadyMoveThree = 'Gloom Spray';ReadyMoveFour = 'Gloom Spray'
        elseif pet.name == 'WeevilFamiliar' or pet.name == 'StalwartAngelin' then
            PetInfo = "Weevil, Vermin";PetJob = 'Thief';ReadyMoveOne = 'Disembowel';ReadyMoveTwo = 'Extirpating Salvo';ReadyMoveThree = 'Extirpating Salvo';ReadyMoveFour = 'Extirpating Salvo'
        elseif pet.name == 'SlimeFamiliar' or pet.name == 'SultryPatrice' then
            PetInfo = "Slime, Amorph";PetJob = 'Warrior';ReadyMoveOne = 'Fluid Toss';ReadyMoveTwo = 'Fluid Spread';ReadyMoveThree = 'Digest';ReadyMoveFour = 'Digest'
        end
    else
        PetName = 'None';PetJob = 'None';PetInfo = 'None';ReadyMoveOne = 'None';ReadyMoveTwo = 'None';ReadyMoveThree = 'None';ReadyMoveFour = 'None'
    end
end

function pet_only_equip_handling()
    if player.status == 'Engaged' and state.AxeMode.value == 'PetOnly' then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if state.DefenseMode.value == "Physical" then
                equip(sets.defense.DWNE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                equip(sets.defense.DWNE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    equip(sets.idle.DWNE.PetEngaged)
                else
                    equip(sets.idle.DWNE)
                end
            end
        else
            if state.DefenseMode.value == "Physical" then
                equip(sets.defense.NE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                equip(sets.defense.NE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    equip(sets.idle.NE.PetEngaged)
                else
                    equip(sets.idle.NE)
                end
            end
        end
    end
end

function pet_buff_timer(spell)
    if spell.english == 'Reward' then
        send_command('timers c "Pet: Regen" 180 down '..RewardRegenIcon..'')
    elseif spell.english == 'Spur' then
        send_command('timers c "Pet: Spur" 90 down '..SpurIcon..'')
    elseif spell.english == 'Run Wild' then
        send_command('timers c "'..spell.english..'" '..RunWildDuration..' down '..RunWildIcon..'')
    end
end

function clear_pet_buff_timers()
    send_command('timers c "Pet: Regen" 0 down '..RewardRegenIcon..'')
    send_command('timers c "Pet: Spur" 0 down '..SpurIcon..'')
    send_command('timers c "Run Wild" 0 down '..RunWildIcon..'')
end

function display_mode_info()
    if DisplayModeInfo == 'true' and DisplayTrue == 1 then
        local x = TextBoxX
        local y = TextBoxY
        send_command('text AccuracyText create Acc. Mode: '..state.OffenseMode.value..'')
        send_command('text AccuracyText pos '..x..' '..y..'')
        send_command('text AccuracyText size '..TextSize..'')
        y = y + (TextSize + 6)
        send_command('text CorrelationText create Corr. Mode: '..state.CorrelationMode.value..'')
        send_command('text CorrelationText pos '..x..' '..y..'')
        send_command('text CorrelationText size '..TextSize..'')
        y = y + (TextSize + 6)
        send_command('text AxeModeText create Axe Mode: '..state.AxeMode.value..'')
        send_command('text AxeModeText pos '..x..' '..y..'')
        send_command('text AxeModeText size '..TextSize..'')
        y = y + (TextSize + 6)
        send_command('text JugPetText create Jug Mode: '..state.JugMode.value..'')
        send_command('text JugPetText pos '..x..' '..y..'')
        send_command('text JugPetText size '..TextSize..'')
        DisplayTrue = DisplayTrue - 1
    end
end

function update_display_mode_info()
    if DisplayModeInfo == 'true' then
        send_command('text AccuracyText text Acc. Mode: '..state.OffenseMode.value..'')
        send_command('text CorrelationText text Corr. Mode: '..state.CorrelationMode.value..'')
        send_command('text AxeModeText text Axe Mode: '..state.AxeMode.value..'')
        send_command('text JugPetText text Jug Mode: '..state.JugMode.value..'')
    end
end

function checkblocking(spell)
    if buffactive.sleep or buffactive.petrification or buffactive.terror then 
        --add_to_chat(3,'Canceling Action - Asleep/Petrified/Terror!')
        cancel_spell()
        return
    end 
    if spell.english == "Double-Up" then
        if not buffactive["Double-Up Chance"] then 
            add_to_chat(3,'Canceling Action - No ability to Double Up')
            cancel_spell()
            return
        end
    end
    if spell.name ~= 'Ranged' and spell.type ~= 'WeaponSkill' and spell.type ~= 'Scholar' and spell.type ~= 'Monster' then
        if spell.action_type == 'Ability' then
            if buffactive.Amnesia then
                cancel_spell()
                add_to_chat(3,'Canceling Ability - Currently have Amnesia')
                return
            else
                recasttime = windower.ffxi.get_ability_recasts()[spell.recast_id] 
                if spell and (recasttime >= 1) then
                    --add_to_chat(3,'Ability Canceled:'..spell.name..' - Waiting on Recast:(seconds) '..recasttime..'')
                    cancel_spell()
                    return
                end
            end
        end
    end
    --if spell.type == 'WeaponSkill' and player.tp < 1000 then
    --    cancel_spell()
    --    add_to_chat(3,'Canceled WS:'..spell.name..' - Current TP is less than 1000.')
    --    return
    --end
    --if spell.type == 'WeaponSkill' and buffactive.Amnesia then
    --    cancel_spell()
    --    add_to_chat(3,'Canceling Ability - Currently have Amnesia.')
    --    return	  
    --end
    --if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
    --    cancel_spell()
    --    add_to_chat(3,'Canceling Utsusemi - Already have maximum shadows (3).')
    --    return
    --end
    if spell.type == 'Monster' or spell.name == 'Reward' then
        if pet.isvalid then
            if spell.name == 'Fireball' and pet.status ~= "Engaged" then
                cancel_spell()
                send_command('input /pet Fight <t>')
                return
            end
            local s = windower.ffxi.get_mob_by_target('me')
            local pet = windower.ffxi.get_mob_by_target('pet')
            local PetMaxDistance = 4
            local pettargetdistance = PetMaxDistance + pet.model_size + s.model_size
            if pet.model_size > 1.6 then 
                pettargetdistance = PetMaxDistance + pet.model_size + s.model_size + 0.1
            end
            if pet.distance:sqrt() >= pettargetdistance then
                --add_to_chat(3,'Canceling: '..spell.name..' - Outside valid JA Distance.')
                cancel_spell()
                return
            end
        else
            add_to_chat(3,'Canceling: '..spell.name..' - That action requires a pet.')
            cancel_spell()
            return
        end
    end
    if spell.name == 'Fight' then
        if pet.isvalid then 
            local t = windower.ffxi.get_mob_by_target('t') or windower.ffxi.get_mob_by_target('st')
            local pet = windower.ffxi.get_mob_by_target('pet')
            local PetMaxDistance = 32 
            local DistanceBetween = ((t.x - pet.x)*(t.x-pet.x) + (t.y-pet.y)*(t.y-pet.y)):sqrt()
            if DistanceBetween > PetMaxDistance then 
                --add_to_chat(3,'Canceling: Fight - Replacing with Heel since target is 30 yalms away from pet.')
                cancel_spell()
                send_command('@wait .5; input /pet Heel <me>')
                return
            end
        end
    end
end

function get_melee_groups()
    classes.CustomMeleeGroups:clear()

    if buffactive['Aftermath: Lv.3'] then
        classes.CustomMeleeGroups:append('Aftermath')
    end
end

function get_combat_form()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end