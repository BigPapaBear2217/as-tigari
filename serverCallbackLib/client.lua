vRPCallback = {}
vRPCallback.CurrentRequestId          = 0
vRPCallback.ServerCallbacks           = {}

vRPCallback.TriggerServerCallback = function(name, cb, ...)
	vRPCallback.ServerCallbacks[vRPCallback.CurrentRequestId] = cb

	TriggerServerEvent('vRPCallback:triggerServerCallback', name, vRPCallback.CurrentRequestId, ...)

	if vRPCallback.CurrentRequestId < 65535 then
		vRPCallback.CurrentRequestId = vRPCallback.CurrentRequestId + 1
	else
		vRPCallback.CurrentRequestId = 0
	end
end

RegisterNetEvent('vRPCallback:serverCallback')
AddEventHandler('vRPCallback:serverCallback', function(requestId, ...)
	vRPCallback.ServerCallbacks[requestId](...)
	vRPCallback.ServerCallbacks[requestId] = nil
end)