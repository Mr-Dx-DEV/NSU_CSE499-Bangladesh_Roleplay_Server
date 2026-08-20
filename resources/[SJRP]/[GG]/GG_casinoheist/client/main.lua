--------------------------------------------------------------------------------------------------------------------------------------------------------

local QBCore = exports['sjfw']:GetCoreObject()

--------------------------------------------------------------------------------------------------------------------------------------------------------

Config = Config or {}
local Busy = false
local PoliceCalled = false
local VaultSpawned = false

--------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload",function()
    isLoggedIn = false
end)

-- DisableInteriorProp
-- EnableInteriorProp

CreateThread(function()
    Wait(2000)
    ks_casino_vault = getInteriorByType(946.251,43.2715,58.9172,"ks_casino_vault", "ks_casino_vault_milo_")
	DisableInteriorProp(ks_casino_vault, "set_vault_door_broken")
	DisableInteriorProp(ks_casino_vault, "set_vault_door")
	EnableInteriorProp(ks_casino_vault, "set_vault_door_closed")
	RefreshInterior(ks_casino_vault)
    TriggerServerEvent('GG_casinoheist:server:spawnvault')
end)

-- Functions
--------------------------------------------------------------------------------------------------------------------------------------------------------

function getInteriorByType(x, y, z, name, iplName)
	local id = 0

	if not IsIplActive(iplName) then
		RequestIpl(iplName)

		while not IsIplActive(iplName) do
			-- RequestIpl(iplName)
			Wait(20)
		end
	end

	while id == 0 do
		id = GetInteriorAtCoordsWithType(x, y, z, name)
		Wait(20)
	end

	return id
end

-- Function for finding out if the player is wearing gloves
local function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

-- Function that loads an animation so it can be played
local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

-- Updates the IPL For everyone
local function UpdateIPL()
    EnableInteriorProp(ks_casino_vault, "set_vault_door_broken")
    Wait(500)
    RefreshInterior(ks_casino_vault)
    print('Spawning Broken Door')
end

-- Function that spawns the Cash Trollys
function SpawnCarts()
    local model = "hei_prop_hei_cash_trolly_01"
    RequestModel(model)
    while not HasModelLoaded(model) do RequestModel(model) Wait(100) end
    ClearAreaOfObjects(989.14, 50.54, 59.65, 10, 0)
    for i = 1, 3 do
        local obj = GetClosestObjectOfType(Config.Trolleys[i].coords, 3.0, `hei_prop_hei_cash_trolly_01`, false, false, false)
        if obj ~= 0 then
            DeleteObject(obj)
            Wait(1)
        end
        CreateObject(model, Config.Trolleys[i].coords, true, true, false)
        exports['sjrp-target']:AddBoxZone("CashTrolly"..i, vector3(Config.Trolleys[i].coords), 1, 1, {
            name = "CashTrolly"..i,
            heading = Config.Trolleys[i].h,
            debugPoly = false,
            minZ = Config.Trolleys[i].coords.z,
            maxZ = Config.Trolleys[i].coords.z + 1.2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "GG_casinoheist:client:StartGrab",
                        icon = "fas fa-circle",
                        label = "Take Loot",
                    },
                },
                distance = 1.0
        })
    end
end

RegisterCommand('goldd', function()
    SpawnCarts()
end)

-- Function that spawns the Gold Trollys
local function SpawnGoldCarts()
    local model = "ch_prop_gold_trolly_01a"
    RequestModel(model)
    while not HasModelLoaded(model) do RequestModel(model) Wait(100) end
    ClearAreaOfObjects(989.14, 50.54, 59.65, 10, 0)
    for i = 1, 1 do
        local obj = GetClosestObjectOfType(Config.GoldTrolleys[i].coords, 3.0, `ch_prop_gold_trolly_01a`, false, false, false)
        if obj ~= 0 then
            DeleteObject(obj)
            Wait(1)
        end
        CreateObject(model, Config.GoldTrolleys[i].coords, true, true, false)
        exports['sjrp-target']:AddBoxZone("GoldTrolly"..i, vector3(Config.GoldTrolleys[i].coords), 1, 1, {
            name = "GoldTrolly"..i,
            heading = Config.GoldTrolleys[i].h,
            debugPoly = false,
            minZ = Config.GoldTrolleys[i].coords.z,
            maxZ = Config.GoldTrolleys[i].coords.z + 1.2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "GG_casinoheist:client:StartGoldGrab",
                        icon = "fas fa-circle",
                        label = "Take Loot",
                    },
                },
                distance = 1.0
        })
    end
end

-- Function that spawns the Cash Piles
local function SpawnCashPile()
    local model = "h4_prop_h4_cash_stack_01a"
    RequestModel(model)
    while not HasModelLoaded(model) do RequestModel(model) Wait(100) end
    for i = 1, 3 do
        local obj = GetClosestObjectOfType(Config.CashPile[i].coords, 3.0, `h4_prop_h4_cash_stack_01a`, false, false, false)
        if obj ~= 0 then
            DeleteObject(obj)
            Wait(1)
        end
        local bruh = CreateObject(model, Config.CashPile[i].coords, true, true, false)
        SetEntityHeading(bruh, Config.CashPile[i].h)
        exports['sjrp-target']:AddBoxZone("CashPile"..i, vector3(Config.CashPile[i].coords), 1, 1, {
            name = "CashPile"..i,
            heading = Config.CashPile[i].h,
            debugPoly = false,
            minZ = Config.CashPile[i].coords.z - 0.5,
            maxZ = Config.CashPile[i].coords.z + 0.5,
            }, {
                options = {
                    {
                        type = "client",
                        event = "GG_casinoheist:client:CashPile",
                        icon = "fas fa-circle",
                        label = "Take Loot",
                    },
                },
                distance = 1.0
        })
    end
