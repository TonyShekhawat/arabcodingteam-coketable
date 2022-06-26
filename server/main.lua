local QBCore = exports['arabcodingteam-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("table", function(source, item)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local item = 'glassbottle'
	if Player.Functions.GetItemByName(item) ~= nil then
        TriggerClientEvent('arabcodingteam-coketable:Createtable', source)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Are Missing A Galss Bottle!', 'error')
	end
end)

QBCore.Functions.CreateCallback('arabcodingteam-coketable:getitem', function(source, cb, items, hasItems)
    local src = source
    local hasItems = false
    local numero = 0
    local player = QBCore.Functions.GetPlayer(source)
    local items = { [1] = {item = "clorox", amount = 2}, [2] = {item = "bakingsoda", amount = 3} }
    
    for k, v in pairs(items) do
        if player.Functions.GetItemByName(v.item) and player.Functions.GetItemByName(v.item).amount >= v.amount then
            numero = numero + 1
            if numero == #items then
                cb(true)
            end
        else
            cb(false)
            return
        end
    end
end)
