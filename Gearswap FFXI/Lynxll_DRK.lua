-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('CaladPre', 'CaladAM3', 'LibPre', 'LibAM3', 'LibAcc', 'Apoc', 'Hybrid', 'SW')
    state.HybridMode:options ('Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
     
    select_default_macro_book()
 
     
 
end
 
    -- Define sets and vars used by this job file.
    function init_gear_sets()
            --------------------------------------
            -- Start defining the sets
            --------------------------------------
            -- Precast Sets
            sets.WSDayBonus = {head="Gavialis Helm"}
 
            -- Precast sets to enhance JAs
            sets.precast.JA['Diabolic Eye'] = {hands="Fallen's finger gauntlets +3"}
            sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +1"}
            sets.precast.JA['Nether Void'] = {legs="Heathen's Flanchard +1"}
            sets.precast.JA['Souleater'] = {head="Ignominy Burgeonet +1"}
            sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +1"}
            sets.precast.JA['Last Resort'] = {back="Ankou's Mantle",feet="Fallen's Sollerets"}
            sets.precast.JA['Dark Seal'] = {head="Fallen's Burgeonet +3"}
            sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +3"}
 
             
           -- Waltz set (chr and vit)
    sets.precast.Waltz = {}        
            
            -- Fast cast sets for spells
                      
            -- Precast Sets
    sets.precast.FC = {    
		ammo="Sapience Orb",
		head="Carmine Mask +1",
		body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Odyssean Greaves", augments={'"Fast Cast"+4','DEX+9',}},
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Malignance Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Kishar Ring",
		right_ring="Medada's Ring",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
                    
            -- Specific spells
    sets.midcast.Utsusemi = {}
      
    sets.midcast.DarkMagic = {    
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear="Digni. Earring",
		left_ring="Medada's Ring",
		right_ring="Stikini Ring +1",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
             
    sets.midcast.Endark = {    
		ammo="Pemphredo Tathlum",
		head="Igno. Burgeonet +1",
		body={ name="Carm. Sc. Mail +1", augments={'HP+80','STR+12','INT+12',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet="Rat. Sollerets +1",
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear="Digni. Earring",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring +1",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
             
    sets.midcast['Endark II'] = sets.midcast.Endark
            
    sets.midcast['Dread Spikes'] = {    
		ammo="Aqreqaq Bomblet",
		head="Ratri Sallet +1",
		body="Ratri Plate",
		hands="Rat. Gadlings +1",
		legs="Ratri Cuisses +1",
		feet="Rat. Sollerets +1",
		neck="Unmoving Collar",
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Moonlight Ring",
		back="Moonlight Cape",}
             
    sets.midcast['Elemental Magic'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear="Digni. Earring",
		left_ring="Medada's Ring",
		right_ring="Stikini Ring +1",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
             
    sets.midcast['Enfeebling Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Carmine Mask +1",
		body="Ignominy Cuirass +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear="Digni. Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
            
    sets.midcast.Stun = {
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear="Digni. Earring",
		left_ring="Medada's Ring",
		right_ring="Stikini Ring +1",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
             
    sets.midcast.Absorb = {    
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Carm. Sc. Mail +1", augments={'HP+80','STR+12','INT+12',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Austerity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
                    
    sets.midcast.Drain = {    
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Carm. Sc. Mail +1", augments={'HP+80','STR+12','INT+12',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Austerity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
                    
    sets.midcast['Aspir'] = {    
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Carm. Sc. Mail +1", augments={'HP+80','STR+12','INT+12',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Austerity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
                 
    sets.midcast['Aspir II'] = {    
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Carm. Sc. Mail +1", augments={'HP+80','STR+12','INT+12',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Austerity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
             
 
    sets.midcast['Drain II'] = {    
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Carm. Sc. Mail +1", augments={'HP+80','STR+12','INT+12',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Austerity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
             
    sets.midcast['Drain III'] = {    
		ammo="Pemphredo Tathlum",
		head={ name="Fall. Burgeonet +3", augments={'Enhances "Dark Seal" effect',}},
		body={ name="Carm. Sc. Mail +1", augments={'HP+80','STR+12','INT+12',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Rat. Sollerets +1",
		neck="Erra Pendant",
		waist="Austerity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Ankou's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
 
                                            
            -- Weaponskill sets
            -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
 
            -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Catastrophe'] = {    
		ammo="Crepuscular Pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Catastrophe'].Acc = {    
		ammo="Crepuscular Pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Sanguine Blade'] = {
		}
      
    sets.precast.WS['Torcleaver'] = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ignominy Cuirass +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Torcleaver'].Acc = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ignominy Cuirass +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
    sets.precast.WS['Scourge'] = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
    sets.precast.WS['Scourge'].Acc = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
    sets.precast.WS['Savage Blade'] = {
	    ammo="Crepuscular Pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ignominy Cuirass +3",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
             
    sets.precast.WS['Requiescat'] = {
	    ammo="Crepuscular Pebble",
		head="Hjarrandi Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
             
    sets.precast.WS['Cross Reaper'] = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ignominy Cuirass +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Cross Reaper'].Acc = {
	    ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ignominy Cuirass +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Quietus'] = {    
		ammo="Crepuscular Pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Quietus'].Acc = {
	    ammo="Crepuscular Pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Entropy'] = {    
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ratri Cuisses +1",
		feet="Sakpata's Leggings",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Lugra Earring +1",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
                     
    sets.precast.WS['Entropy'].Acc = {
	    ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ratri Cuisses +1",
		feet="Sakpata's Leggings",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Lugra Earring +1",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
    sets.precast.WS['Insurgency'] = {    
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
                     
    sets.precast.WS['Insurgency'].Acc = {
	    ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
                     
    sets.precast.WS['Resolution'] = {    
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
                     
    sets.precast.WS['Resolution'].Acc = {    
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
                                
            -- Sets to return to when not performing an action.
            
            -- Resting sets
    sets.resting = {    
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
            
      
            -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    
	sets.idle.Town = {    
		main={ name="Caladbolg", augments={'Path: A',}},
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
	}
	
	sets.idle = {   
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
 
            -- Defense sets
    sets.defense.PDT = {    
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
      
    sets.defense.Reraise = {}
      
    sets.defense.MDT = {    
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
      
      
      
            -- Engaged sets
             
    sets.engaged.CaladPre = {    
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},}
             
    sets.engaged.CaladAM3 = {    
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Dagon Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear="Brutal Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},}
             
    sets.engaged.LibPre = {    
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear="Brutal Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},}
     
    sets.engaged.Hybrid = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}    
     
    sets.engaged.LibAM3 = {    
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
		}
     
    sets.engaged.LibAcc = {		
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},}
             
    sets.engaged.Apoc = {
	    ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear="Brutal Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}       
             
    sets.engaged.SW = {
	    ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Ig. Flanchard +3",
		feet="Flam. Gambieras +2",
		neck={ name="Abyssal Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},}
    
	sets.Kiting = {legs="Carmine cuisses +1"}
     
    end
     

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.midcast['Elemental Magic'], {waist="Hachirin-No-Obi"})
        end
    end
end
------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (skillchain_elements[spell.skillchain_a]:contains(world.day_element) or skillchain_elements[spell.skillchain_b]:contains(world.day_element) or skillchain_elements[spell.skillchain_c]:contains(world.day_element))
        then equip({head="Gavialis Helm"})
    end
end 
 
 
function job_post_midcast(spell, action, spellMap, eventArgs)
    if S{"Drain","Drain II","Drain III"}:contains(spell.english) and (spell.element==world.day_element or spell.element==world.weather_element) then
        equip({waist="Hachirin-no-obi"})
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    if buff:lower()=='sleep' then
        if gain and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
            equip({neck="Berserker's Torque"})
        elseif not gain then -- Take Berserker's off
            handle_equipping_gear(player.status)
        end
    end
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Sleep and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
        meleeSet = set_combine(meleeSet,{neck="Berserker's Torque"})
    end
    return meleeSet
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 9)
end