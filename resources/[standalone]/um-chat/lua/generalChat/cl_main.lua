--================================================--
--  UM-Chat | Client-side Chat System
--================================================--

local defaultProfileImage = "https://i.pinimg.com/564x/6c/50/6e/6c506e1d79ddb57147f88d02db0ef3a0.jpg"

-- Fetch messages from server
local function getMessages()
    return lib.callback.await("um-chat:callback:GetMessages", false)
end

----------------------------------------------------
-- NUI CALLBACKS
----------------------------------------------------

-- Get Messages
RegisterNUICallback("GetMessages", function(_, cb)
    cb(1)
    local messages = getMessages()

    SendNUIMessage({
        type = "setMessages",
        data = messages or {}
    })
end)

-- Send Message
RegisterNUICallback("SendMessage", function(data, cb)
    cb(1)

    local message = data.message
    local profileImage = GetResourceKvpString("profileImage") or defaultProfileImage

    TriggerServerEvent("um-chat:server:sendMessageServer", message, profileImage)

    local messages = getMessages()
    SendNUIMessage({
        type = "setMessages",
        data = messages
    })
end)

-- Save Profile Image
RegisterNUICallback("saveProfileImage", function(data, cb)
    cb(1)
    Debug("Saved Profile Image", "info")
    SetResourceKvp("profileImage", data.image)
end)

----------------------------------------------------
-- ADMIN CHAT SYSTEM
----------------------------------------------------

local adminChat = require("config.chat").adminChat
if not adminChat.status then return end

Wait(1000)

-- Check permission for admin chat
local hasPermission = lib.callback.await("um-chat:callback:getPermissionCheckAdminChat", false)
if not hasPermission then return end

Debug("Admin Chat is loaded checkPermissionStatus true", "info")

local adminNotifyCount = 0

-- Open Admin Chat
RegisterNetEvent("um-chat:client:openAdminChat", function()
    if not ChatLoaded then
        return Debug("Chat is waiting nui", "warn")
    end

    SetNuiFocus(true, true)
    SendNUIMessage({ type = "adminChatOpen" })
    adminNotifyCount = 0
end)

-- Add Keybind for Admin Chat
lib.addKeybind({
    name = adminChat.command.name,
    description = adminChat.command.help,
    defaultKey = adminChat.key,
    onPressed = function()
        ExecuteCommand(adminChat.command.name)
    end
})

-- Admin Chat Notification
RegisterNetEvent("um-chat:client:sendAdminNotifyMessage", function()
    if GetInvokingResource() then return end

    local muteStatus = GetResourceKvpString("adminNotify") or "false"
    if muteStatus == "true" then return end

    adminNotifyCount += 1
    SendNUIMessage({
        type = "adminNotifyCount",
        data = adminNotifyCount
    })
end)

-- Set Mute for Admin Notifications
RegisterNUICallback("setMuteNotify", function(data, cb)
    cb(1)
    Debug("setMuteNotify", data.status)
    SetResourceKvp("adminNotify", data.status)
end)

Debug("Admin Chat is loaded addKeybind", "info")