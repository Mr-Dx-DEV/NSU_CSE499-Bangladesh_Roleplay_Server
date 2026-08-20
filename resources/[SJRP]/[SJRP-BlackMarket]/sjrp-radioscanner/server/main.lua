local QBCore = exports['sjfw']:GetCoreObject()
local TurnedOn = {}
local HasEntered = {}
local CurrentLocation = nil
local SecretCode = nil
local PickupLocation = nil
local SetupAlready = false
local PickupProp = nil
local PickupGuards = {}
local PickupGuardsIds = {}
local PickedupAlready = false
local PossibleLocations = {
    [1] = {
        hint = 'Big Orange Ball',
        coords = vector3(2743.89, 4415.82, 48.62)
    },
    [2] = {
        hint = 'The Altruist Cult',
        coords = vector3(-1139.72, 4964.49, 222.24)
    },
    [3] = {
        hint = 'Trevor\'s Shop',
        coords = vector3(1386.6, 3622.9, 35.01)
    },
    [4] = {
        hint = 'Alien Caravan',
        coords = vector3(2482.59, 3722.22, 43.92)
    },
    [5] = {
        hint = 'Sandy Airport',
        coords = vector3(2160.24, 4789.52, 41.96)
    },
    [6] = {
        hint = 'Chicken Factory',
        coords = vector3(-121.55, 6204.61, 32.38)
    },
    [7] = {
        hint = 'Ammunation Paleto',
        coords = vector3(-342.4, 6097.78, 31.31)
    },
    [8] = {
        hint = 'Church Route 66',
        coords = vector3(-310.15, 2794.31, 59.46)
    },
    [9] = {
        hint = 'Satellites',
        coords = vector3(2049.4, 2949.82, 47.74)
    },
    [10] = {
        hint = 'Scrapyard',
        coords = vector3(2369.01, 3155.56, 49.07)
    },
    [11] = {
        hint = 'Purple Hotdog Dinasour',
        coords = vector3(2525.84, 2578.06, 37.94)
    },
    [12] = {
        hint = 'Lighthouse',
        coords = vector3(3426.93, 5174.52, 7.41)
    },
    [13] = {
        hint = 'Grape Fields',
        coords = vector3(-1928.28, 1779.27, 173.09)
    },
    [14] = {
        hint = 'Animal Ark',
        coords = vector3(569.04, 2796.74, 42.02)
    },
    [15] = {
        hint = 'Rebel',
        coords = vector3(739.37, 2579.39, 75.47)
    },
    [16] = {
        hint = 'Horse Race Track',
        coords = vector3(1253.27, 323.41, 85.99)
    },
    [17] = {
        hint = 'Los Santos Customs',
        coords = vector3(-1164.44, -2022.21, 13.16)
    },
    [18] = {
        hint = 'Airport',
        coords = vector3(-1215.31, -2744.58, 19.63)
    },
    [19] = {
        hint = 'Merryweather Cargo',
        coords = vector3(511.31, -3118.08, 25.57)
    },
    [20] = {
        hint = 'Jetsam Terminal',
        coords = vector3(800.41, -2990.01, 17.79)
    },
}
local PickupLocations = {
    vector3(300.86, 369.49, 105.34),
    vector3(-921.47, 471.73, 84.8),
    vector3(-1491.3, -199.58, 50.4),
    vector3(-1047.58, -1150.84, 2.16),
    vector3(-678.31, -1171.39, 10.62),
    vector3(-215.99, -1691.55, 34.01),
    vector3(-25.98, -566.93, 37.75),
    vector3(869.98, -2331.9, 30.35),
    vector3(411.7, -2064.02, 21.45),
    vector3(-2014.09, 426.22, 102.31),
    vector3(-1709.41, 2635.31, 1.51),
    vector3(-527.31, 5288.05, 74.21),
    vector3(-201.8, 3657.89, 51.74),
    vector3(1255.9, 4397.79, 43.29),
    vector3(1965.79, 3754.66, 32.23),
    vector3(1937.29, 3836.21, 32.24),
    vector3(1024.33, -477.41, 63.96),
    vector3(888.32, -2213.24, 30.51)
}

