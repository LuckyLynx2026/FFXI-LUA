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
    state.IdleMode:options('Normal', 'DT', 'Refresh')
    
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
    sets.precast.JA['Enlightenment'] = {body="Peda. Gown +3"}

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --15
		main={ name="Musa", augments={'Path: C',}},
		sub="Clerisy Strap",
		ammo="Sapience Orb",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body="Pinga Tunic",
		hands="Acad. Bracers +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Acad. Loafers +3",
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Enchntr. Earring +1",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Medada's Ring",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.precast.FC.Grimoire = {head="Peda. M.Board +3", feet="Acad. Loafers +3"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {waist="Channeler's Stone"})
    
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ammo="Impatiens",
		head="Arbatel Bonnet +3",
		hands="Arbatel Bracers +2",
		legs="Arbatel Pants +2",
		feet="Arbatel Loafers +3",
		waist="Witful Belt",
		left_ring="Lebeche Ring",
		back="Perimede Cape",
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
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        }

	
	sets.precast.WS['Cataclysm'] = {    
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
		}


	sets.precast.WS['Shattersoul'] = {    
		ammo="Ghastly Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Medada's Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
		}


	sets.precast.WS['Myrkr'] = {
		ammo="Hydrocera",
		head="Pixie Hairpin +1",
		body="Acad. Gown +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Arbatel Loafers +3",
		neck="Sanctity Necklace",
		waist="Luminary Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Fenrir Ring +1",
		right_ring="Mephitas's Ring +1",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        } -- Max MP
   

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC
    
    sets.midcast.Cure = {
		main="Daybreak",
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}},
		legs={ name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Incanter's Torque",
		waist="Shinjutsu-no-Obi +1",
		left_ear="Calamitous Earring",
		right_ear="Mendi. Earring",
		left_ring="Naji's Loop",
		right_ring="Kuchekula Ring",
		back="Fi Follet Cape +1",
        }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}},
		legs={ name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Incanter's Torque",
		waist="Hachirin-no-Obi",
		left_ear="Calamitous Earring",
		right_ear="Mendi. Earring",
		left_ring="Naji's Loop",
		right_ring="Kuchekula Ring",
		back="Fi Follet Cape +1",
        })
    
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
    
    sets.midcast.StatusRemoval = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		ammo="Oreiad's Tathlum",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},
		legs="Acad. Pants +3",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Debilis Medallion",
		waist="Gishdubar Sash",
		left_ear="Regal Earring",
		right_ear="Etiolation Earring",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back="Oretan. Cape +1",
        }
    
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {})
    
    sets.midcast['Enhancing Magic'] = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		ammo="Savant's Treatise",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Arbatel Bracers +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Augment. Earring",
		right_ear="Andoaa Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back="Fi follet cape +1",
        }
    
    sets.midcast.EnhancingDuration = {
		main={ name="Musa", augments={'Path: C',}},
		sub="Enki Strap",
		ammo="Savant's Treatise",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Arbatel Bracers +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Augment. Earring",
		right_ear="Andoaa Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back="Fi follet cape +1",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main={ name="Musa", augments={'Path: C',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Arbatel Bracers +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Nuna Gorget",
		waist="Embla Sash",
		left_ear="Calamitous Earring",
		right_ear="Mendi. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Fenrir Ring +1",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        })
    
    
    
    sets.midcast.Haste = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif",
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })
        
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        legs="Acad. Pants +3",
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
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}},
		legs="Arbatel Pants +2",
		feet="Acad. Loafers +3",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back="Aurist's cape +1",
        }
    
    sets.midcast.IntEnfeebles = {
	    main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}},
		legs="Arbatel Pants +2",
		feet="Acad. Loafers +3",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back="Aurist's cape +1",
		}

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    
    sets.midcast['Dark Magic'] = {
		main={ name="Musa", augments={'Path: C',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands="Acad. Bracers +3",
		legs="Acad. Pants +3",
		feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast.Kaustra = {
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Agwu's Robe",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Agwu's Pigaches",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Hachirin-no-Obi",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Archon Ring",
		right_ring="Medada's Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        }
    
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Pixie Hairpin +1",
		body="Acad. Gown +3",
		hands="Acad. Bracers +3",
		legs={ name="Peda. Pants +3", augments={'Enhances "Tabula Rasa" effect',}},
		feet="Agwu's Pigaches",
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Hirudinea Earring",
		right_ear="Malignance Earring",
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
		back={ name="Bookworm's Cape", augments={'INT+2','MND+2','Helix eff. dur. +15',}},
        })
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {    
		main={ name="Musa", augments={'Path: C',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands="Acad. Bracers +3",
		legs="Acad. Pants +3",
		feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},})

    -- Elemental Magic
    sets.midcast['Elemental Magic'] = {
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Enki Strap",
		ammo="Ghastly Tathlum +1",
		head={ name="Agwu's Cap", augments={'Path: A',}},
		body="Arbatel Gown +3",
		hands="Arbatel Bracers +2",
		legs="Arbatel Pants +2",
		feet="Arbatel Loafers +3",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Medada's Ring",
		right_ring="Freke Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        }


    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Enki Strap",
		ammo="Ghastly Tathlum +1",
		head={ name="Agwu's Cap", augments={'Path: A',}},
		body="Arbatel Gown +3",
		hands="Arbatel Bracers +2",
		legs="Arbatel Pants +2",
		feet="Arbatel Loafers +3",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Medada's Ring",
		right_ring="Freke Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        })
    
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Enki Strap",
        head=empty,
        body="Twilight Cloak",
        ring1="Medada's ring",
		neck="Erra pendant",
		back="Aurist's cape +1",
        })
    
    sets.midcast.Helix = {
        main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        waist="Yamabuki-no-Obi",
        }

    sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
        head="Pixie Hairpin +1",
        ring1="Medada's ring",
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
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo="Homiliary",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Arbatel Gown +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.idle.DT = set_combine(sets.idle, {
		main="Malignance Pole",
		sub="Mensch Strap +1",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Arbatel Gown +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",
        })

    sets.idle.Refresh = {    
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo="Homiliary",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Arbatel Gown +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},}

    sets.idle.Town = set_combine(sets.idle, {
		main={ name="Musa", augments={'Path: C',}},
		sub="Enki Strap",
		ammo="Staunch Tathlum +1",
		head="Acad. Mortar. +3",
		body="Arbatel Gown +3",
		hands="Acad. Bracers +3",
		legs="Acad. Pants +3",
		feet="Herald's gaiters",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Barkaro. Earring",
		right_ear="Regal Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
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
		ammo="Amar Cluster",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Grunfeld Rope",
		left_ear="Crep. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Mephitas's Ring +1",
		back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        }
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    sets.magic_burst = { 
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Agwu's Cap", augments={'Path: A',}},
		body="Arbatel Gown +3",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Hachirin-no-Obi",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Mujin Band",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        }

    sets.magic_burst.Resistant = { 
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Agwu's Cap", augments={'Path: A',}},
		body="Arbatel Gown +3",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3",
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Hachirin-no-Obi",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Mujin Band",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
        } 
    
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +3"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +3"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +2"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +2", "Lugh's Cape"}
    sets.buff['Penury'] = {legs="Arbatel Pants +2"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +2"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3",legs="Acad. Pants +3",}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +3"}
    
    sets.buff.FullSublimation = {
        head="Acad. Mortar. +3",
        ear1="Savant's Earring",
        body="Peda. Gown +3",
        }

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.LightArts = {legs="Acad. Pants +3", feet="Acad. Loafers +3"}
    sets.DarkArts = {head="Acad. mortarboard +3",body="Acad. Gown +3", feet="Acad. Loafers +3"}

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