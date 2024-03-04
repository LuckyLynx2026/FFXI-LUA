-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:
        
        Magic Burst            Toggle Magic Burst Mode  [Alt-`]
        Death Mode            Casting and Idle modes that maximize MP pool throughout precast/midcast/idle swaps
        Capacity Pts. Mode    Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle        Automatically locks desired equipset on file load
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

    state.CP = M(false, "Capacity Points Mode")

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant', 'Spaekona', 'Occult')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')    
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}
    
    -- Additional local binds
	send_command('bind ^` input /ma Stun <t>')--;input /p <wstar> #1 Stun <t>, Articgun next. <wstar> <call14>') 
    send_command('bind !` gs c toggle MagicBurst')
	send_command('bind @d gs c toggle DeathMode')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')
    

    select_default_macro_book()
    set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @d')
    send_command('unbind @c')
    send_command('unbind @w')
    
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        feet="Wicce Sabots +1",
        back=gear.BLM_Death_Cape,
        }

    sets.precast.JA.Manafont = {body="Arch. Coat"}

    -- Fast cast sets for spells
    sets.precast.FC = {
		main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",
		ammo="Sapience orb",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Merlinic Crackows",
		neck="Voltsurge torque",
		waist="Witful Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Malignance earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back="Swith Cape +1",
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",
		ammo="Sapience orb",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body="Mallquis Saio +2",
		hands="Mallquis Cuffs +2",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Mallquis Clogs +1",
		neck="Stoicheion Medal",
		waist="Witful Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Malignance earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back="Swith Cape +1",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main={ name="Serenity", augments={'MP+45','Enha.mag. skill +9','"Cure" potency +4%','"Cure" spellcasting time -8%',}},
		sub="Clerisy Strap",
		ammo="Sapience orb",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		hands="Telchine Gloves",
		legs="Doyen Pants",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Voltsurge torque",
		waist="Witful Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Malignance earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back="Swith Cape +1",
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2="Levia. Ring +1", waist="Channeler's Stone"}) -- stop quick cast
    
    sets.precast.FC.DeathMode = {
		main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",
		ammo="Sapience orb",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Merlinic Crackows",
		neck="Voltsurge torque",
		waist="Witful Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Malignance earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back="Swith Cape +1",
        }

    sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {head=empty, body="Twilight Cloak"})

    -- Weaponskill sets
    
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Hasty Pinion +1",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','INT+9',}},
		feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +25',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh ring +1",
		right_ring="Epaminondas's Ring",
		back="Taranus's cape",
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Vidohunir'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Amalric Doublet +1",
		hands="Jhakri Cuffs +2",
		legs="Mallquis Trews +2",
		feet="Mallquis Clogs +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +25',}},
		right_ear="Ishvara Earring",
		left_ring="Freke ring",
		right_ring="Shiva Ring +1",
		back="Taranus's cape",
        } -- INT

    sets.precast.WS['Myrkr'] = {
		ammo="Hydrocera",
		head="Pixie Hairpin +1",
		body="Amalric Doublet +1",
		hands={ name="Psycloth Manillas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Psycloth Boots",
		neck="Sanctity necklace",
		waist="Luminary sash",
		left_ear="Regal earring",
		right_ear="Loquac. Earring",
		left_ring="Jhakri ring",
		right_ring="Mephitas's Ring +1",
		back="Taranus's cape",
        } -- Max MP

    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
		ammo="Pemphredo Tathlum",
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body="Amalric Doublet +1",
		hands={ name="Psycloth Manillas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Sanctity Necklace",
		waist="Witful Belt",
		left_ear="Mendi. Earring",
		right_ear="Malignance earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back="Swith Cape +1",
        } -- Haste

    sets.midcast.Cure = {
		main="Gada",
		sub="Ammurapi shield",
		ammo="Esper Stone +1",
		head="Vanya Hood",
		body="Amalric Doublet +1",
		hands="Telchine Gloves",
		legs="Gyve Trousers",
		feet="Merlinic Crackows",
		neck="Incanter's torque",
		waist="Luminary sash",
		left_ear="Mendi. Earring",
		right_ear="Regal earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure)

    
	sets.midcast.Cursna = set_combine(sets.midcast.Cure,{
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		waist="Gishdubar Sash",
		right_ring="Ephedra Ring",
		left_ring="Haoma's ring",
		back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
		main="Gada",
		sub="Ammurapi shield",
		ammo="Impatiens",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body="Telchine Chasuble",
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Incanter's torque",
		waist="Olympus Sash",
		left_ear="Augment. Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Swith Cape +1",
        }

    sets.midcast.EnhancingDuration = {}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
		sub="Ammurapi shield",
        })
    
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		waist="Gishdubar Sash",
        })
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		right_ear="Earthcry Earring",
		neck="Nodens Gorget",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		head="Amalric Coif",
		})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring1="Sheltered Ring",
        })
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
		main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Merlinic Hood",
		body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
		hands="Mallquis Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Fast Cast"+3','MND+2','"Mag.Atk.Bns."+13',}},
		feet="Mallquis Clogs +1",
		neck="Sanctity Necklace",
		waist="Luminary sash",
		left_ear="Malignance earring",
		right_ear="Regal earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back="Taranus's cape",
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Merlinic Hood",
		body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
		hands="Mallquis Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Fast Cast"+3','MND+2','"Mag.Atk.Bns."+13',}},
		feet="Mallquis Clogs +1",
		neck="Sanctity Necklace",
		waist="Sacro Cord",
		left_ear="Malignance earring",
		right_ear="Regal earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back="Taranus's cape",
        }) -- INT/Magic accuracy
        
    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {
		main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Ea Slops",
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Etiolation Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evanescence Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body={ name="Amalric Doublet", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		legs="Ea Slops",
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Hirudinea Earring",
		right_ear="Etiolation Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Evanescence Ring",
		back="Perimede Cape",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Death = {
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Elan Strap +1",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands="Spae. Gloves +3",
		legs={ name="Arch. Tonban +3", augments={'Increases Elemental Magic debuff time and potency',}},
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast.Death.Resistant = set_combine(sets.midcast.Death, {
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Elan Strap +1",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands="Spae. Gloves +3",
		legs={ name="Arch. Tonban +3", augments={'Increases Elemental Magic debuff time and potency',}},
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
        })

    sets.midcast.Death.Occult = set_combine(sets.midcast.Death, {})

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Elan Strap +1",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands="Spae. Gloves +3",
		legs={ name="Arch. Tonban +3", augments={'Increases Elemental Magic debuff time and potency',}},
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Elan Strap +1",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands="Spae. Gloves +3",
		legs={ name="Arch. Tonban +3", augments={'Increases Elemental Magic debuff time and potency',}},
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
        })
            
    sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
        sub="Enki Strap",
        body="Spaekona's Coat +1",
        })

    sets.midcast['Elemental Magic'].Occult = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        sub="Niobid Strap",
        head=empty,
        body="Twilight Cloak",
        })

    sets.midcast.Impact.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        sub="Enki Strap",
        head=empty,
        body="Twilight Cloak",
        })

    sets.midcast.Impact.Occult = set_combine(sets.midcast.Impact, {})

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC
    
    sets.resting = {    
		main="Chatoyant Staff",
		sub="Mensch Strap +1",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Shamash Robe",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Bathy Choker +1",
		waist="Fucho-no-Obi",
		left_ear="Magnetic Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonlight Cape",
        }

    -- Idle sets
    
    sets.idle = {
		main="Mpaca's Staff",
		sub="Mensch Strap +1",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Shamash Robe",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Assid. Pants +1",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Fucho-no-Obi",
		left_ear="Halasz Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",
        }

    sets.idle.DT = set_combine(sets.idle, {
		main="Mpaca's Staff",
		sub="Mensch Strap +1",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Shamash Robe",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Fucho-no-Obi",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",
        })

    sets.idle.ManaWall = {
        feet="Wicce Sabots +1",
        }

    sets.idle.DeathMode = {
        }

    sets.idle.Town = set_combine(sets.idle, {
		main="Mpaca's Staff",
		sub="Mensch Strap +1",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Ea Slops",
		feet="Herald's Gaiters",
		neck="Mizu. Kubikazari",
		waist="Orpheus's Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
        })

    sets.idle.Weak = sets.idle.DT
        
    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.magic_burst = { 
		main={ name="Marin Staff +1", augments={'Path: A',}},
		sub="Elan Strap +1",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands="Spae. Gloves +3",
		legs={ name="Arch. Tonban +3", augments={'Increases Elemental Magic debuff time and potency',}},
		feet={ name="Arch. Sabots +3", augments={'Increases Aspir absorption amount',}},
		neck={ name="Src. Stole +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring="Mujin Band",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+8','"Mag.Atk.Bns."+10',}},
        }

    sets.magic_burst.Resistant = {} 

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group

    sets.engaged = {
		ammo="Hasty Pinion +1",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','INT+9',}},
		feet="Jhakri Pigaches +2",
		neck="Combatant's Torque",
		waist="Windbuffet Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring +1",
		back="Taranus's cape",
        }

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.DarkAffinity = {head="Pixie Hairpin +1"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end

    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)        
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            --if state.CastingMode.value == "Resistant" then
                --equip(sets.magic_burst.Resistant)
            --else
                equip(sets.magic_burst)
            --end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
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
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
        end
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

-- latent DT set auto equip on HP% change
    windower.register_event('hpp change', function(new, old)
        if new<=25 then
            equip(sets.latent_dt)
        end
    end)


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end

    return defenseSet
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
    set_macro_page(1, 18)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 10')
end
