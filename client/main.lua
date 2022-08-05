local QBCore = exports['qb-core']:GetCoreObject()

local function ConstantDevelopmentGrandma(notifType, message, title)
	if Config.Framework.Notifications == 'QBCore' then
		if notifType == 1 then
			QBCore.Functions.Notify(message, 'success')
		elseif notifType == 2 then
			QBCore.Functions.Notify(message, 'primary')
		elseif notifType == 3 then
			QBCore.Functions.Notify(message, 'error')
		end
	elseif Config.Framework.Notifications == "okok" then
		if notifType == 1 then
			exports['okokNotify']:Alert(title, message, 3000, 'success')
		elseif notifType == 2 then
			exports['okokNotify']:Alert(title, message, 3000, 'info')
		elseif notifType == 3 then
			exports['okokNotify']:Alert(title, message, 3000, 'error')
		end
	elseif Config.Framework.Notifications == "mythic" then
		if notifType == 1 then
			exports['mythic_notify']:DoHudText('success', message)
		elseif notifType == 2 then
			exports['mythic_notify']:DoHudText('inform', message)
		elseif notifType == 3 then
			exports['mythic_notify']:DoHudText('error', message)
		end
    elseif Config.Framework.Notifications == "tnj" then
        if notifType == 1 then
            exports['tnj-notify']:Notify(message, 'success', 3000)
		elseif notifType == 2 then
            exports['tnj-notify']:Notify(message, 'primary', 3000)
		elseif notifType == 3 then
            exports['tnj-notify']:Notify(message, 'error', 3000)
		end
	elseif Config.Framework.Notifications == 'chat' then
        if notifType == 1 then
            TriggerEvent('chatMessage', message)
		elseif notifType == 2 then
            TriggerEvent('chatMessage', message)
		elseif notifType == 3 then
            TriggerEvent('chatMessage', message)
		end
	end
end

local function EnsurePedModel(pedModel)
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(10)
    end
end

local function CreatePedAtCoords(pedModel, coords)
    pedModel = type(pedModel) == "string" or pedModel
    EnsurePedModel(pedModel)
    local ped = CreatePed(0, pedModel, coords.x, coords.y, coords.z - 0.98, coords.w, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityVisible(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)
    if Config.Framework.Debug == true then
        print('Constant Development Grandma | PED Activation')
    end
    return ped
end

Citizen.CreateThread(function()
	CreatePedAtCoords(Config.IllegalMedical.PedModel, Config.IllegalMedical.Coords)
    if Config.Framework.Debug == true then
        print('Constant Development Grandma | PED Activated')
    end
end)

Citizen.CreateThread(function()
    if Config.Framework.Target == 'qb-target' then
        exports['qb-target']:AddTargetEntity(Config.IllegalMedical.PedModel, {
            options = {
                {
                    type = "client",
                    event = "cr-grandma:client:MedicalAid",
                    icon = Config.IllegalMedical.TargetIcon,
                    label = "Speak with "..Config.IllegalMedical.PedName,
                    ped = Config.IllegalMedical.PedModel
                },
            },
            distance = 3.0
        })
        if Config.Framework.Debug == true then
            print('Constant Development Grandma | Target Activated')
        end
    elseif Config.Framework.Target == 'qtarget' then
        exports['qtarget']:AddTargetEntity(Config.IllegalMedical.PedModel, {
            options = {
                {
                    type = "client",
                    event = "cr-grandma:client:MedicalAid",
                    icon = Config.IllegalMedical.TargetIcon,
                    label = "Speak with "..Config.IllegalMedical.PedName,
                    ped = Config.IllegalMedical.PedModel
                },
            },
            distance = 3.0
        })
        if Config.Framework.Debug == true then
            print('Constant Development Grandma | Target Activated')
        end
    end
end)

RegisterNetEvent("cr-grandma:client:MedicalAid", function()
    if QBCore.Functions.GetPlayerData().metadata.isdead or QBCore.Functions.GetPlayerData().metadata.inlaststand then
        if QBCore.Functions.GetPlayerData().money['cash'] or QBCore.Functions.GetPlayerData().money['bank'] or QBCore.Functions.GetPlayerData().money['crypto'] >= Config.IllegalMedical.PaymentCost then
            QBCore.Functions.Progressbar('ConstantDevelopmentIllegalGrandmaMedical', Config.IllegalMedical.PedName..'is helping you..', math.random(2500, 10000), false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                TriggerServerEvent("cr-grandma:server:MedicalAid")
            end, function()
                ConstantDevelopmentGrandma(3, "You wouldn\'t sit still so I stopped helping you...", Config.IllegalMedical.OkOkNotificationTitle)
            end)
        else
            ConstantDevelopmentGrandma(3, Config.IllegalMedical.PedName.."won't help, if you don't have some the Money...", Config.IllegalMedical.OkOkNotificationTitle)
        end
    else
        ConstantDevelopmentGrandma(3, "It seems like you don\'t need any help?", Config.IllegalMedical.OkOkNotificationTitle)
    end
end)

RegisterNetEvent("cr-grandma:client:MedicalAidNotification", function(NotificationType, NotificationMessage)
    ConstantDevelopmentGrandma(NotificationType, NotificationMessage, Config.IllegalMedical.OkOkNotificationTitle)
end)
