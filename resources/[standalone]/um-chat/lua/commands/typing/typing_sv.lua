-- Load typing dot config
local chatConfig = require("config.chat").commandGeneral.typingDot
if not chatConfig.status then return end

-- Event: when a player starts/stops typing
RegisterNetEvent("um-chat:callback:typing", function(isTyping)
    if type(isTyping) ~= "boolean" then return end

    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)

    -- Get nearby players within 3 meters (excluding self)
    local nearbyPlayers = lib.getNearbyPlayers(coords, 3, false)
    if #nearbyPlayers <= 1 then return end

    -- Send typing state to each nearby client
    for _, player in ipairs(nearbyPlayers) do
        TriggerClientEvent("um_typing", player.id, src, isTyping)
    end
end)
