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
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	state.Buff['Double Shot'] = buffactive['Double Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	
	DefaultAmmo = {['Yoichinoyumi'] = "Yoichi's arrow", ['Annihilator'] = "Chrono bullet", ['Armageddon'] = "Devastating bullet", ['Fomalhaut'] = "Chrono bullet", ['Gastraphetes'] = "Quelling bolt"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Yoichi's arrow", ['Annihilator'] = "Chrono bullet", ['Armageddon'] = "Devastating bullet", ['Fomalhaut'] = "Chrono bullet", ['Gastraphetes'] = "Quelling bolt"}

	select_default_macro_book()

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end


-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Amini Glovelettes +2"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +3"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +3"}
	sets.precast.JA['Sharpshot'] = {legs="Orion braccae +3"}
	sets.precast.JA['Velocity Shot'] = {body="Amini Caban +2"}
	sets.precast.JA['Double Shot'] = {head="Amini Gapette +2"}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Carmine Mask +1",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Gyve Trousers",
		feet="Malignance Boots",
		neck="Voltsurge Torque",
		waist="Cornelia's belt",
		left_ear="Etiolation Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Medada's ring",
		back="Moonlight Cape",}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets (snapshot)
		
	
	sets.precast.RA = {
		head="Orion Beret +3",
		body="Amini Caban +2",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		feet="Meg. Jam. +2",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Yemaya Belt",
		left_ring="Crepuscular Ring",
		back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

	sets.precast.WS['Last Stand'] = {
		head="Orion Beret +3",
		body="Amini Caban +2",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Amini Bottillons +2",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear={ name="Amini Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
	
	
	sets.precast.WS['Coronach'] = {
		head="Orion Beret +3",
		body="Amini Caban +2",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Amini Bottillons +2",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Amini Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Trueflight'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Dingir Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Jishnu\'s Radiance'] = {
		head="Orion Beret +3",
		body="Amini Caban +2",
		hands="Amini Glove. +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Amini Bottillons +2",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Amini Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
		left_ring="Regal Ring",
		right_ring="Begrudging Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Wildfire'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Novio Earring",
		left_ring="Dingir Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Flaming Arrow'] = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Dingir Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Namas Arrow'] = {
		head="Orion Beret +3",
		body="Amini Caban +2",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Amini Bottillons +2",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Amini Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {}

	sets.midcast.Utsusemi = {}

	-- Ranged sets

	sets.midcast.RA = {
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body={ name="Ikenga's Vest", augments={'Path: A',}},
		hands="Amini Glove. +2",
		legs="Amini Bragues +2",
		feet="Ikenga's Clogs",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body={ name="Ikenga's Vest", augments={'Path: A',}},
		hands="Amini Glove. +2",
		legs="Amini Bragues +2",
		feet="Ikenga's Clogs",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Crepuscular Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},})
		
	sets.DoubleShot = set_combine(sets.midcast.RA,{
		head="Meghanada Visor +2",
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		hands="Oshosi Gloves +1",
		legs="Osh. Trousers +1",
		feet="Osh. Leggings +1",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="K. Kachina Belt +1",
		left_ear="Odr Earring",
		right_ear={ name="Amini Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
		left_ring="Begrudging Ring",
		right_ring="Mummu Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},})

	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
	    head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Sanctity Necklace",
		waist="Gishdubar Sash",
		left_ear="Dawn Earring",
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Moonlight Cape",}

	-- Idle sets
	sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back="Moonlight Cape",}
	
	sets.idle.Town = {
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body="Nisroch Jerkin",
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Malignance Boots",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},}
	
	
	-- Defense sets
	sets.defense.PDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back="Moonlight Cape",}

	sets.defense.MDT = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

	sets.Kiting = {legs="Carmine cuisses +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------
		
	sets.engaged = {
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wrist. +1",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck="Scout's Gorget +2",
		waist="Windbuffet belt +1",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},}
	
	
	sets.engaged.Acc = {
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Adhemar Wrist. +1",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Combatant's Torque",
		waist="Windbuffet belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}},}

	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +3"})
	sets.buff.Camouflage = {body="Orion Jerkin +3"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if ((spell.name == 'Trueflight') or (spell.name == 'Wildfire') or 
    (spell.type == 'CorsairShot')) and ((spell.element == world.weather_element) or 
    (spell.element == world.day_element)) then
        equip({ waist="Hachirin-no-Obi"})
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and buffactive['Double Shot'] then
        equip(sets.DoubleShot)
    end
end	

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 4)
end

