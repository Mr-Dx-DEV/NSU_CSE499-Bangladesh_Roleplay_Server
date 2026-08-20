local QBCore = exports['sjfw']:GetCoreObject()
function CreateBlips()
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].blipTrue then
			local blip = AddBlipForCoord(v.location)
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, 527)
			SetBlipColour(blip, 81)
			SetBlipScale(blip, 0.7)
			SetBlipDisplay(blip, 6)

			BeginTextCommandSetBlipName('STRING')
			if Config.BlipNamer then
				AddTextComponentString(Config.Locations[k].name)
			else
				AddTextComponentString("Mining")
			end
			EndTextCommandSetBlipName(blip)
		end
	end
end

CreateThread(function()
	--Hide the mineshaft doors
	CreateModelHide(vector3(-596.04, 2089.01, 131.41), 10.5, -1241212535, true)

    if Config.Blips == true then
		CreateBlips()
	end
end)
CreateThread(function()
	if Config.PropSpawn == true then
		CreateProps()
	end
end)
CreateThread(function()
	if Config.Pedspawn == true then
		CreatePeds()
	end
end)
-----------------------------------------------------------

local peds = {}
local shopPeds = {}
function CreatePeds()
	while true do
		Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)
			if dist < Config.Distance and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end
			if dist >= Config.Distance and peds[k] then
				if Config.Fade then
					for i = 255, 0, -51 do
						Wait(50)
						SetEntityAlpha(peds[k].ped, i, false)
					end
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end

function nearPed(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(1)
	end
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end
	if Config.MinusOne then 
		local x, y, z = table.unpack(coords)
		ped = CreatePed(genderNum, GetHashKey(model), x, y, z - 1, heading, false, true)
		table.insert(shopPeds, ped)
	else
		ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
		table.insert(shopPeds, ped)
	end
	SetEntityAlpha(ped, 0, false)
	if Config.Frozen then
		FreezeEntityPosition(ped, true) --Don't let the ped move.
	end
	if Config.Invincible then
		SetEntityInvincible(ped, true) --Don't let the ped die.
	end
	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(ped, true) --Don't let the ped react to his surroundings.
	end
	--Add an animation to the ped, if one exists.
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) -- begins peds animation
	end
	if Config.Fade then
		for i = 0, 255, 51 do
			Wait(50)
			SetEntityAlpha(ped, i, false)
		end
	end
	return ped
end

-----------------------------------------------------------

function CreateProps()

	--Quickly add outside lighting
		if minelight1 == nil then
			RequestModel(GetHashKey("prop_worklight_03a"))
			while not HasModelLoaded(GetHashKey("prop_worklight_03a")) do Wait(1) end
			local minelight1 = CreateObject(GetHashKey("prop_worklight_03a"),-593.29, 2093.22, 131.7-1.05,false,false,false)
			SetEntityHeading(minelight1,GetEntityHeading(minelight1)-80)
			FreezeEntityPosition(minelight1, true)
		end		
		if minelight2 == nil then
			RequestModel(GetHashKey("prop_worklight_03a"))
			while not HasModelLoaded(GetHashKey("prop_worklight_03a")) do Wait(1) end
			local minelight2 = CreateObject(GetHashKey("prop_worklight_03a"),-604.55, 2089.74, 131.15-1.05,false,false,false)
			SetEntityHeading(minelight2,GetEntityHeading(minelight2)-260)
			FreezeEntityPosition(minelight2, true)
		end

	local prop = 0
	for k,v in pairs(Config.OrePositions) do
		prop = prop+1
		local prop = CreateObject(GetHashKey("cs_x_rubweec"),v.coords.x, v.coords.y, v.coords.z+1.03,false,false,false)
		SetEntityHeading(prop,GetEntityHeading(prop)-90)
		FreezeEntityPosition(prop, true)           
    end
	for k,v in pairs(Config.MineLights) do
		prop = prop+1
		local prop = CreateObject(GetHashKey("xs_prop_arena_lights_ceiling_l_c"),v.coords.x, v.coords.y, v.coords.z+1.03,false,false,false)
		--SetEntityHeading(prop,GetEntityHeading(prop)-90)
		FreezeEntityPosition(prop, true)           
    end
	--Jewel Cutting Bench
	local bench = CreateObject(GetHashKey("gr_prop_gr_bench_04b"),Config.Locations['JewelCut'].location,false,false,false)
	SetEntityHeading(bench,GetEntityHeading(bench)-Config.Locations['JewelCut'].heading)
	FreezeEntityPosition(bench, true)

	--Stone Cracking Bench
	local bench2 = CreateObject(GetHashKey("prop_tool_bench02"),Config.Locations['Cracking'].location,false,false,false)
	SetEntityHeading(bench2,GetEntityHeading(bench2)-Config.Locations['Cracking'].heading)
	FreezeEntityPosition(bench2, true)
	--Stone Prop for bench
	local bench2prop = CreateObject(GetHashKey("cs_x_rubweec"),Config.Locations['Cracking'].location.x, Config.Locations['Cracking'].location.y, Config.Locations['Cracking'].location.z+0.83,false,false,false)
	SetEntityHeading(bench2prop,GetEntityHeading(bench2prop)-Config.Locations['Cracking'].heading+90)
	FreezeEntityPosition(bench2prop, true)
	local bench2prop2 = CreateObject(GetHashKey("prop_worklight_03a"),Config.Locations['Cracking'].location.x-1.4, Config.Locations['Cracking'].location.y+1.08, Config.Locations['Cracking'].location.z,false,false,false)
	SetEntityHeading(bench2prop2,GetEntityHeading(bench2prop2)-Config.Locations['Cracking'].heading+180)
	FreezeEntityPosition(bench2prop2, true)
