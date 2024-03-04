-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- gs c toggle hastemode -- Toggles whether or not you're getting Haste II
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()

    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Sange = buffactive.sange or false
    state.Buff.Innin = buffactive.innin or false
    
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi' }
    state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
    state.UseRune = M(false, 'Use Rune')
	
    run_sj = player.sub_job == 'RUN' or false

    select_ammo()
    LugraWSList = S{'Blade: Shun', 'Blade: Ku', 'Blade: Jin', 'Blade: Kamu'}
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    
    gear.RegularAmmo = 'Happo Shuriken'
    gear.SangeAmmo = 'Happo Shuriken'

    
    wsList = S{'Blade: Hi', 'Blade: Retsu'}
	nukeList = S{'Katon: San', 'Doton: San', 'Suiton: San', 'Raiton: San', 'Hyoton: San', 'Huton: San'}

    update_combat_form()
    
    state.warned = M(false)
    options.ammo_warning_limit = 25
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Low', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'MDT', 'EVA')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.CastingMode = M{['description']='Casting', 'Enmity', 'Normal', 'Burst' }
	-- BlueMagic --
	EnmityBlueMagic = S{"Jettatura","Sheep Song","Soporific","Blank Gaze","Geist Wall"}
	
    select_default_macro_book()

    send_command('bind ^= gs c cycle treasuremode')
	send_command('bind ^- gs c cycle hastemode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c cycle HasteMode')
    send_command('bind @[ gs c cycle Runes')
    send_command('bind ^] gs c toggle UseRune')
	
	send_command('wait 2; input /lockstyleset 15')
    
end


function file_unload()
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind @f9')
    send_command('unbind @[')
end


-- Define sets and vars used by this job file.
-- visualized at http://www.ffxiah.com/node/194 (not currently up to date 10/29/2015)
-- Happo
-- Hachiya
-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)

-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

