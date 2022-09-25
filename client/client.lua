local waitTime = 500
local x
local y
local z
local text
local uid
local zoneName
local testShow = false
local created = false -- first create
local enable = false

RegisterNetEvent("dcTEW:client:toggle")
AddEventHandler("dcTEW:client:toggle", function()
  if CheckPermission() ~= true then return false end
  enable = not enable
end)

RegisterNetEvent("dcTEW:client:draw")
AddEventHandler("dcTEW:client:draw", function(data)
  created = true
  x = data.x
  y = data.y
  z = data.z
  if CheckTextInZone(x, y, z) == true then
    text = data.text
    uid = data.uid
    testShow = true
    zoneName = CheckZone()
  else
   -- TriggerEvent("dcTEW:Notify", "You can't create to Zone outside")
  end

end)

Citizen.CreateThread(function()
  while true do
    if CheckPermission() ~= true then
      enable = false
    end
    if enable == true then
      waitTime = 5
      local color = { r = 255, g = 255, b = 255, a = 200 }
      local position = GetEntityCoords(PlayerPedId())
      local hit, coords, entity = RayCastGamePlayCamera(1000.0)
      DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
      DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g
        , color.b, color.a, false, true, 2, nil, nil, false)
      if created == true then
        DrawText3Ds(coords.x, coords.y, coords.z, "[E] Submit")
      else
        DrawText3Ds(coords.x, coords.y, coords.z, "[E] Create a New 3D Text")
      end
      if IsControlJustReleased(0, 38) then
        if created == false then
          x = coords.x
          y = coords.y
          z = coords.z
          InputMenu(x, y, z)
          -- created = true
          -- Refresh()
        else
          created = false
          testShow = false
          local data = {
            coords = {
              x = x,
              y = y,
              z = z,
            },
            text = text,
            zoneName = zoneName,
            uid = uid,
            author = QBCore.Functions.GetPlayerData().license
          }
          TriggerServerEvent("dcTEW:server:save", data)
        end
      end
      if created == true then
        Ca = (position.y - y) / (position.x - x)
        Cb = y - Ca * x
        if IsControlJustReleased(0, 188) then
          z = z + 0.1
        elseif IsControlJustReleased(0, 187) then
          z = z - 0.1
        elseif IsControlJustReleased(0, 189) then
          x = x + 0.1
          y = Ca * x + Cb
        elseif IsControlJustReleased(0, 190) then
          x = x - 0.1
          y = Ca * x + Cb
        end
      end
      if testShow == true then
        local p = GetEntityCoords(PlayerPedId()) --player coords
        Cx = math.abs(x - p.x)
        Cy = math.abs(y - p.y)
        CXY = math.sqrt(Cy * Cy + Cx * Cx)
        CDistance = math.sqrt(CXY * CXY + math.abs(z - p.z) * math.abs(z - p.z))
        DrawText3Ds(x, y, z, text)
        DrawText3Ds(x, y, z - 0.2, "Distance:" .. CDistance)
        DrawText3Ds(x, y, z - 0.3, "[E]Submit")
      end
    else
      waitTime = 500
    end
    Wait(waitTime)
  end
end)
