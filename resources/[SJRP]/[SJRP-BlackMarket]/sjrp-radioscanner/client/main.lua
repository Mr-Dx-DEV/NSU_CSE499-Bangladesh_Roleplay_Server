local QBCore = exports['sjfw']:GetCoreObject()
local CurrentLocation = nil
local SecretCode = nil
local PickupLocation = nil
local PickupLocationBlip = nil
local Guards = {}

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerServerEvent('qb-radioscanner:server:TurnedOff')
end)

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local PlayerCoords = GetEntityCoords(ped)
        local WaitTime = 800
        if CurrentLocation then
            if #(PlayerCoords - CurrentLocation.coords) < 2 then
                WaitTime = 1
                DrawText3D(CurrentLocation.coords.x, CurrentLocation.coords.y, CurrentLocation.coords.z + 0.4, "~o~E~w~ - Dealer")
                if IsControlJustReleased(0, 38) then
                    local dialog = exports['sjrp-input']:ShowInput({
                        header = "Secret Code",
                        submitText = "Confirm",
                        inputs = {
                            {
                                text = "5794",
                                name = "password",
                                type = "number",
                                isRequired = true
                            }
                        }
                    })
                    if dialog then
                        TriggerServerEvent('qb-radioscanner:server:EnteredPassword', dialog.password)
                    end
                end
            elseif #(PlayerCoords - PickupLocation) < 2 then
                WaitTime = 1
                DrawText3D(PickupLocation.x, PickupLocation.y, PickupLocation.z + 0.4, "~o~E~w~ - Collect Deal")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('qb-radioscanner:server:PickUp')
                end                
            end
        end
        Wait(WaitTime)
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local PlayerCoords = GetEntityCoords(ped)
        local WaitTime = 800
        for k, v in pairs(Config.Items) do
            if #(PlayerCoords - v.sellcoords) < 2 then
                WaitTime = 1
                DrawText3D(v.sellcoords.x, v.sellcoords.y, v.sellcoords.z + 0.4, "~o~E~w~ - Sell Boxes")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('qb-radioscanner:server:Sell', k)
                end
            end
        end
        Wait(WaitTime)
    end
end)

RegisterNetEvent('qb-radioscanner:client:UpdateLocation', function(Location, Code, Pickup)
    CurrentLocation = Location
    SecretCode = Code
    PickupLocation = Pickup

    if CurrentLocation == nil then return end

    TriggerServerEvent('sjrp-phone:server:sendNewMail', {
        sender = 'Radio Scanner',
        subject = 'Possible Deal',
        message = 'A new possible deal has come up.<br /><br /> This time the hint is: '..CurrentLocation.hint..'. '..SecretCode..'<br /><br /> You better make this one work.',
        button = {}
    })
end)

RegisterNetEvent('qb-radioscanner:client:EnteredPassword', function()
    PickupLocationBlip = AddBlipForCoord(PickupLocation.x, PickupLocation.y, PickupLocation.z)
    SetBlipSprite(PickupLocationBlip, 51)
    SetBlipRoute(PickupLocationBlip, PickupLocation.x , PickupLocation.y, PickupLocation.z)
    SetBlipRouteColour(PickupLocationBlip, PickupLocation.x, PickupLocation.y, PickupLocation.z, 46)
end)

RegisterNetEvent('qb-radioscanner:client:Setup', function(Peds)
    AddRelationshipGroup('RADIOGUARDS')
    for i = 1, #Peds do
        local ped = NetworkGetEntityFromNetworkId(Peds[i])
        Guards[#Guards + 1] = ped
        SetPedRelationshipGroupHash(ped, `RADIOGUARDS`)
        SetPedAccuracy(ped, Config.Guards.accuracy)
        TaskGuardCurrentPosition(ped, 10.0, 10.0, true)
        SetPedFleeAttributes(ped, 0, true)
        SetPedDropsWeaponsWhenDead(ped, false)
        SetPedCanEvasiveDive(ped, true)
        SetPedCombatMovement(ped, 2)
    end
    SetRelationshipBetweenGroups(0, `RADIOGUARDS`, `RADIOGUARDS`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `RADIOGUARDS`)
    SetRelationshipBetweenGroups(5, `RADIOGUARDS`, `PLAYER`)
end)

RegisterNetEvent('qb-radioscanner:client:Reset', function()
    RemoveBlip(PickupLocationBlip)
    CurrentLocation = nil
    SecretCode = nil
    PickupLocation = nil
    Wait(7000)
    for i = 1, #Guards do
        NetworkFadeOutEntity(Guards[i], false, true)
    end
    Guards = {}
end)