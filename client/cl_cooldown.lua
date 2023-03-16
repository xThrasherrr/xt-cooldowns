local QBCore = exports['qb-core']:GetCoreObject()
local universalCooldown = false
local cooldowns = {}

-- Cooldown Client Bool --
RegisterNetEvent('xt-cooldown:client:CooldownBool', function(type, bool)
    if type == 'all' then
        Config.GlobalCooldown.active = bool
    else
        Config.Cooldowns[type].active = bool
    end
    XTDebug(type..' Cooldown', 'Active: '..tostring(bool))
end)

-- Export to Check Cooldown --
local function CooldownCheck(type)
    local callback
    if type == 'global' then
        callback = Config.GlobalCooldown.active
    else
        callback = Config.Cooldowns[type].active
    end
    XTDebug('Cooldown Check', 'Type: '..type..' | Active: '..tostring(callback))
    return callback
end
exports('CooldownCheck', CooldownCheck)