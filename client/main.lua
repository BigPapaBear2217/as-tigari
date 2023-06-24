local opened = false
local blip = nil
local mainBlip = nil


RegisterNetEvent('as_tigari:client:openUI')
AddEventHandler('as_tigari:client:openUI', function()
    
    if not opened then
        SendNUIMessage({
            action = 'open'
        })
    else
        SendNUIMessage({
            action = 'close'
        })
    end

    opened = not opened
    SetNuiFocus(opened, opened)
end)

RegisterNUICallback('close', function()
    opened = false
    SendNUIMessage({
        action = 'close'
    })
    SetNuiFocus(opened, opened)
end)

CreateThread(function()
    InitBlip()
    Wait(500)
    while true do
        local msec = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if #(Config.OpenMenu - playerCoords) < 5.0 then
            msec = 0
            if not opened then
                DrawText(Config.Text, Config.OpenMenu, 0, 0.7)
                if IsControlJustPressed(0, Config.DefaultKey) and #(Config.OpenMenu - playerCoords) < 1.5 then
                    TriggerEvent('as_tigari:client:openUI')
                end
            end
        end
    Wait(msec)
    end
end)


RegisterNUICallback('startTIGARI', function(data, cb)
    vRPCallback.TriggerServerCallback('tigari:iaiteme', function(aremarfa)
		if aremarfa then
			ExecuteCommand("e mechanic")
			FreezeEntityPosition(player,true)
			exports.rprogress:Custom({
				Duration = 7000,
				Label = "🚬 Procesezi tigarile...",
				Animation = {
					scenario = "", -- https://pastebin.com/6mrYTdQv
					animationDictionary = "", -- https://alexguirre.github.io/animations-list/
				},
				DisableControls = {
					Mouse = false,
					Player = true,
					Vehicle = true
				}
			})
			Citizen.Wait(7000)
			ExecuteCommand("e c")
			FreezeEntityPosition(player,false)
			TriggerServerEvent("tigari:giveTigari")
		end
	end)
end)


RegisterNUICallback('startPACHET', function(data, cb)
    vRPCallback.TriggerServerCallback('pachet:iaiteme', function(aretigari)
		if aretigari then
			ExecuteCommand("e mechanic")
			FreezeEntityPosition(player,true)
			exports.rprogress:Custom({
				Duration = 7000,
				Label = "🚬 Pui tigarile in pachet...",
				Animation = {
					scenario = "", -- https://pastebin.com/6mrYTdQv
					animationDictionary = "", -- https://alexguirre.github.io/animations-list/
				},
				DisableControls = {
					Mouse = false,
					Player = true,
					Vehicle = true
				}
			})
			Citizen.Wait(7000)
			ExecuteCommand("e c")
			FreezeEntityPosition(player,false)
			TriggerServerEvent("tigari:givePachet")
		end
	end)
end)


function CreateBlip(coords)
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipScale(blip, Config.JobBlips.scale)
    SetBlipSprite(blip, Config.JobBlips.sprite)
    SetBlipColour(blip, Config.JobBlips.color)

    SetBlipRoute(blip, true)
end


function DrawText(text, coords, font, size)

    local camCoords = GetGameplayCamCoords()
    local distance = #(coords - camCoords)

    if not font then font = 0 end
    if not size then size = 0.7 end

    local scale = (size / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(font)
    SetTextColour(255, 255, 255, 215)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(true)

    SetDrawOrigin(coords, 0)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

function InitBlip()
    if mainBlip then
       RemoveBlip(mainBlip) 
    end
 
    mainBlip = AddBlipForCoord(Config.OpenMenu)
    SetBlipSprite(mainBlip, Config.MainBlip.sprite)
    SetBlipScale(mainBlip, Config.MainBlip.scale)
    SetBlipColour(mainBlip, Config.MainBlip.color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.MainBlip.label)
    EndTextCommandSetBlipName(mainBlip)
end
