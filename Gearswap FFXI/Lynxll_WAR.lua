--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+W ]           Enable Roll sets* look binds section notes
 
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
function job_setup()
     
     
    --Chirich Rings
    gear.ChirichL = {name="Chirich Ring +1", bag="wardrobe3"}
    gear.ChirichR = {name="Chirich Ring +1", bag="wardrobe4"}
     
    --Moonlight Rings
    gear.MoonlightL = {name="Moonlight Ring", bag="wardrobe3"}
    gear.MoonlightR = {name="Moonlight Ring", bag="wardrobe4"}
     
    --War jse back

     
    gear.empty = {head=empty, body=empty, hands=empty, legs=empty, feet=empty}
     
    --Prevent gearinfo override
    no_swap_gear = S{"Warp Ring","Tavnazian Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)", "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
                    "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch"}
 
 
    abyprocws = S{"Cyclone", "Energy Drain", "Red Lotus Blade", "Seraph Blade", "Freezebite", "Shadow of Death", "Raiden Thrust", "Blade: Ei", "Tachi: Jinpi", "Tachi: Koki",
                "Seraph Strike", "Earth Crusher", "Sunburst"}
     
    --I have this in my my motes-mappings lua
    areas.Abyssea = S{
    "Abyssea - Konschtat",
    "Abyssea - La Theine",
    "Abyssea - Tahrongi",
    "Abyssea - Attohwa",
    "Abyssea - Misareaux",
    "Abyssea - Vunkerl",
    "Abyssea - Altepa",
    "Abyssea - Uleguerand",
    "Abyssea - Grauberg",
    "Abyssea - Empyreal Paradox"
    }
end
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Twohand', 'DW', 'Single', 'Hybrid')                      
    state.HybridMode:options('Normal', 'PDT')                       
    state.WeaponskillMode:options('Normal', 'Atk')                          
    state.CastingMode:options('Normal')                             
    state.IdleMode:options('Normal', 'Regen')                                
    state.PhysicalDefenseMode:options('DT')     
    state.MagicalDefenseMode:options('Reraise')                     
     
     
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')                    --^ means ctrl
    send_command('bind !` input /ja "Seigan" <me>')                   --! means alt                   
    send_command('bind @w gs c toggle Roll')                        --@ means windows key
     

