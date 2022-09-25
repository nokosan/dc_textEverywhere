function DrawText3Ds(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
  local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100
  if onScreen then
    SetTextColour(255, 255, 255, 255)
    SetTextScale(0.0 * scale, 0.35 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextCentre(true)
    SetTextDropshadow(1, 1, 1, 1, 255)
    BeginTextCommandWidth("STRING")
    AddTextComponentString(text)
    local height = GetTextScaleHeight(0.55 * scale, 4)
    local width = EndTextCommandGetWidth(4)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(_x, _y)
  end
end

function GetTableSize(t)
  local count = 0
  for _, __ in pairs(t) do
    count = count + 1
  end
  return count
end

function CheckJob(zoneName)
  local jobArr = Config.Lists[zoneName].authorizedJobs
  if GetTableSize(jobArr) == 0 then return true end
  local Player = QBCore.Functions.GetPlayerData()
  for jobName, grades in pairs(jobArr) do --key: job name,value : job grades
    if Player.job.name == jobName then
      if #grades == 0 then return true end --any grades
      for _, garde in pairs(grades) do
        if Player.job.grade.level == garde then return true end
      end
    end
  end
  return false
end

function CheckTextInZone(x, y, z)
  local coords = vector3(x, y, z)
  if ZoneLists[CheckZone()]:isPointInside(coords) then
    return true
  end
  TriggerEvent("dcTEW:Notify", "You can't create to Zone outside")
  return false
end

function Refresh()
  TriggerServerEvent("dcTEW:server:getData", CheckZone())
end

exports('DrawText3Ds', DrawText3Ds)
