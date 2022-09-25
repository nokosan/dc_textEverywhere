ZoneLists = {}
local entered = false
for zoneName, data in pairs(Config.Lists) do
  ZoneLists[zoneName] = PolyZone:Create(data.polyZone.data,
    -- Example = PolyZone:Create(data.polyZone.data,
    {
      name = zoneName,
      minZ = data.polyZone.minZ,
      maxZ = data.polyZone.maxZ,
      debugGrid = data.debug,
    }
  )
end

function CheckZone()
  for zoneName, _ in pairs(ZoneLists) do
    if ZoneLists[zoneName]:isPointInside(PolyZone.getPlayerPosition()) then
      return zoneName
    end
  end
  -- return false
end

function CheckPermission()
  local zoneName = CheckZone()
  if zoneName == nil then return false end
  return CheckJob(zoneName)
end

Citizen.CreateThread(function()
  while true do
    Wait(500)
    for zoneName, _ in pairs(ZoneLists) do
      ZoneLists[zoneName]:onPlayerInOut(function(isPointInside, point)
        -- insidePinkCage = isPointInside
        if (isPointInside) then
          if entered == false then
            TriggerEvent("dcTEW:client:showText", true, zoneName)
          end
          entered = true
        else
          TriggerEvent("dcTEW:client:showText", false)
          entered = false
        end
      end)
    end
  end
end)
