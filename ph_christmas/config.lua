Config = {}
--Santa Coords
Config.pedCoords = vector3(1067.06, -654.11, 55.48)
Config.pedHeading = 35.35

Config.GiftItems = {
    [1] = { item = "coallump", minAmount = 1, maxAmount = 1, probability = 20 },  -- 20% chance
    [2] = { item = "firstaid", minAmount = 1, maxAmount = 2, probability = 35 },  
    [3] = { item = "lockpick", minAmount = 1, maxAmount = 2, probability = 35 },  
    [4] = { item = "joint", minAmount = 1, maxAmount = 2, probability = 35 },    
    [5] = { item = "weapon_pistol", minAmount = 1, maxAmount = 1, probability = 5 }, 
    [6] = { item = "pistol_ammo", minAmount = 1, maxAmount = 3, probability = 15 }, 
    [7] = { item = "weapon_assaultrifle", minAmount = 1, maxAmount = 1, probability = 1 }, 
    [8] = { item = "rifle_ammo", minAmount = 1, maxAmount = 2, probability = 3 }, 
    [9] = { item = "cash", minAmount = 1000, maxAmount = 10000, probability = 150 }, 
    -- Add more items with their respective probabilities
}


Config.Cooldown = true -- set to true for cooldown on recieving gifts, false for no cooldown
Config.CooldownTime = 0.02 --in hours
Config.Dispatch = 'cd_dispatch' --use ps-dispatch for PS-Dispatch, use cd_dispatch for CD_Dispatch,- none for qb-police alert
Config.minigameType = 'ps-ui' --use 'ps-ui' if using circle mingame when stealing gifts.
Config.numberOfCircles = 5 --number of spins it takes
Config.circleMiliseconds = 10 --miliseconds controlling how fast the circle goes (preferabkly 10-20)