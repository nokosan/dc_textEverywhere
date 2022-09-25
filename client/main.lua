local showTextdata = {}
local isShowed = false
RegisterNetEvent("dcTEW:client:showText")
AddEventHandler("dcTEW:client:showText", function(show, zoneName)
  isShowed = show
  if show == true then
    TriggerServerEvent("dcTEW:server:getData", zoneName)
  else
    showTextdata = {}
  end
end)
RegisterNetEvent("dcTEW:client:getData")
AddEventHandler("dcTEW:client:getData", function(data)
  showTextdata = data
end)
Citizen.CreateThread(function()
  while true do
    if isShowed then
      Wait(0)
      for uid, data in pairs(showTextdata) do
        local coords = showTextdata[uid].coords
        DrawText3Ds(coords.x, coords.y, coords.z, showTextdata[uid].text)
      end
    else
      Wait(1000)
    end
  end
end)
