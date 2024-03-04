
--[[
        Custom commands:
        Becasue /sch can be a thing... I've opted to keep this part 
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off for locking of weapons
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle mainweapon			cycles main weapons in the list you defined below
		gs c toggle subweapon			cycles main weapons in the list you defined below
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking
        gs c nuke cycledown             Cycles element type for nuking in reverse order    
	gs c nuke enspellup             Cycles element type for enspell
	gs c nuke enspelldown		Cycles element type for enspell in reverse order 
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  if /sch
	gs c nuke enspell		Cast enspell of saved enspell element		
        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob		Toggles the Job section of the HUD on or off
        gs c hud lite			Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file. Also on CTRL-END
        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

include('organizer-lib') -- optional
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
meleeModes = M('normal', 'acc', 'dt', 'mdt')
nukeModes = M('normal', 'acc')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Crocea Mors', 'Naegling', 'Maxentius', 'Excalibur', 'Almace', 'Ceremonial Dagger', 'Daybreak')
subWeapon = M('Ammurapi Shield', 'Machaera +2', 'Tauret', 'Almace', 'Ceremonial Dagger')
------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
----------------------------------------------------------

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1400    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
	windower.send_command('bind insert gs c nuke cycle')        -- insert to Cycles Nuke element
	windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
	windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
	windower.send_command('bind f8 gs c toggle meleemode')      -- F8 to change Melee Mode  
	windower.send_command('bind !f9 gs c toggle melee') 		-- Alt-F9 Toggle Melee mode on / off, locking of weapons
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
	windower.send_command('bind home gs c nuke enspellup')		-- Home Cycle Enspell Up
	windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	windower.send_command('bind ^f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
	windower.send_command('bind F10 gs c toggle matchsc')		-- CTRL-F10 to change Match SC Mode      	
	windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
	windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  

--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_melee'] = '(F8)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F8)'
keybinds_on['key_bind_subweapon'] = '(CTRL-F8)'
keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_enspell_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind !f9')
    send_command('unbind f8')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !end')  
    send_command('unbind ^end')  	
end

include('RDM_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,7) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Atro.Chapeau +1"
    AF.Body		=	"Atrophy Tabard +2"
    AF.Hands	=	"Atrophy Gloves +2"
    AF.Legs		=	"Atrophy Tights +1"
    AF.Feet		=	"Atrophy Boots +1"

    --Vitiation
    RELIC.Head		=	"Viti. Chapeau +3"
    RELIC.Body		=	"Viti. Tabard +3"
    RELIC.Hands 	=	"Viti. Gloves +2"
    RELIC.Legs		=	"Viti. Tights +3"
    RELIC.Feet		=	"Vitiation Boots +3"

    --Lethargy
    EMPY.Head		=	"Leth. Chappel +1"
    EMPY.Body		=	"Lethargy Sayon +1"
    EMPY.Hands		=	"Leth. Gantherots +1"
    EMPY.Legs		=	"Leth. Fuseau +1"
    EMPY.Feet		=	"Leth. Houseaux +1"

	-- SETS
     
    sets.me = {}        		-- leave this empty
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
    sets.weapons = {}			-- leave this empty
	


    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    sets.me.idle.refresh = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Bunzi's Robe",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back="Moonlight Cape",
    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.refresh,{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield sets
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw = set_combine(sets.me.idle.refresh,{   
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
    })
    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
    })
    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
    })
    sets.me.melee.mdtdw = set_combine(sets.me.melee.normaldw,{
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Aya. Manopolas +2",
		legs={ name="Viti. Tights +3", augments={'Enspell Damage','Accuracy',}},
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Orpheus's sash",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
	})
	------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So canjust put what will be changing when off hand is a shield
 	------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{   
        legs		=	RELIC.Legs,
    })
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw,{

    })
    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw,{

    })
    sets.me.melee.mdtsw = set_combine(sets.me.melee.mdtdw,{

    })
	
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    sets.me["Savage Blade"] = {
		ammo="Aurgelmir Orb +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Nuna Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},
	}
    sets.me["Knights of Round"] = {
		ammo="Aurgelmir Orb +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Nuna Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},
	}
	sets.me["Death Blossom"] = {
		ammo="Aurgelmir Orb +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Nuna Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},
	}
	sets.me["Black Halo"] = {
		ammo="Aurgelmir Orb +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Sherida Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},
    }
    sets.me["Requiescat"] = {
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Ayanmo Corazza +2",
		hands="Jhakri Cuffs +2",
		legs="Aya. Cosciales +2",
		feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Orpheus's sash",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Rng.Atk.+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }
    sets.me["Chant du Cygne"] = {
		ammo="Yetshila +1",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
    }
	sets.me["Evisceration"] = {
		ammo="Yetshila +1",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
    }
    sets.me["Sanguine Blade"] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Sanctity Necklace",
		waist="Orpheus's sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }

    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
    sets.midcast.nuking = {}		-- leave this empty
    sets.midcast.MB	= {}		-- leave this empty   
    sets.midcast.enhancing = {} 	-- leave this empty   
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		ammo="Staunch Tathlum +1",
		head="Atro. Chapeau +1",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
		legs="Aya. Cosciales +2",
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Prolix Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }											

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })
	
    sets.precast['Impact'] = set_combine(sets.precast.casting,{head=empty, body="Twilight Cloak"})
 

	-- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{

    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
	    waist="Siegel Sash",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
	back		=	"Pahtli Cape",
        feet		=	"Telchine Pigaches",
	left_ring	=	"Lebeche Ring",		
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Chainspell"] = {body = RELIC.Body}
	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
    sets.midcast.Orpheus = {
        --waist="Orpheus's Sash", -- Commented cause I dont have one yet
    }  
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
	head		=	"Pixie Hairpin +1",
	waist		=	"Refoccilation Stone",
	left_ring	=	"Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
	waist		=	"Refoccilation Stone",
    }	

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Snotra Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Shiva Ring +1",
		right_ring="Freke Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }

    sets.midcast.nuking.normal = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Sanctity Necklace",
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Shiva Ring +1",
		right_ring="Freke Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppelande +1",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Ea Slops",
		feet="Jhakri Pigaches +2",
		neck="Mizu. Kubikazari",
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Freke Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    })
	
	
    
	sets.midcast.nuking.acc = {
		main="Maxentius",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Ea Hat +1",
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Fast Cast"+3','MND+2','"Mag.Atk.Bns."+13',}},
		feet="Jhakri Pigaches +2",
		neck="Sanctity Necklace",
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Shiva Ring +1",
		right_ring="Freke Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
		main="Maxentius",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Ea Hat +1",
		body="Ea Houppelande +1",
		hands={ name="Amalric Gages", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		legs="Ea Slops",
		feet="Jhakri Pigaches +2",
		neck="Mizu. Kubikazari",
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Mujin Band",
		right_ring="Freke Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    })	
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod
    sets.midcast.Enfeebling.macc = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy tabard +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+30','CHR+3','"Mag.Atk.Bns."+10',}},
		feet="Vitiation Boots +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {

	})
	--Type B-potency from: Mnd & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.mndpot = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy tabard +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+30','CHR+3','"Mag.Atk.Bns."+10',}},
		feet="Vitiation Boots +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }
	-- Type C-potency from: Int & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.intpot = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy tabard +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+30','CHR+3','"Mag.Atk.Bns."+10',}},
		feet="Vitiation Boots +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring="Stikini Ring +1",
		right_ring="Freke Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }
	--Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillpot = {
		main="Daybreak",main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy tabard +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+30','CHR+3','"Mag.Atk.Bns."+10',}},
		feet="Vitiation Boots +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }
	-- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillmndpot = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy tabard +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+30','CHR+3','"Mag.Atk.Bns."+10',}},
		feet="Vitiation Boots +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }
	-- Type F-potency from "Enfeebling potency" gear only
    sets.midcast.Enfeebling.skillmndpot = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy tabard +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+30','CHR+3','"Mag.Atk.Bns."+10',}},
		feet="Vitiation Boots +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }
	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {
		main={ name="Colada", augments={'Enh. Mag. eff. dur. +2','INT+6','Mag. Acc.+23','"Mag.Atk.Bns."+11',}},
		sub="Arendsi Fleuret",
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body="Viti. Tabard +3",
		hands="Atrophy gloves +2",
		legs={ name="Telchine Braconi", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
		feet="Leth. Houseaux +1",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Augment. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +7','Mag. Acc.+7','Enh. Mag. eff. dur. +13',}},
    }
    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {
		main="Pukulatmuj +1",
		sub="Pukulatmuj",
		ammo="Staunch Tathlum +1",
		head="Umuthi Hat",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Viti. Gloves +2", augments={'Enhancing Magic duration',}},
		legs="Atrophy Tights +1",
		feet="Leth. Houseaux +1",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Augment. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +7','Mag. Acc.+7','Enh. Mag. eff. dur. +13',}},
    }) 

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {
        head		=	EMPY.Head,
        hands		=	AF.Hands,
        legs		=	EMPY.Legs,
	})  


    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing.duration, {
		main={ name="Colada", augments={'Enh. Mag. eff. dur. +2','INT+6','Mag. Acc.+23','"Mag.Atk.Bns."+11',}},
		sub="Arendsi Fleuret",
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body="Taeon tabard",
		hands={ name="Taeon Gloves", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +2',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -7%','Phalanx +3',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Augment. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +5','Enha.mag. skill +7','Mag. Acc.+7','Enh. Mag. eff. dur. +13',}},
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.duration, {
		waist		=	"Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
	    head={ name="Amalric Coif", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
	
	})
	
	sets.midcast['Impact'] = set_combine(sets.midcast.nuking, {head=empty, body="Twilight Cloak"})

    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
		main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Ammurapi Shield",
		range="Ullr",
		head="Pixie Hairpin +1",
		body="Jhakri Robe +2",
		hands={ name="Amalric Gages", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Fast Cast"+3','MND+2','"Mag.Atk.Bns."+13',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+7','Magic burst dmg.+10%','CHR+1','"Mag.Atk.Bns."+4',}},
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Digni. Earring",
		right_ear="Malignance Earring",
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		main="Chatoyant Staff",
		sub="Enki Strap",
		ammo="Regal Gem",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Kaykaus Tights", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		feet={ name="Kaykaus Boots", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{

    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.cursna = set_combine(sets.midcast.casting, {
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}},
		body="Atrophy tabard +2",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Debilis medallion",
		waist="Gishdubar Sash",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Oretan. Cape +1",
    })

	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end