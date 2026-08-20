Config, Types, Bones = {}, {}, {}
Types[1], Types[2], Types[3] = {}, {}, {}

-- This is the vehicle bones table, this is needed to verify if the vehicle bone exists when checking them, here is a list of vehicle bones you can use, all of them are included in this table: https://wiki.rage.mp/index.php?title=Vehicle_Bones
Config.VehicleBones = {'chassis', 'chassis_lowlod', 'chassis_dummy', 'seat_dside_f', 'seat_dside_r', 'seat_dside_r1', 'seat_dside_r2', 'seat_dside_r3', 'seat_dside_r4', 'seat_dside_r5', 'seat_dside_r6', 'seat_dside_r7', 'seat_pside_f', 'seat_pside_r', 'seat_pside_r1', 'seat_pside_r2', 'seat_pside_r3', 'seat_pside_r4', 'seat_pside_r5', 'seat_pside_r6', 'seat_pside_r7', 'window_lf1', 'window_lf2', 'window_lf3', 'window_rf1', 'window_rf2', 'window_rf3', 'window_lr1', 'window_lr2', 'window_lr3', 'window_rr1', 'window_rr2', 'window_rr3', 'door_dside_f', 'door_dside_r', 'door_pside_f', 'door_pside_r', 'handle_dside_f', 'handle_dside_r', 'handle_pside_f', 'handle_pside_r', 'wheel_lf', 'wheel_rf', 'wheel_lm1', 'wheel_rm1', 'wheel_lm2', 'wheel_rm2', 'wheel_lm3', 'wheel_rm3', 'wheel_lr', 'wheel_rr', 'suspension_lf', 'suspension_rf', 'suspension_lm', 'suspension_rm', 'suspension_lr', 'suspension_rr', 'spring_rf', 'spring_lf', 'spring_rr', 'spring_lr', 'transmission_f', 'transmission_m', 'transmission_r', 'hub_lf', 'hub_rf', 'hub_lm1', 'hub_rm1', 'hub_lm2', 'hub_rm2', 'hub_lm3', 'hub_rm3', 'hub_lr', 'hub_rr', 'windscreen', 'windscreen_r', 'window_lf', 'window_rf', 'window_lr', 'window_rr', 'window_lm', 'window_rm', 'bodyshell', 'bumper_f', 'bumper_r', 'wing_rf', 'wing_lf', 'bonnet', 'boot', 'exhaust', 'exhaust_2', 'exhaust_3', 'exhaust_4', 'exhaust_5', 'exhaust_6', 'exhaust_7', 'exhaust_8', 'exhaust_9', 'exhaust_10', 'exhaust_11', 'exhaust_12', 'exhaust_13', 'exhaust_14', 'exhaust_15', 'exhaust_16', 'engine', 'overheat', 'overheat_2', 'petrolcap', 'petrolcap', 'petroltank', 'petroltank_l', 'petroltank_r', 'steering', 'hbgrip_l', 'hbgrip_r', 'headlight_l', 'headlight_r', 'taillight_l', 'taillight_r', 'indicator_lf', 'indicator_rf', 'indicator_lr', 'indicator_rr', 'brakelight_l', 'brakelight_r', 'brakelight_m', 'reversinglight_l', 'reversinglight_r', 'extralight_1', 'extralight_2', 'extralight_3', 'extralight_4', 'numberplate', 'interiorlight', 'siren1', 'siren2', 'siren3', 'siren4', 'siren5', 'siren6', 'siren7', 'siren8', 'siren9', 'siren10', 'siren11', 'siren12', 'siren13', 'siren14', 'siren15', 'siren16', 'siren17', 'siren18', 'siren19', 'siren20', 'siren_glass1', 'siren_glass2', 'siren_glass3', 'siren_glass4', 'siren_glass5', 'siren_glass6', 'siren_glass7', 'siren_glass8', 'siren_glass9', 'siren_glass10', 'siren_glass11', 'siren_glass12', 'siren_glass13', 'siren_glass14', 'siren_glass15', 'siren_glass16', 'siren_glass17', 'siren_glass18', 'siren_glass19', 'siren_glass20', 'spoiler', 'struts', 'misc_a', 'misc_b', 'misc_c', 'misc_d', 'misc_e', 'misc_f', 'misc_g', 'misc_h', 'misc_i', 'misc_j', 'misc_k', 'misc_l', 'misc_m', 'misc_n', 'misc_o', 'misc_p', 'misc_q', 'misc_r', 'misc_s', 'misc_t', 'misc_u', 'misc_v', 'misc_w', 'misc_x', 'misc_y', 'misc_z', 'misc_1', 'misc_2', 'weapon_1a', 'weapon_1b', 'weapon_1c', 'weapon_1d', 'weapon_1a_rot', 'weapon_1b_rot', 'weapon_1c_rot', 'weapon_1d_rot', 'weapon_2a', 'weapon_2b', 'weapon_2c', 'weapon_2d', 'weapon_2a_rot', 'weapon_2b_rot', 'weapon_2c_rot', 'weapon_2d_rot', 'weapon_3a', 'weapon_3b', 'weapon_3c', 'weapon_3d', 'weapon_3a_rot', 'weapon_3b_rot', 'weapon_3c_rot', 'weapon_3d_rot', 'weapon_4a', 'weapon_4b', 'weapon_4c', 'weapon_4d', 'weapon_4a_rot', 'weapon_4b_rot', 'weapon_4c_rot', 'weapon_4d_rot', 'turret_1base', 'turret_1barrel', 'turret_2base', 'turret_2barrel', 'turret_3base', 'turret_3barrel', 'ammobelt', 'searchlight_base', 'searchlight_light', 'attach_female', 'roof', 'roof2', 'soft_1', 'soft_2', 'soft_3', 'soft_4', 'soft_5', 'soft_6', 'soft_7', 'soft_8', 'soft_9', 'soft_10', 'soft_11', 'soft_12', 'soft_13', 'forks', 'mast', 'carriage', 'fork_l', 'fork_r', 'forks_attach', 'frame_1', 'frame_2', 'frame_3', 'frame_pickup_1', 'frame_pickup_2', 'frame_pickup_3', 'frame_pickup_4', 'freight_cont', 'freight_bogey', 'freightgrain_slidedoor', 'door_hatch_r', 'door_hatch_l', 'tow_arm', 'tow_mount_a', 'tow_mount_b', 'tipper', 'combine_reel', 'combine_auger', 'slipstream_l', 'slipstream_r', 'arm_1', 'arm_2', 'arm_3', 'arm_4', 'scoop', 'boom', 'stick', 'bucket', 'shovel_2', 'shovel_3', 'Lookat_UpprPiston_head', 'Lookat_LowrPiston_boom', 'Boom_Driver', 'cutter_driver', 'vehicle_blocker', 'extra_1', 'extra_2', 'extra_3', 'extra_4', 'extra_5', 'extra_6', 'extra_7', 'extra_8', 'extra_9', 'extra_ten', 'extra_11', 'extra_12', 'break_extra_1', 'break_extra_2', 'break_extra_3', 'break_extra_4', 'break_extra_5', 'break_extra_6', 'break_extra_7', 'break_extra_8', 'break_extra_9', 'break_extra_10', 'mod_col_1', 'mod_col_2', 'mod_col_3', 'mod_col_4', 'mod_col_5', 'handlebars', 'forks_u', 'forks_l', 'wheel_f', 'swingarm', 'wheel_r', 'crank', 'pedal_r', 'pedal_l', 'static_prop', 'moving_prop', 'static_prop2', 'moving_prop2', 'rudder', 'rudder2', 'wheel_rf1_dummy', 'wheel_rf2_dummy', 'wheel_rf3_dummy', 'wheel_rb1_dummy', 'wheel_rb2_dummy', 'wheel_rb3_dummy', 'wheel_lf1_dummy', 'wheel_lf2_dummy', 'wheel_lf3_dummy', 'wheel_lb1_dummy', 'wheel_lb2_dummy', 'wheel_lb3_dummy', 'bogie_front', 'bogie_rear', 'rotor_main', 'rotor_rear', 'rotor_main_2', 'rotor_rear_2', 'elevators', 'tail', 'outriggers_l', 'outriggers_r', 'rope_attach_a', 'rope_attach_b', 'prop_1', 'prop_2', 'elevator_l', 'elevator_r', 'rudder_l', 'rudder_r', 'prop_3', 'prop_4', 'prop_5', 'prop_6', 'prop_7', 'prop_8', 'rudder_2', 'aileron_l', 'aileron_r', 'airbrake_l', 'airbrake_r', 'wing_l', 'wing_r', 'wing_lr', 'wing_rr', 'engine_l', 'engine_r', 'nozzles_f', 'nozzles_r', 'afterburner', 'wingtip_1', 'wingtip_2', 'gear_door_fl', 'gear_door_fr', 'gear_door_rl1', 'gear_door_rr1', 'gear_door_rl2', 'gear_door_rr2', 'gear_door_rml', 'gear_door_rmr', 'gear_f', 'gear_rl', 'gear_lm1', 'gear_rr', 'gear_rm1', 'gear_rm', 'prop_left', 'prop_right', 'legs', 'attach_male', 'draft_animal_attach_lr', 'draft_animal_attach_rr', 'draft_animal_attach_lm', 'draft_animal_attach_rm', 'draft_animal_attach_lf', 'draft_animal_attach_rf', 'wheelcover_l', 'wheelcover_r', 'barracks', 'pontoon_l', 'pontoon_r', 'no_ped_col_step_l', 'no_ped_col_strut_1_l', 'no_ped_col_strut_2_l', 'no_ped_col_step_r', 'no_ped_col_strut_1_r', 'no_ped_col_strut_2_r', 'light_cover', 'emissives', 'neon_l', 'neon_r', 'neon_f', 'neon_b', 'dashglow', 'doorlight_lf', 'doorlight_rf', 'doorlight_lr', 'doorlight_rr', 'unknown_id', 'dials', 'engineblock', 'bobble_head', 'bobble_base', 'bobble_hand', 'chassis_Control'}

