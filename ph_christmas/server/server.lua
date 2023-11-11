QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("gift", function(source, item)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(source)
    if Ply.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('ph_christmas:client:useGift', src, item)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["gift"], "remove")
    end
end)


RegisterNetEvent('ph_christmas:server:AddGift', function(item, amount)
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add", amount)

end)

RegisterNetEvent('ph_christmast:server:recieveGift')
AddEventHandler('ph_christmast:server:recieveGift', function(item, itemAmount)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    if item == "cash" then
        ply.Functions.AddMoney('cash', itemAmount)
    else
        ply.Functions.AddItem(item, itemAmount)
    end
end)