end

-- Function that spawns the Cash Piles
local function TargetLockers()
    for i = 1, 4 do
        exports['sjrp-target']:AddBoxZone("DrillSpots"..i, vector3(Config.DrillSpots[i].coords), 1, 1, {
            name = "DrillSpots"..i,
            heading = 0.00,
            debugPoly = false,
            minZ = Config.DrillSpots[i].coords.z - 0.5,
            maxZ = Config.DrillSpots[i].coords.z + 0.5,
            }, {
                options = {
                    {
                        type = "client",
                        event = "drill:Usedrill",
                        icon = "fas fa-circle",
                        label = "Take Loot",
                    },
                },
                distance = 1.0
        })
    end
end

-- Function that plays after the player hacks a door
local function StartHackAnim(Config)
    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("ch_p_m_bag_var03_arm_s")
    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("ch_p_m_bag_var03_arm_s") do
        Wait(100)
    end
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", Config.KeycardDoors[closestKeypad].animationx + 0, Config.KeycardDoors[closestKeypad].animationy + 0, Config.KeycardDoors[closestKeypad].animationz + 0.85)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", Config.KeycardDoors[closestKeypad].animationx + 0, Config.KeycardDoors[closestKeypad].animationy + 0, Config.KeycardDoors[closestKeypad].animationz + 0.85)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", Config.KeycardDoors[closestKeypad].animationx + 0, Config.KeycardDoors[closestKeypad].animationy + 0, Config.KeycardDoors[closestKeypad].animationz + 0.85)
    bag = CreateObject(`ch_p_m_bag_var03_arm_s`, targetPosition, 1, 1, 0)
    laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
    local IntroHack = NetworkCreateSynchronisedScene(animPos, targetRotation, 0, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, IntroHack, animDict, "hack_enter", 0, 0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, IntroHack, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, IntroHack, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    HackLoop = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, -1, 1.0)
    NetworkAddPedToSynchronisedScene(ped, HackLoop, animDict, "hack_loop", 0, 0, -1, 1, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, HackLoop, animDict, "hack_loop_bag", 1.0, 0.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, HackLoop, animDict, "hack_loop_laptop", 1.0, -0.0, 1)
    HackLoopFinish = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, -1, 1.3)
    NetworkAddPedToSynchronisedScene(ped, HackLoopFinish, animDict, "hack_exit", 0, 0, -1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, HackLoopFinish, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, HackLoopFinish, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(IntroHack)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["security_card_02"], "remove")
    TriggerServerEvent("QBCore:Server:RemoveItem", "security_card_02", 1)
    Wait(6000)
    FreezeEntityPosition(PlayerPedId(), true)
    NetworkStopSynchronisedScene(IntroHack)
    NetworkStartSynchronisedScene(HackLoop)
    exports["datacrack"]:Start(Config.HackDifficulty)
end

