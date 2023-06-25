local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface("vRP","as-tigari")

RegisterServerEvent("tigari:givePachet")
AddEventHandler("tigari:givePachet",function()
	local user_id = vRP.getUserId({source})
	vRP.giveInventoryItem({user_id, 'pachet', 1})
end)
RegisterServerEvent("tigari:giveTigari")
AddEventHandler("tigari:giveTigari",function()
	local user_id = vRP.getUserId({source})
	vRP.giveInventoryItem({user_id, 'tigara', 20})
end)

vRPCallback.RegisterServerCallback("tigari:iaiteme",function(source,cb)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.hasGroup({user_id, "Traficant de Tigari"}) then
		if vRP.tryGetInventoryItem({user_id,"tutun",20,false}) and vRP.tryGetInventoryItem({user_id,"foita",20,false}) and vRP.tryGetInventoryItem({user_id,"filter",20,false}) then
			cb(true)
		else
			cb(false)
            TriggerClientEvent('sc_notify',source,'error','Inventar',"Nu ai toate materialele",5000)
			
		end
	else
        TriggerClientEvent('sc_notify',source,'error','Server',"Nu ai jobul",5000)
    end
end)
vRPCallback.RegisterServerCallback("pachet:iaiteme",function(source,cb)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.hasGroup({user_id, "Traficant de Tigari"}) then
		if vRP.tryGetInventoryItem({user_id,"tigara",20,false}) then
			cb(true)
		else
			cb(false)
            TriggerClientEvent('sc_notify',source,'error','Inventar',"Nu ai tigarile",5000)
			
		end
	else
        TriggerClientEvent('sc_notify',source,'error','Server',"Nu ai jobul",5000)
    end
end)