----------------------------------------------------------------------------------------
-- Settings
----------------------------------------------------------------------------------------

-- Set to true to enable standalone functionality
Config.Standalone = false

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 3.0

-- Enable debug options and distance preview
Config.Debug = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = false

-- Key to open the target
Config.OpenKey = 'LMENU' -- Left Alt
Config.OpenControlKey = 19 -- Control for keypress detection also Left Alt, controls are found here https://docs.fivem.net/docs/game-references/controls/

-- Key to open the menu
Config.MenuControlKey = 237 -- Control for keypress detection, this is the Right Mouse Button, controls are found here https://docs.fivem.net/docs/game-references/controls/

----------------------------------------------------------------------------------------
-- Target Configs
----------------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {
	-- MRPD
    --duty
    ["PDDuty"] = {
        name = "PDDuty",
        coords = vector3(631.73, 8.78, 82.63),
        length = 0.2,
        width = 0.6,
        heading = 330,
        debugPoly = false,
        minZ = 82.43,
        maxZ = 83.03,
        options = {
            {
                type = "client",
                event = "Toggle:Duty",
                icon = "far fa-clipboard",
                label = "Sign In / Out",
                job = "police",
            },
        },
        distance = 1.5
    },
    --bossmenu
	   ["mrpdbossmenu"] = {
        name = "mrpdbossmenu",
        coords = vector3(607.16, 12.58, 82.63),
        length = 0.6,
        width = 0.2,
        heading = 330,
        debugPoly = false,
        minZ = 82.43,
        maxZ = 83.03,
        options = {
            {
                type = "client",
                event = "qb-bossmenu:client:openMenu",
                icon = "far fa-clipboard",
                label = "Boss Menu",
                job = {["police"] = 9,}
            },
        },
        distance = 1.5
    },
    --armory
    ["PDArmory"] = {
        name = "PDArmory",
        coords = vector3(600.66, -19.64, 87.49),
        length = 2.8,
        width = 0.6,
        heading = 340,
        debugPoly = false,
        minZ = 86.49,
        maxZ = 89.09,
        options = {
            {
                type = "client",
                event = "police:openPDArmory",
                icon = "fas fa-shield-alt",
                label = "Police Armory",
                job = "police"
            }
        },
        distance = 1.5
    },
    --stash
    ["mrpdpersonalstash"] = {
        name = "MissionRowPersonalStash",
        coords = vector3(603.93, -18.45, 87.49),
        length = 0.2,
        width = 4.0,
        heading = 340,
        debugPoly = false,
        minZ = 86.89,
        maxZ = 87.69,
        options = {
            {
              type = "client",
              event = "police:client:pstash",
              icon = "fas fa-sign-in-alt",
              label = "Open Personal Stash",
              job = "police",
            },
        },
        distance = 2.5
    },
    --fingerprint
    ["fingerprint"] = {
        name = "fingerprint",
        coords = vector3(595.18, 12.05, 76.63),
        length = 0.6,
        width =  0.6,
        heading = 350,
        debugPoly = false,
        minZ = 76.63,
        maxZ = 77.03,
        options = {
            {
                type = "client",
                event = "police:client:fingerprint",
                icon = "fas fa-fingerprint",
                label = "Fingerprint Station",
                job = "police",
            },
        },
        distance = 1.5
    },

    --Outfit
	["mrpdoutfit"] = {
        name = "mrpdoutfit",
        coords = vector3(623.08, 1.98, 76.63),
        length = 0.2,
        width = 0.8,
        heading = 350,
        debugPoly = false,
        minZ = 76.43,
        maxZ = 77.63,
        options = {
            {
                type = "client",
                event = "qb-clothing:client:openOutfitMenu",
                icon = "fas fa-shield-alt",
                label = "PD Outfit",
                job = "police"
            },
            {
                type = "client",
                event = "nh-context:opendress2",
                icon = "fas fa-shield-alt",
                label = "PD Clothing",
                job = "police"
            },
        },
        distance = 1.5
    },


    --bcso

    ["BCSODuty"] = {
        name = "BCSODuty",
        coords = vector3(1852.80, 3687.80, 34.22),
        length = 0.5,
        width = 0.4,
        heading = 20,
        debugPoly = false,
        minZ = 34.05,
        maxZ = 34.40,
        options = {
            {
                type = "client",
                event = "Toggle:Duty",
                icon = "far fa-clipboard",
                label = "Sign In / Out",
                job = "police",
            },
        },
        distance = 1.5
    },

    ["BCSOArmory"] = {
        name = "BCSOArmory",
        coords = vector3(1861.85, 3688.25, 34.22),
        length = 1.0,
        width = 1.8,
        heading = 30.0,
        debugPoly = false,
        minZ = 34.30,
        maxZ = 35.50,
        options = {
            {
                type = "client",
                event = "police:openPDArmory",
                icon = "fas fa-shield-alt",
                label = "Police Armory",
                job = "police"
            }
        },
        distance = 1.5
    }, 

    ["bcsopersonalstash"] = {
        name = "BlaneCountyPersonalStash",
        coords = vector3(1853.23, 3689.50, 29.82),
        length = 2.80,
        width = 0.50,
        heading = 120.0,
        debugPoly = false,
        minZ = 27.62,
        maxZ = 30.49,
        options = {
            {
              type = "client",
              event = "police:client:pstash",
              icon = "fas fa-sign-in-alt",
              label = "Open Personal Stash",
              job = "police",
            },
        },
        distance = 2.5
    },

    ["BCSOfingerprint"] = {
        name = "BCSOfingerprint",
        coords = vector3(1844.45, 3692.50, 34.19),
        length = 0.4,
        width = 0.4,
        heading = 30.00,
        debugPoly = false,
        minZ = 33.90,
        maxZ = 34.20,
        options = {
            {
                type = "client",
                event = "police:client:fingerprint",
                icon = "fas fa-fingerprint",
                label = "Fingerprint Station",
                job = "police",
            },
        },
        distance = 1.5
    },
 --------/ EMS Stash

    ["EMSstash"] = {
        name = "EMSstash",
        coords = vector3(306.18, -601.94, 43.28),
        length = 0.2,
        width = 1,
        heading = 340,
        debugPoly = false,
        minZ = 42.28,
        maxZ = 44.68,
        options = {
            {
                type = "client",
                event = "hospital:openEMSPersonal",
                icon = "fas fa-shopping-cart",
                label = "Open Personal Stash",
                job = "ambulance",
            }
        },
        distance = 2.5
    },
    -----------Bosmenu
    ["EMSBossMenu"] = {
        name = "EMS-BossMenu",
        coords = vector3(335.84, -594.28, 43.28),
        length = 0.6,
        width = 0.2,
        heading = 345,
        debugPoly = false,
        minZ=43.08,
        maxZ=43.68,
        options = {
            {
                type = "client",
                event = "qb-bossmenu:client:openMenu",
                icon = "far fa-clipboard",
                label = "Boss Menu",
                job = {["ambulance"] = 10,}
            }
        },
        distance = 2.5
    },
     --Outfit
	["EMSpdoutfit"] = {
        name = "EMSpdoutfit",
        coords = vector3(300.2, -597.72, 43.28),
        length = 0.6,
        width = 0.4,
        heading = 5,
        debugPoly = false,
        minZ=42.68,
        maxZ=42.88,
        options = {
            {
                type = "client",
                event = "qb-clothing:client:openOutfitMenu",
                icon = "fas fa-shield-alt",
                label = "EMS Outfit",
                job = "ambulance"
            },
        },
        distance = 1.5
    },

    --Clothing
	["EMSClothing"] = {
        name = "EMSClothing",
        coords = vector3(302.84, -598.45, 43.28),
        length = 0.4,
        width = 0.4,
        heading = 340,
        debugPoly = false,
        minZ = 42.48,
        maxZ = 44.48,
        options = {
            {
                type = "client",
                event = "nh-context:opendress2",
                icon = "fas fa-shield-alt",
                label = "EMS Clothing",
                job = "ambulance"
            },
        },
        distance = 1.5
    },
    ----- Plastic Surgery

     ["surgery"] = {
        name = "surgery",
        coords = vector3(322.62, -572.57, 43.28),
        length = 2.6,
        width = 1,
        heading = 340,
        debugPoly = false,
        minZ = 42.28,
        maxZ = 44.48,
        options = {
            {
                type = "client",
                event = "qb-plastic:surgery",
                icon = "far fa-clipboard",
                label = "Plastic Surgery",
            }
        },
        distance = 1.5
    },
    ----- Checkin

     ["Checkin"] = {
        name = "Checkin",
        coords = vector3(307.54, -595.31, 43.28),
        length = 0.4,
        width = 0.5,
        heading = 65,
        debugPoly = false,
        minZ = 42.88,
        maxZ = 43.28,
        options = {
            {
                type = "client",
                event = "Hospital:CheckIn",
                icon = "far fa-clipboard",
                label = "📋Check In",
            }
        },
        distance = 1.5
    },

    ---hunting plus fishing
    ["fishing"] = {
        name = "fishing",
        coords = vector3(-1593.5, 5197.9, 4.36),
        length = 0.60,
        width = 0.60,
        heading = 55.0,
        debugPoly = false,
        minZ = 4.30,
        maxZ = 4.80,
        options = {
            {
              type = "client",
              event = "crfw:client:buyFishingGear",
              icon = "far fa-fish",
              label = "Fishing Gear",
            },
        },
        distance = 2.0
    },

    ["MechStash"] = {
        name = "MechStash",
        coords = vector3(128.62, -3014.69, 7.04),
        length = 1.6,
        width = 2.8,
        heading = 0,
        debugPoly = false,
		minZ = 6.04,
        maxZ = 9.24,
        options = {
            {
                type = "client",
                event = "MechStash",
                icon = "fas fa-archive",
                label = "Mechanic Stash",
                job = "mechanic",
            }
        },
        distance = 2.5
    },
    ["MechanicDuty"] = {
        name = "MechanicDuty",
        coords = vector3(123.59, -3007.86, 7.04),
        length = 0.4,
        width = 0.2,
        heading = 0,
        debugPoly = false,
		minZ = 7.44,
        maxZ = 7.84,
        options = {
            {
                type = "client",
                event = "Toggle:Duty",
                icon = "far fa-clipboard",
                label = "Sign In / Out",
                job = "mechanic",
            }
        },
        distance = 2.5
    },
    -----------Bosmenu
    ["MechanBossMenu"] = {
        name = "MechanBossMenu",
        coords = vector3(125.41, -3014.83, 7.04),
        length = 0.4,
        width = 0.4,
        heading = 355,
        debugPoly = false,
        minZ=6.84,
        maxZ=7.04,
        options = {
            {
                type = "client",
                event = "qb-bossmenu:client:openMenu",
                icon = "far fa-clipboard",
                label = "Boss Menu",
                job = {["mechanic"] = 4,}
            }
        },
        distance = 2.5
    },


------/ Jewel Heist  

    ["jewelheist"] = {
        name = "jewelheist",
        coords = vector3(-595.8919, -283.6023, 50.3237),
        length = 1.00,
        width = 1.00,
        heading = 302.7994,
        debugPoly = false,
        minZ = 50.00,
        maxZ = 51.40,
        options = {
            {
              type = "client",
              event = "qb-jewellery:client:startheist",
              icon = "fas fa-gem",
              label = "Disable Cameras",
            },
        },
        distance = 5.0
    },
    ["jewelheistdoor"] = {
        name = "jewelheistdoor",
        coords = vector3(-619.9963, -223.90, 38.3175),
        length = 0.30,
        width = 0.40,
        heading = 38.5005,
        debugPoly = false,
        minZ = 38.50,
        maxZ = 38.80,
        options = {
            {
              type = "client",
              event = "qb-jewellery:client:UsePinkCard",
              icon = "fas fa-id-card-alt",
              label = "Disable Doors",
            },
        },
        distance = 5.0
    },
    -----------GarbageJob
    ["Garbagebus-Return"] = {
        name = "Garbagebus-Return",
        coords = vector3(-334.11, -1565.61, 24.95),
        length = 4.4,
        width = 11.4,
        heading = 330,
        debugPoly = false,
        minZ = 24.15,
        maxZ = 28.15,
        options = {
            {
              type = "client",
              event = "garbage:returnTruck",
              icon = "fas fa-shopping-cart",
              label = "Return GarbageBus",
            },
        },
        distance = 5.0
    },
    ---------Trucker
    ["Trucker"] = {
        name = "Trucker",
        coords = vector3(-552.49, 5347.43, 74.74),
        length = 0.8,
        width = 0.4,
        heading = 340,
        debugPoly = false,
        minZ=74.94,
        maxZ=75.94,
        options = {
            {
              type = "client",
              event = "GG:Trucker",
              icon = "fas fa-shopping-cart",
              label = "Start Tracker",
              job = "trucker",
            },
        },
        distance = 5.0
    },
    ---------RepairStation
    ["RepairStation"] = {
        name = "RepairStation",
        coords = vector3(532.4, -176.82, 54.22),
        length = 6.4,
        width = 9.2,
        heading = 5,
        debugPoly = false,
        minZ=53.22,
        maxZ=57.22,
        options = {
            {
              type = "client",
              event = "khrp:fixCarS",
              icon = "fas fa-car",
              label = "Repair Vehicle",
            },
        },
        distance = 5.0
    },
    ---------HotDogStartJob
    ["HotDogStartJob"] = {
        name = "HotDogStartJob",
        coords = vector3(49.22, -1000.63, 29.34),
        length = 0.8,
        width = 1.4,
        heading = 340,
        debugPoly = false,
        minZ=28.34,
        maxZ=30.94,
        options = {
            {
              type = "client",
              event = "GG-Hotdog:Start",
              icon = "fas fa-car",
              label = "Start Hotdog",
              job = 'hotdog'
            },
            {
                type = "client",
                event = "GG-Hotdog:stop",
                icon = "fas fa-car",
                label = "Stop Hotdog",
                job = 'hotdog'
            },
        },
        distance = 5.0
    },
}

