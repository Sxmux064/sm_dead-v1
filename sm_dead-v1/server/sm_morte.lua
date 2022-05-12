local ESX = exports['es_extended']:getSharedObject()

--

ESX.RegisterCommand(SM.ReviveCommand_Label, {SM.Admin, 'admin'}, function(xPlayer, args, showError)
	args.playerId.triggerEvent('sm_dead:revive')
end, true, {help = 'Rianima player.', validate = true, arguments = {
	{name = 'playerId', help = '[ID]', type = 'player'}
}})

ESX.RegisterCommand(SM.HealCommand_Label, {SM.Admin, 'admin'}, function(xPlayer, args, showError)
	args.playerId.triggerEvent('sm_dead:cura')
end, true, {help = 'Cura player.', validate = true, arguments = {
	{name = 'playerId', help = '[ID]', type = 'player'}
}})

-- 

RegisterServerEvent('sm_dead:setdead')
AddEventHandler('sm_dead:setdead', function(morto)
    local source = source
	local steaml = GetPlayerIdentifiers(source)[1]

	MySQL.Sync.execute('UPDATE users SET is_dead = @morto WHERE identifier = @steam', {
		['@steam'] = steaml,
		['@morto'] = morto
	})
end)

RegisterServerEvent("sm_dead:rianima_medikit")
AddEventHandler("sm_dead:rianima_medikit",function()
    local source = source
    local player = ESX.GetPlayerFromId(source)

    if ESX.GetPlayerFromId(source).getInventoryItem(SM.ItemToRevive.itemname).count >= SM.ItemToRevive.quantity then
        ESX.GetPlayerFromId(source).removeInventoryItem(SM.ItemToRevive.itemname, SM.ItemToRevive.quantity)
        TriggerClientEvent("sm_dead:revive")
    else
        TriggerClientEvent('esx:showNotification', source, SM.Languages['haven\'t_medikit']..SM.ItemToRevive.itemname)
    end
end)

RegisterCommand("test_sm",function()
	TriggerEvent("sm_dead:rianima_medikit")
end)
ESX.RegisterServerCallback('sm_dead:checkdead', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		cb(isDead)
	end)
end)