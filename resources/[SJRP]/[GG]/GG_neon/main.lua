local QBCore = exports['sjfw']:GetCoreObject()

QBCore.Functions.CreateUseableItem("laptop_1", function(source, item)
    local src = source
    TriggerClientEvent("showui", src)
end)