Config.PolyZones = {

}

Config.TargetBones = {
    ["bones"] = {
        bones = {
            'boot', 
            'rudder', 
            'rudder2', 
            'petrolcap', 
            'petroltank', 
            'petroltank_l', 
            'petroltank_r',
        },
        options = {
      {
        type = "client",
        event = "sjrp-fuel:client:SendMenuToServer",
        icon = "fas fa-gas-pump",
        label = "Refuel Vehicle",
      },
        },
          distance = 1.0
    },

    -- cars refule
    ["main"] = {
        bones = {
            "door_dside_f",
            "door_dside_r",
            "door_pside_f",
            "door_pside_r"
        },
        options = {
      { 
        type = "client",
        event = "sjrp-fuel:client:SendMenuToServer",
        icon = "fas fa-gas-pump",
        label = "Refuel Vehicle",
      },
        },
          distance = 1.0
    },
    -- flipcar
    ["caroptions"] = {
        bones = {
            "door_dside_f",
            "door_dside_r",
            "door_pside_f",
            "door_pside_r",
            "chassis"
        },
        options = {
       {
        type = "client",
        event = "vehiclekeys:client:GiveKeys",
        parameters = {},
        icon = "fas fa-key",
        label = "Give Key",
       },
       {
        type = "client",
        event = "police:client:PutPlayerInVehicle",
        icon = "fas fa-chevron-circle-left",
        label = "PLACE IN VEHICLE",
       },
       {
        type = "client",
        event = "police:client:SetPlayerOutVehicle",
        icon = "fas fa-chevron-circle-right",
        label = "TAKE OUT OF VEHICLE",
       },
       {
        type = "client",
        event = "police:client:ImpoundVehicle",
        icon = "fas fa-car",
        label = "IMPOUND VEHICLE",
        job = 'police'
       },
       {
        type = "client",
        event = "qb-trunk:client:GetIn",
        icon = "fas fa-user-secret",
        label = "GET IN TRUNK",
       },
       {
        type = "client",
        event = "vehicle:flipit",
        parameters = {},
        icon = "fas fa-car-crash",
        label = "Flip Vehicle",
       },
        },
          distance = 1.0
    },

    -----------Legacy Fuel
    ["fuel"] = {
        models = {
            'boot', 
            'rudder', 
            'rudder2', 
            'petrolcap', 
            'petroltank', 
            'petroltank_l', 
            'petroltank_r',
        },
        options = {
            {
                type = "client",
                event = "crfw-fuel:client:fuel",
                icon = "fas fa-gas-pump",
                label = "Refuel Car",
            },
            {
                type = "client",
                event = "crfw-fuel:client:fuelcan",
                icon = "fas fa-burn",
                label = "Buy Jerry Can",
            },
    },
    distance = 2.5
    }, 

}

