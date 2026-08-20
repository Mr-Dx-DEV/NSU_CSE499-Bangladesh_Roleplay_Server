Config = {}

Config.Location = {
    {
        name = "Wild Oats Drive",
        location = vector3(-174.07, 502.62, 137.42),
        inside = vector3(-173.72, 495.69, 137.57),
        exit = vector3(-174.34, 497.89, 137.67),
        outside = vector3(-177.07, 503.4, 137.03),
        loot = {
            vector3(-166.92, 495.6, 137.65),
            vector3(-165.97, 482.16, 137.27),
            vector3(-167.31, 487.45, 133.84),
            vector3(-174.65, 492.51 ,130.04),
        }
    },
    --[[{
        name = "Integrity Way",
        location = vector3(-48.29, -587.09, 37.95),
        insde = vector3(0,0,0),
        exit = vector3(0,0,0),
        loot = {
            vector3(0,0,0),
            vector3(0,0,0),
            vector3(0,0,0),
            vector3(0,0,0),
        }
    },]]

}

Config.Items = {
    normalItems = {
        "cryptostick",
        "vodka",
        "iphone",
        "samsungphone",
        "advancedlockpick",
        "electronickit",
        "armor",
        "handcuffs",
        "radio",
        "lockpick"
    },
    rareItems = {
        "tablet",
        "laptop",
        "goldchain",
        "pixellaptop",
        "diamond_ring",
    },
    veryRareItems = {
        "redphone",
    }
}

--- Location Picker

local setLocPick = math.random(1, 3) -- un-comment me out for location change
--local setLocPick = 6 -- comment me out for location change

Config.LocationSets = {
    [1] = {
        ["x"] = 634.89,
        ["y"] = 2774.95,
        ["z"] = 42.01,
        ["h"] = 276.07,
    },
    [2] = {
        ["x"] = 911.06,
        ["y"] = 3644.84,
        ["z"] = 32.68,
        ["h"] = 180.17,
    },
    [3] = {
        ["x"] = 41.34,
        ["y"] = 3705.22,
        ["z"] = 40.72,
        ["h"] = 344.52,
    },
    [4] = {
        ["x"] = 741.85,
        ["y"] = 4170.94,
        ["z"] = 41.09,
        ["h"] = 169.87,
    },
    [5] = {
        ["x"] = 1332.75,
        ["y"] = 4325.01,
        ["z"] = 38.25,
        ["h"] = 0.21,
    },
    [6] = {
        ["x"] = 2564.69,
        ["y"] = 4680.12,
        ["z"] = 34.08,
        ["h"] = 44.12,
    },
} 

Config.Locations = {
    ["market"] = {
        ["label"] = "market",
        ["type"] = "mark",
        ["coords"] = {
            [1] = {
                ["x"] = tonumber(Config.LocationSets[setLocPick]["x"]),
                ["y"] = tonumber(Config.LocationSets[setLocPick]["y"]),
                ["z"] = tonumber(Config.LocationSets[setLocPick]["z"]),
                ["h"] = tonumber(Config.LocationSets[setLocPick]["h"]),
            },
        },
    },
}

--- Shop Times

Config.Open = 8

Config.Close = 14
