local QBCore = exports['arabcodingteam-core']:GetCoreObject()
local deleteobj = false

RegisterNetEvent('arabcodingteam-coketable:Createtable', function(spawnedObj)
  local ped = GetPlayerPed(PlayerId())
  local inveh = IsPedInAnyVehicle(ped)
if deleteobj == false and not inveh then
  FreezeEntityPosition(ped, true)
  TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
  TriggerServerEvent('QBCore:Server:RemoveItem', 'table', 1)
  TriggerServerEvent('QBCore:Server:RemoveItem', 'glassbottle', 1)
  Wait(300)
  FreezeEntityPosition(ped, false)
    local modelHash = Table.prop 
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    local spawnedObj = CreateObject(modelHash, x, y, z, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, modelHash)
    deleteobj = true
end
end)


RegisterNetEvent('arabcodingteam-coketable:DeleteTable', function()
    local ped = GetPlayerPed(PlayerId())
    local selectedWeapon = GetSelectedPedWeapon(ped)
    if selectedWeapon ~= GetHashKey("weapon_unarmed") then
        for a = 1, #Table.blacklistweapons do
            if selectedWeapon == GetHashKey(Table.blacklistweapons[a]) then
                QBCore.Functions.Notify('You Can`t Work With One Hand !', 'error', 7500)
            end
        end
      elseif deleteobj == true then
        local obj = QBCore.Functions.GetClosestObject(spawnedObj)
      TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
      Wait(500)
      DeleteObject(obj)
      QBCore.Functions.Notify('Table In Your Bag', 'success', 7500)
      TriggerServerEvent('QBCore:Server:AddItem', 'table', 1)
      deleteobj = false
      Wait(500)
      ClearPedTasks(ped)
    end
end)

RegisterNetEvent('arabcodingteam-coketable:Makecokebaggy', function(data)
  QBCore.Functions.TriggerCallback("qb-coketable:getitem", function(result)
    if result then
      TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})

        local time = math.random(7,10)
        local circles = math.random(15,20)
        local success = exports['qb-lock']:StartLockPickCircle(circles, time, success)
        if success then
          TriggerServerEvent('QBCore:Server:AddItem', 'cokebaggy', math.random(1,2))
          TriggerServerEvent('QBCore:Server:RemoveItem', 'clorox', 2)
          TriggerServerEvent('QBCore:Server:RemoveItem', 'bakingsoda', 3)
          QBCore.Functions.Notify('You Made Some Good Shiit', 'success', 7500)
          ClearPedTasks(PlayerPedId())
        else
           QBCore.Functions.Notify('You Lost Some Item !!!', 'error', 7500)
           TriggerServerEvent('QBCore:Server:RemoveItem', 'clorox', math.random(1,2))
           TriggerServerEvent('QBCore:Server:RemoveItem', 'bakingsoda', math.random(1,2))
           ClearPedTasks(PlayerPedId())
       end
      end
  end)
end)

RegisterNetEvent('arabcodingteam-coketable:TableShop', function()
	local HouseItems = {}
	HouseItems.label = "Coke House"
	HouseItems.items = Table.CokeHouse
	HouseItems.slots = #Table.CokeHouse
	TriggerServerEvent("inventory:server:OpenInventory", "shop", "CokeHouse_"..math.random(1, 99), HouseItems) 
end)

RegisterNetEvent('arabcodingteam-coketable:knockdoor', function()
  local hour = GetClockHours()
  TriggerEvent('animations:client:EmoteCommandStart', {"knock"})
  Wait(2000)
  ClearPedTasks(PlayerPedId())
  GetTime()
end)

function GetTime()
	local hour = GetClockHours()
	if hour > 23 or hour < 18 then
	  return true
  end
  print(hour)
  TriggerEvent("arabcodingteam-coketable:TableShop")
end

Citizen.CreateThread(function()
Wait(200)
local models = {
  Table.prop,
  }
  exports['arabcodingteam-target']:AddTargetModel(models, {
    options = {
      {
        num = 1,
        type = "client",
        event = "arabcodingteam-coketable:DeleteTable",
        icon = 'fas fa-hand',
        label = 'put in',
      },
      {
        num = 2,
        type = "client",
        event = "arabcodingteam-coketable:Makecokebaggy",
        icon = 'fas fa-cannabis',
        label = 'Make Coke',
      },
    },
    distance = 1.5,
  })
  Wait(200)
  exports['arabcodingteam-target']:AddBoxZone("KnockDoor", vector3(2222.44, 5614.94, 54.71), 1.3, 1, {
    name = "KnockDoor",
    heading = 15,
    debugPoly = false,
    minZ=54.31,
    maxZ=55.91,
  }, {
    options = {
      {
        num = 1,
        type = "client",
        event = "arabcodingteam-coketable:knockdoor",
        icon = 'fas fa-home',
        label = 'Knock Door',
      }
    },
    distance = 2.5,
  })
end)
