CreateThread(function()

   
    exports['qb-target']:AddTargetModel('Santaclaus', { -- This defines the models, can be a string or a table
    options = {
        {  
        event = "ph_christmasp:Client:giveGift",
        icon = "fas fa-birthday-cake",
        label = "Recieve a Gift!",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("stealpresent1", vector3(1072.8, -654.62, 56.49), 4.0, 2, {
    name = "stealpresent1",
    heading = 340,
    debugpoly = false,
}, {
    options = {
        {  
        event = "ph_christmasp:Client:stealGift",
        icon = "fas fa-hand",
        label = "Steal A Gift",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("stealpresent2", vector3(1066.51, -655.5, 56.48), 2, 2, {
    name = "stealpresent2",
    heading = 0,
    debugpoly = false,
}, {
    options = {
        {  
        event = "ph_christmasp:Client:stealGift",
        icon = "fas fa-hand",
        label = "Steal A Gift",
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("stealpresent3", vector3(1049.62, -642.29, 56.49), 3.0, 1, {
    name = "stealpresent3",
    heading = 335,
    debugpoly = false,
}, {
    options = {
        {  
        event = "ph_christmasp:Client:stealGift",
        icon = "fas fa-hand",
        label = "Steal A Gift",
        },
    },
    distance = 1.5
})

end)