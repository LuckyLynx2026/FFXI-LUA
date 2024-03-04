-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
	get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	
    -- list of weaponskills that make better use of Gavialis helm
    wsList = S{'Stardiver'}

	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Mid', 'Acc')
	state.IdleMode:options('Normal', 'DT')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal', 'CappedAtk', 'Acc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false

	select_default_macro_book(1, 8)
    send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^[')
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

    -- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets +3"}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    
    

    sets.Organizer = {
    }

	sets.precast.JA.Jump = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
		hands="Vishap F. G. +1",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Ostro Greaves",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}},
    }

	sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +2" }
    
	sets.TreasureHunter = { 
		ammo="Per. Lucky Egg",
		head="Wh. Rarab Cap +1",
		legs="Volte Hose",
		feet="Volte Boots",
		waist="Chaac Belt",}
	
	sets.precast.JA['High Jump'] = {
  		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
		hands="Vishap F. G. +1",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Ostro Greaves",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}},
    }
	
	sets.precast.JA['Soul Jump'] = {
        ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Vishap Mail +2",
		hands="Flam. Manopolas +2",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Ostro Greaves",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}},
    }
	
	sets.precast.JA['Spirit Jump'] = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
		hands="Vishap F. G. +1",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Pelt. Schyn. +1",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}},
    }
	
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {
		head="Vishap Armet +1",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		left_ear="Pratik Earring",
    }
	
	sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +3"}
	
	sets.precast.JA['Deep Breathing'] = {
		head="Pteroslaver Armet +3",
    }
    
	sets.precast.JA['Spirit Surge'] = { 
        body="Pteroslaver Mail +3"
    }
	
	-- Healing Breath sets
	sets.HB = {
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Acro Surcoat",
		legs="Vishap Brais +2",
		waist="Glassblower's belt",
		hands="Acro Gauntlets",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		back="Updraft Mantle",
    }
	------------------------