Config.TargetEntities = {

}

Config.TargetModels = {
    ---rental
    ["VehicleRental"] = {
        models = {
            `a_f_y_runner_01`,
        },
        options = {
            {
                type = "client",
                event = "qb-rental:openMenu",
                icon = "fas fa-car",
                label = "Rent Vehicle",
            },
        },
        distance = 4.0
    },
  
  -- jewellery rob
  ["jewelboxes"] = {
	models = {
		`des_jewel_cab3_start`,
		`des_jewel_cab2_start`,
		`des_jewel_cab_start`,
		`des_jewel_cab4_start`,

	},
	options = {
		{
			type = "client",
			event = "qb-jewellery:client:startbreakinglass",
			icon = "fas fa-gem",
			label = "Break Glass",
		},
	},
	distance = 4.0
},

----- ATM Menu

["atms"] = {        
	models = {            
		'prop_atm_01',            
		'prop_atm_02',            
		'prop_atm_03',            
		'prop_fleeca_atm',        
	},        
	options = {            
		{                
			  type = "command",                
			  event = "atm",                
			  icon = "fas fa-credit-card",                
			  label = "Insert Card",            
		},        
	},        
	distance = 1.0    
},

    --------- Blackmarket
    ["blackmarket"] = {
        models = {
            "g_m_m_chicold_01",
        },
        options = {
            {
                type = "client",
                event = "market:client:SellMenu",
                icon = "fas fa-theater-masks",
                label = "blackmarket",
            },
        },
        distance = 2.0
    },

    --degitalden
    ["degitalden"] = {
        models = {
            'ig_lifeinvad_01',
        },
        options = {
            {
                type = "client", 
                event = "qb-shops:marketshop",
                icon = 'fas fa-laptop', 
                label = 'Want to be a tech expart?',

            },
        },
        distance = 2.0
    },
}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {
    options = {
        {
            type = "client",
            event = "qb-phone:client:GiveContactDetails",
            icon = "fas fa-address-book",
            label = "Give Contact Details",
        },
        {
            event = "police:client:RobPlayer",
            icon = "fas fa-user-secret",
            label = "Rob Player",
        },
        {
            type = "client",
            event = "police:client:CuffPlayer",
            icon = "fas fa-hands",
            label = "Cuff / Uncuff",
            job = "police",
            item = 'handcuffs',
        },
        {
          type = "client",
          event = "police:client:EscortPlayer",
          icon = "fas fa-key",
          label = "Escort",
        },
        {
            type = "client",
            event = "police:client:PutPlayerInVehicle",
            icon = "fas fa-chevron-circle-left",
            job = 'police',
            label = "Place in Vehicle",
        },
        {
            type = "client",
            event = "police:client:SetPlayerOutVehicle",
            icon = "fas fa-chevron-circle-right",
            job = 'police',
            label = "Take out of Vehicle",
        },
    }
}

