function XTServerNotify(target, message, type)
    TriggerClientEvent('QBCore:Notify', target, message, type)
end

-- Universal Cooldown --
RegisterServerEvent('xt-cooldown:server:UniversalCooldown', function(bool)
    if bool == 'true' then bool = true else bool = false end
    if Config.GlobalCooldown.active == bool then return end
    Config.GlobalCooldown.active = bool
    TriggerClientEvent('xt-cooldown:client:CooldownBool', -1, 'all', bool)
    XTDebug('Universal Cooldown', 'Active: '..tostring(bool))
    SetTimeout((Config.GlobalCooldown.cooldownLength * 60000), function()
        if Config.GlobalCooldown.active then
            Config.GlobalCooldown.active = false
            TriggerClientEvent('xt-cooldown:client:CooldownBool', -1, 'all', false)
        end
        XTDebug('Global Cooldown', 'Active: false')
    end)
end)

-- Creates Custom Cooldown Events + Callbacks --
for x,t in pairs(Config.Cooldowns) do
    -- Custom Cooldowns --
    RegisterServerEvent('xt-cooldown:server:Cooldown'..x, function(bool)
        if bool == 'true' then bool = true else bool = false end
        if Config.Cooldowns[x].active == bool then return end
        Config.Cooldowns[x].active = bool
        TriggerClientEvent('xt-cooldown:client:CooldownBool', -1, x, bool)
        XTDebug(x..' Cooldown', 'Active: '..tostring(bool))
        if bool then
            SetTimeout((t.cooldownLength * 60000), function()
                if Config.Cooldowns[x].active then
                    Config.Cooldowns[x].active = false
                    TriggerClientEvent('xt-cooldown:client:CooldownBool', -1, x, false)
                end
                XTDebug(x..' Cooldown', 'Active: false')
            end)
        end
    end)

    -- Return Custom Cooldown --
    if lib then
        lib.callback.register('xt-cooldown:server:'..x, function(source)
            if Config.GlobalCooldown.active then XTServerNotify(source, 'Global Criminal Cooldown is Active!', 'error') return true end
            if Config.Cooldowns[x].active then XTServerNotify(source, 'Cooldown is Active!', 'error') return Config.Cooldowns[x].active end
        end)
    else
        QBCore.Functions.CreateCallback('xt-cooldown:server:'..x,function(source, cb)
            if Config.GlobalCooldown.active then XTServerNotify(source, 'Global Criminal Cooldown is Active!', 'error') return true end
            if Config.Cooldowns[x].active then XTServerNotify(source, 'Cooldown is Active!', 'error') end
            cb(Config.Cooldowns[x].active)
        end)
    end
end

-- Toggle Cooldowns --
local coolDownOptions = ''
for _,t in pairs(Config.Cooldowns) do coolDownOptions = coolDownOptions..', '..t.commandID end
if lib then
    lib.addCommand(Config.Command, {
        help = 'Set Criminal Cooldowns',
        params = {
            {
                name = 'type',
                type = 'string',
                help = coolDownOptions,
            },
            {
                name = 'bool',
                type = 'string',
                help = 'true, false',
            }
        },
        restricted = 'group.admin'
    }, function(source, args, raw)
        if not args then return end
        local cooldown
        for x,t in pairs(Config.Cooldowns) do
            if args.type == t.commandID then
                cooldown = x
                break
            end
        end
        if args.type == 'all' then
            TriggerEvent('xt-cooldown:server:UniversalCooldown', args.bool)
        else
            TriggerEvent('xt-cooldown:server:Cooldown'..cooldown, args.bool)
        end
    end)
else
    QBCore.Commands.Add(Config.Command, 'Set Criminal Cooldowns', {{name = "type", help = coolDownOptions},{ name = 'bool', help = 'true, false' }}, false, function(source, args)
        if not args then return end
        local cooldown
        for x,t in pairs(Config.Cooldowns) do
            if args.type == t.commandID then
                cooldown = x
                break
            end
        end
        if args[1] == 'all' then
            TriggerEvent('xt-cooldown:server:UniversalCooldown', args[2])
        else
            TriggerEvent('xt-cooldown:server:Cooldown'..cooldown, args[2])
        end
    end, 'admin')
end