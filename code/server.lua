ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

ESX.RegisterServerCallback('renzer_gift:checksql', function(source, cb)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchScalar('SELECT gift FROM users WHERE identifier=@identifier', {
		['@identifier']   = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('renzer_gift:additem')
AddEventHandler('renzer_gift:additem', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchScalar('SELECT gift FROM users WHERE identifier=@identifier', {
		['@identifier']   = xPlayer.identifier
	}, function(resultadorecebeu)
		if resultadorecebeu == 0 then
            for k,v in pairs(Config.Item) do
                local xItem = xPlayer.getInventoryItem(v.item)
				local xItemCount = math.random(v.count[1],v.count[2])
                xPlayer.addInventoryItem(xItem.name, xItemCount)
               
                MySQL.Sync.execute("UPDATE users SET gift=1 WHERE identifier=@identifier", 
                    {   ['@identifier']   = xPlayer.identifier,	}
                )
            end

		end
	end)
end)
RegisterServerEvent('renzer_gift:addMoney')
AddEventHandler('renzer_gift:addMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(Config.Money)
end)