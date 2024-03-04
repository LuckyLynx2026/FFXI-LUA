
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end

function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','Counter')
    state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.IdleMode:options('Normal', 'PDT')

	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end


function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
	sets.precast.JA['Boost'] = {waist="Ask sash",} 
	sets.precast.JA['Boost'].OutOfCombat = {waist="Ask sash",} 
	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters"}
	sets.precast.JA['Focus'] = {head="Anchorite's Crown"}
	sets.precast.JA['Counterstance'] = {    
		ammo="Amar Cluster",
		head="Hiza. Somen　+2",
		body="Ashera Harness",
		hands="Hizamaru Kote +2",
		legs="Ken. Hakama +1",
		feet="Hes. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Cryptic Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},} --feet="Hesychast's Gaiters +1"
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	sets.precast.JA['Mantra'] = {feet="Mel. Gaiters +2"} --feet="Hesychast's Gaiters +1"

	sets.precast.JA['Chi Blast'] = {}
	
	sets.precast.JA['Chakra'] = {
		ammo="Aurgelmir Orb +1",
		head="Ken. Jinpachi +1",
		body="Anchorite's cyclas +1",
		hands="Hizamaru Kote +2",
		legs="Hiza. Hizayoroi +2",
		feet="Hiza. Sune-Ate +2",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Eabani Earring",
		right_ear="Cryptic Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Moonlight Cape",}
	
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Malignance Boots"}
		
	sets.precast.Flourish1 = {ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},waist="Olseni Belt",legs="Mummu Kecks +2",feet="Malignance Boots"}


	-- Fast cast sets for spells
	
	sets.precast.FC = {    
		ammo="Sapience Orb",
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Voltsurge Torque",
		waist="Eschan Stone",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {    
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},}
	sets.precast.WSSomeAcc = {    
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},}
	sets.precast.WSAcc = {    
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},}

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head="Ken. Jinpachi +1",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},})
	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands={ name="Herculean Gloves", augments={'"Triple Atk."+4','Accuracy+14','Attack+14',}},
		legs="Ken. Hakama +1",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},})
	sets.precast.WS['Final Heaven']    = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Herculean Vest", augments={'AGI+2','Pet: "Dbl.Atk."+2 Pet: Crit.hit rate +2','Weapon skill damage +9%','Accuracy+3 Attack+3',}},
		hands="Ken. Tekko +1",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},})
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs="Ken. Hakama +1",
		feet={ name="Herculean Boots", augments={'Crit. hit damage +4%','DEX+14',}},
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Begrudging Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},})
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs="Ken. Hakama +1",
		feet={ name="Herculean Boots", augments={'Crit. hit damage +4%','DEX+14',}},
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Odr earring",
		left_ring="Niqmaddu Ring",
		right_ring="Begrudging Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},})
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {   
		ammo="Aurgelmir Orb +1",
		head="Ken. Jinpachi +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},})
	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {    
		ammo="Knobkierrie",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Anch. Gaiters +2",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},})
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Raging Fists"].SomeAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Howling Fist"].SomeAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSSomeAcc)
	sets.precast.WS["Final Heaven"].SomeAcc = set_combine(sets.precast.WS["Final Heaven"], sets.precast.WSSomeAcc)
	sets.precast.WS["Ascetic's Fury"].SomeAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSSomeAcc)
	sets.precast.WS["Victory Smite"].SomeAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSSomeAcc)
	sets.precast.WS["Shijin Spiral"].SomeAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Dragon Kick"].SomeAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSSomeAcc)
	sets.precast.WS["Tornado Kick"].SomeAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSSomeAcc)
	
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Final Heaven"].Acc = set_combine(sets.precast.WS["Final Heaven"], sets.precast.WSAcc)
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear2="Brutal Earring",ear1="Sherida Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	
	-- Midcast Sets

		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {body="Hesychast's Cyclas",ring2="Sheltered Ring"}
	

	-- Idle sets
	sets.idle = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Sheltered Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}
	sets.idle.town = {   
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Sheltered Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}
	sets.idle.Weak = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Sheltered Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

	sets.idle.PDT = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Sheltered Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}		

	-- Defense sets
	sets.defense.PDT = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
		
	-- Defense sets
	sets.defense.HP = {}

	sets.defense.MDT = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}
		
	sets.defense.MEVA = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Moonbow Belt +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {    
		ammo="Aurgelmir Orb +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	sets.engaged.SomeAcc = {   
		ammo="Ginsen",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	sets.engaged.Acc = {    
		ammo="Ginsen",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	sets.engaged.Counter = {    
		ammo="Amar Cluster",
		head="Malignance Chapeau",
		body="Ashera Harness",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Cryptic Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}


	-- Defensive melee hybrid sets
	sets.engaged.PDT = {   
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	sets.engaged.SomeAcc.PDT = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	sets.engaged.Acc.PDT = {    
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	sets.engaged.Counter.PDT = {    
		ammo="Amar Cluster",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Cryptic Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}


	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.SomeAcc.HF = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.Counter.HF = set_combine(sets.engaged.Counter, {})
	


	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Footwork = {feet="Shukuyu Sune-Ate"}
	sets.buff.Boost = {"Ask Sash"} --waist="Ask Sash"
	
	sets.FootworkWS = {feet="Shukuyu Sune-Ate"}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist='Chaac belt'})

	
end
function aftercast(spell)
  if player.status == 'Idle' then
    -- Equip Idle set if not engaged.
    equip(sets.IdleSet)
  elseif player.status == "Engaged" then
    -- Equip Default melee set if engaged.
    equip(sets.Melee.Default)
    if buffactive['Impetus'] then
      -- If Impetus is up, then equip the Empyrean body after equipping the default melee set.
      equip({body = "Bhikku Cyclas +1"})
    end
  end
  if spell.name == "Impetus" then
    -- Equip Empyrean body immediately after using Impetus, even if not engaged
    equip({body = "Bhikku Cyclas +1"})
  end
end


function status_change(new,old)
  if new == "Idle" then
    equip(sets.IdleSet)
  elseif new == "Engaged" then
    equip(sets.Melee.Default)
    if buffactive['Impetus'] then
      equip({body = "Bhikku Cyclas +1"})
    end
  end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 20)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 20)
	else
		set_macro_page(6, 20)
	end
end