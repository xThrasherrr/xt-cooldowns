-- DOCS: https://xtdev.gitbook.io/xt-docs/free-resources/xt-cooldowns

Config = {}

-- General Configs --
Config.Debug = true
Config.Command = 'cooldown' -- Command to Toggle Cooldowns

-- Global Cooldown Config --
-- cooldownLength | Length of Cooldown in Minutes
-- active | True/False if Cooldown is Active (DO NOT CHANGE)
Config.GlobalCooldown = {
    cooldownLength = 20, -- Set in Minutes
    active = false -- Don't fuck w/ this
}

-- Custom Cooldowns Config --
-- commandID | ID Used to Toggle to Correct Cooldown
-- cooldownLength | Length of Cooldown in Minutes
-- active | True/False if Cooldown is Active (DO NOT CHANGE)
Config.Cooldowns = {
    ['Stores'] = {
        commandID = 'store',
        cooldownLength = 20,
        active = false
    },
    ['Vangelico'] = {
        commandID = 'vangelico',
        cooldownLength = 20,
        active = false
    },
    ['Fleeca'] = {
        commandID = 'fleeca',
        cooldownLength = 20,
        active = false
    },
    ['Paleto'] = {
        commandID = 'paleto',
        cooldownLength = 20,
        active = false
    },
    ['Pacific'] = {
        commandID = 'pacific',
        cooldownLength = 20,
        active = false
    },
}