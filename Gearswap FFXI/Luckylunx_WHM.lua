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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {    
		main={ name="Grioavolr", augments={'Magic burst dmg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26',}},
		sub="Enki Strap",
		ammo="Incantor Stone",
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		legs="Aya. Cosciales +2",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back={ name="Alaunus's Cape", augments={'"Fast Cast"+10',}},}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {ammo="Incantor Stone",
    waist="Siegel Sash",})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {ammo="Incantor Stone", head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {    
		main="Vadose Rod",
		sub="Ammurapi Shield",
		ammo="Incantor Stone",
		legs="Ebers Pant. +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {    
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub={ name="Genbu's Shield", augments={'"Cure" potency +3%','"Cure" spellcasting time -8%',}},
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		legs="Ebers Pant. +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back={ name="Alaunus's Cape", augments={'"Fast Cast"+10',}},})
    
	sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = {}
    gear.default.weaponskill_waist = {}
    sets.precast.WS = {}
    
    sets.precast.WS['Flash Nova'] = {}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
		main={ name="Grioavolr", augments={'Magic burst dmg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26',}},
		sub="Enki Strap",
		ammo="Incantor Stone",
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		legs="Aya. Cosciales +2",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back={ name="Alaunus's Cape", augments={'"Fast Cast"+10',}},}
    
    -- Cure sets
    gear.default.obi_waist = "Hachirin-no-obi"

    sets.midcast.CureSolace = {    
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		body="Theo. Bliaut +2",
		hands="Theophany Mitts +2",
		legs="Ebers Pant. +1",
		feet={ name="Kaykaus Boots", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Hachirin-no-obi",
		left_ear="Mendi. Earring",
		right_ear="Glorious Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'Enmity-10',}},}

    sets.midcast.Cure = {    
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		body="Ebers Bliaut +1",
		hands="Theophany Mitts +2",
		legs="Ebers Pant. +1",
		feet={ name="Kaykaus Boots", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Glorious Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'Enmity-10',}},}

    sets.midcast.Curaga = {    
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		body="Theo. Bliaut +2",
		hands="Theophany Mitts +2",
		legs="Ebers Pant. +1",
		feet={ name="Kaykaus Boots", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Glorious Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'Enmity-10',}},}

    sets.midcast.CureMelee = {}

    sets.midcast.Cursna = {    
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Culminus",
		ammo="Hasty Pinion +1",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		body="Ebers Bliaut +1",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
		legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Debilis Medallion",
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Etiolation Earring",
		left_ring="Haoma's Ring",
		right_ring="Menelaus's Ring",
		back={ name="Alaunus's Cape", augments={'Enmity-10',}},}

    sets.midcast.StatusRemoval = {
		head="Ebers Cap +1",
		hands="Ebers Mitts +1",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		back={ name="Mending Cape", augments={'Healing magic skill +2','Enha.mag. skill +7','Mag. Acc.+7',}},}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {    
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head="Umuthi Hat",
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
		hands="Inyan. Dastanas +2",
		legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
		feet="Piety Duckbills +1",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Augment. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Mending Cape", augments={'Healing magic skill +2','Enha.mag. skill +7','Mag. Acc.+7',}},}

    sets.midcast.Stoneskin = {    
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head="Umuthi Hat",
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
		hands="Inyan. Dastanas +2",
		legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
		feet="Piety Duckbills +1",
		neck="Nodens Gorget",
		waist="Siegel Sash",
		left_ear="Andoaa Earring",
		right_ear="Earthcry Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Mending Cape", augments={'Healing magic skill +2','Enha.mag. skill +7','Mag. Acc.+7',}},}

    sets.midcast.Auspice = {
	    main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet="Orsn. Duckbills +1",
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Andoaa Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Mending Cape", augments={'Healing magic skill +2','Enha.mag. skill +7','Mag. Acc.+7',}},}

    sets.midcast.BarElement = {    
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head="Ebers Cap +1",
		body="Ebers Bliaut +1",
		hands="Ebers Mitts +1",
		legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
		feet={ name="Piety Duckbills +1", augments={'Enhances "Afflatus Solace" effect',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Augment. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Mending Cape", augments={'Healing magic skill +2','Enha.mag. skill +7','Mag. Acc.+7',}},}

    sets.midcast.Regen = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		head="Inyanga Tiara +2",
		body={ name="Piety Bliaut +1", augments={'Enhances "Benediction" effect',}},
		hands="Ebers Mitts +1",
		legs="Th. Pantaloons +2",
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		waist="Embla Sash",}

    sets.midcast.Protectra = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		waist="Embla Sash",
		left_ring="Sheltered Ring",}

    sets.midcast.Shellra = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+20',}},
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		waist="Embla Sash",
		left_ring="Sheltered Ring",}


    sets.midcast['Divine Magic'] = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Bunzi's Hat",
		body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
		legs="Th. Pantaloons +2",
		feet={ name="Chironic Slippers", augments={'"Dbl.Atk."+1','CHR+10','"Refresh"+1','Accuracy+15 Attack+15',}},
		neck="Incanter's Torque",
		waist="Kobo Obi",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Mending Cape", augments={'Healing magic skill +2','Enha.mag. skill +7','Mag. Acc.+7',}},}

    sets.midcast['Dark Magic'] = {}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {    
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Theophany Cap +2",
		body="Theo. Bliaut +2",
		hands="Theophany Mitts +2",
		legs={ name="Chironic Hose", augments={'Accuracy+13','Attack+8','Damage taken-3%','Accuracy+8 Attack+8','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back="Izdubar Mantle",}

    sets.midcast.IntEnfeebles = {    
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Theophany Cap +2",
		body="Theo. Bliaut +2",
		hands="Theophany Mitts +2",
		legs={ name="Chironic Hose", augments={'Accuracy+13','Attack+8','Damage taken-3%','Accuracy+8 Attack+8','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back="Izdubar Mantle",}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Warder's Charm +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Inyanga Tiara +2",
		body="Shamash Robe",
		hands="Inyan. Dastanas +2",
		legs="Assid. Pants +1",
		feet="Inyan. Crackows +2",
		neck="Bathy Choker +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Infused Earring",
		left_ring="Stikini Ring +1",
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",}

    sets.idle.PDT = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Shamash Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",}

    sets.idle.Town = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Shamash Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",}
    
    sets.idle.Weak = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Shamash Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",}
    
    -- Defense sets

    sets.defense.PDT = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Shamash Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",}

    sets.defense.MDT = {    
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Shamash Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Warder's Charm +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Archon Ring",
		back="Moonlight Cape",}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {    
		main="Maxentius",
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Combatant's Torque",
		waist="Windbuffet Belt +1",
		left_ear="Brutal Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Hetairoi Ring",
		back="Moonlight Cape",}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Orison Mitts +1",back="Mending Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 10)
end