-- Function that plays the animation for the player planting the bomb on the Vault Door
local function StartBombAnim(Config)
    local animDict = "anim_heist@hs3f@ig8_vault_explosives@right@male@"
    RequestAnimDict(animDict)
    RequestModel("ch_prop_ch_explosive_01a")
    RequestModel("ch_p_m_bag_var03_arm_s")

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("ch_prop_ch_explosive_01a")
        or not HasModelLoaded("ch_p_m_bag_var03_arm_s") do
        Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "player_ig8_vault_explosive_plant_a", Config.VaultBomb[1].x + 0.3, Config.VaultBomb[1].y + 0, Config.VaultBomb[1].z + 1.1)
    local animPos4 = GetAnimInitialOffsetPosition(animDict, "player_ig8_vault_explosive_plant_b", Config.VaultBomb[1].x + 0.3, Config.VaultBomb[1].y + 0, Config.VaultBomb[1].z + 1.1)
    local animPos5 = GetAnimInitialOffsetPosition(animDict, "player_ig8_vault_explosive_plant_c", Config.VaultBomb[1].x + 0.3, Config.VaultBomb[1].y + 0, Config.VaultBomb[1].z + 1.1)
    local bag = CreateObject(`ch_p_m_bag_var03_arm_s`, targetPosition, 1, 1, 0)
    local bomb = CreateObject(`ch_prop_ch_explosive_01a`, targetPosition - 5, 1, 1, 0)
    local bomb2 = CreateObject(`ch_prop_ch_explosive_01a`, targetPosition - 5, 1, 1, 0)
    local bomb3 = CreateObject(`ch_prop_ch_explosive_01a`, targetPosition - 5, 1, 1, 0)
    local bomb4 = CreateObject(`ch_prop_ch_explosive_01a`, targetPosition - 5, 1, 1, 0)
    -- SetEntityVisible(bomb2, false)
    -- SetEntityVisible(bomb3, false)
    -- SetEntityVisible(bomb4, false)
    FreezeEntityPosition(ped, true)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, true, false, 1065353216, 0, 0.8)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "player_ig8_vault_explosive_plant_a", 0, 0, 10, 1, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "bag_ig8_vault_explosive_plant_a", 4.0, -80.0, 1)
    NetworkAddEntityToSynchronisedScene(bomb2, netScene3, animDict, "semtex_a_ig8_vault_explosive_plant_a", 4.0, -80.0, 1)
    local netScene4 = NetworkCreateSynchronisedScene(animPos4, targetRotation, 2, true, false, 1065353216, 0, 0.8)
    NetworkAddPedToSynchronisedScene(ped, netScene4, animDict, "player_ig8_vault_explosive_plant_b", 0, 0, 10, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene4, animDict, "bag_ig8_vault_explosive_plant_b", 4.0, -80.0, 1)
    NetworkAddEntityToSynchronisedScene(bomb3, netScene4, animDict, "semtex_b_ig8_vault_explosive_plant_b", 4.0, -80.0, 1)
    local netScene5 = NetworkCreateSynchronisedScene(animPos5, targetRotation, 2, true, false, 1065353216, 0, 0.8)
    NetworkAddPedToSynchronisedScene(ped, netScene5, animDict, "player_ig8_vault_explosive_plant_c", 0, 0, 10, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene5, animDict, "bag_ig8_vault_explosive_plant_c", 4.0, -80.0, 1)
    NetworkAddEntityToSynchronisedScene(bomb4, netScene5, animDict, "semtex_c_ig8_vault_explosive_plant_c", 4.0, -80.0, 1)
    -- LocalPlayer.state:set("inv_busy", true, true)
    DeleteObject(bomb)
    SetEntityVisible(bomb2, true)
    NetworkStartSynchronisedScene(netScene3)
    Wait(3500)
    SetEntityVisible(bomb3, true)
    NetworkStopSynchronisedScene(netScene3)
    NetworkStartSynchronisedScene(netScene4)
    Wait(3500)
    SetEntityVisible(bomb4, true)
    NetworkStopSynchronisedScene(netScene4)
    NetworkStartSynchronisedScene(netScene5)
    Wait(3500)
    NetworkStopSynchronisedScene(netScene5)
    DeleteObject(bag)
    FreezeEntityPosition(ped, false)
    SetPedComponentVariation(ped, 5, 82, 3, 0)
    LocalPlayer.state:set("inv_busy", false, true)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["weapon_pipebomb"], "remove")
    TriggerServerEvent("QBCore:Server:RemoveItem", "weapon_pipebomb", 1)
    --QBCore.Functions.Notify('The bomb will go off in ' ..Config.BombTime.. ' seconds.', "error")
    Wait(Config.BombTime * 1000)
    AddExplosion(Config.VaultBomb[1].x, Config.VaultBomb[1].y, Config.VaultBomb[1].z, 82, 5.0, true, false, 15.0)
    TriggerServerEvent('aj:sync', false)
    DeleteObject(bomb)
    DeleteObject(bomb2)
    DeleteObject(bomb3)
    DeleteObject(bomb4)
    Wait(100)
    SpawnCarts()
    SpawnGoldCarts()
    SpawnCashPile()
    TargetLockers()
    UpdateIPL()
end

