-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:
        
        Magic Burst            Toggle Magic Burst Mode  [Alt-`]
        Helix Mode            Toggle between Lugh's Cape for potency and Bookworm's Cape for duration [WinKey-H]
        Stormsurge Mode        Toggle to activate Peda. Loafers +3 bonus for storm spells.
        Capacity Pts. Mode    Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle        Automatically locks desired equipset on file load


-------------------------------------------------------------------------------------------------------------------

        Addendum Commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts                Dark Arts

        gs c scholar light                  Light Arts/Addendum
        gs c scholar dark                                        Dark Arts/Addendum
        gs c scholar cost                   Penury                      Parsimony
        gs c scholar speed                  Celerity                Alacrity
        gs c scholar aoe                Accession                   Manifestation
        gs c scholar power                  Rapture                     Ebullience
        gs c scholar duration               Perpetuance
        gs c scholar accuracy               Altruism                Focalization
        gs c scholar enmity                 Tranquility                 Equanimity
        gs c scholar skillchain                                     Immanence
        gs c scholar addendum            Addendum: White             Addendum: Black
--]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.HelixMode = M{['description']='Helix Mode', 'Lughs', 'Bookworm'}
    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
    state.CP = M(false, "Capacity Points Mode")

    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    
    state.WeaponLock = M(false, 'Weapon Lock')    
    state.MagicBurst = M(false, 'Magic Burst')
    state.StormSurge = M(false, 'Stormsurge')

    -- Additional local binds

    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @c gs c toggle CP')
    send_command('bind @h gs c cycle HelixMode')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @s gs c toggle StormSurge')
    send_command('bind @w gs c toggle WeaponLock')


    select_default_macro_book()
    set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

    send_command('unbind !`')
    send_command('unbind @c')
    send_command('unbind @h')
    send_command('unbind @g')
    send_command('unbind @s')
    send_command('unbind @w')

end



-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +3"}
    sets.precast.JA['Enlightenment'] = {body="Peda. Gown +1"}

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --15
		main={ name="Coeus", augments={'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		sub="Enki Strap",
		ammo="Incantor Stone",
		head="Agwu's Cap",
		body="Zendik Robe",
		hands="Agwu's Gages",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Acad. Loafers +1",
		neck="Sanctity Necklace",
		waist="Embla Sash",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		   back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.precast.FC.Grimoire = {head="Peda. M.Board +1", feet="Acad. Loafers +1"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {waist="Channeler's Stone"})
    
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main="Musa",
		sub="Clerisy Strap",
		ammo="Impatiens",
		legs="Doyen Pants",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		right_ear="Malignance earring",
        })
    
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
		
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat",
		legs="Doyen Pants",})
    
	sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2="Levia. Ring +1", waist="Channeler's Stone"}) -- stop quick cast

    
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		ammo="Hydrocera",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		back="Refraction Cape",
        }

    sets.precast.WS['Myrkr'] = {
		ammo="Hydrocera",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Evans Earring",
		right_ear="Etiolation Earring",
		left_ring="Mephitas's Ring",
		right_ring="Mephitas's Ring +1",
		back="Errant Cape",
        } -- Max MP
   

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC
    
    sets.midcast.Cure = {
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Hydrocera",
		head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		hands={ name="Kaykaus Cuffs", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		legs={ name="Kaykaus Tights", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		feet="Skaoi Boots",
		neck="Colossus's Torque",
		waist="Sacro Cord",
		left_ear="Novia Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring",
		right_ring="Sirona's Ring",
		back="Oretan. Cape +1",
        }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Hydrocera",
		head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		hands={ name="Kaykaus Cuffs", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		legs={ name="Kaykaus Tights", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		feet="Skaoi Boots",
		neck="Colossus's Torque",
		waist="Sacro Cord",
		left_ear="Novia Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring",
		right_ring="Sirona's Ring",
		back="Oretan. Cape +1",
        })
    
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring1="Levia. Ring +1",
        ring2="Levia. Ring +1",
		waist="Luminary Sash",
        })
    
    sets.midcast.StatusRemoval = {
		ammo="Oreiad's Tathlum",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Peda. Bracers +3",
		legs="Acad. Pants +2",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nuna Gorget",
		waist="Gishdubar Sash",
		left_ear="Regal earring",
		right_ear="Mendi. Earring",
		left_ring="Ephedra Ring",
		right_ring="Haoma's Ring",
		back="Oretan. Cape +1",
        }
    
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {})
    
    sets.midcast['Enhancing Magic'] = {
		main="Gada",
		sub="Ammurapi shield",
		ammo="Savant's Treatise",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body="Peda. Gown +1",
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Incanter's torque",
		waist="Olympus Sash",
		left_ear="Augment. Earring",
		right_ear="Andoaa Earring",
		ring2="Stikini Ring",
		ring1="Stikini Ring +1",
		back="Swith Cape +1",
        }
    
    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi shield",
        head="Telchine Cap",
        body="Peda. Gown +3",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Musa",
		sub="Enki strap",
		ammo="Savant's Treatise",
		head="Arbatel Bonnet +1",
		body="Telchine Chasuble",
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Incanter's torque",
		waist="Olympus Sash",
		left_ear="Augment. Earring",
		right_ear="Andoaa Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        })
    
    
    
    sets.midcast.Haste = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif",
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })
        
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        legs="Acad. Pants +2",
        neck="Nodens Gorget",
        waist="Siegel Sash",
		ear1="Earthcry earring",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        main="Vadose Rod",
        sub="Ammurapi shield",
        head="Amalric Coif",
        waist="Emphatikos Rope",
        })
    
    sets.midcast.Storm = sets.midcast.EnhancingDuration

    sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {feet="Peda. Loafers +3"})
    
    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring2="Sheltered Ring",
        })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		main="Daybreak",
		sub="Enki Strap",
		ammo="Hydrocera",
		head="Acad. Mortar. +3",
		body="Academic's gown +3",
		hands="Acad. Bracers +2",
		legs="Acad. Pants +2",
		feet="Jhakri Pigaches +2",
		neck="Argute Stole +1",
		waist="Luminary sash",
		left_ear="Regal earring",
		right_ear="Malignance earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        }
    
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Pemphredo Tathlum",})

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    
    sets.midcast['Dark Magic'] = {
		main="Daybreak",
		sub="Ammurapi shield",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Academic's gown +3",
		hands={ name="Amalric Gages", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		legs="Peda. Pants +3",
		feet="Jhakri Pigaches +2",
		neck="Erra pendant",
		waist="Sacro Cord",
		left_ear="Regal earring",
		right_ear="Malignance earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Bookworm's Cape", augments={'INT+2','MND+2','Helix eff. dur. +15',}},
        }

    sets.midcast.Kaustra = {
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Amalric Doublet +1",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Mizu. Kubikazari",
		waist="Sacro Cord",
		left_ear="Regal earring",
		right_ear="Malignance earring",
		left_ring="Archon Ring",
		right_ring="Freke ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        }
    
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        ear1="Hirudinea Earring",
        neck="Erra pendant",
		ring2="Archon Ring",
		ring1="Evanescence ring",
        waist="Fucho-no-obi",
		legs="Peda. Pants +3",
		feet="Merlinic crackows",
        })
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {    
		main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands="Acad. Bracers +2",
		legs="Peda. Pants +3",
		feet="Acad. Loafers +2",
		neck="Erra Pendant",
		waist="Witful Belt",
		left_ear="Regal Earring",
		right_ear="Malignance earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},})

    -- Elemental Magic
    sets.midcast['Elemental Magic'] = {
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
		ammo="Oreiad's Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Agwu's Slops",
		feet="Jhakri Pigaches +2",
		neck="Argute Stole +1",
		waist="Sacro Cord",
		left_ear="Novio Earring",
		right_ear="Strophadic Earring",
		left_ring="Jhakri Ring",
		right_ring="Stikini Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        }


    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
		ammo="Oreiad's Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Agwu's Slops",
		feet="Jhakri Pigaches +2",
		neck="Argute Stole +1",
		waist="Sacro Cord",
		left_ear="Novio Earring",
		right_ear="Strophadic Earring",
		left_ring="Jhakri Ring",
		right_ring="Stikini Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        })
    
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
        head=empty,
        body="Twilight Cloak",
        ring1="Archon Ring",
		neck="Erra pendant",
        })
    
    sets.midcast.Helix = {
        main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        waist="Yamabuki-no-Obi",
        }

    sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
        head="Pixie Hairpin +1",
        ring1="Archon Ring",
        })

    sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {
		main="Daybreak",
        ring2="Weather. Ring"
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.idle = {
		main="Daybreak",
		sub="Ammurapi shield",
		ammo="Staunch Tathlum +1",
		head="Acad. Mortar. +3",
		body="Academic's gown +3",
		hands="Acad. Bracers +2",
		legs="Peda. Pants +3",
		feet="Chironic slippers",
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.idle.DT = set_combine(sets.idle, {
		main="Daybreak",
		sub="Ammurapi shield",
		head="Acad. Mortar. +3",
		body="Shamash Robe",
		hands="Peda. Bracers +3",
		legs="Peda. Pants +3",
		feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
		neck="Loricate Torque +1",
		waist="Gishdubar Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        })

    sets.idle.Refresh = {    
		main="Daybreak",
		sub="Ammurapi shield",
		ammo="Homiliary",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Arbatel Bracers +1",
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Chironic slippers",
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},}

    sets.idle.Town = set_combine(sets.idle, {
		main="Musa",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Peda. M.Board +1",
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Herald's gaiters",
		neck="Mizu. Kubikazari",
		waist="Sacro Cord",
		left_ear="Regal earring",
		right_ear="Malignance earring",
		left_ring="Shiva Ring +1",
		right_ring="Freke ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        })

    sets.idle.Weak = sets.idle.DT
    
    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
        })
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
    sets.Kiting = {feet="Herald's gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.engaged = {
		ammo="Homiliary",
		head="Acad. Mortar. +3",
		body="Academic's gown +3",
		hands="Acad. Bracers +2",
		legs="Peda. Pants +3",
		feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
		neck="Loricate torque +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        }
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.magic_burst = { 
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
		ammo="Oreiad's Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Agwu's Slops",
		feet="Jhakri Pigaches +2",
		neck="Argute Stole +1",
		waist="Sacro Cord",
		left_ear="Novio Earring",
		right_ear="Strophadic Earring",
		left_ring="Jhakri Ring",
		right_ring="Stikini Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        }

    sets.magic_burst.Resistant = { 
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
		ammo="Oreiad's Tathlum",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Agwu's Slops",
		feet="Jhakri Pigaches +2",
		neck="Argute Stole +1",
		waist="Sacro Cord",
		left_ear="Novio Earring",
		right_ear="Strophadic Earring",
		left_ring="Jhakri Ring",
		right_ring="Stikini Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        } 
    
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}, sub="Enki Strap", hands="Arbatel Bracers +1", "Lugh's Cape"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3",legs="Acad. Pants +2",}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
    
    sets.buff.FullSublimation = {
        head="Acad. Mortar. +2",
        ear1="Savant's Earring",
        body="Peda. Gown +1",
        }

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.LightArts = {legs="Acad. Pants +2", feet="Acad. Loafers +2"}
    sets.DarkArts = {head="Acad. mortarboard +3",body="Acad. Gown +3", feet="Acad. Loafers +2"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.Bookworm = {back="Bookworm's Cape"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then 
        equip(sets.precast.FC.Grimoire) 
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
        if spellMap == "Helix" then
            --equip(sets.midcast['Elemental Magic'])
            if spell.english:startswith('Lumino') then
                equip(sets.midcast.LightHelix)
            elseif spell.english:startswith('Nocto') then
                equip(sets.midcast.DarkHelix)
            else
                equip(sets.midcast.Helix)
            end
            if state.HelixMode.value == 'Bookworm' then
                equip(sets.Bookworm)
            end
        end
    end
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Enfeebling Magic' then
        if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
            equip(sets.LightArts)
        elseif spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then 
            equip(sets.DarkArts)
        end
    end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        if state.CastingMode.value == "Resistant" then
            equip(sets.magic_burst.Resistant)
        else
            equip(sets.magic_burst)
        end
        if spell.english == "Impact" then
            equip(sets.midcast.Impact)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
        if state.Buff.Perpetuance then
            equip(sets.buff['Perpetuance'])
        end
        if spellMap == "Storm" and state.StormSurge.value then
            equip (sets.midcast.Stormsurge)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end 
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
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

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and (spell.element == world.weather_element or spell.element == world.day_element) then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 17)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 5')
end