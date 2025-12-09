-- Typing dot display (client-side)
local typingConfig = require("config.chat").commandGeneral.typingDot
if not typingConfig or not typingConfig.status then
    return
end

local typingPlayers = {} -- [playerId] = true/false or extra data
local selectedTypeIndex = typingConfig.selectedDotType
local dotTypeList = typingConfig.dotTypeList or {}

local selectedDot = dotTypeList[selectedTypeIndex]
if not selectedDot then
    warn("Invalid typing dot type in config.chat.lua")
    return
end

local scale = selectedDot.scale or 0.3
local color = selectedDot.color or {255, 255, 255, 215}
local animate = selectedDot.animation or false
local textFrames = (animate and selectedDot.text) and selectedDot.text or nil

-- Draw 3D text helper
local function draw3DText(x, y, z, text)
    local onScreen, screenX, screenY = World3dToScreen2d(x, y, z)
    if not onScreen then return end

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(true)
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(screenX, screenY)
end

-- Receive typing events from server (serverId -> player)
RegisterNetEvent("um_typing", function(serverId, state)
    if GetInvokingResource() ~= nil then return end

    local player = GetPlayerFromServerId(serverId)
    if not player then return end
    if not NetworkIsPlayerActive(player) then return end

    local ped = GetPlayerPed(player)
    if not DoesEntityExist(ped) then return end

    typingPlayers[player] = state
end)

-- Animation state
local lastAnimUpdate = 0
local animIndex = 1

-- If animating, prepare available frames count
local framesCount = textFrames and #textFrames or 0

-- Main loop: draw typing dots for nearby players
CreateThread(function()
    while true do
        local waitTime = 0
        local myCoords = GetEntityCoords(cache.ped)

        if not next(typingPlayers) then
            -- No typing players -> sleep longer
            waitTime = 500
        else
            -- Update animation index every 500ms (if animation enabled)
            if animate and framesCount > 0 then
                local now = GetGameTimer()
                if now - lastAnimUpdate >= 500 then
                    animIndex = (animIndex % framesCount) + 1
                    lastAnimUpdate = now
                end
            end

            -- Iterate typing players and draw
            for playerId, state in pairs(typingPlayers) do
                if state then
                    local ped = GetPlayerPed(playerId)
                    local coords = GetEntityCoords(ped)
                    -- Determine which text to draw
                    local textToDraw
                    if animate and framesCount > 0 then
                        textToDraw = textFrames[animIndex]
                    else
                        textToDraw = selectedDot.text or ""
                    end

                    -- If player is close enough (<= 3 units) draw, else remove from list
                    local dist = #(myCoords - coords)
                    if dist <= 3.0 then
                        draw3DText(coords.x, coords.y, coords.z + 1.0, textToDraw)
                    else
                        typingPlayers[playerId] = nil
                    end
                else
                    -- state falsy -> remove entry
                    typingPlayers[playerId] = nil
                end
            end
        end

        Wait(waitTime)
    end
end)