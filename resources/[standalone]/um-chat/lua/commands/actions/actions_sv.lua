--=============================================================
--== CLEANED & OPTIMIZED SERVER-SIDE CHAT ACTION HANDLER ======
--=============================================================

local commandsConfig = require("config.commands")
local actions = commandsConfig.actions
local anonymousMask = commandsConfig.anonymousMask
local maxCharacterLength = commandsConfig.maxCharacterLength or 200

local chatConfig = require("config.chat")
local framework = chatConfig.framework

-- Local cooldown table
local playerCooldowns = {}
local cooldownDuration = 4000

----------------------------------------------------------
-- Function: Check cooldown
----------------------------------------------------------
local function isOnCooldown(playerId, action)
    local currentTime = GetGameTimer()
    playerCooldowns[playerId] = playerCooldowns[playerId] or {}

    if playerCooldowns[playerId][action] then
        local timeDiff = currentTime - playerCooldowns[playerId][action]
        if timeDiff < cooldownDuration then
            return true
        end
    end

    playerCooldowns[playerId][action] = currentTime
    return false
end

----------------------------------------------------------
-- Function: Clear cooldown
----------------------------------------------------------
local function clearCooldown(playerId, action)
    if not playerCooldowns[playerId] then return end
    playerCooldowns[playerId][action] = nil
    if not next(playerCooldowns[playerId]) then
        playerCooldowns[playerId] = nil
    end
end

----------------------------------------------------------
-- Function: Validate message length
----------------------------------------------------------
local function isMessageTooLong(msg)
    return type(msg) == "string" and #msg > maxCharacterLength
end

----------------------------------------------------------
-- Function: Get player display name with mask logic
----------------------------------------------------------
local function getDisplayName(playerId)
    if not anonymousMask.status then
        return GetPlayerFirstName(playerId)
    end

    local maskName = lib.callback.await("um-chat:checkMask", playerId)
    if not maskName then
        return GetPlayerFirstName(playerId)
    end

    return maskName
end

----------------------------------------------------------
-- Function: Send chat and text draw event
----------------------------------------------------------
local function sendChatAction(target, sender, data)
    if data and data.tag then
        TriggerClientEvent("chat:addMessage", target, {
            args = data.msg,
            title = getDisplayName(sender),
            tag = data.tag,
            showID = {
                status = data.showID,
                id = sender
            }
        })
    end

    if data and data.drwTextStatus then
        TriggerClientEvent("um_action", target, sender, {
            msg = data.msg,
            type = data.typeName
        })
    end
end

----------------------------------------------------------
-- Function: Send message within distance
----------------------------------------------------------
local function sendNearbyAction(sender, data)
    if not sender then return end

    local senderPed = GetPlayerPed(sender)
    local senderCoords = GetEntityCoords(senderPed)

    for _, playerId in pairs(GetPlayers()) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local dist = #(senderCoords - playerCoords)

        if dist < data.distance then
            sendChatAction(playerId, sender, data)
        end
    end
end

----------------------------------------------------------
-- Function: Job visibility settings
----------------------------------------------------------
local function parseJobDisplay(job)
    return {
        gradeShow = job and job.gradeShow or false,
        callsignShow = job and job.callsignShow or false
    }
end

----------------------------------------------------------
-- Function: Format player job name
----------------------------------------------------------
local function getJobDisplayName(playerId, jobData)
    local opts = parseJobDisplay(jobData)
    if not opts.gradeShow and not opts.callsignShow then
        return GetPlayerFirstName(playerId)
    end

    local jobInfo = GetPlayerJobsInfo(playerId)
    local name = GetPlayerFirstName(playerId)
    local grade = jobInfo and jobInfo.grade or ""
    local callsign = jobInfo and jobInfo.callsign or ""

    if opts.gradeShow and opts.callsignShow then
        return string.format("%s | %s | %s", name, grade, callsign)
    elseif opts.gradeShow then
        return string.format("%s | %s", name, grade)
    elseif opts.callsignShow then
        return string.format("%s | %s", name, callsign)
    end

    return name
end

----------------------------------------------------------
-- Function: Send message to player with job tag
----------------------------------------------------------
local function sendJobMessage(target, sender, data)
    if not (data and data.tag) then return end

    TriggerClientEvent("chat:addMessage", target, {
        args = data.msg,
        title = getJobDisplayName(sender, data.job),
        tag = data.tag,
        showID = { status = data.showID, id = sender }
    })
end

----------------------------------------------------------
-- Function: Send message to players in same job
----------------------------------------------------------
local function sendToJobPlayers(sender, data)
    local players = GetFrameworkPlayersJob(sender, data.job.name)
    if not players then return end

    for _, player in pairs(players) do
        local playerJob = player.PlayerData and player.PlayerData.job
        local onDutyOnly = data.job.onlyOnDuty

        if playerJob and playerJob.name == data.job.name then
            if not onDutyOnly or (onDutyOnly and playerJob.onduty) then
                sendJobMessage(player.source or player.PlayerData.source, sender, data)
            end
        end
    end
end

----------------------------------------------------------
-- Function: Register chat command
----------------------------------------------------------
local function registerChatCommand(name, settings)
    lib.addCommand(name, settings.command, function(playerId, args)
        if not playerId then return end

        local message = nil
        local drawText = false

        -- Check parameters
        if settings.command and settings.command.params then
            local paramName = settings.command.params[1].name
            local paramValue = args[paramName]

            if isMessageTooLong(paramValue) or #paramValue < 1 then
                return
            end

            message = paramValue:gsub("[~<].-[>~]", "")
        else
            message = settings.message and settings.message() or error("No action message found!")
        end

        -- Cooldown control
        if settings.drawText and isOnCooldown(name, playerId) then
            return
        end

        drawText = settings.drawText or false
        if drawText then
            SetTimeout(cooldownDuration, function()
                clearCooldown(name, playerId)
            end)
        end

        local actionData = {
            msg = message,
            tag = settings.tag or false,
            distance = settings.distance or 5,
            showID = settings.showID or false,
            typeName = name,
            drwTextStatus = drawText,
            job = settings.job or false
        }

        if settings.job then
            sendToJobPlayers(playerId, actionData)
        else
            sendNearbyAction(playerId, actionData)
        end

        if settings.logs then
            TriggerEvent("um-chat:server:logs:addLogs", name, playerId, message, "black")
        end
    end)
end

----------------------------------------------------------
-- Thread: Initialize all commands
----------------------------------------------------------
CreateThread(function()
    for commandName, commandData in pairs(actions) do
        if commandData.status then
            registerChatCommand(commandName, commandData)
        end
    end
end)