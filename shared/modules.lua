QBCore = exports['qb-core']:GetCoreObject()

-- Client Notify --
function XTClientNotify(text, type)
	QBCore.Functions.Notify(text, type)
end

-- Server Notify --
function XTServerNotify(target, message, type)
    TriggerClientEvent('QBCore:Notify', target, message, type)
end

-- Debug Print --
function XTDebug(type, debugTxt)
    if debugTxt == nil then debugTxt = '' end
    if Config.Debug then
        print("^2xT Debug ^7| "..type.." | ^2"..debugTxt)
    end
end

-- Debug / Resource Print on Startup --
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        XTDebug('xT Development', 'dsc.gg/xtdev ^7| '..resource)
    end
end)