local function StartDrillAnim(Config)
    local animDict = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@"
    local animDict2 = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@"
    local ped = PlayerPedId()
    coords = GetEntityCoords(ped)
    -- rot = GetEntityHeading(ped)

    Locker = GetClosestObjectOfType(coords, 1.5, `ch_prop_ch_sec_cabinet_01j`, false, false, false)

    if Locker == 0 then
        return
    end

    LockerPos = GetEntityCoords(Locker)
    LockerHead = GetEntityHeading(Locker)
    rot = GetEntityHeading(Locker)
    SetEntityVisible(Locker, false)
    SetEntityAsMissionEntity(Locker, true, true)
    DeleteEntity(Locker)
    DeleteObject(Locker)

    Locker2 = GetClosestObjectOfType(coords, 1.5, `ch_prop_ch_sec_cabinet_01j`, false, false, false)
    print('Locker',Locker)
    print('Locker2', Locker2)
    SetEntityVisible(Locker2, false)
    SetEntityAsMissionEntity(Locker2, true, true)
    DeleteEntity(Locker2)
    DeleteObject(Locker2)

    local obj = CreateObject(-2110344306, LockerPos, 1, 0, 0)
    SetEntityHeading(obj, LockerHead)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    SetEntityCollision(obj, true, true)

    NewLockerPos = GetEntityCoords(obj)

    while not NetworkHasControlOfEntity(obj) do
		Wait(1)
		NetworkRequestControlOfEntity(obj)
	end

    RequestModel("ch_p_m_bag_var03_arm_s")
    RequestModel("ch_prop_vault_drill_01a")
    RequestModel("ch_prop_ch_moneybag_01a")
    RequestAnimDict(animDict)
    RequestAnimDict(animDict2)
    while not HasAnimDictLoaded(animDict) or not HasAnimDictLoaded(animDict2) or not HasModelLoaded('ch_p_m_bag_var03_arm_s') or not HasModelLoaded('ch_prop_ch_moneybag_01a') or not HasModelLoaded('ch_prop_vault_drill_01a') do
        Wait(100)
        print('Requesting Assets')
    end

    local targetPosition = GetEntityCoords(obj)
    local targetRotation = vector3(0.0, 0.0, rot)
    local animPos = GetAnimInitialOffsetPosition(animDict, "enter", targetPosition[1], targetPosition[2], targetPosition[3], targetRotation, 0, 2)
    local targetHeading = rot
    TaskGoStraightToCoord(ped, animPos, 0.025, 5000, targetHeading, 0.05)

    Citizen.Wait(4000)
    SetPedComponentVariation(ped, 5, 0, 0, 0)

    local bag = CreateObject(`ch_p_m_bag_var03_arm_s`, targetPosition, 1, 1, 0)
    local drill = CreateObject(`ch_prop_vault_drill_01a`, targetPosition, 1, 1, 0)
    local money = CreateObject(`hei_prop_heist_gold_bar`, targetPosition, 1, 1, 0)
    SetEntityVisible(money, false)

    local netScene = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "enter", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "enter_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene, animDict, "enter_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene, animDict, "enter_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)
    -- NetworkAddSynchronisedSceneCamera(netScene, animDict, "enter_cam")

    local netScene2 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, false, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene2, animDict, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene2, animDict, "action_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)
    -- NetworkAddSynchronisedSceneCamera(netScene2, animDict, "action_cam")

    local netScene3 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene3, animDict, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene3, animDict, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene3, animDict, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)
    -- NetworkAddSynchronisedSceneCamera(netScene3, animDict, "reward_cam")

    local netScene5 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, false, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene5, animDict2, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene5, animDict2, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene5, animDict2, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene5, animDict2, "action_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)
    -- NetworkAddSynchronisedSceneCamera(netScene5, animDict2, "action_cam")

    local netScene6 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene6, animDict2, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene6, animDict2, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene6, animDict2, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene6, animDict2, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene6, animDict2, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)
    -- NetworkAddSynchronisedSceneCamera(netScene6, animDict2, "reward_cam")

    local netScene7 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene7, "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@", "exit", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene7, "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@", "exit_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene7, "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@", "exit_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene7, "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@", "exit_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)
    -- NetworkAddSynchronisedSceneCamera(netScene6, animDict2, "reward_cam")

    local netScene8 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, true, 1065353216, 0, 1065353216, 2.0)
    NetworkAddEntityToSynchronisedScene(obj, netScene8, 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@', "idle_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    NetworkStartSynchronisedScene(netScene)
    Wait(GetAnimDuration(animDict, 'enter') * 1000)
    -- NetworkStopSynchronisedScene(netScene)
    NetworkStartSynchronisedScene(netScene2)
    Wait(GetAnimDuration(animDict, 'action') * 1000)
    -- NetworkStopSynchronisedScene(netScene2)
    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene3)
    Wait(GetAnimDuration(animDict, 'reward') * 1000)
    -- NetworkStopSynchronisedScene(netScene3)
    SetEntityVisible(money, false)

    print('[Drill] Second Animation Part')

    NetworkStartSynchronisedScene(netScene5)
    Wait(GetAnimDuration(animDict2, 'action') * 1000)
    -- NetworkStopSynchronisedScene(netScene5)
    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene6)
    Wait(GetAnimDuration(animDict2, 'reward') * 1000)
    -- NetworkStopSynchronisedScene(netScene6)

    print('[Drill] Third Animation Part')

    NetworkStartSynchronisedScene(netScene7)
    Wait(GetAnimDuration('anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@', 'exit') * 1000)
    NetworkStartSynchronisedScene(netScene8)
    
    RemoveAnimDict(animDict)
    RemoveAnimDict(animDict2)
    RemoveAnimDict("anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@")
    
    DeleteObject(bag)
    DeleteObject(drill)
    DeleteObject(money)
    -- DeleteObject(obj)
    SetEntityVisible(Locker, true)
    FreezeEntityPosition(ped, false)
    SetPedComponentVariation(ped, 5, 82, 3, 0)
end

-- Events for looting
--------------------------------------------------------------------------------------------------------------------------------------------------------

