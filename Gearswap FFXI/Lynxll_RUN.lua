-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Souleater
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Weapon Bash
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Resolution
--              [ CTRL+Numpad8 ]    Upheaval
--              [ CTRL+Numpad9 ]    Dimidiation
--              [ CTRL+Numpad5 ]    Ground Strike
--              [ CTRL+Numpad6 ]    Full Break
--              [ CTRL+Numpad1 ]    Herculean Slash
--              [ CTRL+Numpad2 ]    Shockwave
--              [ CTRL+Numpad3 ]    Armor Break
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    rayke_duration = 35
    gambit_duration = 96

    lockstyleset = 20

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Tank', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
    state.MagicalDefenseMode:options('MDT')

    state.Knockback = M(false, 'Knockback')

    state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart', 'Aettir', 'GreatAxe'}
    state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}
    state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

    -- Additional local binds


    send_command('bind ^` input //gs c rune')
    send_command('bind !` input /ja "Vivacious Pulse" <me>')
    send_command('bind ^insert gs c cycleback Runes')
    send_command('bind ^delete gs c cycle Runes')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @a gs c cycle AttackMode')
    send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @k gs c toggle Knockback')
	send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^f11')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind @a')
    send_command('unbind @c')
    send_command('unbind @d')
	send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
	send_command('unbind ^,')
    send_command('unbind @w')

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity sets
    sets.Enmity = {
		ammo="Aqreqaq Bomblet",
		head="Nyame Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +2",
		neck="Moonlight Necklace",
		waist="Trance Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cryptic Earring",
		left_ring="Moonlight Ring",
		right_ring="Eihwaz Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Spell interruption rate down-10%',}},}

    sets.Enmity.HP = {
		ammo="Aqreqaq Bomblet",
		head="Nyame Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +2",
		neck="Moonlight Necklace",
		waist="Trance Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cryptic Earring",
		left_ring="Moonlight Ring",
		right_ring="Eihwaz Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Spell interruption rate down-10%',}},
        }

    sets.precast.JA['Vallation'] = {body="Runeist's Coat +3", legs="Futhark Trousers +3"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist's Boots +1"}
    sets.precast.JA['Battuta'] = {head="Fu. Bandeau +3"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +3"}

    sets.precast.JA['Lunge'] = {
		ammo="Seeth. Bomblet +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Fenrir Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+7','"Embolden"+14','"Dbl.Atk."+3',}},
        }

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist's Mitons +2"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots +3"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +3"}
    
	sets.precast.JA['Vivacious Pulse'] = {    
		head="Erilaz Galea +2",
		legs="Rune. Trousers +1",
		neck="Incanter's Torque",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",}


    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Sapience Orb",
		head="Rune. Bandeau +3",
		body="Agwu's Robe",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Aya. Cosciales +2",
		feet="Agwu's Pigaches",
		neck="Voltsurge Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Moonlight Ring",
		right_ring="Kishar Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        }

    sets.precast.FC.HP = set_combine(sets.precast.FC, {
		ammo="Sapience Orb",
		head="Rune. Bandeau +3",
		body="Agwu's Robe",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Aya. Cosciales +2",
		feet="Agwu's Pigaches",
		neck="Voltsurge Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Moonlight Ring",
		right_ring="Kishar Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs="Futhark Trousers +3",
		waist="Siegel sash",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ammo="Impatiens", ear2="Mendi. Earring"})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
		neck="Magoraga beads",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {    
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+12','Weapon skill damage +5%','AGI+1','Rng.Atk.+14',}},
		hands="Meg. Gloves +2",
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {    
		ammo="Yamarang",
		head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+12','Weapon skill damage +5%','AGI+1','Rng.Atk.+14',}},
		hands="Meg. Gloves +2",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},})

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Meg. Gloves +2",
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Caro Necklace",
		waist="Prosilio Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},})  

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},})

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        })

    sets.precast.WS['Resolution'].Uncapped = set_combine(sets.precast.WS['Resolution'], {
        ring1="Regal Ring",
        })

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+12','Weapon skill damage +5%','AGI+1','Rng.Atk.+14',}},
		hands="Meg. Gloves +2",
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Caro Necklace",
		waist="Grunfeld Rope",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        })

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+12','Weapon skill damage +5%','AGI+1','Rng.Atk.+14',}},
		hands="Meg. Gloves +2",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Caro Necklace",
		waist="Grunfeld Rope",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        })

    sets.precast.WS['Dimidiation'].Uncapped = set_combine(sets.precast.WS['Dimidiation'], {})

    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

    sets.precast.WS['Shockwave'] = {
        ammo="Pemphredo Tathlum",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Leyline Gloves",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Moonshade Earring",
        ring1="Ayanmo Ring",
        ring2="Weather. Ring +1",
        back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        waist="Eschan Stone",
        }

    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
        feet="Lustra. Leggings +1",
        ear2="Ishvara Earring",
        back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        })

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
		ammo="Staunch Tathlum +1",
		head="Agwu's Cap",
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Magnetic Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        } -- +10% from merit points

    sets.midcast.Cure = {
		ammo="Staunch Tathlum +1",
		head="Turms cap +1",
		body="Ayanmo Corazza +2",
		hands="Turms mittens +1",
		legs="Aya. Cosciales +2",
		feet="Turms leggings +1",
		neck="Phalaina Locket",
		waist="Gishdubar Sash",
		left_ear="Roundel Earring",
		right_ear="Mendi. Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring="Defending Ring",
		back="Solemnity Cape",
        }

    sets.midcast['Enhancing Magic'] = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +2",
		body="Nyame Mail",
		hands="Runeist's Mitons +2",
		legs={ name="Futhark Trousers +3", augments={'Enhances "Inspire" effect',}},
		feet="Nyame Sollerets",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",
        }

    sets.midcast.EnhancingDuration = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +2",
		body="Nyame Mail",
		hands="Regal Gauntlets",
		legs={ name="Futhark Trousers +3", augments={'Enhances "Inspire" effect',}},
		feet="Nyame Sollerets",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Augment. Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",
        }

    sets.midcast['Phalanx'] = set_combine(sets.midcast.SpellInterrupt, {
		ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Taeon Tabard", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','"Conserve MP"+1','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +2',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Stikini Ring +1",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back="Moonlight Cape",
        })

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SpellInterrupt, {})

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {    
		ammo="Staunch Tathlum +1",
		head="Rune. Bandeau +3",
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Regal Gauntlets",
		legs={ name="Futhark Trousers +3", augments={'Enhances "Inspire" effect',}},
		feet="Nyame Sollerets",
		neck="Moonlight Necklace",
		waist="Flume Belt +1",
		left_ear="Andoaa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Stikini Ring +1",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},})
    
	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Erilaz Galea +2", waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        ammo="Yamarang",
        legs="Rune. Trousers +1",
        neck="Incanter's Torque",
        ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe3"},
        waist="Bishop's Sash",
        }

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Foil = sets.Enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {		
		ammo="Staunch Tathlum +1",
		head="Agwu's Cap",
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Magnetic Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        }
	
	sets.midcast['Blue Magic'].Enmity = {    
		ammo="Staunch Tathlum +1",
		head="Agwu's Cap",
		body="Emet Harness +1",
		hands="Regal Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Ahosi Leggings",
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Cryptic Earring",
		right_ear="Magnetic Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Spell interruption rate down-10%',}},}
    
	sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast['Enhancing Magic']


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		ammo="Homiliary",
		head="Turms Cap +1",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Turms Leggings +1",
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        }

    sets.idle.DT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Cryptic Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        }

    sets.idle.Town = set_combine(sets.idle, {
		ammo="Aurgelmir orb +1",
		head="Turms cap +1",
		body="Ashera Harness",
		hands="Turms mittens +1",
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Turms leggings +1",
		neck="Futhark Torque +2",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        })

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.Knockback = {back="Repulse Mantle"}

    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Cryptic Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        }

    sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        }

    sets.defense.HP = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        }

    sets.defense.Parry = {
		ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ashera Harness",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
		ammo="Aurgelmir Orb +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ashera Harness",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Combatant's Torque",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
		ammo="Aurgelmir Orb +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ashera Harness",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Nyame Sollerets",
		neck="Combatant's Torque",
		waist="Reiki Yotai",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		ammo="Honed Tathlum",
		head="Aya. Zucchetto +2",
		body="Ashera Harness",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Reiki Yotai",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        })

    sets.engaged.Tank = set_combine(sets.engaged, {
	    ammo="Yamarang",
		head="Erilaz Galea +2",
		body="Erilaz Surcoat +2",
		hands="Nyame Gauntlets",
		legs="Eri. Leg Guards +2",
		feet="Erilaz Greaves +2",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        })

    sets.engaged.Aftermath = {}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = {
		ammo="Yamarang",
		head="Aya. Zucchetto +2",
		body="Ashera Harness",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)
    sets.engaged.Tank.DT = set_combine(sets.engaged.STP, sets.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		left_ring="Eshmun's Ring",
		right_ring="Eshmun's Ring",
        }

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.Epeolatry = {main="Epeolatry"}
    sets.Lionheart = {main="Lionheart"}
    sets.Aettir = {main="Aettir"}
    sets.GreatAxe = {main="Hepatizon Axe +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        return
    end
    if state.DefenseMode.value == 'HP' then
        currentSpell = spell.english
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            equip(sets.precast.FC.HP)
        elseif spell.action_type == 'Ability' then
            equip(sets.Enmity.HP)
			equip(sets.precast.JA[currentSpell])
        end
	else
        if spell.action_type == 'Ability' then
            equip(sets.Enmity)
			equip(sets.precast.JA[spell])
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.DefenseMode.value == 'HP' and spell.english ~= "Phalanx" then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.Enmity.HP)
            elseif spell.skill == 'Enhancing Magic' then
                equip(sets.midcast.EnhancingDuration)
            end
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if state.DefenseMode.value == 'None' then
        if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
		end
        if spell.english == 'Phalanx' and buffactive['Embolden'] then
            equip(sets.midcast.EnhancingDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "terror" then
        if gain then
            equip(sets.defense.PDT)
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    equip(sets[state.WeaponSet.current])

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end

    --if state.CP.current == 'on' then
    --    equip(sets.CP)
    --    disable('back')
    --else
    --    enable('back')
    --end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Knockback.value == true then
        msg = msg .. ' Knockback Resist |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' and state.AttackMode.value == 'Uncapped' then
        return "Uncapped"
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'BLU' then
        set_macro_page(2, 14)
    elseif player.sub_job == 'DRK' then
        set_macro_page(3, 14)
    elseif player.sub_job == 'WHM' then
        set_macro_page(4, 14)
    else
        set_macro_page(1, 14)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end