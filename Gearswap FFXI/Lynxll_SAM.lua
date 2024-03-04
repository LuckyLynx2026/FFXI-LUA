-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    include('Mote-TreasureHunter')
	state.TreasureMode:set('Tag')
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
	send_command('unbind ^=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.TreasureHunter = { 
		ammo="Per. Lucky Egg",
		head="Wh. Rarab Cap +1",
		legs="Volte Hose",
		feet="Volte Boots",
		waist="Chaac Belt",}
    
	
	-- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +1",hands="Sakonji Kote +3",back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
    sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {    
		head="Hizamaru Somen +2",
		body="Flamma Korazin +2",
		hands="Hizamaru Kote +2",
		legs="Hiza. Hizayoroi +2",
		feet="Hiza. Sune-Ate +2",
		waist="Chaac Belt",
		left_ear="Enchntr. Earring +1",
		left_ring="Light Ring",
		back="Laic Mantle",}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

	sets.precast.WS.Acc = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Wakido Haidate +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
	
	
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {right_ear="Brutal Earring"})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head="Hizamaru Somen +2",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},})
    
	sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Jinpu'] = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, {		
		head="Valorous mask",
		body="Sakonji domaru +3",
		hands={ name="Valorous Mitts", augments={'Accuracy+25','Weapon skill damage +4%','STR+6','Attack+2',}},
		legs="Wakido haidate +3",
		feet={ name="Valorous Greaves", augments={'Accuracy+30','Weapon skill damage +4%','Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +25',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},})

    -- Midcast Sets
    
	sets.midcast.FastRecast = {
        hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {    
		body="Hizamaru Haramaki +2",
		neck="Sanctity Necklace",
		left_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {   
		sub="Utu Grip",
		ammo="Aurgelmir orb +1",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet="Danzo sune-ate",
		neck="Samurai's nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    
    sets.idle.Field = {
		ammo="Staunch tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet="Ken. Sune-Ate +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.idle.Weak = {
		ammo="Staunch tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet="Ken. Sune-Ate +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    
    -- Defense sets
    sets.defense.PDT = {    
		sub="Utu grip",
		ammo="Staunch tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido kote +3",
		legs="Kendatsuba hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Gelatinous ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.defense.Reraise = {
		sub="Utu grip",
		ammo="Staunch tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido kote +3",
		legs="Kendatsuba hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Gelatinous ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.defense.MDT = {    
		sub="Utu grip",
		ammo="Staunch tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido kote +3",
		legs="Kendatsuba hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Gelatinous ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.Kiting = {feet="Danzo sune-ate"}

    sets.Reraise = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {    
		sub="Utu Grip",
		ammo="Aurgelmir orb +1",
		head="Flam. Zucchetto +2",
		body="Kendatsuba samue +1",
		hands="Wakido kote +3",
		legs="Ryuo hakama +1",
		feet="Ryuo sune-ate +1",
		neck="Samurai's nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Flamma Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    sets.engaged.Acc = {    
		sub="Utu Grip",
		ammo="Aurgelmir orb +1",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Wakido Haidate +3",
		feet="Ken. Sune-Ate +1",
		neck="Sam. Nodowa +1",
		waist="Ioskeha Belt +1",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Flamma Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    sets.engaged.PDT = {    
		sub="Utu grip",
		ammo="Aurgelmir Orb +1",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Wakido Kote +3",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+13','Accuracy+20 Attack+20','Accuracy+6','"Store TP"+10','Phys. dmg. taken-10%',}},}
    sets.engaged.Acc.PDT = {    
		sub="Utu grip",
		ammo="Aurgelmir Orb +1",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Wakido Kote +3",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+13','Accuracy+20 Attack+20','Accuracy+6','"Store TP"+10','Phys. dmg. taken-10%',}},}
	
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {
		sub="Utu Grip",
		ammo="Aurgelmir orb +1",
		head="Flam. Zucchetto +2",
		body="Kendatsuba samue +1",
		hands="Flam. Manopolas +2",
		legs="Ryuo hakama +1",
		feet="Ryuo sune-ate +1",
		neck="Samurai's nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Flamma Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    sets.engaged.Adoulin.Acc = {    
		sub="Utu Grip",
		ammo="Aurgelmir orb +1",
		head="Flam. Zucchetto +2",
		body="Kendatsuba samue +1",
		hands="Flam. Manopolas +2",
		legs="Kendatsuba hakama +1",
		feet="Flam. Gambieras +2",
		neck="Samurai's nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Flamma Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    sets.engaged.Adoulin.PDT = {
		sub="Utu Strap",
		ammo="Aurgelmir orb +1",
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    sets.engaged.Adoulin.Acc.PDT = {		
		sub="Utu grip",
		ammo="Aurgelmir orb +1",
		head="Flam. Zucchetto +2",
		body="Kendatsuba samue +1",
		hands="Flam. Manopolas +2",
		legs="Kendatsuba hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Loricate torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}

	

    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 3)
    else
        set_macro_page(1, 3)
    end
end

