QBCore = exports['sjfw']:GetCoreObject()

local wait = 60000*10

Citizen.CreateThread(function()
    while true do
        Wait(wait)
        TriggerServerEvent('crfw-paychecks:Register')
    end
end)

RegisterNetEvent('crfw-paychecks:targetcollect')
AddEventHandler('crfw-paychecks:targetcollect', function()
    TriggerServerEvent('crfw-paychecks:Collect')
end)

CreateThread(function()
    exports['sjrp-target']:AddBoxZone('paychecks', vector3(-1083.21, -246.95, 37.52), 1.5, 1.6, {
        name = 'paychecks',
        heading = 240,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "crfw-paychecks:targetcollect",
                icon = "fas fa-money-check-alt",
                label = "Collect Paycheck",
            },
        },           
        distance = 2.0
    })
end)