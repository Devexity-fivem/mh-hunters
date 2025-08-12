--[[ ===================================================== ]] --
--[[           MH AI Hunters Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local isbusy = false

local function CountCops()
    local online = 0
    for k, id in pairs(QBCore.Functions.GetPlayers()) do
        local target = QBCore.Functions.GetPlayer(id)
        if target.PlayerData.job.name == "police" and target.PlayerData.job.onduty then
            online = online + 1
        end
    end
    return online
end

QBCore.Commands.Add("startHunt", "", {}, false, function(source, args)
    if args[1] and tonumber(args[1]) > 0 then
        local id = tonumber(args[1])
        local amount = tonumber(args[2])
        if amount > Config.MaxVehicleSpawn then amount = Config.MaxVehicleSpawn end
        if Config.UseHunters then
            isbusy = true
            TriggerClientEvent("mh-hunters:client:startHunt", id, amount, 0)
        end
    end
end, 'admin')

QBCore.Commands.Add("stopHunt", "", {}, false, function(source, args)
    if args[1] and tonumber(args[1]) > 0 then
        local id = tonumber(args[1])
        isbusy = false
        TriggerClientEvent("mh-hunters:client:stopHunt", id)
    end
end, 'admin')

RegisterServerEvent('mh-hunters:server:start')
AddEventHandler('mh-hunters:server:start', function(amount)
    local src = source
    if amount > Config.MaxVehicleSpawn then amount = Config.MaxVehicleSpawn end
    if Config.EnableIfNoCopsOnline and not isbusy then
        isbusy = true
        TriggerClientEvent("mh-hunters:client:startHunt", src, amount, CountCops())
    else
        if Config.UseHunters and not isbusy then
            isbusy = true
            TriggerClientEvent("mh-hunters:client:startHunt", src, amount, 0)
        end
    end
end)

RegisterServerEvent('mh-hunters:server:stop')
AddEventHandler('mh-hunters:server:stop', function()
    local src = source
    isbusy = false
    TriggerClientEvent("mh-hunters:client:stopHunt", source)
end)

RegisterNetEvent('police:server:policeAlert', function(text)
    local src = source
    local count = CountCops()
    if Config.EnableIfNoCopsOnline and Config.UseHunters and count == 0 and not isbusy then
        isbusy = true
        TriggerClientEvent("mh-hunters:client:startHunt", src, math.random(Config.MinHunters, Config.MaxHunters), count)
    end
end)

CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `player_hunters` (
            `id` int(10) NOT NULL AUTO_INCREMENT,
            `name` varchar(50) NOT NULL,
            `license` varchar(50) NOT NULL,
            `amount` int(10) NOT NULL,
            PRIMARY KEY (`id`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;    
    ]])
end)



-- server.lua (mh-hunters)

local jailedRecently = {}

local function msOrDefault(v, default)
    v = tonumber(v)
    if not v or v < 0 then return default end
    return v
end

-- keep the SAME event name your client already calls:
-- 'mh-hunters:server:reviveAndJailFromHunters'
-- (we'll do jail -> revive inside)
RegisterNetEvent('mh-hunters:server:reviveAndJailFromHunters', function(minutes, reason)
    local src = source
    minutes = tonumber(minutes) or 20
    reason  = reason or "caught by hunters"

    if jailedRecently[src] then return end
    jailedRecently[src] = true
    SetTimeout(8000, function() jailedRecently[src] = nil end) -- anti-spam

    local preJailDelay     = msOrDefault(Config.HunterPreJailDelay, 0)
    local reviveAfterDelay = msOrDefault(Config.HunterReviveAfterJailDelay, 2000)

    -- 1) (optional) wait before jailing
    SetTimeout(preJailDelay, function()
        if GetPlayerPing(src) == 0 then return end -- player left

        -- 2) JAIL FIRST
        if GetResourceState('rcore_prison') == 'started' then
            exports['rcore_prison']:Jail(src, minutes, reason)
        else
            print(('[mh-hunters] rcore_prison not started; cannot jail %d'):format(src))
            return
        end

        -- 3) After jailing, wait a bit, then revive inside prison
        SetTimeout(reviveAfterDelay, function()
            if GetPlayerPing(src) == 0 then return end
            if GetResourceState('wasabi_ambulance') == 'started' then
                exports.wasabi_ambulance:RevivePlayer(src) -- server export
            else
                print('[mh-hunters] wasabi_ambulance not started; skipping revive after jail')
            end
        end)
    end)
end)