Config.Peds = {

 	---Grandma 

	["grandma"] = {
		model = "ig_mrs_thornhill",
		coords = vector4(1443.43, 6333.52, 23.88, 83.82),
		minusOne = true,
		freeze = true,
		invincible = true,
		blockevents = true,
		target = {
			options = {
				{
					type = "client",
					event = "grandma:client:healing",
					icon = "fas fa-band-aid",
					label = "Request Healing For 1200$",
				},
			},
			distance = 1.5,
		},
		currentpednumber = 0,
	},
    ["GarbagePed"] = {
        model = 's_m_y_garbage', 
        coords = vector4(-349.96, -1569.92, 25.22, 296.46),
        minusOne = true, 
        freeze = true, 
        invincible = true, 
        blockevents = true,
        target = { 
            options = {
               {
                 type = "server",
                 event = "garbage:server:getGarbageJob",
                 icon = "fas fa-sign-in-alt",
                 label = "Get Garbage Job",
                },
               {
                 type = "client",
                 event = "garbage:getTruck",
                 icon = "fas fa-sign-in-alt",
                 label = "Get Garbage Truck",
                },
               {
                 type = "server",
                 event = "garbagejob:server:PayShift",
                 icon = "fas fa-sign-in-alt",
                 label = "Collect Pay Check",
                },
            },
            distance = 1.5,
        },
    },
    --Hunting
    ["Hunting"] = {
        model = "cs_hunter",
        coords = vector4(-679.72, 5839.01, 17.33, 226.23),
        minusOne = true, 
        freeze = true, 
        invincible = true, 
        blockevents = true,
        target = {
            options = {
                {
                    event = "qb-hunting:client:interactionEvent",
                    icon = "fas fa-circle",
                    label = "Buy Gear"
                },
                {
                    event = "SJRP-HuntingSell",
                    icon = "fas fa-circle",
                    label = "Sell meats"
                }
            }, 
            distnace = 2.0
        },
    },
}

