-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:
        
        Magic Burst            Toggle Magic Burst Mode  [Alt-`]
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
    indi_timer = ''
    indi_duration = 180

    state.CP = M(false, "Capacity Points Mode")
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')    
    state.MagicBurst = M(false, 'Magic Burst')

    -- Additional local binds


    send_command('bind ^` input /ja "Full Circle" <me>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')


    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @c')
    send_command('unbind @w')

end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1"}
    sets.precast.JA['Life Cycle'] = {body="Geo. Tunic", back="Nantosuelta's Cape"}
  
    -- Fast cast sets for spells
    
    sets.precast.FC = {
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		legs="Geo. Pants +1",
		feet="Merlinic Crackows",
		neck="Voltsurge torque",
		waist="Witful Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Malignance earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash"})
        
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        hands="Bagua Mitaines +1",
        body="Mallquis saio +2",
		neck="Stoicheion medal",
		right_ear="Malignance earring",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main={ name="Serenity", augments={'MP+45','Enha.mag. skill +9','"Cure" potency +4%','"Cure" spellcasting time -8%',}},
		sub="Clerisy Strap",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		right_ear="Mendi. Earring",
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','INT+9',}},
		feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +25',}},
		right_ear="Cessance Earring",
		left_ring="Karieyh ring +1",
		right_ring="Epaminondas's Ring",
		back="Solemnity Cape",
        }

    
    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------
    
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
		head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		hands="Mallquis Cuffs +2",
		legs="Geo. Pants +1",
		feet="Merlinic Crackows",
		waist="Witful Belt",
        } -- Haste
    
   sets.midcast.Geomancy = {
		main="Idris",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
		hands="Geo. Mitaines +3",
		legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		feet="Azimuth Gaiters +1",
		neck="Bagua charm +2",
		waist="Kobo obi",
		left_ear="Mendi. Earring",
		right_ear="Calamitous Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        }
    
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
		main="Idris",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
		hands="Geo. Mitaines +3",
		legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
		feet="Azimuth Gaiters +1",
		neck="Bagua charm +2",
		waist="Kobo obi",
		left_ear="Mendi. Earring",
		right_ear="Calamitous Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        })

    sets.midcast.Cure = {
		main="Vadose Rod",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +3%','"Cure" spellcasting time -8%',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
		hands="Telchine Gloves",
		legs="Gyve Trousers",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Incanter's torque",
		waist="Luminary sash",
		left_ear="Mendi. Earring",
		right_ear="Malignance earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring1="Levia. Ring +1",
        ring2="Levia. Ring +1",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
		main="Vadose Rod",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
		hands="Telchine Gloves",
		legs="Gyve Trousers",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Incanter's torque",
		waist="Gishdubar Sash",
		left_ear="Mendi. Earring",
		right_ear="Malignance earring",
		left_ring="Ephedra Ring",
		right_ring="Haoma's Ring",
		back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
		main="Gada",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Umuthi Hat",
		body="Telchine Chasuble",
		hands={ name="Psycloth Manillas", augments={'MP+50','INT+7','"Conserve MP"+6',}},
		legs="Geo. Pants +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Incanter's torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Malignance earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
        }
        
    sets.midcast.EnhancingDuration = {}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main="Bolelabunga",
        sub="Ammurapi shield",
        })
    
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        head="Amalric Coif",
        waist="Gishdubar Sash",
        })
            
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        ear2="Earthcry earring",
        waist="Siegel Sash",
		neck="Nodens Gorget",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        main="Vadose Rod",
        sub="Ammurapi shield",
        head="Amalric Coif",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring1="Sheltered Ring",
        })
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect


    sets.midcast.MndEnfeebles = {
		main="Gada",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Mallquis Chapeau +2",
		body={ name="Vanya Robe", augments={'HP+50','MP+50','"Refresh"+2',}},
		hands="Mallquis Cuffs +2",
		legs="Psycloth lappas",
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		neck="Bagua charm +2",
		waist="Luminary sash",
		left_ear="Malignance earring",
		right_ear="Regal earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back="Izdubar Mantle",
        } -- MND/Magic accuracy
    
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Rubicundity",waist="Sacro Cord",
        }) -- INT/Magic accuracy

    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Mallquis Chapeau +2",
		body="Amalric doublet",
		hands="Amalric gages",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Fast Cast"+3','MND+2','"Mag.Atk.Bns."+13',}},
		feet="Merlinic Crackows",
		neck="Bagua charm +2",
		waist="Sacro Cord",
		left_ear="Regal earring",
		right_ear="Malignance earring",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring +1",
		back="Izdubar Mantle",
        }
    
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head={ name="Bagua Galero", augments={'Enhances "Primeval Zeal" effect',}},
		waist="Fucho-no-Obi",
		left_ear="Hirudinea Earring",
		neck="Erra pendant",
        })
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        feet="Regal Pumps +1"
        })

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main="Idris",
		sub="Ammurapi shield",
		head="Merlinic Hood",
		body="Amalric doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric slops +1",
		feet="Merlinic Crackows",
		neck="Mizu. Kubikazari",
		waist="Sacro Cord",
		left_ear="Regal earring",
		right_ear="Malignance earring",
		left_ring="Freke ring",
		right_ring="Shiva Ring +1",
		back="Izdubar mantle",
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		main="Idris",
		sub="Ammurapi shield",
		head="Jhakri Coronal +2",
		body="Amalric doublet +1",
		hands="Amalric Gages +1",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Fast Cast"+3','MND+2','"Mag.Atk.Bns."+13',}},
		feet="Jhakri Pigaches +2",
		neck="Sanctity Necklace",
		waist="Sacro Cord",
		left_ear="Regal earring",
		right_ear="Malignance earring",
		left_ring="Freke ring",
		right_ring="Shiva Ring +1",
		back="Izdubar Mantle",
        })

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {
        main="Idris",
        sub="Ammurapi shield",
        ring1="Freke ring",
        })

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.GeoElem.Seidr = set_combine(sets.midcast['Elemental Magic'].Seidr,  {})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak",
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		main="Idris",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body="Shamash Robe",
		hands="Geo. Mitaines +3",
		legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
		feet="Geomancy sandals",
		neck="Bagua charm +2",
		waist="Fucho-no-Obi",
		left_ear="Handler's Earring +1",
		right_ear="Handler's Earring",
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        }
    
    sets.resting = set_combine(sets.idle, {
		main="Idris",
		sub="Mensch Strap",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body="Shamash Robe",
		hands="Geo. Mitaines +3",
		legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		neck="Bagua charm +2",
		waist="Isa belt",
		left_ear="Handler's Earring +1",
		right_ear="Handler's Earring",
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        })

    sets.idle.DT = set_combine(sets.idle, {
		main="Idris",
		sub="Ammurapi Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Nyame Helm",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        })

    sets.idle.Weak = sets.idle.DT

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, { 
        -- Pet: -DT (37.5% to cap) / Pet: Regen 
		head="Azimuth Hood +1",
		hands="Geo. Mitaines +3",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		waist="Isa Belt",
		neck="Bagua charm +2",
		left_ear="Handler's Earring +1",
		right_ear="Handler's Earring",
		back="Nantosuelta's Cape",
        })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
		sub="Ammurapi Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Nyame Helm",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bagua charm +2",
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        })

    -- .Indi sets are for when an Indi-spell is active.
