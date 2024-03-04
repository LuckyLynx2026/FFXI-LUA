----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Acc", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Aptitude Mantle +1" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP") 
    send_command("bind = gs c clear")

    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 0
    pos_y = 0
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
end

function job_setup()
    include("PUP-LIB.lua")
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II +1"
    Animators.Melee = "Animator P +1"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +2"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +1"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +1" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +1" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +1" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +1" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +1" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello +1"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto +1"
    Empy_Karagoz.Hands = "Karagoz Guanti +1"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe +1"



    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {    
		main={ name="Xiucoatl", augments={'Path: C',}},
		head="Heyoka Cap",
		body="Malignance Tabard",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back="Solemnity Cape",}

    -------------------------------------Fastcast
    sets.precast.FC = {
        head={ name="Herculean Helm", augments={'Pet: Attack+5 Pet: Rng.Atk.+5','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: VIT+10','Pet: "Mag.Atk.Bns."+8',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		legs="Gyve Trousers",
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		back="Swith Cape +1",
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
        head={ name="Herculean Helm", augments={'Pet: Attack+5 Pet: Rng.Atk.+5','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: VIT+10','Pet: "Mag.Atk.Bns."+8',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		legs="Gyve Trousers",
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		back="Swith Cape +1",
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Herald's gaiters"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads", body = "Passion Jacket"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet_Tatical}

    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}

    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}

    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
		main="Nibiru Sainti",
		ammo="Automat. Oil +3",
		head={ name="Herculean Helm", augments={'Pet: "Mag.Atk.Bns."+30','"Repair" potency +7%',}},
		hands={ name="Herculean Gloves", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','"Repair" potency +7%','Pet: AGI+6','Pet: Attack+12 Pet: Rng.Atk.+12',}},
		legs={ name="Desultor Tassets", augments={'"Repair" potency +10%','"Phantom Roll" ability delay -5',}},
		feet="Foire Bab. +1",
		left_ear="Guignol Earring",
		right_ear="Pratik Earring",
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
		main={ name="Midnights", augments={'Pet: Attack+25','Pet: Accuracy+25','Pet: Damage taken -3%',}},
		body="Kara. Farsetto +1",
		hands="Foire Dastanas +1",
		neck="Buffoon's Collar",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    sets.precast.JA["Activate"] = {back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       -- Add your set here 
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body="Foire Tobe +2",
		hands="Heyoka Mittens",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
	    head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+13','Crit. hit damage +4%','DEX+12','Attack+15',}},
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Crit. hit damage +4%','DEX+14',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},})

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {
	    head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+13','Crit. hit damage +4%','DEX+12','Attack+15',}},
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Crit. hit damage +4%','DEX+14',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
	    head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+13','Crit. hit damage +4%','DEX+12','Attack+15',}},
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Crit. hit damage +4%','DEX+14',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},})

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {
        head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+13','Crit. hit damage +4%','DEX+12','Attack+15',}},
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+2','Crit. hit damage +4%','DEX+12',}},
		feet={ name="Herculean Boots", augments={'Crit. hit damage +4%','DEX+14',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},})

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
	    head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body="Foire Tobe +2",
		hands="Heyoka Mittens",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},})

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
		head="Heyoka Cap",
		body="Malignance Tabard",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back="Solemnity Cape",
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Tali'ah Manteel +2",
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Hiza. Sune-Ate +2",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Tali'ah Manteel +2",
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = {
            head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
			body="Malignance Tabard",
			hands="Heyoka Mittens",
			legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
			feet="Heyoka Leggings",
			neck="Loricate Torque +1",
			waist="Moonbow Belt +1",
			left_ear="Mache Earring +1",
			right_ear="Telos Earring",
			left_ring="Defending Ring",
			right_ring="C. Palug Ring",
			back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		head="Tali'ah Turban +1",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Kyrene's Earring",
		right_ear="Telos Earring",
		left_ring="Varar Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		head="Heyoka Cap",
		body="Heyoka Harness",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Varar Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		head="Heyoka Cap",
		body="Malignance Tabard",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = {
        head="Tali'ah Turban +1",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Empath Necklace",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Varar Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    sets.midcast.Pet.Cure = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    sets.midcast.Pet["Healing Magic"] = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    sets.midcast.Pet["Elemental Magic"] = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    sets.midcast.Pet["Enfeebling Magic"] = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    sets.midcast.Pet["Dark Magic"] = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    sets.midcast.Pet["Divine Magic"] = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    sets.midcast.Pet["Enhancing Magic"] = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = {
		main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		head={ name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Empath Necklace",
		waist="Moonbow Belt +1",
		left_ear="Handler's Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Overbearing Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = {
    	main={ name="Xiucoatl", augments={'Path: C',}},
		head="Heyoka Cap",
		body="Malignance Tabard",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back="Solemnity Cape",
    }

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
        head="Heyoka Cap",
		body="Heyoka Harness",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
        main={ name="Condemners", augments={'Pet: Damage taken -5%','Pet: VIT+7','Accuracy+6','Pet: Accuracy+17 Pet: Rng. Acc.+17',}},
		head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Shulmanu Collar",
		waist="Isa Belt",
		left_ear="Handler's Earring +1",
		right_ear="Enmerker Earring",
		left_ring="Varar Ring +1",
		right_ring="Overbearing Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		head="Heyoka Cap",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Mpaca's gloves",
		legs={ name="Herculean Trousers", augments={'Pet: Attack+13 Pet: Rng.Atk.+13','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: AGI+10',}},
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		head="Heyoka Cap",
		body="Heyoka Harness",
		hands="Mpaca's gloves",
		legs="Heyoka Subligar",
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		head={ name="Herculean Helm", augments={'Pet: Attack+5 Pet: Rng.Atk.+5','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: VIT+10','Pet: "Mag.Atk.Bns."+8',}},
		body="Nyame Mail",
		hands="Mpaca's gloves",
		legs={ name="Herculean Trousers", augments={'Pet: Attack+13 Pet: Rng.Atk.+13','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: AGI+10',}},
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Enmerkar Earring",
		right_ear="Handler's Earring +1",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = {
        main={ name="Condemners", augments={'Pet: Damage taken -5%','Pet: VIT+7','Accuracy+6','Pet: Accuracy+17 Pet: Rng. Acc.+17',}},
		head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Empath Necklace",
		waist="Isa Belt",
		left_ear="Handler's Earring +1",
		right_ear="Enmerker Earring",
		left_ring="Varar Ring +1",
		right_ring="Overbearing Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Mpaca's gloves",
		legs="Heyoka Subligar",
		feet="Mpaca's boots",
		neck="Empath Necklace",
		waist="Klouskap Sash +1",
		left_ear="Handler's Earring +1",
		right_ear="Handler's Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged = set_combine( sets.idle.Pet.Engaged,{
		main={ name="Xiucoatl", augments={'Path: C',}},
		head="Heyoka Cap",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Mpaca's gloves",
		legs="Heyoka Subligar",
		feet="Mpaca's boots",
		neck={ name="Pup. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Varar Ring +1",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+7 Pet: Rng. Acc.+7','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},})

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
		main={ name="Xiucoatl", augments={'Path: C',}},
		head="Karagoz Capello +1",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Karagoz Guanti +1",
		legs="Kara. Pantaloni +1",
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
		main={ name="Xiucoatl", augments={'Path: C',}},
		head={ name="Herculean Helm", augments={'Pet: Attack+5 Pet: Rng.Atk.+5','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: VIT+10','Pet: "Mag.Atk.Bns."+8',}},
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Karagoz Guanti +1",
		legs={ name="Herculean Trousers", augments={'Pet: Attack+13 Pet: Rng.Atk.+13','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: AGI+10',}},
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {    
		main={ name="Xiucoatl", augments={'Path: C',}},
		head="Karagoz Capello +1",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Karagoz Guanti +1",
		legs="Kara. Pantaloni +1",
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},}

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {
		main={ name="Xiucoatl", augments={'Path: C',}},
		head="Karagoz Capello +1",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Karagoz Guanti +1",
		legs="Kara. Pantaloni +1",
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] = set_combine( sets.midcast.Pet.WSNoFTP, {
		main={ name="Xiucoatl", augments={'Path: C',}},
		head={ name="Herculean Helm", augments={'Pet: Attack+5 Pet: Rng.Atk.+5','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: VIT+10','Pet: "Mag.Atk.Bns."+8',}},
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Karagoz Guanti +1",
		legs={ name="Herculean Trousers", augments={'Pet: Attack+13 Pet: Rng.Atk.+13','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: AGI+10',}},
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		})

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {    
		main={ name="Xiucoatl", augments={'Path: C',}},
		head="Karagoz Capello +1",
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Karagoz Guanti +1",
		legs="Kara. Pantaloni +1",
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] = set_combine( sets.midcast.Pet.WSFTP, {
		main={ name="Xiucoatl", augments={'Path: C',}},
		head={ name="Herculean Helm", augments={'Pet: Attack+5 Pet: Rng.Atk.+5','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: VIT+10','Pet: "Mag.Atk.Bns."+8',}},
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands="Karagoz Guanti +1",
		legs={ name="Herculean Trousers", augments={'Pet: Attack+13 Pet: Rng.Atk.+13','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: AGI+10',}},
		feet="Mpaca's boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar earring",
		right_ear="Kyrene's Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},})

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Malignance Tabard",
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    -- Resting sets
    sets.resting = {
        main={ name="Xiucoatl", augments={'Path: C',}},
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body="Malignance Tabard",
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == "WAR" then
        set_macro_page(1, 15)
    elseif player.sub_job == "NIN" then
        set_macro_page(1, 15)
    elseif player.sub_job == "DNC" then
        set_macro_page(1, 15)
    else
        set_macro_page(1, 15)
    end
end

