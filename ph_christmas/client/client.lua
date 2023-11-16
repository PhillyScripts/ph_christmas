QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData()

local giftCooldowns = {}

RegisterNetEvent('ph_christmasp:Client:giveGift')
AddEventHandler('ph_christmasp:Client:giveGift', function()
    local source = source

    if Config.Cooldown == false then
        -- Cooldown is not enabled, perform the gift action without checking cooldown
        QBCore.Functions.Progressbar('abrir_vitrine', 'Taking Gift', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('ph_christmas:server:AddGift', "gift", 1)
        end)
        QBCore.Functions.Notify('Ho! Ho! Ho! Merry Christmas! ')
        return
    end

    -- Cooldown is enabled, apply the cooldown logic
    local cooldownConfig = Config.CooldownTime or 24
    local cooldown = cooldownConfig * 60 * 60  -- Convert hours to seconds

    local lastGiftTime = giftCooldowns[source] or 0

    if (GetGameTimer() - lastGiftTime) >= cooldown * 1000 then
        QBCore.Functions.Progressbar('abrir_vitrine', 'Taking Gift', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('ph_christmas:server:AddGift', "gift", 1)
        end)
        QBCore.Functions.Notify('Ho! Ho! Ho! Merry Christmas! ')
        giftCooldowns[source] = GetGameTimer()
    else
        local remainingHours = (lastGiftTime + cooldown * 1000 - GetGameTimer()) / 3600000  -- Convert milliseconds to hours
        QBCore.Functions.Notify('You can only give a gift once every ' .. cooldownConfig .. ' hours. Remaining: ' .. string.format("%.1f", remainingHours) .. ' hours.', 'error')
    end
end)

RegisterNetEvent('ph_christmasp:Client:stealGift')
AddEventHandler('ph_christmasp:Client:stealGift', function()
    local source = source

    -- Check if Config.Dispatch is 'ps-dispatch'
    if Config.Dispatch == 'ps-dispatch' then
        -- Call the export if the condition is true
        exports['ps-dispatch']:SuspiciousActivity()
    elseif Config.Dispatch == 'cd_dispatch' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police', }, 
            coords = data.coords,
            title = '10-66 Suspicious Activity',
            message = 'Suspicious Activity by a '..data.sex..' reported at '..data.street, 
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = '911 - Suspicious Activity',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.Dispatch == 'none' then
        TriggerServerEvent('police:server:policeAlert', 'Suspicious Activity')
    end

    exports["rpemotes"]:EmoteCommandStart('mechanic', 1)

    if Config.minigameType == 'ps-ui' then
        exports['ps-ui']:Circle(function(success)
            if success then
                print("success")
                QBCore.Functions.Progressbar('gift', 'Stealing gift!!', 19000, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'anim@gangops@facility@servers@',
                    anim = 'hotwire',
                    flags = 16,
                }, {}, {}, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('ph_christmas:server:AddGift', "gift", 1)
                    QBCore.Functions.Notify('You stole a gift! Someone called the cops!')
                end)
            else
                print("fail")
                QBCore.Functions.Notify('Failed to steal the presents!', 'error')
                -- Clear tasks to end the animation
                ClearPedTasks(PlayerPedId())
            end
        end, Config.numberOfCircles, Config.circleMiliseconds)
    else
        QBCore.Functions.Progressbar('gift', 'Stealing gift!!', 19000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, function()
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('ph_christmas:server:AddGift', "gift", 1)
            QBCore.Functions.Notify('You stole a gift! Someone called the cops!')
        end)
    end
end)




RegisterNetEvent('ph_christmas:client:useGift')
AddEventHandler('ph_christmas:client:useGift', function(source)
    local src = source
    local ply = QBCore.Functions.GetPlayerData()

    QBCore.Functions.Progressbar('gift', 'Opening gift!!', 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function()
        local totalProbability = 0
        for _, item in pairs(Config.GiftItems) do
            totalProbability = totalProbability + item.probability
        end

        local randomValue = math.random(totalProbability)
        local selectedItemId

        for itemId, item in pairs(Config.GiftItems) do
            if randomValue <= item.probability then
                selectedItemId = itemId
                break
            else
                randomValue = randomValue - item.probability
            end
        end

        local item = Config.GiftItems[selectedItemId]
        TriggerServerEvent('ph_christmast:server:recieveGift', item.item, math.random(item.minAmount, item.maxAmount))

        if item.item and QBCore.Shared.Items[item.item] then
            local itemName = QBCore.Shared.Items[item.item].label
            local itemAmount = math.random(item.minAmount, item.maxAmount)

            if item.item == 'cash' then
                QBCore.Functions.Notify('Congratulations! You received cash!', 'success')
            elseif item.item == 'coallump' then
                QBCore.Functions.Notify("You've been naughty and got a Lump of Coal.", 'error')
            else
                QBCore.Functions.Notify('You received ' .. itemAmount .. 'x ' .. itemName, 'success')
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[item.item], 'add')
            end
        else
            print('Invalid item received from the gift.')
        end
    end, function()
    end)
end)

CreateThread(function()
    -- Spawning Ped for store
    local ped = GetHashKey('Santaclaus')
    local pedCoords = Config.pedCoords
    RequestModel(ped)
    
    while not HasModelLoaded(ped) do
        Citizen.Wait(0)
    end
    
    local createPed = CreatePed(1, ped, pedCoords.x, pedCoords.y, pedCoords.z, Config.pedHeading, true, false)
    SetEntityInvincible(createPed, true)
    SetEntityAsMissionEntity(createPed, true, true)
    SetBlockingOfNonTemporaryEvents(createPed, true)
    SetEntityNoCollisionEntity(createPed, true)
    SetPedCanRagdoll(createPed, false)
    SetEntityMaxSpeed(createPed, 0.0)
    TaskWarpPedIntoVehicle(createPed, 0, 0)
    
    
    end)