--   Healing Breath   --
------------------------

	sets.HB = {}
	--Midcast Set for HB spell triggers--
	sets.HB.Trigger = {
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Acro Surcoat",
		legs="Vishap Brais +2",
		waist="Glassblower's belt",
		hands="Acro Gauntlets",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		back="Updraft Mantle",
	}
	
	--The Freshmaker--
	sets.HB.Mentos = {
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Acro Surcoat",
		legs="Vishap Brais +2",
		waist="Glassblower's belt",
		hands="Acro Gauntlets",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		back="Updraft Mantle",
	}
	
	--Elemental Breath--
	sets.HB.Ricola = {
	    ammo="Voluspa Tathlum",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Acro Surcoat",
		hands="Acro Gauntlets",
		legs="Acro Breeches",
		feet="Acro Leggings",
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",
		back="Updraft Mantle",
	}
    sets.MadrigalBonus = {
        hands="Composer's Mitts"
    }
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Amar Cluster",
		head="Carmine Mask +1",
		body={ name="Taeon Tabard", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','"Conserve MP"+1','Phalanx +3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs={ name="Nyame Flanchard", augments={'Path: D',}},
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Beeline Ring",
		back="Moonlight Cape",
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
    }	
		
	

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+29','Weapon skill damage +5%',}},
		body={ name="Valorous Mail", augments={'Accuracy+3 Attack+3','Weapon skill damage +5%','STR+4','Accuracy+9','Attack+12',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +2",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    })
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = {
		ammo="Knobkierrie",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Dagon Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	
	sets.precast.WS['Stardiver'].CappedAtk = {
	    ammo="Crepuscular Pebble",
		head="Flam. Zucchetto +2",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	
	sets.precast.WS['Stardiver'].Acc = {
	    ammo="Voluspa Tathlum",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Dagon Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Vishap Brais +2",
		feet="Vishap Greaves +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

    sets.precast.WS["Camlann's Torment"] = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+29','Weapon skill damage +5%',}},
		body={ name="Valorous Mail", augments={'Accuracy+3 Attack+3','Weapon skill damage +5%','STR+4','Accuracy+9','Attack+12',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +2",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS["Camlann's Torment"].CappedAtk = {
        ammo="Knobkierrie",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Gleti's Breeches",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	
	sets.precast.WS["Camlann's Torment"].Acc = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+29','Weapon skill damage +5%',}},
		body={ name="Valorous Mail", augments={'Accuracy+3 Attack+3','Weapon skill damage +5%','STR+4','Accuracy+9','Attack+12',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +2",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	
	sets.precast.WS['Drakesbane'] = {
		ammo="Knobkierrie",
		head="Gleti's Mask",
		body="Hjarrandi breastplate",
		hands="Gleti's Gauntlets",
		legs="Pelt. Cuissots +1",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS['Drakesbane'].CappedAtk = {
    	ammo="Crepuscular pebble",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Pelt. Cuissots +1",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Drakesbane'].Acc = {
		ammo="Knobkierrie",
		head="Gleti's Mask",
		body="Hjarrandi breastplate",
		hands="Gleti's Gauntlets",
		legs="Pelt. Cuissots +1",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    
    sets.precast.WS['Impulse Drive'] = {
		ammo="Knobkierrie",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Dagon Breast.",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS['Impulse Drive'].CappedAtk = {
	    ammo="Knobkierrie",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	sets.precast.WS['Impulse Drive'].Acc = {
    	ammo="Knobkierrie",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Dagon Breast.",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Enmerkar Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Enmerkar Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = set_combine(sets.idle, {		
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Enmerkar Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},})
	
	sets.idle.Field = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Enmerkar Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
		neck="Bathy Choker +1",
		left_ear="Infused Earring",
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
    })
	
	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Enmerkar Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
    })

	sets.defense.MDT = set_combine(sets.defense.PDT, {
        ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Gleti's Breeches",
		feet={ name="Gleti's Boots", augments={'Path: A',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Enmerkar Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    })

	sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

	sets.Reraise = {head="Crepuscular Helm",body="Crepuscular Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

	sets.engaged.Mid = set_combine(sets.engaged, {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands="Sulev. Gauntlets +2",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Flam. Gambieras +2",
		neck="Shulmanu Collar",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}},
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		ammo="Voluspa Tathlum",
		head="Flam. Zucchetto +2",
		body="Vishap Mail +2",
		hands="Sulev. Gauntlets +2",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Flam. Gambieras +2",
		neck="Shulmanu Collar",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Sulev. Gauntlets +2",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Flam. Gambieras +2",
		neck="Anu torque",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
    })

	sets.engaged.Reraise = set_combine(sets.engaged, {
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise

end

-------------------------------------
---------                   ---------
------                         ------
---         Start of Maps         ---
------                         ------
---------                   ---------
------------------------------------- 

-------------------------
--   BLU Spells List   --
-------------------------

function maps()
	PhysicalSpells = S {
		'Bludgeon', 'Body Slam', 'Feather Storm', 'Mandibular Bite', 'Queasyshroom',
		'Screwdriver', 'Sickle Slash', 'Smite of Rage', 'Power Attack',
		'Terror Touch', 'Battle Dance', 'Claw Cyclone', 'Grand Slam', 
		'Jet Stream', 'Pinecone Bomb', 'Wild Oats', 'Uppercut'
	}

	MagicalSpells = S {}
	
	BlueMagic_Buffs = S {
		'Refueling'
	}

	BlueMagic_Healing = S {
		'Healing Breeze', 'Pollen', 'Wild Carrot'
	}

	BlueMagic_Enmity = S {
		'Blank Gaze', 'Jettatura', 'Geist Wall', 'Sheep Song', 'Soporific'
	}
	
end

------------------------
--   Sub Mage Table   --
------------------------

mp_jobs = S {"WHM", "BLM", "RDM", "SMN", "BLU", "SCH", "GEO", "PLD", "DRK", "RUN"}

--------------------------------
--   Elemental Breath Table   --
--------------------------------

ElementalBreath = S { "Flame Breath", "Sand Breath", "Hydro Breath", 
"Gust Breath", "Frost Breath", "Lightning Breath", }

-------------------------------
--   WS Chart For Gavialis   --
-------------------------------

check_ws_day = {
Firesday = S {'Liquefaction','Fusion','Light'},
Earthsday= S {'Scission','Gravitation','Darkness'},
Watersday = S {'Reverberation','Distortion','Darkness'},
Windsday = S {'Detonation','Fragmentation','Light'},
Iceday = S {'Induration','Distortion','Darkness'},
Lightningsday = S {'Impaction','Fragmentation','Light'},
Lightsday = S {'Transfixion','Fusion','Light'},
Darksday = S {'Compression','Gravitation','Darkness'},}


---------------------
--   HB Triggers   --
---------------------
Trigger = S {
	'Power Attack', 'Foot Kick', 'Sprout Smack', 'Helldive', 'Cocoon', 'Wild Carrot',
	'Dia', 'Diaga', 'Dia II', 'Sneak', 'Invisible', 'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Cura', 
	'Raise', 'Reraise', 'Poisona', 'Paralyna', 'Blindna', 'Silena', 'Stona', 'Cursna', 'Haste',
	'Regen', 'Regen II', 'Erase', 'Flash'
}

------------------------
--   Town Gear List   --
------------------------

Town = S {
    "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
    "Port Windurst", "Windurst Waters", "Windurst Woods", "Windurst Walls", "Heavens Tower",
    "Port San d'Oria", "Northern San d'Oria", "Southern San d'Oria", "Chateau d'Oraguille",
	"Port Bastok", "Bastok Markets", "Bastok Mines", "Metalworks",
    "Aht Urhgan Whitegate", "Nashmau",
    "Selbina", "Mhaura", "Norg",  "Kazham", "Tavanazian Safehold",
    "Eastern Adoulin", "Western Adoulin", "Celennia Memorial Library", "Mog Garden"
}

---End of Maps----------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Steady Wing' then
        equip (sets.HB.Mentos)
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if string.find(spell.english,'Healing Breath')  then
			equip (sets.HB.Mentos)
		elseif ElementalBreath:contains(spell.english) then
			equip (sets.HB.Ricola)
	end	
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		--category == 4 or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 8)
    elseif player.sub_job == 'WHM' then
    	set_macro_page(2, 8)
    else
    	set_macro_page(1, 8)
    end
end