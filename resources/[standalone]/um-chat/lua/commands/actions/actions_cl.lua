local drawText = require("tools.drawtext")
local commands = require("config.commands").actions

-- Event: Show temporary action text
RegisterNetEvent("um_action", function(serverId, data)
    if GetInvokingResource() ~= nil then return end

    local playerId = GetPlayerFromServerId(serverId)
    if not playerId or not NetworkIsPlayerActive(playerId) or not data then return end

    local ped = GetPlayerPed(playerId)
    if not DoesEntityExist(ped) then return end

    CreateThread(function()
        local endTime = GetGameTimer() + 4000
        while GetGameTimer() < endTime do
            local coords = GetEntityCoords(ped)
            drawText(coords.x, coords.y, coords.z, data.msg, data.type)
            Wait(0)
        end
    end)
end)

-- Prevent command spamming
local isExecuting = false

-- NUI Command Execution Callback
RegisterNUICallback("um-chat:game:nuicallback:commandExecute", function(data, cb)
    cb(1)
    if isExecuting then return end
    isExecuting = true

    local cmdData = commands[data.command]
    local anim = cmdData and cmdData.anim

    if anim then
        lib.requestAnimDict(anim.dict)
        TaskPlayAnim(cache.ped, anim.dict, anim.clip, 8.0, 1.0, -1, 49, 0, false, false, false)
        Wait(anim.duration or 1500)
        ClearPedTasks(cache.ped)
    end

    ExecuteCommand(data.command)
    Wait(1500)
    isExecuting = false
end)

-- Anonymous Mask System
local maskConfig = require("config.commands").anonymousMask
if not (maskConfig and maskConfig.status) then return end

lib.callback.register("um-chat:checkMask", function()
    local drawable = GetPedDrawableVariation(cache.ped, 1)
    local hasMask = maskConfig.maskSlots[drawable]
    local mode = maskConfig.mode

    if mode == 1 then
        return hasMask and false or maskConfig.name
    else
        return hasMask and maskConfig.name or false
    end
end)