function init_gear_sets()

    --------------------------------------
    -- Job Abilties
    --------------------------------------
    sets.precast.JA['Mijin Gakure'] = { 
		ammo="Grenade Core",
		head="Adhemar Bonnet +1",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Mochizuki hakama +1",
		feet={ name="Adhe. Gamashes +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Odnowa Earring +1",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Dingir Ring",
		back="Izdubar Mantle",
	}
    sets.precast.JA['Futae'] = { hands="Hattori tekko +1" }
    sets.precast.JA['Provoke'] = { 
		ammo="Sapience Orb",
		head="Versa Celata",
		body="Emet harness +1",
		hands="Kurys gloves",
		legs="Wukong's Haka. +1",
		feet="Mummu Gamash. +2",
		neck="Moonlight Necklace",
		waist="Trance Belt",
		left_ear="Etiolation Earring",
		right_ear="Friomisi Earring",
		left_ring="Begrudging Ring",
		right_ring="Petrov Ring",
		back="Moonlight cape",
    }
    sets.precast.JA.Sange = { ammo=gear.SangeAmmo, body="Mochizuki Chainmail +1" }
    
    -- Waltz (chr and vit)
    sets.precast.Waltz = {
        ammo="Yamarang",
		head="Hachiya Hatsu. +3",
		body=gear.ta_rawvest,
		hands="Hizamaru Kote +2",
		legs="Mochizuki hakama +1",
		feet="Hachiya Kyahan +3",
		neck="Unmoving Collar",
		waist="Flume Belt +1",
		left_ear="Lugra Earring +1",
		right_ear="Lugra Earring",
		left_ring="Petrov Ring",
		back="Solemnity Cape",
    }
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}
    sets.midcast.Trust =  {}
     sets.midcast["Apururu (UC)"] = set_combine(sets.midcast.Trust, {
         body="Apururu Unity shirt",
     })
    
    --------------------------------------
    -- Utility Sets for rules below
    --------------------------------------
    sets.TreasureHunter = { 
		waist="Chaac Belt",
		ammo="Per. Lucky Egg",
		head="Wh. Rarab Cap +1",
	}
	
    sets.CapacityMantle = { back="Mecistopins mantle" }
    sets.IshvaraMoon    = { ear1="Ishvara Earring", ear2="Moonshade Earring" }

	sets.RegularAmmo    = { ammo=gear.RegularAmmo }
    sets.SangeAmmo      = { ammo=gear.SangeAmmo }
    
    sets.NightAccAmmo   = { ammo=gear.RegularAmmo }
    sets.DayAccAmmo     = { ammo=gear.RegularAmmo }

    --------------------------------------
    -- Ranged
    --------------------------------------
    
    sets.precast.RA = {
		ammo=gear.SangeAmmo,
		head="Aurore Beret +1",
		body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},
		legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
    }
    sets.midcast.RA = {
		ammo=gear.SangeAmmo,
		head="Mummu Bonnet +2",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet={ name="Adhe. Gamashes +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		neck="Iskur Gorget",
		waist="Eschan Stone",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
		back="Yokaze Mantle",
    }
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
    })
    sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)
    
    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Gyve Trousers",
		neck="Voltsurge torque",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
        feet="Mochizuki Kyahan +3" -- special enhancement for casting ninjutsu III
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads", body="Mochizuki Chainmail +1" })
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Attack+25','Weapon skill damage +4%','AGI+8','Accuracy+15',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
        neck="Moonlight Necklace",
		left_ear="Etiolation Earring",
		back="Mujin Mantle",
        right_ear="Loquacious Earring",
        left_ring="Kishar Ring",
		right_ring="Prolix Ring",
        feet="Mochizuki Kyahan +3"
    }
      
    -- skill ++ 
    sets.midcast.Ninjutsu = {
		head="Mochizuki hatsuburi +3",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Digni. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Yokaze Mantle",
    }
	
    -- any ninjutsu cast on self
    sets.midcast.SelfNinjutsu = sets.midcast.Ninjutsu
    sets.midcast.Utsusemi = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Hizamaru Kote +2",
		legs="Mummu Kecks +2",
		feet="Hattori Kyahan +1",
		neck="Magoraga Beads",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cryptic Earring",
		right_ear="Halasz Earring",
		left_ring="Evanescence Ring",
		right_ring="Kishar Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},}
    sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {body="Hattori Ningi +1"})

    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
        ammo="Pemphredo tathlum",
		head="Mochizuki hatsuburi +3",
		body="Mummu Jacket +2",
		hands="Hatorri tekko +1",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +4%','INT+9','Mag. Acc.+7',}},
		feet="Mummu Gamash. +2",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Digni. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Yokaze Mantle",
    }
	
	sets.Burst = set_combine(sets.midcast.ElementalNinjutsu.Burst, { hands="Hattori Tekko +1"})
	
	sets.midcast.ElementalNinjutsu.Burst = {
    }
	
	sets.midcast.ElementalNinjutsu.Enmity = {
		ammo="Sapience Orb",
		head="Mochizuki hatsuburi +3",
		body="Emet harness +1",
		hands="Kurys gloves",
		legs="Wukong's Haka. +1",
		feet="Mummu Gamash. +2",
		neck="Moonlight Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Digni. Earring",
		left_ring="Petrov Ring",
		right_ring="Begrudging Ring",
		back="Yokaze Mantle",
    }
	
	--EnmityBlueMagic--
	sets.midcast.BLUEnmity = {
		ammo="Sapience Orb",
		head="Mochizuki hatsuburi +3",
		body="Mummu Jacket +2",
		hands="Kurys gloves",
		legs="Wukong's Haka. +1",
		feet="Mummu Gamash. +2",
		neck="Moonlight Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Digni. Earring",
		left_ring="Petrov Ring",
		right_ring="Begrudging Ring",
		back="Yokaze Mantle",
    }
	
    -- Effusions
    sets.precast.Effusion = {}
    sets.precast.Effusion.Lunge = {
		head="Mochizuki hatsuburi +3",
		body={ name="Herculean Vest", augments={'Weapon skill damage +4%','Pet: VIT+1','Magic Damage +10','Accuracy+19 Attack+19','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Gyve Trousers",
		feet="Hachiya Kyahan +3",
		neck="Satlada Necklace",
		waist="Eschan Stone",
		left_ear="Strophadic Earring",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Dingir Ring",
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
	}
    sets.precast.Effusion.Swipe = {
		head="Mochizuki hatsuburi +3",
		body={ name="Herculean Vest", augments={'Weapon skill damage +4%','Pet: VIT+1','Magic Damage +10','Accuracy+19 Attack+19','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Gyve Trousers",
		feet="Hachiya Kyahan +3",
		neck="Satlada Necklace",
		waist="Eschan Stone",
		left_ear="Strophadic Earring",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Dingir Ring",
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
	}
    
    sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",
     }

    sets.idle.Regen = set_combine(sets.idle, {
		head="Malignance Chapeau",
		body="Hiza. Haramaki +2",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Dawn Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back="Moonlight Cape",
    })
    
    sets.idle.Town = set_combine(sets.idle, {
		ammo="Aurgelmir orb +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Archon Ring",
		right_ring="Defending Ring",
		back="Moonlight Cape",
    })
    --sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
		--body="Councilor's Garb"
    --})
    
    sets.idle.Weak = sets.idle

    -- Defense sets
    sets.defense.PDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back="Moonlight Cape",
    }
    
    sets.defense.MDT = set_combine(sets.engaged.MaxHaste, {
	ring2="Defending ring"
	})
    
    sets.DayMovement = {feet="Danzo sune-ate"}
    sets.NightMovement = {feet="Hachiya Kyahan +1"}

    sets.Organizer = {
        shihei="Shihei",
        inoshi="Inoshishinofuda",
        shika="Shikanofuda",
        chono="Chonofuda"
    }

    -- Normal melee group without buffs
    sets.engaged = {
        ammo=gear.RegularAmmo,
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Hiza. Sune-Ate +2",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
    }
    -- assumptions made about target, Rancor no longer "OK" 
    sets.engaged.Low = {
	    ammo=gear.RegularAmmo, 
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
    }

    sets.engaged.Mid = {
	    ammo=gear.RegularAmmo,
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
	}
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		ammo=gear.RegularAmmo,
		head="Adhemar Bonnet +1",
		body="Kendatsuba samue +1",
		hands="Adhemar Wrist. +1",
		legs="Kendatsuba hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Ninja nodowa +2",
		waist="Reiki yotai",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
	})
    
    sets.engaged.Innin = set_combine(sets.engaged, {
    })
    sets.engaged.Innin.Low = set_combine(sets.engaged.Innin, {
    })
    sets.engaged.Innin.Mid = set_combine(sets.engaged.Innin.Low, {
    })
    sets.engaged.Innin.Acc = set_combine (sets.engaged.Innin.Mid, {
	    neck="Ninja nodowa +2"
	})

    -- Defensive sets
    sets.NormalPDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Beeline Ring",
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
    }	
    sets.AccPDT = {}
	sets.NormalMDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Beeline Ring",
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
    }
    sets.Evasive = {
        head="Mummu Bonnet +2",
		body="Malignance tabard",
		hands="Hizamaru Kote +2",
		legs="Hiza. Hizayoroi +2",
		feet="Ken. Sune-Ate +1",
		neck="Combatant's Torque",
		left_ring="Beeline Ring",
		right_ring="Defending Ring",
		back="Yokaze Mantle",
    }
    
	sets.engaged.MDT = set_combine(sets.engaged, sets.NormalMDT)
	sets.engaged.PDT = set_combine(sets.engaged, sets.NormalPDT)
    sets.engaged.Low.PDT = set_combine(sets.engaged.Low, sets.NormalPDT)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.NormalPDT)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.AccPDT)

    sets.engaged.Innin.PDT = set_combine(sets.engaged.Innin, sets.NormalPDT)
    sets.engaged.Innin.Low.PDT = set_combine(sets.engaged.Innin.Low, sets.NormalPDT)
    sets.engaged.Innin.Mid.PDT = set_combine(sets.engaged.Innin.Mid, sets.NormalPDT)
    sets.engaged.Innin.Acc.PDT = set_combine(sets.engaged.Innin.Acc, sets.AccPDT)
 
    -- sets on the right side of set_combine take priority
    -- you might want to create sets.Evasive.Mid, and then use
    -- them instead of combining sets.Evasvie for every set below
    sets.engaged.EVA = set_combine(sets.engaged, sets.Evasive)
    sets.engaged.Low.EVA = set_combine(sets.engaged.Low, sets.Evasive)
    sets.engaged.Mid.EVA = set_combine(sets.engaged.Mid, sets.Evasive)
    sets.engaged.Acc.EVA = set_combine(sets.engaged.Acc, sets.Evasive)
 
    -- you can also pass a 3rd set, which takes priority over the first two.  
    sets.engaged.Innin.EVA = set_combine(sets.engaged.Innin, sets.Evasive)
    sets.engaged.Innin.Low.EVA = set_combine(sets.engaged.Innin.Low, sets.Evasive)
    sets.engaged.Innin.Mid.EVA = set_combine(sets.engaged.Innin.Mid, sets.Evasive)
    sets.engaged.Innin.Acc.EVA = set_combine(sets.engaged.Innin.Acc, sets.Evasive)
	
    sets.engaged.HastePDT = {}

    -- Delay Cap from spell + songs alone
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
		ammo=gear.RegularAmmo,
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6','Accuracy+5',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
    })
    -- Base set for hard content
    sets.engaged.Low.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        neck="Ninja nodowa +2"
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, {
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
		ammo=gear.RegularAmmo,
		head="Adhemar Bonnet +1",
		body="Kendatsuba samue +1",
		hands="Adhemar Wrist. +1",
		legs="Kendatsuba hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Ninja nodowa +2",
		waist="Sailfi belt +1",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich RIng +1",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10',}},
    })
    -- do nothing here
    sets.engaged.Innin.MaxHaste     = sets.engaged.MaxHaste
    sets.engaged.Innin.Low.MaxHaste = sets.engaged.Low.MaxHaste
    sets.engaged.Innin.Mid.MaxHaste = sets.engaged.Mid.MaxHaste
    sets.engaged.Innin.Acc.MaxHaste = sets.engaged.Acc.MaxHaste
   
    -- Defensive sets
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.NormalPDT)
    sets.engaged.Low.PDT.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, sets.NormalPDT)
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, sets.NormalPDT)
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.AccPDT)
    
    sets.engaged.Innin.PDT.MaxHaste = set_combine(sets.engaged.Innin.MaxHaste, sets.NormalPDT)
    sets.engaged.Innin.Low.PDT.MaxHaste = set_combine(sets.engaged.Innin.Low.MaxHaste, sets.NormalPDT)
    sets.engaged.Innin.Mid.PDT.MaxHaste = set_combine(sets.engaged.Innin.Mid.MaxHaste, sets.NormalPDT)
    sets.engaged.Innin.Acc.PDT.MaxHaste = sets.engaged.Acc.PDT.MaxHaste

    -- 35% Haste 
    sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {
        head="Adhemar Bonnet +1",
		ear2="Suppanomimi",
		waist="Reiki yotai"
    })
    sets.engaged.Low.Haste_35 = set_combine(sets.engaged.Low.MaxHaste, {
	    head="Adhemar Bonnet +1",
		ear2="Suppanomimi",
		waist="Reiki yotai"
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {
        head="Adhemar Bonnet +1",
		ear2="Suppanomimi",
		waist="Reiki yotai"
		
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {
        head="Adhemar Bonnet +1",
		ear2="Suppanomimi",
		waist="Reiki yotai"
    })

    sets.engaged.Innin.Haste_35 = set_combine(sets.engaged.Haste_35, {
    })
    sets.engaged.Innin.Low.Haste_35 = set_combine(sets.engaged.Low.Haste_35, {
    })
    sets.engaged.Innin.Mid.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {
    })
    sets.engaged.Innin.Acc.Haste_35 = sets.engaged.Acc.Haste_35
    
    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_35 = set_combine(sets.engaged.Low.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, sets.engaged.AccPDT)
    
    sets.engaged.Innin.PDT.Haste_35 = set_combine(sets.engaged.Innin.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Innin.Low.PDT.Haste_35 = set_combine(sets.engaged.Innin.Low.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_35 = set_combine(sets.engaged.Innin.Mid.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Innin.Acc.PDT.Haste_35 = sets.engaged.Acc.PDT.Haste_35
    
    -- 30% Haste
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
    })
    sets.engaged.Low.Haste_30 = set_combine(sets.engaged.Low.Haste_35, {
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_35, {
    })
    --sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_35, {
    --})
    sets.engaged.Acc.Haste_30 = sets.engaged.Acc.MaxHaste 

    sets.engaged.Innin.Haste_30 = set_combine(sets.engaged.Haste_30, {
	})
    sets.engaged.Innin.Low.Haste_30 = set_combine(sets.engaged.Low.Haste_30, {
    })
    sets.engaged.Innin.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
    })
    sets.engaged.Innin.Acc.Haste_30 = sets.engaged.Acc.Haste_30
    
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_30 = set_combine(sets.engaged.Low.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, sets.engaged.AccPDT)
    
    sets.engaged.Innin.PDT.Haste_30 = set_combine(sets.engaged.Innin.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Innin.Low.PDT.Haste_30 = set_combine(sets.engaged.Innin.Low.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_30 = set_combine(sets.engaged.Innin.Mid.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Innin.Acc.PDT.Haste_30 = sets.engaged.Acc.PDT.Haste_30
    

    -- 5 - 20% Haste 
    sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {
        head="Adhemar Bonnet +1",
		ear1="Eabani earring",
		ring1="Hetairoi ring",
		waist="Reiki yotai",
    })
    sets.engaged.Low.Haste_15 = set_combine(sets.engaged.Low.Haste_30, {
        head="Adhemar Bonnet +1",
		ear1="Eabani earring",
		ring1="Hetairoi ring",
		waist="Reiki yotai",
    })
    sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Mid.Haste_30, {
        head="Adhemar Bonnet +1",
		ear1="Eabani earring",
		ring1="Hetairoi ring",
		waist="Reiki yotai",
    })
    sets.engaged.Acc.Haste_15 = set_combine(sets.engaged.Acc.MaxHaste, {
		head="Adhemar Bonnet +1",
		ear1="Eabani earring",
		ring1="Hetairoi ring",
		waist="Reiki yotai",
	})
    sets.engaged.Innin.Haste_15 = set_combine(sets.engaged.Haste_15, {
    })
    sets.engaged.Innin.Low.Haste_15 = set_combine(sets.engaged.Low.Haste_15, {
    })
    sets.engaged.Innin.Mid.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, {
    })
    sets.engaged.Innin.Acc.Haste_15 = sets.engaged.Acc.Haste_15
    
    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_15 = set_combine(sets.engaged.Low.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, sets.engaged.AccPDT)
    
    sets.engaged.Innin.PDT.Haste_15 = set_combine(sets.engaged.Innin.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Innin.Low.PDT.Haste_15 = set_combine(sets.engaged.Innin.Low.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_15 = set_combine(sets.engaged.Innin.Mid.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Innin.Acc.PDT.Haste_15 = sets.engaged.Acc.PDT.Haste_15
    
    sets.buff.Migawari = {body="Hattori Ningi +1"}
    
    -- Weaponskills 
	sets.precast.WS = {
		ammo="Aurgelmir Orb +1",
		head="Hachiya Hatsu. +3",
		body="Ken. Samue +1",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs="Mochizuki hakama +3",
		feet="Ken. Sune-Ate +1",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear="Odr Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        neck="Ninja nodowa +2"
    })
    sets.precast.WS.Low = sets.precast.WS.Mid
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
    })

    --BLADE: KAMU
	sets.Kamu = {
		ammo="Aqreqaq Bomblet",
		head="Hachiya Hatsu. +3",
		body={ name="Herculean Vest", augments={'Rng.Acc.+12','Weapon skill damage +5%','AGI+1','Rng.Atk.+14',}},
		hands="Adhemar Wrist. +1",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }
    sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Low = set_combine(sets.precast.WS.Low, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Mid = set_combine(sets.precast.WS.Mid, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS.Acc, sets.Kamu, {waist="Caudata Belt"})
    
    -- BLADE: JIN
    sets.Jin = {
		ammo="Yetshila +1",
		head="Hachiya Hatsu. +3",
		body="Adhemar Jacket +1",
		hands="Adhemar Wrist. +1",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)
    sets.precast.WS['Blade: Jin'].Low = set_combine(sets.precast.WS['Blade: Jin'], {
    })
    sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS['Blade: Jin'].Low, {
    })
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'].Mid, {
        legs="Samnuha Tights",
    })
	
	-- BLADE: EI
    sets.precast.WS['Blade: Ei'] = set_combine(sets.precast.WS, {
		ammo="Grenade Core",
		head="Pixie Hairpin +1",
		body={ name="Herculean Vest", augments={'Pet: STR+4','"Mag.Atk.Bns."+22','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		hands="Adhemar Wrist. +1",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +4%','INT+9','Mag. Acc.+7',}},
		feet={ name="Adhe. Gamashes +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back="Izdubar Mantle",
    })

    -- BLADE: HI
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Hachiya Hatsu. +3",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		neck="Fotia Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Brutal Earring",
		left_ring="Regal Ring",
		right_ring="Begrudging Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Blade: Hi'].Low = set_combine(sets.precast.WS['Blade: Hi'], {
    })
    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
    })

    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {
        ear1="Trux Earring",
    })
    
    -- BLADE: SHUN
    sets.Shun = {
		ammo="C. Palug stone",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Mummu Wrists +2",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Brutal Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
    sets.precast.WS['Blade: Shun'].Low = set_combine(sets.precast.WS.Low, sets.Shun)
    sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.precast.WS.Mid, sets.Shun)
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, sets.Shun)
    
    -- BLADE: Rin
    sets.Rin = {
		ammo="Yetshila +1",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Mummu Wrists +2",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)
    sets.precast.WS['Blade: Rin'].Low = set_combine(sets.precast.WS.Low, sets.Rin)
    sets.precast.WS['Blade: Rin'].Mid = set_combine(sets.precast.WS.Mid, sets.Rin)
    sets.precast.WS['Blade: Rin'].Acc = set_combine(sets.precast.WS.Acc, sets.Rin, {waist="Light Belt"})
    
    -- BLADE: Ku 
    sets.Ku = {
		ammo="Yetshila +1",
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands="Mummu Wrists +2",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
    sets.precast.WS['Blade: Ku'].Low = set_combine(sets.precast.WS['Blade: Ku'], {
    })
    sets.precast.WS['Blade: Ku'].Mid = sets.precast.WS['Blade: Ku'].Low
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS['Blade: Ku'].Mid, {
        legs="Samnuha Tights"
    })
    
	--BLADE: Ten
    sets.Ten = {
		ammo="Hasty Pinion +1",
		head="Hachiya Hatsu. +3",
		body={ name="Herculean Vest", augments={'Rng.Acc.+12','Weapon skill damage +5%','AGI+1','Rng.Atk.+14',}},
		hands="Adhemar Wrist. +1",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+22','Weapon skill damage +5%','Rng.Atk.+12',}},
		neck="Caro necklace",
		waist="Grunfeld rope",
		left_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, sets.Ten)
    sets.precast.WS['Blade: Ten'].Low = set_combine(sets.precast.WS['Blade: Ten'], {
    })
    sets.precast.WS['Blade: Ten'].Mid = set_combine(sets.precast.WS['Blade: Ten'].Low, {
    })
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'].Mid, {
    })
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
     })
	 
	--BLADE: YU
    sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS['Aeolian Edge'], {
		ammo="Pemphredo Tathlum",
		head="Mochizuki hatsuburi +3",
		body={ name="Herculean Vest", augments={'Pet: STR+4','"Mag.Atk.Bns."+22','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +4%','INT+9','Mag. Acc.+7',}},
		feet={ name="Adhe. Gamashes +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Novio Earring",
		left_ring="Dingir Ring",
		right_ring="Shiva Ring +1",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    })
	
	--BLADE: CHI
    sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS['Aeolian Edge'], {
		ammo="Pemphredo Tathlum",
		head="Mochizuki hatsuburi +3",
		body={ name="Herculean Vest", augments={'Pet: STR+4','"Mag.Atk.Bns."+22','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +4%','INT+9','Mag. Acc.+7',}},
		feet={ name="Adhe. Gamashes +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Novio Earring",
		left_ring="Dingir Ring",
		right_ring="Shiva Ring +1",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})	
	
    sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']

