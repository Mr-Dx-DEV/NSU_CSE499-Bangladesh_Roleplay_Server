local QBCore = exports['sjfw']:GetCoreObject()

RegisterServerEvent("K9:SendLanguage", function()
    local s = source
    TriggerClientEvent("K9:UpdateLanguage", s, Config.Languages[Config.LanguageChoice])
end)

RegisterServerEvent("K9:RequestOpenMenu", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if IsAuthorized(Player.PlayerData.citizenid) then
        TriggerClientEvent("K9:OpenMenu", src, Config.OpenMenuPedRestriction, Config.PedsList)
    else
      --[[    TriggerClientEvent('QBCore:Notify', source, "You cannot do this!", "error")  ]]
    end
end)

RegisterServerEvent("K9:RequestVehicleToggle", function()
    local src = source
    print("Requested Vehicle Toggle")
    TriggerClientEvent("K9:ToggleVehicle", src, Config.VehicleRestriction, Config.VehiclesList)
end)



function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval  
end