-- Event for Triggering the Cash Trolly Grab
RegisterNetEvent('GG_casinoheist:client:StartGrab', function()
    TriggerEvent('GG_casinoheist:client:SetClosest', closestTrolly)
    -- LocalPlayer.state:set("inv_busy", true, true)
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, `hei_prop_hei_cash_trolly_01`, false, false, false)
    local CashAppear = function()
	    local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)
        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Wait(100)
        end
	    local grabobj = CreateObject(grabmodel, pedCoords, true)
	    FreezeEntityPosition(grabobj, true)
	    SetEntityInvincible(grabobj, true)
	    SetEntityNoCollisionEntity(grabobj, ped)
	    SetEntityVisible(grabobj, false, false)
	    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	    local startedGrabbing = GetGameTimer()
	    Citizen.CreateThread(function()
		    while GetGameTimer() - startedGrabbing < 37000 do
			    Wait(1)
			    DisableControlAction(0, 73, true)
			    if HasAnimEventFired(ped, `CASH_APPEAR`) then
				    if not IsEntityVisible(grabobj) then
					    SetEntityVisible(grabobj, true, false)
				    end
			    end
			    if HasAnimEventFired(ped, `RELEASE_CASH_DESTROY`) then
				    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
				    end
			    end
		    end
		    DeleteObject(grabobj)
	    end)
    end
	local trollyobj = Trolley
    local emptyobj = `hei_prop_hei_cash_trolly_03`

	if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end

    print(GetEntityHeading(trollyobj))
    local rot = GetEntityHeading(trollyobj)
    local targetPosition = GetEntityCoords(trollyobj)
    local targetRotation = vector3(0.0, 0.0, rot)
    local animPos = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@grab_cash', "intro", targetPosition[1], targetPosition[2], targetPosition[3], targetRotation, 0, 2)
    local targetHeading = rot
    TaskGoStraightToCoord(ped, animPos, 0.025, 5000, targetHeading, 0.05)
    Wait(2500)

    local baghash = `ch_p_m_bag_var03_arm_s`
    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Wait(100)
    end
	while not NetworkHasControlOfEntity(trollyobj) do
		Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	local bag = CreateObject(`ch_p_m_bag_var03_arm_s`, GetEntityCoords(PlayerPedId()), true, false, false)
    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(scene1)
	Wait(1500)
	CashAppear()
	local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, true, true, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene2)
	Wait(37000)
	local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene3)
    -- NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
    -- SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
	-- while not NetworkHasControlOfEntity(trollyobj) do
	-- 	Wait(1)
	-- 	NetworkRequestControlOfEntity(trollyobj)
	-- end
	-- DeleteObject(trollyobj)
    -- DeleteEntity(trollyobj)
    -- Wait(100)
    -- PlaceObjectOnGroundProperly(NewTrolley)
    TriggerServerEvent('GG_casinoheist:server:recieveCartItem')
	Wait(1800)
	DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 82, 3, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(`ch_p_m_bag_var03_arm_s`)
    LocalPlayer.state:set("inv_busy", false, true)
    print('closestTrolly',closestTrolly)
    Config.Trolleys[closestTrolly].hit = true
end)

-- Event for Triggering the Cash Pile Grab
RegisterNetEvent('GG_casinoheist:client:CashPile', function()
    -- LocalPlayer.state:set("inv_busy", true, true)
    local ped = PlayerPedId()
    local model = "h4_prop_h4_cash_stack_01a"
    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, `h4_prop_h4_cash_stack_01a`, false, false, false)
	local trollyobj = Trolley

	if IsEntityPlayingAnim(trollyobj, "anim@scripted@heist@ig1_table_grab@cash@male@", "grab_cash", 3) then
		return
    end

    local baghash = `ch_p_m_bag_var03_arm_s`
    RequestAnimDict("anim@scripted@heist@ig1_table_grab@cash@male@")
    RequestModel(baghash)
    while not HasAnimDictLoaded("anim@scripted@heist@ig1_table_grab@cash@male@") and not HasModelLoaded(baghash) do
        Wait(100)
    end
	while not NetworkHasControlOfEntity(trollyobj) do
		Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end

    local rot = GetEntityHeading(trollyobj)
    local targetPosition = GetEntityCoords(trollyobj)
    local targetRotation = vector3(0.0, 0.0, rot)
    local animPos = GetAnimInitialOffsetPosition('anim@scripted@heist@ig1_table_grab@cash@male@', "enter", targetPosition[1], targetPosition[2], targetPosition[3], targetRotation, 0, 2)
    local targetHeading = rot
    TaskGoStraightToCoord(ped, animPos, 0.025, 5000, targetHeading, 0.05)
    Wait(2500)

	local bag = CreateObject(`ch_p_m_bag_var03_arm_s`, GetEntityCoords(PlayerPedId()), true, false, false)

    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, true, false, 1065353216, 0, 1.0)
	NetworkAddPedToSynchronisedScene(ped, scene1, "anim@scripted@heist@ig1_table_grab@cash@male@", "enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@scripted@heist@ig1_table_grab@cash@male@", "enter_bag", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(scene1)

	Wait(1750)

	local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, true, false, 1065353216, 0, 1.0)
	NetworkAddPedToSynchronisedScene(ped, scene2, "anim@scripted@heist@ig1_table_grab@cash@male@", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@scripted@heist@ig1_table_grab@cash@male@", "grab_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@scripted@heist@ig1_table_grab@cash@male@", "grab_cash", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene2)

	Wait(14000)

	local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, true, false, 1065353216, 0, 1.0)
	NetworkAddPedToSynchronisedScene(ped, scene3, "anim@scripted@heist@ig1_table_grab@cash@male@", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@scripted@heist@ig1_table_grab@cash@male@", "exit_bag", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene3)

    Wait(1700)

	while not NetworkHasControlOfEntity(trollyobj) do
		Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
    
    TriggerServerEvent('GG_casinoheist:server:recieveCartItem')

	DeleteObject(trollyobj)
    DeleteEntity(trollyobj)
	DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 82, 3, 0)
	RemoveAnimDict("anim@scripted@heist@ig1_table_grab@cash@male@")
    SetModelAsNoLongerNeeded(`ch_p_m_bag_var03_arm_s`)
    LocalPlayer.state:set("inv_busy", false, true)
end)

