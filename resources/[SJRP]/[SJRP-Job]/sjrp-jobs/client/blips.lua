-- Add blips as per below examples:
-- https://docs.fivem.net/docs/game-references/blips/

local blips = {
  {title="Weazel News", colour=1 , id=459,x = -597.89, y = -929.95, z = 24.0},
  {title="Casino", colour=0 , id=680,x = 948.81, y = 34.26, z = 71.83},
  {title="BD kitZ", colour=46 , id=643,x = 135.47, y = -3030.51, z = 7.04},
 }
 
 
 -- To add additional function to the below blip display, you can add natives to change/add/remove various things, just go here (https://docs.fivem.net/natives/) and search 'SetBlip' and it will give you a list. Example: https://docs.fivem.net/natives/?_0xB14552383D39CE3E
 
CreateThread(function()

   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 0.7) -- This is the size of the blip, 0.65 is fairly good.
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
	   BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)