end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    
    if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
        if spell.english == "Migawari" then
            classes.CustomClass = "Migawari"
        else
            classes.CustomClass = "SelfNinjutsu"
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            eventArgs.cancel = true
            return
        end
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Ranged Attacks 
    if spell.action_type == 'Ranged Attack' and state.OffenseMode ~= 'Acc' then
        equip( sets.SangeAmmo )
    end
    -- protection for lag
    if spell.name == 'Sange' and player.equipment.ammo == gear.RegularAmmo then
        state.Buff.Sange = false
        eventArgs.cancel = true
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
            equip(sets.TreasureHunter)
        end
        -- Mecistopins Mantle rule
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        -- Gavialis Helm rule
        if is_sc_element_today(spell) then
            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            else
              equip(sets.WSDayBonus)
            end
        end
        -- Swap in special ammo for WS in high Acc mode
        if state.OffenseMode.value == 'Acc' then
            equip(select_ws_ammo())
        end
        -- Lugra Earring for some WS
        if LugraWSList:contains(spell.english) then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.Lugralugra)
            else
                equip(sets.IshvaraMoon)
            end
        elseif spell.english == 'Blade: Ten' then
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.LugraMoon)
            else
                equip(sets.IshvaraMoon)
            end
        end

    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if nukeList:contains(spell.english) and buffactive['Futae'] then
		equip(sets.Burst)
    end
	if spell.action_type == 'Magic' then
        equip(sets.midcast.FastRecast)
    end
    if spell.english == "Monomi: Ichi" then
        if buffactive['Sneak'] then
            send_command('@wait 1.7;cancel sneak')
        end
	end