end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')   
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
    send_command('unbind @w')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
 
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
    sets.precast.JA['Defender'] = {hands="Agoge Mufflers +1"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica +2"}
    sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
    sets.precast.JA['Berserk'] = {body="Pumm. Lorica +3", feet="Agoge Calligae +3"}
    sets.precast.JA['Tomahawk'] = {feet="Agoge Calligae +3"}
    sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +3",}
    sets.precast.JA['Restraint'] = {hands="Boii Mufflers +2"}
    sets.precast.JA['Retaliation'] = {feet="Boii Calligae +2", "Pumm. Mufflers +1"}
    sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +1", body="Agoge Lorica +3"}
    sets.precast.JA['Provoke'] = {
		ammo="Sapience Orb",
		head="Pumm. Mask +1",
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands="Pumm. Mufflers +1",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}},
		neck="Moonlight Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Begrudging Ring",
		right_ring="Eihwaz Ring",
		back="Mubvum. Mantle",
    }
     
    -- Magic sets
    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Sapience Orb",
		head="Sakpata's Helm",
		body={ name="Odyss. Chestplate", augments={'"Fast Cast"+4','Mag. Acc.+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet={ name="Odyssean Greaves", augments={'"Fast Cast"+4','DEX+9',}},
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Medada's Ring",
		back="Moonlight Cape",
    }
 
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
        ammo="Staunch Tathlum +1",
        legs="Jokushu Haidate",
    })
     
 
    --WS sets
     
    --General WS set
    sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Boii Cuisses +2",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Boii Earring +1",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }
     
    --Great Axe
    sets.precast.WS['Upheaval'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
    }
    sets.precast.WS['Upheaval'].Atk = set_combine(sets.precast.WS['Upheaval'], {    
		ammo="Knobkierrie",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Boii Cuisses +2",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},})
     
    -- sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS['Upheaval'], {})
     
    sets.precast.WS["Ukko's Fury"] = {
		ammo="Yetshila +1",
		head="Boii Mask +2",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +2",
		feet="Boii Calligae +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Boii Earring +1",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }
    sets.precast.WS["Ukko's Fury"].Atk = set_combine(sets.precast.WS["Ukko's Fury"], {})
     
    sets.precast.WS["King's Justice"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
    sets.precast.WS["King's Justice"].Atk = set_combine(sets.precast.WS["King's Justice"], {		
		ammo="Knobkierrie",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Boii Cuisses +2",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},})
     
    -- sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS["King's Justice"], {})
     
    sets.precast.WS["Raging Rush"] = sets.precast.WS["Ukko's Fury"]
    
	sets.precast.WS['Steel Cyclone'] = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Boii Mufflers +2",
		legs="Boii Cuisses +2",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
	sets.precast.WS['Metatron Torment'] = sets.precast.WS["King's Justice"]
    
	sets.precast.WS['Fell Cleave'] = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Boii Mufflers +2",
		legs="Boii Cuisses +2",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
     
    sets.precast.WS['Full Break'] = {
		ammo="Pemphredo Tathlum",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Boii Cuisses +2",
		feet="Sakpata's Leggings",
		neck="Moonlight Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Digni. Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back="Moonlight Cape",
    }
     
    sets.precast.WS['Armor Break'] = sets.precast.WS['Full Break']
    sets.precast.WS['Weapon Break'] = sets.precast.WS['Full Break']
    sets.precast.WS['Shield Break'] = sets.precast.WS['Full Break']
    sets.precast.WS['Disaster'] = sets.precast.WS["King's Justice"]
     
    --Axe
    sets.precast.WS['Decimation'] = {
	    ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}
    
	
	sets.precast.WS['Ruinator'] = sets.precast.WS['Decimation']
    
	sets.precast.WS['Mistral Axe'] = {
	    ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Boii Mufflers +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
	
	sets.precast.WS['Bora Axe'] = sets.precast.WS["King's Justice"]
    
	sets.precast.WS['Calamity'] = {
	    ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Boii Mufflers +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
	sets.precast.WS['Smash Axe'] = sets.precast.WS['Full Break']
     
    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })
     
    sets.precast.WS['Rampage'] = {
        ammo="Yetshila +1",
        head="Boii Mask +3",
        body="Sakpata's Breastplate",
        hands="Sakpata's Gauntlets",
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        right_ear="Boii Earring +1",
        left_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
     
    --Great Sword
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {left_ring="Sroda Ring"})  
    sets.precast.WS['Groundstrike'] = sets.precast.WS["King's Justice"]
    sets.precast.WS['Shockwave'] = sets.precast.WS['Full Break']
     
    --Scythe
    sets.precast.WS['Spiral Hell'] = sets.precast.WS["King's Justice"]
    -- sets.precast.WS['Entropy'] = sets.precast.WS
     
    sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Pixie Hairpin +1",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Archon Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })
     
    sets.precast.WS['Infernal Scythe'] = sets.precast.WS['Shadow of Death']
     
    --Staff
    sets.precast.WS['Retribution'] = sets.precast.WS["King's Justice"]
    sets.precast.WS['Cataclysm'] = sets.precast.WS['Shadow of Death']
    sets.precast.WS['Shell Crusher'] = sets.precast.WS['Full Break']
     
    --Sword
    sets.precast.WS['Savage Blade'] = {    
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Boii Mufflers +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
	sets.precast.WS['Savage Blade'].Atk = {
			ammo="Knobkierrie",
			head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
			body="Sakpata's Breastplate",
			hands="Sakpata's Gauntlets",
			legs="Boii Cuisses +2",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +2", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
			right_ear="Thrud Earring",
			left_ring="Niqmaddu Ring",
			right_ring="Epaminondas's Ring",
			back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    -- sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
     
    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Rampage']
    sets.precast.WS['Sanguine Blade'] = sets.precast.WS['Shadow of Death']
    sets.precast.WS['Flat Blade'] = sets.precast.WS['Full Break']
     
    --Club
    sets.precast.WS['Judgment'] = {    
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
	sets.precast.WS['Black Halo'] = sets.precast.WS["King's Justice"]
    sets.precast.WS['Hexa Strike'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Brainshaker'] = sets.precast.WS['Full Break']
    sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {left_ear="Schere Earring", right_ear="Thrud Earring", back=gear.CicholWSD})
 
    --Dagger
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Cloudsplitter']
    sets.precast.WS['Evisceration'] = sets.precast.WS['Rampage']
    -- sets.precast.WS['Extenterator'] = sets.precast.WS
 
    --Polearm
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS["King's Justice"], {
        ammo="Yetshila +1", 
        head="Blistering Sallet +1", 
        feet="Boii Calligae +3",
        left_ring="Lehko Habhoka's Ring",
    })
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1", 
        head="Blistering Sallet +1", 
        feet="Boii Calligae +3",
        left_ring="Lehko Habhoka's Ring",
    })
    sets.precast.WS['Leg Sweep'] = sets.precast.WS['Full Break']
    sets.precast.WS['Sonic Thrust'] = sets.precast.WS["King's Justice"]
     
    --H2H 
    sets.precast.WS['Combo'] = set_combine(sets.precast.WS, {neck="Warrior's Bead Necklace +2", waist="Sailfi Belt +1"})
    sets.precast.WS['Shoulder Tackle'] = sets.precast.WS['Full Break']
    sets.precast.WS['Dragon Kick'] = sets.precast.WS['Combo']
    sets.precast.WS['Tornado Kick'] = sets.precast.WS['Combo']
    sets.precast.WS['Raging Fists'] = sets.precast.WS['Combo']
    sets.precast.WS['Asuran Fists'] = sets.precast.WS['Realmrazer']
     
    --Other
    --no longer needed after master levels, the pretarget parts are also untested
    -- sets.pretarget.WS['Blade: Ei'] = {neck="Yarak Torque"}
    -- sets.precast.WS['Blade: Ei'] = {neck="Yarak Torque"}
    -- sets.pretarget.WS['Tachi: Jinpu'] = {neck="Agelast Torque"}
    -- sets.precast.WS['Tachi: Jinpu'] = {neck="Agelast Torque"}
    -- sets.pretarget.WS['Tachi: Koki'] = {head="Kengo Hachimaki", neck="Agelast Torque"}
    -- sets.precast.WS['Tachi: Koki'] = {head="Kengo Hachimaki", neck="Agelast Torque"}
     
    sets.MS = {
        ammo="Yetshila +1",
        feet="Boii Calligae +2",
    }
 
     
--Idle Sets
 
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }
 
    sets.idle.Regen = { 
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Bathy Choker +1",
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Karieyh Ring +1",
		back="Moonlight Cape",
    }
     
    sets.idle.Town = set_combine(sets.idle, {feet="Hermes' Sandals"})
    sets.idle.Field = sets.idle
    sets.idle.Weak = sets.idle
 
    --Damage Taken sets
     
    sets.defense.DT = {
        ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sacro Breastplate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Loricate Torque +1",
        waist="Ioskeha Belt +1",
        left_ear="Genmei Earring",
        right_ear="Odnowa Earring +1",
        left_ring=gear.ChirichL,
        right_ring=gear.ChirichR,
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }
     
    sets.defense.Reraise = set_combine(sets.defense.DT, {
        head="Twilight Helm",
        body="Twilight Mail",
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
    })
     
    --TP sets
    sets.engaged.Twohand = {
		ammo="Coiste Bodhar",
		head="Boii Mask +2",
		body="Boii Lorica +2",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear="Boii Earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    }


    --Dual Wield TP sets  --add dw fighters roll set
    sets.engaged.DW = set_combine(sets.engaged, {
		ammo="Coiste Bodhar",
		head="Boii Mask +2",
		body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Boii Earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    })

     
    sets.engaged.Single = set_combine(sets.engaged, {
		ammo="Coiste Bodhar",
		head="Boii Mask +2",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear="Boii Earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
    })

	sets.engaged.Hybrid = {}
 
    sets.Kiting = {feet="Hermes' Sandals"}
     
    sets.buff.Doom = {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		left_ring="Eshmun's Ring",
		right_ring="Eshmun's Ring",
        }
 
end
 
 
 

 
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end
 
-- Modify the default idle set after it was constructed.

function job_post_precast(spell, action, spellMap, eventArgs)  
    if spell.type == 'WeaponSkill' then
        if buffactive["Mighty Strikes"] then
            equip(sets.MS)
        elseif areas.Abyssea:contains(world.area) and abyprocws:contains(spell.english) then
            equip(gear.empty)
        end
    end

end
     

 

 
--prevents gearinfo from overriding a piece of gear you are trying to use
function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("left_ring")
    else
        enable("left_ring")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("right_ring")
    else
        enable("right_ring")
    end
    if no_swap_gear:contains(player.equipment.waist) then
        disable("waist")
    else
        enable("waist")
    end
end
 
windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("left_ring")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("right_ring")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.waist) then
            enable("waist")
            equip(sets.idle)
        end
    end
)
 

