QBCore = exports['qb-core']:GetCoreObject()
Config = {} -- dont change it
Config.Draw3DText = {
  font = 0,
}

Config.Lists = {} -- dont change it

RegisterNetEvent("dcTEW:Notify", function(msg, type, time)
  -- TriggerClientEvent('QBCore:Notify', msg, 'primary')
  if time == nil then time = 5000 end
  exports['okokNotify']:Alert('Notice', msg, time, "info")
end)
