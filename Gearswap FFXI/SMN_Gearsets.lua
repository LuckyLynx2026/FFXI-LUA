-- Setup your Key Bindings here:  
    windower.send_command('bind f7 gs c toggle mb')
    windower.send_command('bind f9 gs c avatar mode')
    windower.send_command('bind f10 gs c toggle auto')
    windower.send_command('bind f12 gs c toggle melee')
    
    include('organizer-lib') 
-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        -- leave this empty
    sets.avatar = {}    -- leave this empty
      
    -- Your idle set when you DON'T have an avatar out
    sets.me.idle = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Beckoner's horn +1",
		body="Apogee dalmatica +1",
		hands="Asteria Mitts +1",
		legs="Assiduity pants +1",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		feet="Baaya. Sabots +1",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		right_ear="Lugalbanda earring",
		left_ear="C. Palug Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back="Moonlight cape",
    }
      
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
		main="Chatoyant Staff",
		sub="Mensch Strap",
		ammo="Hydrocera",
		head="Inyanga Tiara +2",
		body="Apogee dalmatica +1",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2",
		neck="Sanctity Necklace",
		waist="Luminary sash",
		right_ear="Lugalbanda earring",
		left_ear="C. Palug Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back="Moonlight cape",
    }
      
    -----------------------
    -- Perpetuation Related
    -----------------------
      
    -- Avatar's Out --  
    -- This is the base for all perpetuation scenarios, as seen below
    sets.avatar.perp = {
		main="Nirvana",
		sub="Mensch Strap",
		ammo="Sancus Sachet +1",
		head="Beckoner's horn +1",
		body="Apogee dalmatica +1",
		hands="Asteria mitts +1",
		legs="Assiduity pants +1",
		feet="Baayami Sabots +1",
		neck="Smn. Collar +2",
		waist="Lucidity Sash",
		right_ear="Evans Earring",
		left_ear="C. Palug Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evoker's Ring",
		back="Moonlight cape",
    }
  
    -- The following sets base off of perpetuation, so you can consider them idle sets.
    -- Set the relevant gear, bearing in mind it will overwrite the perpetuation item for that slot!
    sets.avatar["Carbuncle"] = {hands="Asteria Mitts +1"}
    sets.avatar["Cait Sith"] = {hands="Lamassu Mitts +1"}
    -- When we want our avatar to stay alive
    sets.avatar.tank = set_combine(sets.avatar.perp,{
		main={ name="Nirvana", augments={'Path: A',}},
		sub="Mensch Strap",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands="Baayami Cuffs +1",
		legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},
		feet="Baaya. Sabots +1",
		neck="Empath Necklace",
		waist="Isa Belt",
		left_ear="Handler's Earring +1",
		right_ear="Handler's Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evoker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    })
      
    -- When we want our avatar to shred
    sets.avatar.melee = set_combine(sets.avatar.perp,{
		main={ name="Nirvana", augments={'Path: A',}},
		sub="Mensch Strap",
		ammo="Sancus Sachet +1",
		head="Tali'ah Turban +2",
		body="Con. Doublet +3",
		hands={ name="Helios Gloves", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','Pet: "Dbl. Atk."+5',}},
		legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="C. Palug Earring",
		right_ear="Kyrene's Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evoker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    })
      
    -- When we want our avatar to hit
    sets.avatar.acc = set_combine(sets.avatar.perp,{
		main={ name="Nirvana", augments={'Path: A',}},
		sub="Mensch Strap",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		body="Con. Doublet +3",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +2",
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck={ name="Smn. Collar +2", augments={'Path: A',}},
		waist="Klouskap Sash +1",
		left_ear="C. Palug Earring",
		right_ear="Kyrene's Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    })
    
    ----------------------------
    -- Summoning Skill Related
    -- Including all blood pacts
    ----------------------------
      
    -- + Summoning Magic. This is a base set for max skill and blood pacts and we'll overwrite later as and when we need to
    sets.avatar.skill = {
		ammo="Sancus Sachet +1",
		head="Beckoner's horn +1",
		hands="Lamassu Mitts +1",
		legs="Baayami Slops +1",
		feet="Baayami Sabots +1",
		neck="Incanter's torque",
		waist="Kobo Obi",
		right_ear="Andoaa Earring",
		left_ear="Lodurr earring",
		left_ring="Stikini Ring +1",
		right_ring="Evoker's Ring",
		back="Conveyance Cape",
    }
      
    -------------------------
    -- Individual Blood Pacts
    -------------------------
      
    -- Physical damage
    sets.avatar.atk = set_combine(sets.avatar.skill,{
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		body="Con. Doublet +3",
		hands="Merlinic dastanas",
		legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Smn. Collar +2",
		waist="Incarnation Sash",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda earring",
		left_ring="Varar Ring +1",
		right_ring="C. Palug Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    })
    sets.avatar.pacc = set_combine(sets.avatar.atk,{
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		body="Con. Doublet +3",
		hands="Merlinic dastanas",
		legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Smn. Collar +2",
		waist="Incarnation Sash",
		left_ear="Kyrene's Earring",
		right_ear="Lugalbanda earring",
		left_ring="Varar Ring +1",
		right_ring="C. Palug Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    })
      
    -- Magic Attack
    sets.avatar.mab = set_combine(sets.avatar.skill,{
		main={ name="Grioavolr", augments={'Spell interruption rate down -3%','Pet: STR+7','Pet: Mag. Acc.+22','Pet: "Mag.Atk.Bns."+20',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Blood Pact Dmg.+10','Pet: Mag. Acc.+7',}},
		legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck={ name="Smn. Collar +2", augments={'Path: A',}},
		waist="Regal Belt",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','Pet: "Regen"+10',}},
    })
    sets.avatar.mb = set_combine(sets.avatar.mab,{hands="Glyphic Bracers +1"})
    -- Hybrid
    sets.avatar.hybrid = set_combine(sets.avatar.skill,{
		main={ name="Nirvana", augments={'Path: A',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Blood Pact Dmg.+10','Pet: Mag. Acc.+7',}},
		legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck={ name="Smn. Collar +2", augments={'Path: A',}},
		waist="Regal Belt",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    })
      
    -- Magic Accuracy
    sets.avatar.macc = set_combine(sets.avatar.skill,{
		main={ name="Grioavolr", augments={'Magic burst dmg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		body="Apogee dalmatica +1",
		hands="Merlinic dastanas",
		legs="Tali'ah Sera. +2",
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Smn. Collar +2",
		waist="Regal Belt",
		right_ear="Lugalbanda earring",
		left_ear="Gelos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','Pet: "Regen"+10',}},
    })
      
    -- Buffs
    sets.avatar.buff = set_combine(sets.avatar.skill,{})
      
    -- Other
    sets.avatar.other = set_combine(sets.avatar.skill,{})
      
    -- Combat Related Sets
      
    -- Melee
    -- The melee set combines with perpetuation, because we don't want to be losing all our MP whilst we swing our Staff
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
    sets.me.melee = set_combine(sets.avatar.perp,{
		main="Nirvana",
		sub="Mensch Strap",
		ammo="Hasty Pinion +1",
		head="Tali'ah Turban +2",
		body={ name="Glyphic Doublet +1", augments={'Reduces Sp. "Blood Pact" MP cost',}},
		hands="Tali'ah Gages +2",
		legs="Tali'ah Sera. +2",
		feet="Tali'ah Crackows +2",
		neck="Combatant's Torque",
		waist="Klouskap Sash +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Chirich Ring +1",
		right_ring="Petrov Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    })
      
    -- Shattersoul. Weapon Skills do not work off perpetuation as it only stays equipped for a moment
    sets.me["Shattersoul"] = {
		main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Merlinic Hood",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		hands={ name="Psycloth Manillas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
		legs="Inyanga Shalwar +2",
		feet="Merlinic Crackows",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear="Malignance earring",
		left_ring="Shiva Ring +1",
		right_ring="Freke ring",
		back="Solemnity cape",
    }
    sets.me["Garland of Bliss"] = {
		main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Merlinic Hood",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		hands={ name="Psycloth Manillas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
		legs="Gyve Trousers",
		feet="Merlinic Crackows",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Malignance earring",
		right_ear="Friomisi Earring",
		left_ring="Freke ring",
		right_ring="Arvina Ringlet +1",
		back="Izdubar Mantle",
    }
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ---------------
    -- Casting Sets
    ---------------
      
    sets.precast = {}
    sets.midcast = {}
    sets.aftercast = {}
      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
		ammo="Sapience orb",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body="Inyanga Jubbah +2",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Voltsurge torque",
		waist="Witful Belt",
		left_ear="Malignance earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Kishar ring",
		back="Swith Cape +1",
    }   
      
    -- Summoning Magic Cast time - gear
    sets.precast.summoning = set_combine(sets.precast.casting,{
		ammo="Sancus Sachet +1",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body="Baayami robe +1",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Voltsurge torque",
		waist="Witful Belt",
		left_ear="Malignance earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Kishar ring",
		back="Swith Cape +1",
    })
      
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
		waist="Siegel Sash",
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
		head="Umuthi Hat",
		waist="Siegel Sash",
		legs="Doyen pants",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		main={ name="Serenity", augments={'MP+45','Enha.mag. skill +9','"Cure" potency +4%','"Cure" spellcasting time -8%',}},
		sub="Clerisy Strap",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		right_ear="Mendi. Earring",
		left_ear="Malignance earring",
		legs="Doyen pants",
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------
      
    -- Blood Pact Ability Delay
    sets.precast.bp = {
		ammo="Sancus Sachet +1",
		head="Beckoner's horn +1",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baaya. Sabots +1",
		neck="Incanter's Torque",
		waist="Lucidity Sash",
		left_ear="Lodurr Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evoker's Ring",
		back="Conveyance Cape",
    }
      
    -- Mana Cede
    sets.precast["Mana Cede"] = {
		hands="Beck. Bracers +1",
    }
      
    -- Astral Flow  
    sets.precast["Astral Flow"] = {
		head={ name="Glyphic Horn +1", augments={'Enhances "Astral Flow" effect',}},
    }
      
    ----------
    -- Midcast
    ----------
      
    -- We handle the damage and etc. in Pet Midcast later
      
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
		ammo="Sancus Sachet +1",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body="Amalric Doublet +1",
		hands={ name="Psycloth Manillas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
		legs={ name="Lengo Pants", augments={'INT+7','Mag. Acc.+8','"Mag.Atk.Bns."+7',}},
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		waist="Austerity Belt +1",
		left_ring="Evanescence Ring",
		right_ring="Prolix Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+3 Attack+3','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}},
    }
      
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
		head="Telchine cap",
		hands="Telchine gloves",
		neck="Incanter's torque",
		legs="Telchine braconi",
		feet="Telchine pigaches",
		waist="Olympus Sash",
		right_ear="Augmenting earring",
		left_ear="Andoaa Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
    })
      
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		waist="Siegel Sash",
		right_ear="Earthcry Earring",neck="Nodens Gorget",
    })
    -- Elemental Siphon, eg, Tatsumaki Thingies, Esper Stone, etc
    sets.midcast.siphon = set_combine(sets.avatar.skill,{
		ammo="Sancus Sachet +1",
		head="Baayami Hat",
		body="Baayami Robe +1",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baaya. Sabots +1",
		neck="Incanter's Torque",
		waist="Lucidity Sash",
		left_ear="C. Palug Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evoker's Ring",
		back="Conveyance Cape",
    })
        
    -- Cure Potency
    sets.midcast.cure = set_combine(sets.midcast.casting,{
		main={ name="Serenity", augments={'MP+45','Enha.mag. skill +9','"Cure" potency +4%','"Cure" spellcasting time -8%',}},
		sub="Curatio Grip",
		ammo="Hydrocera",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body="Amalric Doublet +1",
		hands="Inyanga Dastanas +2",
		legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Locket",
		waist="Luminary sash",
		left_ear="Mendi. Earring",
		right_ear="Roundel Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe2"},
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		back="Oretan. Cape +1",
    })
      
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have an avatar out?
  
end