----------------------------------------------------------------------------------------
-- Functions
----------------------------------------------------------------------------------------

if Config.EnableDefaultOptions then
	function Config.ToggleDoor(vehicle, door)
		if GetVehicleDoorLockStatus(vehicle) ~= 2 then
			if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
				SetVehicleDoorShut(vehicle, door, false)
			else
				SetVehicleDoorOpen(vehicle, door, false)
			end
		end
	end
end

----------------------------------------------------------------------------------------
-- Default options
----------------------------------------------------------------------------------------

-- These options don't represent the actual way of making TargetBones or filling out Config.TargetBones, refer to the TEMPLATES.md for a template on that, this is only the way to add it without affecting the config table

if Config.EnableDefaultOptions then
	Bones['seat_dside_f'] = {
		["Toggle Front Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Front Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 0)
			end,
			distance = 1.2
		}
	}

	Bones['seat_pside_f'] = {
		["Toggle Front Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Front Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 1)
			end,
			distance = 1.2
		}
	}

	Bones['seat_dside_r'] = {
		["Toggle Rear Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Rear Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 2)
			end,
			distance = 1.2
		}
	}

	Bones['seat_pside_r'] = {
		["Toggle Rear Door"] = {
			icon = "fas fa-door-open",
			label = "Toggle Rear Door",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
			end,
			action = function(entity)
				Config.ToggleDoor(entity, 3)
			end,
			distance = 1.2
		}
	}

	Bones['bonnet'] = {
		["Toggle Hood"] = {
			icon = "fa-duotone fa-engine",
			label = "Toggle Hood",
			action = function(entity)
				Config.ToggleDoor(entity, 4)
			end,
			distance = 0.9
		}
	}
end