end

-----------------------------------------------------------

CreateThread(function()
	exports['sjrp-target']:AddCircleZone("MineShaft", Config.Locations['Mine'].location, 2.0, { name="MineShaft", debugPoly=false, useZ=true, }, 
	{ options = { { event = "qb-mine:openShop", icon = "fas fa-certificate", label = "Browse Store", }, },
		distance = 2.0
	})
	--Smelter to turn stone into ore
	exports['sjrp-target']:AddCircleZone("Smelter", Config.Locations['Smelter'].location, 3.0, { name="Smelter", debugPoly=false, useZ=true, }, 
	{ options = { { event = "qb-mine:SmeltMenu", icon = "fas fa-certificate", label = "Use Smelter", }, },
		distance = 10.0
	})
	--Ore Buyer
	exports['sjrp-target']:AddCircleZone("Buyer", Config.Locations['Buyer'].location, 2.0, { name="Buyer", debugPoly=false, useZ=true, }, 
	{ options = { { event = "qb-mine:SellOre", icon = "fas fa-certificate", label = "Sell Ores", },	},
		distance = 2.0
	})
	--Jewel Cutting Bench
	exports['sjrp-target']:AddCircleZone("JewelCut", Config.Locations['JewelCut'].location, 2.0, { name="JewelCut", debugPoly=false, useZ=true, }, 
	{ options = { { event = "qb-mine:JewelCut", icon = "fas fa-certificate", label = "Use Jewel Cutting Bench", },	},
		distance = 2.0
	})
	--Jewel Buyer
	exports['sjrp-target']:AddCircleZone("JewelBuyer", Config.Locations['Buyer2'].location, 2.0, { name="JewelBuyer", debugPoly=false, useZ=true, }, 
	{ options = { { event = "qb-mine:JewelSell", icon = "fas fa-certificate", label = "Talk To Jewel Buyer", },	},
		distance = 2.0
	})
	--Cracking Bench
	exports['sjrp-target']:AddCircleZone("CrackingBench", Config.Locations['Cracking'].location, 2.0, { name="CrackingBench", debugPoly=false, useZ=true, }, 
	{ options = { { event = "qb-mine:CrackStart", icon = "fas fa-certificate", label = "Use Cracking Bench", },	},
		distance = 2.0
	})
	local ore = 0
	for k,v in pairs(Config.OrePositions) do
		ore = ore+1
		exports['sjrp-target']:AddCircleZone(ore, v.coords, 2.0, { name=ore, debugPoly=false, useZ=true, }, 
		{ options = { { event = "qb-mine:MineOre", icon = "fas fa-certificate", label = "Mine ore", },	},
			distance = 2.5
		})
	end
end)

-----------------------------------------------------------
--Mining Store Opening
RegisterNetEvent('qb-mine:openShop', function ()
	TriggerServerEvent("inventory:server:OpenInventory", "shop", "mine", Config.Items)
end)
------------------------------------------------------------
-- Mine Ore Command / Animations

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Wait( 5 )
    end