-- Event for Triggering the Gold Trolly Grab
RegisterNetEvent('GG_casinoheist:client:StartGoldGrab', function()
    -- LocalPlayer.state:set("inv_busy", true, true)
    local ped = PlayerPedId()
    local model = "ch_prop_gold_bar_01a"
    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, `ch_prop_gold_trolly_01a`, false, false,false)
    local CashAppear = function()
        local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)
        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Wait(100)
        end
        local grabobj = CreateObject(grabmodel, pedCoords, true)
        FreezeEntityPosition(grabobj, true)
        SetEntityInvincible(grabobj, true)
        SetEntityNoCollisionEntity(grabobj, ped)
        SetEntityVisible(grabobj, false, false)
        AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        local startedGrabbing = GetGameTimer()
        Citizen.CreateThread(function()
            while GetGameTimer() - startedGrabbing < 37000 do
                Wait(1)
                DisableControlAction(0, 73, true)
                if HasAnimEventFired(ped, `CASH_APPEAR`) then
                    if not IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, true, false)
                    end
                end
                if HasAnimEventFired(ped, `RELEASE_CASH_DESTROY`) then
                    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                    end
                end
            end
            DeleteObject(grabobj)
        end)
    end
    local trollyobj = Trolley
    local emptyobj = `hei_prop_hei_cash_trolly_03`
    if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
        return
    end
    local baghash = `ch_p_m_bag_var03_arm_s`
    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and
        not HasModelLoaded(baghash) do
        Wait(100)
    end
    while not NetworkHasControlOfEntity(trollyobj) do
        Wait(1)
        NetworkRequestControlOfEntity(trollyobj)
    end

    local rot = GetEntityHeading(trollyobj)
    local targetPosition = GetEntityCoords(trollyobj)
    local targetRotation = vector3(0.0, 0.0, rot)
    local animPos = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@grab_cash', "intro", targetPosition[1], targetPosition[2], targetPosition[3], targetRotation, 0, 2)
    local targetHeading = rot
    TaskGoStraightToCoord(ped, animPos, 0.025, 5000, targetHeading, 0.05)
    Wait(2500)

    local bag = CreateObject(`ch_p_m_bag_var03_arm_s`, GetEntityCoords(PlayerPedId()), true, false, false)
    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(scene1)
    Wait(1500)
    CashAppear()
    local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, true, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(scene2)
    Wait(37000)
    local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(scene3)
    -- NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, -0.985), true)
    -- SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
    -- while not NetworkHasControlOfEntity(trollyobj) do
    --     Wait(1)
    --     NetworkRequestControlOfEntity(trollyobj)
    -- end
    -- DeleteObject(trollyobj)
    -- PlaceObjectOnGroundProperly(NewTrolley)
    TriggerServerEvent('GG_casinoheist:server:recieveGoldItem')
    Wait(1800)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 82, 3, 0)
    RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
    -- SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(`ch_p_m_bag_var03_arm_s`)
    LocalPlayer.state:set("inv_busy", false, true)
    Config.GoldTrolleys[1].hit = true
end)

-- CRASHES SERVER DONT USE
--[[RegisterNetEvent('GG_casinoheist:client:sync', function()
    local obj = GetClosestObjectOfType(Config.VaultDoorSpawn[1].x, Config.VaultDoorSpawn[1].y, Config.VaultDoorSpawn[1].z, 3.0, `ch_prop_ch_vaultdoor01x`, false)
    print(obj)
    if obj ~= 0 then
        print('Attempting to Delete Vault')
        SetEntityAsMissionEntity(obj)
        DeleteEntity(obj)
        DeleteObject(obj)
        print(obj)
    end
end)]]

-- Event for handling the minigame for hacking the keypads
AddEventHandler("datacrack", function(output) -- this event will be triggered when the player finished hacking
    -- your code here, for example:
    if output then
        print('1')
        TriggerServerEvent('sjrp-doorlock:server:updateState', Config.KeycardDoors[closestKeypad].id, false, false, false, true)
        Config.KeycardDoors[closestKeypad].isOpen = true
        -- if not VaultSpawned then
        --     TriggerServerEvent('GG_casinoheist:server:spawnvault')
        --     TriggerServerEvent('aj:sync', true)
        --     VaultSpawned = true
        -- end
    else
        print('2')
    end
    NetworkStopSynchronisedScene(HackLoop)
    NetworkStartSynchronisedScene(HackLoopFinish)
    Wait(4300)
    NetworkStopSynchronisedScene(HackLoopFinish)
    DeleteObject(bag)
    DeleteObject(laptop)
    DeleteObject(card)
    FreezeEntityPosition(PlayerPedId(), false)
    SetPedComponentVariation(PlayerPedId(), 5, 82, 3, 0)
end)

-- Event for Triggering the explosion anim to everyone in an area of the blast
RegisterNetEvent('GG_casinoheist:client:ExplodeAnim', function()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = #(pos - vector3(975.31, 59.51, 59.85))
    print(dist..' < 25')
    if dist < 25 then
        loadAnimDict("anim_heist@hs3f@ig8_vault_explosive_react@right@male@")
        TaskPlayAnim(PlayerPedId(), "anim_heist@hs3f@ig8_vault_explosive_react@right@male@", "player_react_explosive_left", 8.0, 8.0, -1, 120, 0, 0, 0, 0 )
    end
end)