end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    --if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
    --    equip(sets.TreasureHunter)
    --end
end

function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'Tag' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'Tag' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Aftermath timer creation
    aw_custom_aftermath_timers_aftercast(spell)
    --if spell.type == 'WeaponSkill' then
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.value == 'PDT' then
        if state.Buff.Migawari then
            idleSet = set_combine(idleSet, sets.buff.Migawari)
        else 
            idleSet = set_combine(idleSet, sets.defense.PDT)
        end
    else
        idleSet = set_combine(idleSet, select_movement())
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
    if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if player.mp < 100 and state.OffenseMode.value ~= 'Acc' then
        -- use Rajas instead of Oneiros for normal + mid
        meleeSet = set_combine(meleeSet, sets.Rajas)
    end
    meleeSet = set_combine(meleeSet, select_ammo())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    if buff == 'Innin' and gain  or buffactive['Innin'] then
        state.CombatForm:set('Innin')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        state.CombatForm:reset()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

	if spell.english == 'Lunge' or spell.english == 'Swipe' then
            if LastRune == 'Tenebrae' then
                equip(sets.precast.Effusion.Lunge,{head="Pixie Hairpin +1"})
            end
        end
		
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
		if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_ammo()
    determine_haste_group()
    update_combat_form()
    run_sj = player.sub_job == 'RUN' or false
    --select_movement()
    th_update(cmdParams, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'Tag' or state.TreasureMode.value == 'Fulltime' then
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

function select_movement()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.NightMovement
    else
        return sets.DayMovement
    end
end

function determine_haste_group()
 
    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
             ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
             ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                 ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
           ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
           ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
           ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
               ( buffactive.march == 2 and buffactive['haste samba'] ) or
               ( buffactive[580] and buffactive['haste samba'] ) then 
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
               ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
               ( buffactive[580] ) or  -- geo haste
               ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end
 
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Capacity Point Mantle' then
        gear.Back = newValue
    elseif stateField == 'Runes' then
        local msg = ''
        if newValue == 'Ignis' then
            msg = msg .. 'Increasing resistence against ICE and deals FIRE damage.'
        elseif newValue == 'Gelus' then
            msg = msg .. 'Increasing resistence against WIND and deals ICE damage.'
        elseif newValue == 'Flabra' then
            msg = msg .. 'Increasing resistence against EARTH and deals WIND damage.'
        elseif newValue == 'Tellus' then
            msg = msg .. 'Increasing resistence against LIGHTNING and deals EARTH damage.'
        elseif newValue == 'Sulpor' then
            msg = msg .. 'Increasing resistence against WATER and deals LIGHTNING damage.'
        elseif newValue == 'Unda' then
            msg = msg .. 'Increasing resistence against FIRE and deals WATER damage.'
        elseif newValue == 'Lux' then
            msg = msg .. 'Increasing resistence against DARK and deals LIGHT damage.'
        elseif newValue == 'Tenebrae' then
            msg = msg .. 'Increasing resistence against LIGHT and deals DARK damage.'
        end
        add_to_chat(123, msg)
    elseif stateField == 'Use Rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

--- Custom spell mapping.
--function job_get_spell_map(spell, default_spell_map)
--    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
--        return 'HighTierNuke'
--    end
--end
-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.type == 'Trust' then
        return 'Trust'
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.HasteMode.value ~= 'Normal' then
        msg = msg .. ', Haste: '..state.HasteMode.current
    end
    if state.RangedMode.value ~= 'Normal' then
        msg = msg .. ', Rng: '..state.RangedMode.current
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local empy_ws = "Blade: Hi"
        
        info.aftermath.weaponskill = empy_ws
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

function select_ammo()
    if state.Buff.Sange then
        return sets.SangeAmmo
    else
        return sets.RegularAmmo
    end
end

function select_ws_ammo()
    if world.time >= (18*60) or world.time <= (6*60) then
        return sets.NightAccAmmo
    else
        return sets.DayAccAmmo
    end
end
function update_combat_form()
    if state.Buff.Innin then
        state.CombatForm:set('Innin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'RUN' then
        set_macro_page(2, 6)
    else
        set_macro_page(1, 6)
    end
end