local function TurnOff(src)
    if not TurnedOn[src] then return end

    TurnedOn[src] = false
    TriggerClientEvent('QBCore:Notify', src, 'The radio scanner lost connection')
    TriggerClientEvent('qb-radioscanner:client:UpdateLocation', src, nil, nil, nil)
end

CreateThread(function()
    while true do
        for i = 1, #TurnedOn do
            local Player = QBCore.Functions.GetPlayer(i)
            if Player == nil then return end
            if Player.Functions.GetItemByName('radioscanner') then else
                TurnOff(i)
            end
        end
        Wait(3000)
    end
end)

RegisterNetEvent('qb-radioscanner:server:TurnedOff', function()
    TurnOff(source)
end)

local function SetupPickup()
    if SetupAlready then return end

    PickupProp = CreateObject(-653303203, PickupLocation.x, PickupLocation.y, PickupLocation.z - 1, true, true, false)
    for i = 1, Config.Guards.amount do
        PickupGuards[i] = CreatePed(0, Config.Guards.ped[math.random(1, #Config.Guards.ped)], PickupLocation.x + math.random(-3, 3), PickupLocation.y - math.random(-3, 3), PickupLocation.z + 0.2, math.random(1, 360), true, true)
        PickupGuardsIds[i] = NetworkGetNetworkIdFromEntity(PickupGuards[i])
        SetPedRandomProps(PickupGuards[i])
        SetPedArmour(PickupGuards[i], Config.Guards.armour)
        GiveWeaponToPed(PickupGuards[i], Config.Guards.weapon[math.random(1, #Config.Guards.weapon)], Config.Guards.ammo, false, true)
    end

    SetupAlready = true
    while true do
        local Owner = NetworkGetEntityOwner(PickupGuards[1])
        if Owner > 0 then
            Wait(500)
            TriggerClientEvent('qb-radioscanner:client:Setup', Owner, PickupGuardsIds)
            break
        else
            Wait(1000)
        end
    end
end

RegisterNetEvent('qb-radioscanner:server:EnteredPassword', function(Code)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerCoords = GetEntityCoords(GetPlayerPed(src))

    if #(PlayerCoords - CurrentLocation.coords) > 5 then return end
    if not Player.Functions.GetItemByName('radioscanner') then return end
    if HasEntered[src] then TriggerClientEvent('QBCore:Notify', src, 'You already accepted the deal') return end
    if tonumber(Code) ~= SecretCode then TriggerClientEvent('QBCore:Notify', src, 'Wrong code') return end
    if not TurnedOn[src] then return end

    HasEntered[src] = true
    Player.Functions.AddItem('radioscannerticket', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['radioscannerticket'], "add")
    TriggerClientEvent('QBCore:Notify', src, 'Check your map')
    TriggerClientEvent('qb-radioscanner:client:EnteredPassword', src)
    SetupPickup()
end)

local function GuardsAlive()
    for i = 1, #PickupGuards do
        if DoesEntityExist(PickupGuards[i]) then
            if GetEntityHealth(PickupGuards[i]) > 0 then
                return true
            end
        end
    end
end

local function DeleteSetup()
    if not SetupAlready then return end
    
    for i = 1, #PickupGuards do
        if DoesEntityExist(PickupGuards[i]) then
            DeleteEntity(PickupGuards[i])
        end
    end
    if DoesEntityExist(PickupProp) then
        DeleteEntity(PickupProp)
    end
    SetupAlready = false
end

RegisterNetEvent('qb-radioscanner:server:PickUp', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerCoords = GetEntityCoords(GetPlayerPed(src))

    if #(PlayerCoords - PickupLocation) > 5 then return end
    if GuardsAlive() then TriggerClientEvent('QBCore:Notify', src, 'The guards aren\'t dead yet') return end
    if not HasEntered[src] then TriggerClientEvent('QBCore:Notify', src, 'You already collected the pickup') return end
    if not Player.Functions.GetItemByName('radioscannerticket') then TriggerClientEvent('QBCore:Notify', src, 'Where is your delivery ticket?') return end
    if PickedupAlready then TriggerClientEvent('QBCore:Notify', src, 'Someone else already picked up the delivery') TriggerClientEvent('qb-radioscanner:client:Reset', src) return end

    if Player.Functions.RemoveItem('radioscannerticket', 1) then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['radioscannerticket'], "remove")
        HasEntered[src] = false
        for k, v in pairs(Config.Items) do
            if math.random(1, 20) < 10 then
                Player.Functions.AddItem(k, 1)
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[k], "add")
            end
        end
    end
    PickedupAlready = true
    TriggerClientEvent('qb-radioscanner:client:Reset', src)
    Wait(10000)
    DeleteSetup()
end)

RegisterNetEvent('qb-radioscanner:server:Sell', function(k)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerCoords = GetEntityCoords(GetPlayerPed(src))
    local Product = Player.Functions.GetItemByName(k)

    if #(PlayerCoords - Config.Items[k].sellcoords) > 5 then return end
    if not Product then TriggerClientEvent('QBCore:Notify', src, 'You don\'t have anything to offer here') return end
    if not Player.Functions.RemoveItem(k, Product.amount) then return end

    local info = {
        worth = math.random(Config.Items[k].min, Config.Items[k].max) * Product.amount
    }
    if not Config.Markedbills then
        Player.Functions.AddMoney('cash', info.worth)
    else
        Player.Functions.AddItem('trojan_usb', 1, false, info)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['trojan_usb'], "add")
    end
end)

QBCore.Functions.CreateUseableItem('radioscanner', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not TurnedOn[src] then
        TurnedOn[src] = true
        TriggerClientEvent('QBCore:Notify', src, 'You turned on your radio scanner.')
    else
        TurnedOn[src] = false
        TriggerClientEvent('QBCore:Notify', src, 'You turned off your radio scanner.')
    end
    if item.info.quality == nil then
        Player.PlayerData.items[item.slot].info = {}
        Player.PlayerData.items[item.slot].info.quality = 100
    else
        Player.PlayerData.items[item.slot].info.quality = Player.PlayerData.items[item.slot].info.quality - 1
    end
    Player.Functions.SetInventory(Player.PlayerData.items)
end)

CreateThread(function()
    while true do
        CurrentLocation = PossibleLocations[math.random(1, #PossibleLocations)]
        SecretCode = math.random(1000, 9999)
        PickupLocation = PickupLocations[math.random(1, #PickupLocations)]
        PickedupAlready = false
        HasEntered = {}
        TriggerClientEvent('qb-radioscanner:client:Reset', -1)
        Wait(50)
        for i = 1, #TurnedOn do
            if TurnedOn[i] then
                TriggerClientEvent('qb-radioscanner:client:UpdateLocation', i, CurrentLocation, SecretCode, PickupLocation)
            end
        end
        Wait(10000)
        DeleteSetup()
        Wait(60000 * Config.UpdateInterval) 
    end
end)

CreateThread(function()
    while true do
        for i = 1, #TurnedOn do
            if TurnedOn[i] then
                local Player = QBCore.Functions.GetPlayer(i)
                local PlayerInventory = Player.PlayerData.items
                local DecreaseAmount = math.random(1, 6)

                for _, v in pairs(PlayerInventory) do
                    if v.name == 'radioscanner' then
                        if Player.PlayerData.items[v.slot].info.quality - DecreaseAmount > 0 then
                            Player.PlayerData.items[v.slot].info.quality = Player.PlayerData.items[v.slot].info.quality - DecreaseAmount
                        else
                            if Player.PlayerData.items[v.slot].info.quality - DecreaseAmount == 0 then
                                Player.Functions.RemoveItem('radioscanner', v.slot)
                            end
                            Player.PlayerData.items[v.slot].info.quality = 0
                        end
                        break
                    end
                end
                Player.Functions.SetInventory(Player.PlayerData.items)
            end
        end
        Wait(math.random(600000, 1800000))
    end
end)

QBCore.Commands.Add('radioscan', 'help text here', {}, false, function(source, args)
    CurrentLocation = PossibleLocations[math.random(1, #PossibleLocations)]
    SecretCode = math.random(1000, 9999)
    PickupLocation = PickupLocations[math.random(1, #PickupLocations)]
    TurnedOn[source] = true
    PickedupAlready = false
    HasEntered = {}
    TriggerClientEvent('qb-radioscanner:client:Reset', source)
    Wait(50)
    TriggerClientEvent('qb-radioscanner:client:UpdateLocation', source, CurrentLocation, SecretCode, PickupLocation)
    Wait(10000)
    DeleteSetup()
end, 'admin')