-- Gets / Sets to Clest Trolly, Keypad and Drill Sppot, idek if its used anymore lol
RegisterNetEvent('GG_casinoheist:client:SetClosest', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dist
    inRange = false
    for k, v in pairs(Config.DrillSpots) do
        dist = #(pos - vector3(Config.DrillSpots[k].coords.x, Config.DrillSpots[k].coords.y, Config.DrillSpots[k].coords.z))
        if dist < 1.5 and Config.DrillSpots[k].hit == false then
            closestDrill = k
            inRange = true
        end
    end
    if not inRange then
        closestDrill = nil
    end
    for k, v in pairs(Config.Trolleys) do
        dist = #(pos - vector3(Config.Trolleys[k].coords.x, Config.Trolleys[k].coords.y, Config.Trolleys[k].coords.z))
        if dist < 1.5 and Config.Trolleys[k].hit == false then
            closestTrolly = k
            inRange = true
        end
    end
    if not inRange then
        closestTrolly = nil
    end
    for k, v in pairs(Config.KeycardDoors) do
        dist = #(pos - vector3(Config.KeycardDoors[k].coords.x, Config.KeycardDoors[k].coords.y, Config.KeycardDoors[k].coords.z))
        if dist < 1 then
            closestKeypad = k
            inRange = true
        end
    end
    if not inRange then
        closestKeypad = nil
    end
end)

-- Events for using items
--------------------------------------------------------------------------------------------------------------------------------------------------------

-- Event for when the "security_card_02" gets used
RegisterNetEvent('security_card_02:Usesecurity_card_02', function()
    local ped = PlayerPedId()
    TriggerEvent('GG_casinoheist:client:SetClosest', closestKeypad)
    if closestKeypad ~= nil then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                StartHackAnim(Config)
            else
                QBCore.Functions.Notify('You do not have the required items!', "error")
            end
        end, "security_card_02")
    end
end)

-- Event for when the "drill" gets used
RegisterNetEvent('drill:Usedrill', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    TriggerEvent('GG_casinoheist:client:SetClosest', closestDrill)
    if closestDrill ~= nil then
        print('closestDrill',closestDrill)
        print('Hit?',Config.DrillSpots[closestDrill].hit)
        if not Config.DrillSpots[closestDrill].hit then
            if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
            end
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    Busy = true
                    LocalPlayer.state:set("inv_busy", true, true)
                    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                    Wait(2000)
                    StartDrillAnim(Config)
                    LocalPlayer.state:set("inv_busy", false, true)
                    Config.DrillSpots[closestDrill].hit = true
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["drill"], "remove")
                    TriggerServerEvent("QBCore:Server:RemoveItem", "drill", 1)
                    TriggerServerEvent('GG_casinoheist:server:recieveLockerItem')
                    Busy = false
                else
                    QBCore.Functions.Notify('You do not have the required items!', "error")
                end
            end, "drill")
        else
            print('empty')
        end
    end
end)

-- Event for when the "weapon_pipebomb" gets used
RegisterNetEvent('bomb:Usebomb', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local CurrentPos = #(pos - vector3(Config.VaultBomb[1].x, Config.VaultBomb[1].y, Config.VaultBomb[1].z))
    if CurrentPos < 2 and Config.VaultBomb[1].hit == false then
        if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        end
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                SetEntityHeading(ped, 326.34)
                Config.VaultBomb[1].hit = true
                StartBombAnim(Config)
            else
                QBCore.Functions.Notify('You do not have the required items!', "error")
            end
        end, "weapon_pipebomb")
    end
end)

-- Etc...
--------------------------------------------------------------------------------------------------------------------------------------------------------

exports['sjrp-target']:AddBoxZone("VaultDoor", vector3(976.1, 58.59, 59.83), 4, 2, {
	name = "VaultDoor",
	heading = 149.54,
	debugPoly = false,
    minZ = 58.00,
    maxZ = 61.00,
	}, {
		options = {
			{
                type = "client",
                event = "bomb:Usebomb",
                icon = "fas fa-circle",
                label = "Blow Up",
			},
		},
		distance = 2.0
})

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(PlayerPedId())
        NetworkStartSynchronisedScene(HackLoop)
        NetworkStartSynchronisedScene(HackLoopFinish)
        RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
        RemoveAnimDict("anim@scripted@heist@ig1_table_grab@cash@male@")
        RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
        RemoveAnimDict("anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@")
        RemoveAnimDict("anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@")
        RemoveAnimDict("anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@")
        SetModelAsNoLongerNeeded(-2110344306)
        SetModelAsNoLongerNeeded(`hei_prop_hei_cash_trolly_01`)
        SetModelAsNoLongerNeeded(`ch_prop_gold_trolly_01a`)
        SetModelAsNoLongerNeeded(`ch_p_m_bag_var03_arm_s`)
        SetModelAsNoLongerNeeded(`hei_prop_hst_laptop`)
        SetModelAsNoLongerNeeded(`ch_prop_vault_drill_01a`)
        SetModelAsNoLongerNeeded(`ch_prop_vault_drill_01a`)
    end
end)

