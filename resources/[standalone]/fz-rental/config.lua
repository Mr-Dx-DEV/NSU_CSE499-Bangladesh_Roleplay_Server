Config = {}
Config.useBlips = true        -- Show blips on the map.
Config.useTarget = true       -- Use ox_target for interaction.
Config.fuelSystem =
'ox_fuel'                     -- Fuel system to use. Options: 'ox_fuel' or 'LegacyFuel' make sure to start the resource before this one.
Config.keybind = 38           -- Control index for the TextUI. Default is 'E' (38) Change locals file for UI text. https://docs.fivem.net/docs/game-references/controls/#controls

Config.minRentTime = 1        -- Minimum rental time in hours.
Config.maxRentTime = 24       -- Maximum rental time in hours.

Config.moneytype = 'bank'     -- Type of money used for transactions. Options: 'cash' or 'bank'.

Config.peds = {
    car_rental1 = {                                          -- Unique identifier.
        model = 'a_m_m_hasjew_01',                           -- Model for the ped.
        coords = vec4(-512.64, -260.97, 34.4, 202.53),    -- Coordinates for the rental service ped.
        scenario = 'WORLD_HUMAN_CLIPBOARD',                  -- Animation scenario for the ped.
        spawncoords = vec4(-509.99, -261.98, 34.48, 291.91), -- Coords for spawning vehicles.
        blip = {
            sprite = 225,                                    -- Icon for the blip. https://docs.fivem.net/docs/game-references/blips/
            scale = 1.0,                                     -- Size of the blip.
            colour = 2,                                      -- Color of the blip. https://docs.fivem.net/docs/game-references/blips/#blip-colors
            label = 'Rental Service',
        },
        zoneOptions = { -- Used when UseTarget is false.
            length = 3.0,
            width = 3.0,
            debugPoly = false, -- Only used for debugging.
        },
    },
  
}

Config.vehicles = {
    car_rental1 = {
       
        -- 🔰 Your Added Vehicles Below
        {
            name = 'B350 MG',
            description = 'A reliable motorbike.',
            model = 'b350mg',
            price = 50,
            icon = 'car',
        },
        {
            name = 'FT22 MG',
            description = 'A lightweight commuter bike.',
            model = 'ft22mg',
            price = 45,
            icon = 'car',
        },
        {
            name = 'Legender G5',
            description = 'A premium SUV model.',
            model = 'legenderg5',
            price = 120,
            icon = 'car',
        },
        {
            name = 'S11C MG',
            description = 'A compact stylish bike.',
            model = 's11cmg',
            price = 40,
            icon = 'car',
        },
        {
            name = 'Splendor MG',
            description = 'A classic and efficient bike.',
            model = 'splendormg',
            price = 35,
            icon = 'car',
        },
        {
            name = 'Swift MG',
            description = 'A compact hatchback car.',
            model = 'swiftmg',
            price = 90,
            icon = 'car',
        },
        {
            name = 'Thar 2021 MG',
            description = 'A rugged 4x4 off-road SUV.',
            model = 'thar21mg',
            price = 130,
            icon = 'car',
        },
    }

   
}