end 

RegisterNetEvent('qb-mine:MineOre', function ()
QBCore.Functions.TriggerCallback("QBCore:HasItem", function(item) 
		if item then 
			local pos = GetEntityCoords(PlayerPedId())
			loadAnimDict("anim@heists@fleeca_bank@drilling")
			TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
			local pos = GetEntityCoords(PlayerPedId(), true)
			local DrillObject = CreateObject(GetHashKey("hei_prop_heist_drill"), pos.x, pos.y, pos.z, true, true, true)
			AttachEntityToEntity(DrillObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
			QBCore.Functions.Progressbar("open_locker_drill", "Drilling Ore..", math.random(10000,15000), false, true, {
				disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
				StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
				SetEntityAsMissionEntity(DrillObject)--nessesary for gta to even trigger DetachEntity
				Wait(5)
				DetachEntity(DrillObject, true, true)
				Wait(5)
				DeleteObject(DrillObject)
				TriggerServerEvent('qb-mine:MineReward')
				IsDrilling = false
				TriggerServerEvent('qb-mine:MineReward')	
				IsDrilling = false
			end, function() -- Cancel
				StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
				DetachEntity(DrillObject, true, true)
				DeleteObject(DrillObject)
				IsDrilling = false
			end)
		else
			TriggerEvent('QBCore:Notify', "You dont have a drill", 'error')
		end 
	end, "drill")
end)


RegisterNetEvent('qb-mine:CrackStart', function ()
	QBCore.Functions.TriggerCallback("QBCore:HasItem", function(item) 
		if item then 
			local pos = GetEntityCoords(PlayerPedId())
			loadAnimDict('amb@prop_human_parking_meter@male@idle_a')
			TaskPlayAnim(PlayerPedId(), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a' , 3.0, 3.0, -1, 1, 0, false, false, false)
			QBCore.Functions.Progressbar("open_locker_drill", "Cracking Stone..", math.random(10000,15000), false, true, {
				disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
				StopAnimTask(PlayerPedId(), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
				TriggerServerEvent('qb-mine:CrackReward')
				IsDrilling = false
			end, function() -- Cancel
				StopAnimTask(PlayerPedId(), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
				IsDrilling = false
			end)
		else 
			TriggerEvent('QBCore:Notify', "You don't have any Stone", 'error')
		end 
	end, "stone")
end)
RegisterNetEvent('qb-mine:MakeItem', function(data)
	for i = 1, #data.craftable do
		for k, v in pairs(data.craftable[i]) do
			if data.item == k then
				QBCore.Functions.TriggerCallback('qb-mine:get', function(amount) 
					if not amount then 
						TriggerEvent('QBCore:Notify', "You don't have the correct ingredients", 'error')
						TriggerEvent('qb-mine:SmeltMenu')
					else itemProgress(data.item, data.craftable) end		
				end, data.item, data.craftable)
			end
		end
	end
end)

RegisterNetEvent('qb-mine:MakeItem:Cutting', function(data)
QBCore.Functions.TriggerCallback("qb-mine:Cutting:Check:Tools",function(hasTools)
		if hasTools then
			for i = 1, #data.craftable do
				for k, v in pairs(data.craftable[i]) do
					if data.item == k then
						QBCore.Functions.TriggerCallback('qb-mine:get', function(amount) 
							if not amount then 
								TriggerEvent('QBCore:Notify', "You don't have the correct ingredients", 'error')
							else itemProgress(data.item, data.craftable) end		
						end, data.item, data.craftable)
					end
				end
			end
		else
			TriggerEvent('QBCore:Notify', "You don\'t have a Hand Drill or Drill Bit", 'error')
			TriggerEvent('qb-mine:JewelCut')
		end
	end)
end)

function itemProgress(ItemMake, craftable)
	if craftable then
		for i = 1, #Crafting.SmeltMenu do
			for k, v in pairs(Crafting.SmeltMenu[i]) do
				if ItemMake == k then
					bartext = "Smelting "..QBCore.Shared.Items[ItemMake].label
					bartime = 7000
					animDictNow = "amb@prop_human_parking_meter@male@idle_a"
					animNow = "idle_a"
				end
			end
		end
		for i = 1, #Crafting.GemCut do
			for k, v in pairs(Crafting.GemCut[i]) do
				if ItemMake == k then
					bartext = "Cutting "..QBCore.Shared.Items[ItemMake].label
					bartime = 7000
					animDictNow = "amb@prop_human_parking_meter@male@idle_a"
					animNow = "idle_a"
				end
			end
		end
		for i = 1, #Crafting.RingCut do
			for k, v in pairs(Crafting.RingCut[i]) do
				if ItemMake == k then
					bartext = "Cutting "..QBCore.Shared.Items[ItemMake].label
					bartime = 7000
					animDictNow = "amb@prop_human_parking_meter@male@idle_a"
					animNow = "idle_a"
				end
			end
		end
		for i = 1, #Crafting.NeckCut do
			for k, v in pairs(Crafting.NeckCut[i]) do
				if ItemMake == k then
					bartext = "Cutting "..QBCore.Shared.Items[ItemMake].label
					bartime = 7000
					animDictNow = "amb@prop_human_parking_meter@male@idle_a"
					animNow = "idle_a"
				end
			end
		end
	end
	QBCore.Functions.Progressbar('making_food', bartext, bartime, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = animDictNow,
		anim = animNow,
		flags = 8,
	}, {}, {}, function()  
		TriggerServerEvent('qb-mine:GetItem', ItemMake, craftable)
		StopAnimTask(PlayerPedId(), animDictNow, animNow, 1.0)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', "Cancelled!", 'error')
	end)
end
------------------------------------------------------------
--These also lead to the actual selling commands

--Selling animations are simply a pass item to seller animation
--Sell Ore Animation
--Sell Anim small Test
RegisterNetEvent('qb-mine:SellAnim', function(data)
	if data == -2 then
		exports['sjrp-menu']:closeMenu()
		return
	end
	local pid = PlayerPedId()
	loadAnimDict("mp_common")
	TriggerServerEvent('qb-mine:Selling', data) -- Had to slip in the sell command during the animation command
	for k,v in pairs (shopPeds) do
        pCoords = GetEntityCoords(PlayerPedId())
        ppCoords = GetEntityCoords(v)
		ppRot = GetEntityRotation(v)
        dist = #(pCoords - ppCoords)
        if dist < 2 then 
			TaskPlayAnim(pid, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            TaskPlayAnim(v, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            Wait(1500)
            StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
            StopAnimTask(v, "mp_common", "givetake2_a", 1.0)
            RemoveAnimDict("mp_common")
			SetEntityRotation(v, 0,0,ppRot.z,0,0,false)		
			break
		end
	end
	TriggerEvent('qb-mine:SellOre')
end)


--Sell Anim small Test
RegisterNetEvent('qb-mine:SellAnim:Jewel', function(data)
	if data == -2 then
		exports['sjrp-menu']:closeMenu()
		return
	end	
	local pid = PlayerPedId()
	loadAnimDict("mp_common")
	TriggerServerEvent('qb-mine:SellJewel', data) -- Had to slip in the sell command during the animation command
	for k,v in pairs (shopPeds) do
        pCoords = GetEntityCoords(PlayerPedId())
        ppCoords = GetEntityCoords(v)
		ppRot = GetEntityRotation(v)
        dist = #(pCoords - ppCoords)
        if dist < 2 then 
			TaskPlayAnim(pid, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            TaskPlayAnim(v, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            Wait(1500)
            StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
            StopAnimTask(v, "mp_common", "givetake2_a", 1.0)
            RemoveAnimDict("mp_common")
			SetEntityRotation(v, 0,0,ppRot.z,0,0,false)
			break
		end
	end	
	if string.find(data, "ring") then TriggerEvent('qb-mine:JewelSell:Rings')
	elseif string.find(data, "chain") or string.find(data, "necklace") then TriggerEvent('qb-mine:JewelSell:Necklace')
	elseif string.find(data, "emerald") then TriggerEvent('qb-mine:JewelSell:Emerald')
	elseif string.find(data, "ruby") then TriggerEvent('qb-mine:JewelSell:Ruby')
	elseif string.find(data, "diamond") then TriggerEvent('qb-mine:JewelSell:Diamond')
	elseif string.find(data, "sapphire") then TriggerEvent('qb-mine:JewelSell:Sapphire') end
end)


------------------------------------------------------------
--Context Menus
--Selling Ore
RegisterNetEvent('qb-mine:SellOre', function()
	exports['sjrp-menu']:openMenu({
		{ header = "Ore Selling", txt = "Sell Batches of Ore for cash", isMenuHeader = true },
		{ header = "", txt = "✘ Close", params = { event = "qb-mine:SellAnim", args = -2 } },
		{ header = "Copper Ore", txt = "Sell ALL at $"..Config.SellItems['copperore'].." each", params = { event = "qb-mine:SellAnim", args = 'copperore' } },
		{ header = "Iron Ore", txt = "Sell ALL at $"..Config.SellItems['ironore'].." each", params = { event = "qb-mine:SellAnim", args = 'ironore' } },
		{ header = "Gold Ore", txt = "Sell ALL at $"..Config.SellItems['goldore'].." each", params = { event = "qb-mine:SellAnim", args = 'goldore' } },
		{ header = "Carbon", txt = "Sell ALL at $"..Config.SellItems['carbon'].." each", params = { event = "qb-mine:SellAnim", args = 'carbon' } }, 
	})
end)
------------------------
--Jewel Selling Main Menu
RegisterNetEvent('qb-mine:JewelSell', function()
    exports['sjrp-menu']:openMenu({
		{ header = "Jewellery Buyer", txt = "Sell your jewellery here", isMenuHeader = true }, 
		{ header = "", txt = "✘ Close", params = { event = "qb-mine:SellAnim:Jewel", args = -2 } },
		{ header = "Emeralds", txt = "See all Emerald selling options", params = { event = "qb-mine:JewelSell:Emerald", } },
		{ header = "Rubys", txt = "See all Ruby selling options", params = { event = "qb-mine:JewelSell:Ruby", } },
		{ header = "Diamonds", txt = "See all Diamond selling options", params = { event = "qb-mine:JewelSell:Diamond", } },
		{ header = "Sapphires", txt = "See all Sapphire selling options", params = { event = "qb-mine:JewelSell:Sapphire", } },
		{ header = "Rings", txt = "See all Ring Options", params = { event = "qb-mine:JewelSell:Rings", } },
		{ header = "Necklaces", txt = "See all Necklace Options", params = { event = "qb-mine:JewelSell:Necklace", } },
	})
end)
--Jewel Selling - Emerald Menu
RegisterNetEvent('qb-mine:JewelSell:Emerald', function()
    exports['sjrp-menu']:openMenu({
		{ header = "Jewellery Buyer", txt = "Sell your jewellery here", isMenuHeader = true }, 
		{ header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelSell", } },
		{ header = "Emeralds", txt = "Sell ALL at $"..Config.SellItems['emerald'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'emerald' } },
		{ header = "Uncut Emeralds", txt = "Sell ALL at $"..Config.SellItems['uncut_emerald'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'uncut_emerald' } }, 
	})
end)
--Jewel Selling - Ruby Menu
RegisterNetEvent('qb-mine:JewelSell:Ruby', function()
    exports['sjrp-menu']:openMenu({
		{ header = "Jewellery Buyer", txt = "Sell your jewellery here", isMenuHeader = true }, 
		{ header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelSell", } },
		{ header = "Rubys", txt = "Sell ALL at $"..Config.SellItems['ruby'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'ruby' } },
		{ header = "Uncut Rubys", txt = "Sell ALL at $"..Config.SellItems['uncut_ruby'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'uncut_ruby' } },
	})
end)
--Jewel Selling - Diamonds Menu
RegisterNetEvent('qb-mine:JewelSell:Diamond', function()
    exports['sjrp-menu']:openMenu({
		{ header = "Jewellery Buyer", txt = "Sell your jewellery here", isMenuHeader = true }, 
		{ header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelSell", } },
		{ header = "Diamonds", txt = "Sell ALL at $"..Config.SellItems['diamond'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'diamond' } },
		{ header = "Uncut Diamonds", txt = "Sell ALL at $"..Config.SellItems['uncut_diamond'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'uncut_diamond' } },
	})
end)
--Jewel Selling - Sapphire Menu
RegisterNetEvent('qb-mine:JewelSell:Sapphire', function()
    exports['sjrp-menu']:openMenu({
		{ header = "Jewellery Buyer", txt = "Sell your jewellery here", isMenuHeader = true }, 
		{ header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelSell", } },
		{ header = "Sapphires", txt = "Sell ALL at $"..Config.SellItems['sapphire'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'sapphire' } },
		{ header = "Uncut Sapphires", txt = "Sell ALL at $"..Config.SellItems['uncut_sapphire'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'uncut_sapphire' } },
	})
end)

--Jewel Selling - Jewellry Menu
RegisterNetEvent('qb-mine:JewelSell:Rings', function()
    exports['sjrp-menu']:openMenu({
		{ header = "Jewellery Buyer", txt = "Sell your jewellery here", isMenuHeader = true }, 
		{ header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelSell", } },
		{ header = "Gold Rings", txt = "Sell ALL at $"..Config.SellItems['gold_ring'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'gold_ring' } },
		{ header = "Diamond Rings", txt = "Sell ALL at $"..Config.SellItems['diamond_ring'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'diamond_ring'} },
		{ header = "Emerald Rings", txt = "Sell ALL at $"..Config.SellItems['emerald_ring'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'emerald_ring' } },
		{ header = "Ruby Rings", txt = "Sell ALL at $"..Config.SellItems['ruby_ring'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'ruby_ring' } },	
		{ header = "Sapphire Rings", txt = "Sell ALL at $"..Config.SellItems['sapphire_ring'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'sapphire_ring' } },
	})
end)
--Jewel Selling - Jewellery Menu
RegisterNetEvent('qb-mine:JewelSell:Necklace', function()
    exports['sjrp-menu']:openMenu({
		{ header = "Jewellery Buyer", txt = "Sell your jewellery here", isMenuHeader = true }, 
		{ header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelSell", } },
		{ header = "Gold Chains",	txt = "Sell ALL at $"..Config.SellItems['goldchain'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'goldchain' } },
		{ header = "Gold Chains", txt = "Sell ALL at $"..Config.SellItems['10kgoldchain'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = '10kgoldchain' } },
		{ header = "Diamond Necklace", txt = "Sell ALL at $"..Config.SellItems['diamond_necklace'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'diamond_necklace' } },
		{ header = "Emerald Necklace", txt = "Sell ALL at $"..Config.SellItems['emerald_necklace'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'emerald_necklace' } },
		{ header = "Ruby Necklace", txt = "Sell ALL at $"..Config.SellItems['ruby_necklace'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'ruby_necklace' } },	
		{ header = "Sapphire Necklace", txt = "Sell ALL at $"..Config.SellItems['sapphire_necklace'].." each", params = { event = "qb-mine:SellAnim:Jewel", args = 'sapphire_necklace' } },
	})
end)
------------------------

--Smelting
RegisterNetEvent('qb-mine:SmeltMenu', function()
	TriggerEvent("QBCore:Notify", Crafting.SmeltMenu[1]["amount"], "error")
	local SmeltMenu = {}
	SmeltMenu[#SmeltMenu + 1] = { header = "Smelter", txt = "Smelt ores down into usable materials", isMenuHeader = true }
	SmeltMenu[#SmeltMenu + 1] = { header = "", txt = "✘ Close", params = { event = "qb-mine:SellAnim", args = -2 } }
		for i = 1, #Crafting.SmeltMenu do
			for k, v in pairs(Crafting.SmeltMenu[i]) do
				if k ~= "amount" then
					local text = ""
					if Crafting.SmeltMenu[i]["amount"] then amount = " x"..Crafting.SmeltMenu[i]["amount"] else amount = "" end
					setheader = QBCore.Shared.Items[k].label..tostring(amount)
					for l, b in pairs(Crafting.SmeltMenu[i][tostring(k)]) do
						if b == 1 or b ~= nil then number = "" else number = " x"..b end
						text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
						settext = text
					end
					SmeltMenu[#SmeltMenu + 1] = { header = setheader, txt = settext, params = { event = "qb-mine:MakeItem", args = { item = k, craftable = Crafting.SmeltMenu } } }
					settext, amount, setheader = nil
				end
			end
		end
	exports['sjrp-menu']:openMenu(SmeltMenu)
end)
------------------------

--Cutting Jewels
RegisterNetEvent('qb-mine:JewelCut', function()
    exports['sjrp-menu']:openMenu({
	{ header = "Jewellery Crafting Bench", txt = "Requires Hand Drill & Drill Bit", isMenuHeader = true },
	{ header = "", txt = "✘ Close", params = { event = "qb-mine:SellAnim", args = -2 } },
	{ header = "Gem Cutting",	txt = "Go to Gem Cutting Section", params = { event = "qb-mine:JewelCut:Gem", } },
	{ header = "Make Rings", txt = "Go to Ring Crafting Section", params = { event = "qb-mine:JewelCut:Ring", } },
	{ header = "Make Necklaces", txt = "Go to Necklace Crafting Section", params = { event = "qb-mine:JewelCut:Necklace", } },
	})
end)

--Gem Section
RegisterNetEvent('qb-mine:JewelCut:Gem', function()
	local GemCut = {}
	GemCut[#GemCut + 1] = { header = "Jewellery Crafting Bench", txt = "Requires Hand Drill & Drill Bit", isMenuHeader = true }
	GemCut[#GemCut + 1] = { header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelCut", } }
		for i = 1, #Crafting.GemCut do
			for k, v in pairs(Crafting.GemCut[i]) do
				if k ~= "amount" then
					local text = ""
					if Crafting.GemCut[i]["amount"] then amount = " x"..Crafting.GemCut[i]["amount"] else amount = "" end
					setheader = QBCore.Shared.Items[k].label..tostring(amount)
					for l, b in pairs(Crafting.GemCut[i][tostring(k)]) do
						if b == 1 then number = "" else number = " x"..b end
						text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
						settext = text
					end
					GemCut[#GemCut + 1] = { header = setheader, txt = settext, params = { event = "qb-mine:MakeItem:Cutting", args = { item = k, craftable = Crafting.GemCut } } }
					settext, setheader = nil
				end
			end
		end
	exports['sjrp-menu']:openMenu(GemCut)
end)

-- Ring Section
RegisterNetEvent('qb-mine:JewelCut:Ring', function()
	local RingCut = {}
	RingCut[#RingCut + 1] = { header = "Jewellery Crafting Bench", txt = "Requires Hand Drill & Drill Bit", isMenuHeader = true }
	RingCut[#RingCut + 1] = { header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelCut", } }
		for i = 1, #Crafting.RingCut do
			for k, v in pairs(Crafting.RingCut[i]) do
				if k ~= "amount" then
					local text = ""
					if Crafting.RingCut[i]["amount"] then amount = " x"..Crafting.RingCut[i]["amount"] else amount = "" end
					setheader = QBCore.Shared.Items[k].label..tostring(amount)
					for l, b in pairs(Crafting.RingCut[i][tostring(k)]) do
						if b == 1 then number = "" else number = " x"..b end
						text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
						settext = text
					end
					RingCut[#RingCut + 1] = { header = setheader, txt = settext, params = { event = "qb-mine:MakeItem:Cutting", args = { item = k, craftable = Crafting.RingCut } } }
					settext, setheader = nil
				end
			end
		end
	exports['sjrp-menu']:openMenu(RingCut)
end)

--Necklace Section
RegisterNetEvent('qb-mine:JewelCut:Necklace', function()
	local NeckCut = {}
	NeckCut[#NeckCut + 1] = { header = "Jewellery Crafting Bench", txt = "Requires Hand Drill & Drill Bit", isMenuHeader = true }
	NeckCut[#NeckCut + 1] = { header = "", txt = "⬅ Return", params = { event = "qb-mine:JewelCut", } }
		for i = 1, #Crafting.NeckCut do
			for k, v in pairs(Crafting.NeckCut[i]) do
				if k ~= "amount" then
					local text = ""
					if Crafting.NeckCut[i]["amount"] then amount = " x"..Crafting.NeckCut[i]["amount"] else amount = "" end
					setheader = QBCore.Shared.Items[k].label..tostring(amount)
					for l, b in pairs(Crafting.NeckCut[i][tostring(k)]) do
						if b == 1 then number = "" else number = " x"..b end
						text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
						settext = text
					end
					NeckCut[#NeckCut + 1] = { header = setheader, txt = settext, params = { event = "qb-mine:MakeItem:Cutting", args = { item = k, craftable = Crafting.NeckCut } } }
					settext, setheader = nil
				end
			end
		end
	exports['sjrp-menu']:openMenu(NeckCut)
end)