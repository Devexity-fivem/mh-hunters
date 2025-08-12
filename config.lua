--[[ ===================================================== ]] --
--[[           MH AI Hunters Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
Config = {}
Config.WaitTime = 5000 -- 60000       -- a wait timer before the hunters will spawn and chase (1 min) 

Config.UseHunters = true -- if you want the hunter enable set this true
Config.EnableIfNoCopsOnline = true -- enable hunters when no cops are online.

Config.MinLoseHuntersDistance = 1000 -- lose the hunters in a amount of distance.
Config.HuntingTime = 900 -- 300 is 10 min

Config.MinHunters = 4
Config.MaxHunters = 7

Config.UseCars = true
Config.UseBikes = false
Config.UseHelikopters = false
Config.MaxVehicleSpawn = 7 -- max vehicles to spawn don't ho to height.

Config.HelikopterCanShoot = true -- if true helikopters can shoot you

Config.PedAttackCallHunters = false -- if a player attacks a ped the hunters are comming.

Config.Models = {"g_m_y_lost_01", "g_m_y_lost_02", "g_m_y_lost_03"}
Config.Bikes = {"sanchez", "sanchez2", "akuma", "carbonrs", "bagger", "daemon"}
Config.Vehicles = {"polcharger18", "polmustang", "polbmwm3", "polbmwm7", "unmarkedjl"}
Config.Helikopters = {"buzzard", "buzzard2", "annihilator", "maverick", "savage"}
Config.Weapons = {"WEAPON_REVOLVER_MK2", "WEAPON_PISTOL50", "WEAPON_MINISMG", "WEAPON_MACHINEPISTOL", "WEAPON_SMG"}


-- time in milliseconds
-- time in milliseconds
Config.HunterReviveDelay = 2000            -- wait 5s after death before reviving
Config.HunterJailAfterReviveDelay = 500   -- wait 2.5s after revive before jailing






Config.UseCustumPedModel = true
Config.CustumPedModel = "mp_m_freemode_01"
Config.Outfit = {
    ['hair'] = {
        item = 19,
        texture = 0
    }, -- Hear
    ['beard'] = {
        item = 0,
        texture = 0
    }, -- Beard
    ["pants"] = {
        item = 120,
        texture = 0
    }, -- Pants
    ["arms"] = {
        item = 14,
        texture = 0
    }, -- Arms
    ["t-shirt"] = {
        item = 66,
        texture = 0
    }, -- T Shirt
    ["vest"] = {
        item = 18,
        texture = 0
    }, -- Body Vest
    ["torso2"] = {
        item = 289,
        texture = 8
    }, -- Jacket
    ["shoes"] = {
        item = 71,
        texture = 0
    }, -- Shoes
    ["decals"] = {
        item = 0,
        texture = 0
    }, -- Neck Accessory
    ["bag"] = {
        item = 88,
        texture = 0
    }, -- Bag
    ["hat"] = {
        item = 1,
        texture = 0
    }, -- Hat
    ["glass"] = {
        item = 18,
        texture = 0
    }, -- Glasses
    ["mask"] = {
        item = 14,
        texture = 0
    } -- Mask
}
