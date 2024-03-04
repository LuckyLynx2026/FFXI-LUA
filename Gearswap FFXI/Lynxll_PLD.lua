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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD')
    state.PhysicalDefenseMode:options('PDT', 'HP')
    state.MagicalDefenseMode:options('MDT', 'HP')
    state.IdleMode:options('Normal', 'Refresh')
     
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
     
    gear.MoonlightL = {name="Moonlight Ring", bag="wardrobe3"}
    gear.MoonlightR = {name="Moonlight Ring", bag="wardrobe4"} 
    
	target_distance = 5.5 -- Set Default Distance Here --
 
    update_defense_mode()
     
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')
    send_command('bind @f12 gs c cycle CastingMode')
 
    select_default_macro_book()
end
 
function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
    send_command('unbind @f12')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
     
    -- Fast cast sets for spells
     
    sets.precast.FC = {    
		ammo="Sapience Orb",
		head="Carmine Mask +1",
		body="Rev. Surcoat +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Voltsurge Torque",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Medada's Ring",
		right_ring="Kishar Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
     
    --Enmity
 
    sets.precast.Enmity = {    
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +1",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Supershear Ring",
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.precast.Enmity, {legs="Caballarius Breeches +3"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.Enmity, {feet="Reverence Leggings +2"})
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.Enmity, {hands="Cab. Gauntlets +3",ear2="Knightly Earring"})
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.Enmity, {feet="Caballarius Leggings +3"})
    sets.precast.JA['Rampart'] = set_combine(sets.precast.Enmity, {head="Caballarius Coronet +3"})
    sets.precast.JA['Fealty'] = set_combine(sets.precast.Enmity, {body="Caballarius Surcoat +3"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.Enmity, {feet="Chevalier's Sabatons +1"})
    sets.precast.JA['Sepulcher'] = sets.precast.Enmity
    sets.precast.JA['Palisade'] = sets.precast.Enmity
    sets.precast.JA['Cover'] = set_combine(sets.precast.Enmity, {head="Reverence Coronet +2"})
 
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {    
		ammo="Hydrocera",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Cab. Gauntlets +3", augments={'Enhances "Chivalry" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Phalaina Locket",
		waist="Rumination Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring +1",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
     
    -- /WAR
    sets.precast.JA['Provoke'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Berserk'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Warcry'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Aggressor'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Defender'] = set_combine(sets.precast.Enmity, {})
     
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
     
    sets.precast.Step = {}
         
    sets.precast.Flourish1 = {}
 
   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
     
    sets.precast.WS = {    
		ammo="Aurgelmir Orb +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},}
 
    sets.precast.WS.Acc = {    
		ammo="Aurgelmir Orb +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},}
 
     
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ammo="Hydrocera",
		ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Petrov Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},})
    
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {    
		ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Petrov Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},})
     
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {    
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Begrudging Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},})
    
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {    
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Begrudging Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},})
     
    sets.precast.WS['Atonement'] = {    
		ammo="Sapience Orb",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Fotia Belt",
		left_ear="Cryptic Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
         
    sets.precast.WS['Savage Blade'] = {    
		ammo="Aurgelmir Orb +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},}    
     
    sets.precast.WS['Circle Blade'] = {}
         
         
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    sets.midcast.FastRecast = {}
         
    sets.midcast.Enmity = set_combine(sets.precast.Enmity, {})
     
    sets.midcast.SIRD = {
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body="Chev. Cuirass +2",
		hands="Regal Gauntlets",
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet={ name="Odyssean Greaves", augments={'"Fast Cast"+4','DEX+9',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Knightly Earring",
		right_ear="Magnetic Earring",
		left_ring="Moonlight Ring",
		right_ring="Evanescence Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
 
    sets.midcast.Flash = {
	    ammo="Sapience Orb",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body="Sacro Breastplate",
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
    
	sets.midcast.Flash.SIRD = {
	    ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body="Chev. Cuirass +2",
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
     
    sets.midcast.Stun = set_combine(sets.midcast.Enmity, {})
    sets.midcast.Stun.SIRD = set_combine(sets.midcast.Stun, sets.midcast.SIRD)
     
    sets.midcast.Cure = {    
		ammo="Staunch Tathlum +1",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands="Regal Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +2",
		neck="Phalaina Locket",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
    
	sets.midcast.Cure.SIRD = {    
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands="Regal Gauntlets",
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet={ name="Odyssean Greaves", augments={'"Fast Cast"+4','DEX+9',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Knightly Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
 
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.Enmity, {})
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.midcast.SIRD)
    sets.midcast['Blue Magic']['Wild Carrot'] = set_combine(sets.midcast.Enmity, sets.midcast.Cure)
    sets.midcast['Blue Magic']['Wild Carrot'].SIRD = set_combine(sets.midcast['Blue Magic']['Wild Carrot'], sets.midcast.SIRD)
     
    sets.midcast['Enhancing Magic'] = {    
		ammo="Sapience Orb",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
    
	sets.midcast['Enhancing Magic'].SIRD = {
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
    
	sets.midcast['Phalanx'] = {    
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body="Chev. Cuirass +2",
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back={ name="Weard Mantle", augments={'VIT+1','DEX+4','Enmity+3','Phalanx +4',}},}
    
	
	sets.midcast['Phalanx'].SIRD = {
	    ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body="Chev. Cuirass +2",
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}},
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Knightly Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Weard Mantle", augments={'VIT+1','DEX+4','Enmity+3','Phalanx +4',}},}
	
	
	sets.midcast.Protect = {
		ammo="Sapience Orb",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
    
	sets.midcast.Protect.SIRD = {
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
    
	sets.midcast.Shell = {
		ammo="Sapience Orb",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
    
	sets.midcast.Shell.SIRD = {
		ammo="Sapience Orb",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body="Shab. Cuirass +1",
		hands="Regal Gauntlets",
		legs={ name="Founder's Hose", augments={'MND+4','Mag. Acc.+3',}},
		feet="Chev. Sabatons +2",
		neck="Moonlight Necklace",
		waist="Rumination Sash",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}
     
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    sets.Reraise = {}
     
    sets.resting = {}
     
 
    -- Idle sets
    sets.idle = {    
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs="Chev. Cuisses +2",
		feet="Rev. Leggings +2",
		neck="Combatant's Torque",
		waist="Carrier's Sash",
		left_ear="Thureous Earring",
		right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
 
    sets.idle.Refresh = {
	    ammo="Homiliary",
		head="Chev. Armet +2",
		body="Rev. Surcoat +2",
		hands="Regal Gauntlets",
		legs="Chev. Cuisses +2",
		feet="Rev. Leggings +2",
		neck="Coatl Gorget +1",
		waist="Fucho-no-Obi",
		left_ear="Thureous Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
 
    sets.idle.Town = {    
		ammo="Staunch Tathlum +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body="Sacro breastplate",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Thureous Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
     
    sets.idle.Weak = {}
     
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
     
    sets.Kiting = {legs="Carmine Cuisses +1"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
 
    --------------------------------------
    -- Defense sets
    --------------------------------------
     
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.MP = {ammo="Homiliary",feet="Rev. leggings +2",waist="Flume Belt"} --Chev. Armet +1

     
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"}
    sets.MagicalShield = {sub="Aegis"}
 
    -- Basic defense sets.
         
    sets.defense.PDT = {    
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Chev. Cuisses +2",
		feet="Sakpata's Leggings",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
    
	sets.defense.HP = {    
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Chev. Cuisses +2",
		feet="Sakpata's Leggings",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}

    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {   
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Cryptic Earring",
		left_ring="Purity Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},}
 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
     
    sets.engaged = {    
		ammo="Aurgelmir Orb +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Combatant's Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}
 
    sets.engaged.Acc = {    
		ammo="Aurgelmir Orb +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Combatant's Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}
 
    sets.engaged.DW = {
	    ammo="Aurgelmir Orb +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Combatant's Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}
 
    sets.engaged.DW.Acc = {
	    ammo="Aurgelmir Orb +1",
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Sakpata's Leggings",
		neck="Combatant's Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}
 
    sets.engaged.PDT = {
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +2",
		body={ name="Sakpata's Plate", augments={'Path: A',}},
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs="Chev. Cuisses +2",
		feet="Sakpata's Leggings",
		neck="Combatant's Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cryptic Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring=gear.MoonlightL,
        right_ring=gear.MoonlightR,
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}
     
    sets.engaged.Acc.PDT = sets.engaged.PDT
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)
 
    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT, {ear1="Suppanomimi"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.PDT, {ear1="Dudgeon Earring",ear2="Heartseeker Earring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)
 
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
    sets.buff.Doom = {    
		legs="Shabti Cuisses",
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		left_ring="Eshmun's Ring",
		right_ring="Eshmun's Ring",}
    
	sets.buff.Cover = {head="Reverence Coronet +2", body="Caballarius Surcoat +1"}
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" and player.status == 'Engaged' and spell.target.distance > target_distance then -- Cancel WS If You Are Out Of Range --
       eventArgs.cancel=true
       add_to_chat(123, spell.name..' Canceled: [Out of Range]')
       return
    end
end
 
 
function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's state changes (e.g. Normal to Acc Engaged mode).
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end
 
    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
     
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end
 
-- Called when status changes (Idle to Engaged, Resting, etc.)
function job_status_change(newStatus, oldStatus, eventArgs)
    update_defense_mode()
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if world.area:contains('Adoulin') then
        idleSet = set_combine(idleSet, {body="Councilor's Garb"})
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
     
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
     
    return meleeSet
end
 
function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
     
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
     
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
     
    return defenseSet
end
 
 
function display_current_job_state(eventArgs)
    local msg = 'Melee'
     
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
     
    msg = msg .. ': '
     
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
     
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
 
    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
     
    msg = msg .. ', Casting: ' .. state.CastingMode.value
     
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
     
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
 
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
 
    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
 
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'tds' then
        local newTargetDistance = tonumber(cmdParams[2])
        if not newTargetDistance then
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
            return
        end
        if newTargetDistance > 0 then
            target_distance = newTargetDistance
            add_to_chat(122, '[Weaponskill max range set to '..newTargetDistance..' yalms.]')
        else
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
        end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_defense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(12, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(6, 1)
    elseif player.sub_job == 'SAM' then
        set_macro_page(7, 1)
    elseif player.sub_job == 'RNG' then
        set_macro_page(8, 1)
    elseif player.sub_job == 'PLD' then
        set_macro_page(9, 1)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'SCH' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'DRK' then
        set_macro_page(5, 5)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 1)
    else
        set_macro_page(1, 7)  --BRD
    end
end