--    sets.idle.Indi = set_combine(sets.idle, {legs="Bagua Pants +3"})
--    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants +3"})
--    sets.idle.DT.Indi = set_combine(sets.idle.DT, {legs="Bagua Pants +3"})
--    sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {legs="Bagua Pants +3"})

    sets.idle.Town = set_combine(sets.idle, {
		main="Idris",
		sub="Ammurapi shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body="Shamash Robe",
		hands={ name="Bagua Mitaines +1", augments={'Enhances "Curative Recantation" effect',}},
		legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
		feet="Herald's gaiters",
		neck="Bagua charm +2",
		waist="Isa belt",
		left_ear="Genmei earring",
		right_ear="Infused earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini ring +1",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -3%','Damage taken-3%',}},
        })
        
    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {
        feet="Geomancy sandals"
        }

    sets.latent_refresh = {
        waist="Fucho-no-obi"
        }
    
    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {        
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','INT+9',}},
		feet="Jhakri Pigaches +2",
		neck="Combatant's Torque",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Solemnity Cape",
        }


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = {
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+6%','CHR+4','"Mag.Atk.Bns."+10',}},
		hands="Amalric Gages +1",
		feet="Jhakri Pigaches +1",
		neck="Mizu. Kubikazari",
		right_ring="Mujin Band",
		back="Izdubar mantle",
        }

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then 
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            --send_command('@timers d "'..indi_timer..'"')
            --indi_timer = spell.english
            --send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.skill == 'Elemental Magic' then
 --           state.MagicBurst:reset()
        end
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        end 
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 16)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 11')
end