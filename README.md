# ph_christmas
A simple gift giving script, with the ability to steal gifts for QBCore.
*Config is setup for Gabz XMAS Pack in Mirror Park
Fully Adjustable Config including:
-Items Recieved From Gifts and Probability
-Turning on and off cooldown
-Adjusting cooldown time
- Ped Coords
- And support for cd_dispatch and ps-dispatch

## Showcase
https://youtu.be/Dq2ub3xqTQc

## DISCORD
https://discord.gg/Q8S4VYQWwB

## DEPENDENCIES
```
-QBCORE
-santa ped (provided in folder)
*OPTIONAL*
Gabz XMAS Pack
cd_dispatch or ps-dispatch
ps-ui (for circle minigame)

```

## How To Install
-Open DEPENDECIES folder and drag santa into your resources folder

-Drag ph_christmas into resources folder

-add the following to \resources\[qb]\qb-core\shared\items.lua
```
--ph_christmas
["gift"] = {["name"] = "gift", ["label"] = "Gift", ["weight"] = 0, ["type"] = "item", ["image"] = "gift.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A Christmas Gft!"},
["coallump"] = {["name"] = "coallump", ["label"] = "Lump Of Coal", ["weight"] = 0, ["type"] = "item", ["image"] = "coal.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A Completely Useless Lump of Coal. Be Nicer Next Year!"},

```
-Add the images from \ph_christmas\html\images to \resources\[qb]\qb-inventory\html\images

-Add the following to your server.cfg
```
start santa
start ph_christmas
```


