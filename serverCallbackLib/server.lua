vRPCallback = {}
vRPCallback.ServerCallbacks = {}

RegisterServerEvent('vRPCallback:triggerServerCallback')
AddEventHandler('vRPCallback:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	vRPCallback.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('vRPCallback:serverCallback', _source, requestId, ...)
	end, ...)
end)

vRPCallback.RegisterServerCallback = function(name, cb)
	vRPCallback.ServerCallbacks[name] = cb
end

vRPCallback.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if vRPCallback.ServerCallbacks[name] ~= nil then
		vRPCallback.ServerCallbacks[name](source, cb, ...)
	else
		print('vRPCallback.TriggerServerCallback => [' .. name .. '] does not exist')
	end
end