-----------------KingHunter
function BeginCutsceneWithPlayer()
    pos = GetEntityCoords(PlayerPedId())
    local plyrId = PlayerPedId()
    local playerClone = ClonePed_2(plyrId, 0.0, false, true, 1)
    print('Part-one')
    SetBlockingOfNonTemporaryEvents(playerClone, true)
    SetEntityVisible(playerClone, false, false)
    SetEntityInvincible(playerClone, true)
    SetEntityCollision(playerClone, false, false)
    FreezeEntityPosition(playerClone, true)
    SetPedHelmet(playerClone, false)
    RemovePedHelmet(playerClone, true)

    local model1 = GetHashKey("s_m_y_dealer_01") -- Not Used but may be needed later on
    RequestModel(model1)
    while not HasModelLoaded(model1) do
        RequestModel(model1)
        Citizen.Wait(0)
    end
    local ped1 = CreatePed(7, model1, x, y ,z, 0.0, true, true)

    local model2 = GetHashKey("s_m_y_dealer_01")
    RequestModel(model2)
    while not HasModelLoaded(model2) do
        RequestModel(model2)
        Citizen.Wait(0)
    end
    local ped2 = CreatePed(7, model2, x, y ,z, 0.0, true, true)

    local model3 = GetHashKey("s_m_y_dealer_01")
    RequestModel(model3)
    while not HasModelLoaded(model3) do
        RequestModel(model3)
        Citizen.Wait(0)
    end
    local ped3 = CreatePed(7, model3, x, y ,z, 0.0, true, true)
   
    SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
    RegisterEntityForCutscene(plyrId, 'MP_1', 0, 0, 64)

    SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
    RegisterEntityForCutscene(ped1, 'MP_2', 0, 0, 64)

    SetCutsceneEntityStreamingFlags('MP_3', 0, 1)
    RegisterEntityForCutscene(ped2, 'MP_3', 3, 0, 64)  -- 0 = enabled / 3 = false?

    SetCutsceneEntityStreamingFlags('MP_4', 0, 1)
    RegisterEntityForCutscene(ped3, 'MP_4', 3, 0, 64)

    Wait(10)
    StartCutscene(0)
    StartCutsceneAtCoords(pos[1], pos[2], pos[3] - 0.5, 0)
    Wait(10)
    ClonePedToTarget(playerClone, plyrId)
    Wait(10)
    DeleteEntity(playerClone)
     Wait(15000)
     DeleteEntity(ped1)
     DeleteEntity(ped2)
     DeleteEntity(ped3)

    return playerClone
end
--------------Polo
RegisterNetEvent('crfw:spawnped', function()
    print('part-two')
    local Kekw = CreatePed(5, 'mp_m_freemode_01', 975.05, -84.59, 74.35, 140.56, true)  -- mp_m_freemode_01
    SetPedComponentVariation(Kekw, 11, 317, 1, 0)
    SetPedComponentVariation(Kekw, 3, 12, 0, 0)
    SetPedComponentVariation(Kekw, 0, math.random(0,44), 0, 0)
    SetPedComponentVariation(Kekw, 2, math.random(2, 15), math.random(1,5), 0)
    SetPedComponentVariation(Kekw, 8, 170, 0, 0)
    SetPedComponentVariation(Kekw, 4, 10, 0, 0)
    SetPedComponentVariation(Kekw, 10, 71, 0, 0)
    SetPedComponentVariation(Kekw, 6, 24, 0, 0)
    SetPedComponentVariation(Kekw, 13, 71, 0, 0)
end)


--[[ RegisterCommand("fuckcrfw2", function()
    TriggerServerEvent('GG_casinoheist:server:spawnvault')
    StartThermAnim(Config)
    MissionNotification()
end) ]]

RegisterCommand("fuckGG3", function()
    TriggerEvent('GG:spawnped')
end)


CreateThread(function()
    TriggerServerEvent('GG_casinoheist:server:spawnvault')
    TriggerServerEvent('aj:sync', true)
    SpawnPeds()
end)

function SpawnPeds()
    RequestModel("mp_m_freemode_01")
    while not HasModelLoaded("mp_m_freemode_01") do
        Wait(5)
    end
    for k, v in pairs(Config.Peds) do
        local Yew = CreatePed(5, 'mp_m_freemode_01', v.x, v.y, v.z, v.h, true)
        SetPedComponentVariation(Yew, 11, 317, 1, 0)
        SetPedComponentVariation(Yew, 3, 12, 0, 0)
        SetPedComponentVariation(Yew, 0, math.random(0,44), 0, 0)
        SetPedComponentVariation(Yew, 2, math.random(2, 15), math.random(1,5), 0)
        SetPedComponentVariation(Yew, 8, 170, 0, 0)
        SetPedComponentVariation(Yew, 4, 10, 0, 0)
        SetPedComponentVariation(Yew, 10, 71, 0, 0)
        SetPedComponentVariation(Yew, 6, 24, 0, 0)
        SetPedComponentVariation(Yew, 13, 71, 0, 0)
        SetPedHelmet(Yew, true)
        SetPedPropIndex(Yew, 0, 144, 0, true)
        SetPedArmour(Yew, 100)
        SetPedShootRate(Yew, 300)
        SetPedCombatAttributes(Yew, 46, true)
        SetPedCombatAttributes(Yew, 0, true)
        SetPedFleeAttributes(Yew, 0, 0)
        SetPedAsEnemy(Yew,true)
        SetPedMaxHealth(Yew, 200)
        SetPedAlertness(Yew, 1)
        SetPedCombatRange(Yew, 0)
        SetPedCombatMovement(Yew, 1)
        TaskCombatPed(Yew, PlayerPedId(), 0,16)
        GiveWeaponToPed(Yew, `WEAPON_CARBINERIFLE_MK2`, 5000, true, true)
        SetPedRelationshipGroupHash( Yew, `HATES_PLAYER`)
        SetPedDropsWeaponsWhenDead(Yew, false)
    end
end
