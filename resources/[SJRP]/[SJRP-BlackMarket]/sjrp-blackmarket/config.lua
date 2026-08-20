Config = {}

--- Sellable Items

Config.SellableItems = {
    ['markedbills'] = math.random(800, 1000),
    ['cryptostick'] = math.random(250,300),
    ['iphone'] = 500,
    ['samsungphone'] = 400,
    ['laptop'] = math.random(900, 1200),
    ['tablet'] = math.random(700, 1000),
    ['goldchain'] = math.random(700, 1000),
    ['10kgoldchain'] = math.random(1000, 1200),
    ['diamond_ring'] = math.random(700, 1000),
    ['goldbar'] = math.random(800, 1200),
}

--- Location Picker

local setLocPick = math.random(1, 3) -- un-comment me out for location change
--local setLocPick = 6 -- comment me out for location change

Config.LocationSets = {
    [1] = {
        ["x"] = -1422.35,
        ["y"] = -204.51,
        ["z"] = 46.5,
        ["h"] = 269.8,
    },
    [2] = {
        ["x"] = 1601.25,
        ["y"] = 3589.39,
        ["z"] = 38.77,
        ["h"] = 131.8,
    },
    [3] = {
        ["x"] = 1983.89,
        ["y"] = 5175.6,
        ["z"] = 47.64,
        ["h"] = 122.74,
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
        ["products"] = Config.Products,
    },
}

--- Shop Times

Config.Open = 8

Config.Close = 14
