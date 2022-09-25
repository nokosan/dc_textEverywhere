Menu = function()
  exports['qb-menu']:openMenu({
    {
      header = '#DC 3D Text Menu',
      icon = 'fas fa-code',
      isMenuHeader = true, -- Set to true to make a nonclickable title
    },
    {
      header = 'Create',
      txt = 'Draw New 3D Text',
      icon = 'fas fa-code-merge',
      params = {
        event = 'dcTEW:client:toggle',
      }
    },
    {
      header = 'Manage',
      txt = 'Show Exist 3DText List',
      icon = 'fas fa-code-pull-request',
      params = {
        event = 'dcTEW:client:getDataByMenu',
      }
    },
  })
end

RegisterNetEvent("dcTEW:client:openMenu", function()
  if CheckPermission() == true then
    Menu()
  end
end)

-- server -> client -> showmenu
RegisterNetEvent("dcTEW:client:getDataByMenu", function()
  print("t")
  TriggerServerEvent("dcTEW:server:getData", CheckZone(), 2)
end)

RegisterNetEvent("dcTEW:client:showTextList", function(data)
  local zoneName = CheckZone()
  local textLists = {}
  textLists[#textLists + 1] = {
    isMenuHeader = true,
    header = '3DText List #Click to delet',
    icon = 'fa-solid fa-infinity'
  }
  for k, v in pairs(data) do
    textLists[#textLists + 1] = {
      header = "UID:" .. k,
      txt = 'text:' .. v.text,
      icon = 'fa-solid fa-face-grin-tears',
      params = {
        isServer = true,
        event = 'dcTEW:server:deleteAText',
        args = {
          uid = k,
          zoneName = zoneName
        }
      }
    }
  end
  exports['qb-menu']:openMenu(textLists)
end)

RegisterNetEvent("dcTEW:client:refresh", function()
  Refresh()
end)
