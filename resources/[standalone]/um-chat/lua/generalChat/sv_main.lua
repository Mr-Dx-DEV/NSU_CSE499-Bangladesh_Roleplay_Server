--================================================--
--  UM-Chat | Server-side Chat System
--================================================--

local chatConfig = require("config.chat").chatLogs.generalChat
local permissionConfig = require("config.permission")
local adminChatConfig = require("config.chat").adminChat

local chatMessages = {}

----------------------------------------------------
-- HELPER FUNCTIONS
----------------------------------------------------

-- Get player's identifier (default: discord)
local function getPlayerIdentifier(src)
    local idType = permissionConfig.identifier or "discord"
    local identifier = GetPlayerIdentifierByType(src, idType)
    if not identifier then return false end

    -- Remove "discord:" or "license:" prefix
    local prefix = idType .. ":"
    if identifier:find(prefix) then
        identifier = identifier:gsub(prefix, "")
    end

    return identifier
end

-- Get player's permission roles
local function getPlayerPermissions(identifier)
    local roles = {}

    for name, group in pairs(permissionConfig.permissions) do
        for _, perm in ipairs(group.permissions) do
            if identifier == perm then
                table.insert(roles, {
                    name = name,
                    prefix = group.prefix,
                    color = group.color
                })
            end
        end
    end

    return roles
end

----------------------------------------------------
-- CHAT MESSAGE HANDLING
----------------------------------------------------

RegisterNetEvent("um-chat:server:sendMessageServer", function(message, avatar)
    local src = source
    local time = os.time() * 1000

    local identifier = getPlayerIdentifier(src)
    local permissions = getPlayerPermissions(identifier)
    local playerName = GetPlayerFirstName(src) or "Unknown"

    table.insert(chatMessages, {
        fullName = playerName,
        message = message,
        time = time,
        avatarUrl = avatar,
        id = tostring(src),
        permission = permissions
    })

    -- Log to server console if enabled
    if chatConfig.status then
        TriggerEvent("um-chat:server:logs:addLogs", src, "generalChat", message, "black")
    end

    -- Notify admin chat if active
    if adminChatConfig.status then
        for _, playerId in ipairs(GetPlayers()) do
            if IsPlayerAceAllowed(playerId, "command." .. adminChatConfig.command.name) then
                TriggerClientEvent("um-chat:client:sendAdminNotifyMessage", playerId)
            end
        end
    end
end)

----------------------------------------------------
-- CHAT CLEANUP (Deletes messages older than 30 mins)
----------------------------------------------------

local function clearOldMessages()
    local now = os.time() * 1000
    local expiryTime = 1800000 -- 30 minutes

    for i = #chatMessages, 1, -1 do
        if now - chatMessages[i].time > expiryTime then
            table.remove(chatMessages, i)
        end
    end
end

----------------------------------------------------
-- LIB CALLBACKS
----------------------------------------------------

lib.callback.register("um-chat:callback:GetMessages", function()
    clearOldMessages()
    return chatMessages
end)

----------------------------------------------------
-- ADMIN CHAT COMMAND + PERMISSIONS
----------------------------------------------------

if adminChatConfig.status then
    -- Admin Chat Command
    lib.addCommand(adminChatConfig.command.name, {
        help = adminChatConfig.command.help,
        restricted = adminChatConfig.permission
    }, function(src)
        TriggerClientEvent("um-chat:client:openAdminChat", src)
    end)

    -- Admin Chat Permission Check
    lib.callback.register("um-chat:callback:getPermissionCheckAdminChat", function(src)
        return IsPlayerAceAllowed(src, "command." .. adminChatConfig.command.name)
    end)
end