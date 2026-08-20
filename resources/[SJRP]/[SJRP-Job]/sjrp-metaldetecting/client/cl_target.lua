local QBCore = exports['sjfw']:GetCoreObject()

CreateThread(function()
    exports['sjrp-target']:SpawnPed({
        model = Config.CommonPed,
        coords = Config.CommonPedLocation, 
        minusOne = true, 
        freeze = true, 
        invincible = true, 
        blockevents = true,
        scenario = 'WORLD_HUMAN_DRUG_DEALER',
        target = { 
            options = {
                {
                    type="client",
                    event = "qb-metaldetector:CommonTradingMenu",
                    icon = "fas fa-user-secret",
                    label = "Trade your Finds"
                }
            },
          distance = 2.5,
        },
    })
    
    exports['sjrp-target']:SpawnPed({
        model = Config.RarePed, 
        coords = Config.RarePedLocation,
        minusOne = true, 
        freeze = true, 
        invincible = true, 
        blockevents = true,
        scenario = 'WORLD_HUMAN_DRUG_DEALER',
        target = { 
            options = {
                {
                    type = "client",
                    event = "qb-metaldetector:RareTradingMenu",
                    icon = "fas fa-user-secret",
                    label = "Trade your Rare Finds"
                }
            },
            distance = 2.5,
        },
    })
end)
