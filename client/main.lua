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
    if type(pedModel) == "string" then
        pedModel = GetHashKey(pedModel)
    end
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
    local PedModel = Config.IllegalMedical.PedModel
    local Coords = Config.IllegalMedical.Coords
    CreatePedAtCoords(PedModel, Coords)
    if Config.Framework.Debug == true then
        print('Constant Development Grandma | PED Activated')
    end
    if Config.Framework.Target == 'qb-target' then
        exports['qb-target']:AddBoxZone("ConstantDevelopmentIllegalMedical", Config.IllegalMedicalTarget.Coords, Config.IllegalMedicalTarget.Width, Config.IllegalMedicalTarget.Length, {
            name = "ConstantDevelopmentIllegalMedical",
            heading = Config.IllegalMedicalTarget.Heading,
            debugPoly = Config.IllegalMedicalTarget.DebugPoly,
            minZ = Config.IllegalMedicalTarget.minZ,
            maxZ = Config.IllegalMedicalTarget.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "cr-grandma:client:MedicalAid",
                    icon = Config.IllegalMedicalTarget.TargetIcon,
                    label = Config.IllegalMedicalTarget.TargetLabel,
                    canInteract = function()
                        if not Config.IllegalMedicalTarget.CanInteractLimit then return true else
                            if QBCore.Functions.GetPlayerData().metadata.isdead or QBCore.Functions.GetPlayerData().metadata.inlaststand then return true else return false end
                        end
                    end,
                },
                {
                    type = "client",
                    event = "cr-grandma:client:MedicalAidInjuries",
                    icon = Config.IllegalMedicalTarget.InjuryTargetIcon,
                    label = Config.IllegalMedicalTarget.InjuryTargetLabel,
                },
            },
            distance = Config.IllegalMedicalTarget.TargetDistance
        })
        if Config.Framework.Debug == true then
            print('Constant Development Grandma | Target Activated')
        end
    elseif Config.Framework.Target == 'qtarget' then
        exports['qtarget']:AddBoxZone("ConstantDevelopmentIllegalMedical", Config.IllegalMedicalTarget.Coords, Config.IllegalMedicalTarget.Width, Config.IllegalMedicalTarget.Length, {
            name = "ConstantDevelopmentIllegalMedical",
            heading = Config.IllegalMedicalTarget.Heading,
            debugPoly = Config.IllegalMedicalTarget.DebugPoly,
            minZ = Config.IllegalMedicalTarget.minZ,
            maxZ = Config.IllegalMedicalTarget.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "cr-grandma:client:MedicalAid",
                    icon = Config.IllegalMedicalTarget.TargetIcon,
                    label = Config.IllegalMedicalTarget.TargetLabel,
                    canInteract = function()
                        if not Config.IllegalMedicalTarget.CanInteractLimit then return true else
                            if QBCore.Functions.GetPlayerData().metadata.isdead or QBCore.Functions.GetPlayerData().metadata.inlaststand then return true else return false end
                        end
                    end,
                },
                {
                    type = "client",
                    event = "cr-grandma:client:MedicalAidInjuries",
                    icon = Config.IllegalMedicalTarget.InjuryTargetIcon,
                    label = Config.IllegalMedicalTarget.InjuryTargetLabel,
                },
            },
            distance = Config.IllegalMedicalTarget.TargetDistance
        })
        if Config.Framework.Debug == true then
            print('Constant Development Grandma | Target Activated')
        end
    end
end)

RegisterNetEvent("cr-grandma:client:MedicalAid", function()
    if QBCore.Functions.GetPlayerData().metadata.isdead or QBCore.Functions.GetPlayerData().metadata.inlaststand then
        QBCore.Functions.Progressbar('ConstantDevelopmentIllegalGrandmaMedical', Config.IllegalMedical.PedName..'is helping you..', math.random(2500, 10000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            if Config.IllegalMedical.Minigame.Enabled == true then
                if Config.IllegalMedical.Minigame.PSUI then
                    exports['ps-ui']:Circle(function(success)
                        if success then
                            TriggerServerEvent("cr-grandma:server:MedicalAid")
                        else
                            ConstantDevelopmentGrandma(3, "You failed my Challenge and expect me to help you? Are you insane...", Config.IllegalMedical.OkOkNotificationTitle)
                        end
                    end, math.random(5, 10), math.random(3, 6))
                elseif Config.IllegalMedical.Minigame.QBCoreSkillBar then
                    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
                    Skillbar.Start({
                        duration = math.random(1000, 3000),
                        pos = math.random(10, 30),
                        width = math.random(10, 20),
                    }, function()
                        TriggerServerEvent("cr-grandma:server:MedicalAid")
                    end, function()
                        ConstantDevelopmentGrandma(3, "You failed my Challenge and expect me to help you? Are you insane...", Config.IllegalMedical.OkOkNotificationTitle)
                    end)
                elseif Config.IllegalMedical.Minigame.QBCoreNPInspiredLock then
                    local seconds = math.random(3, 6)
                    local circles = math.random(5, 10)
                    local success = exports['qb-lock']:StartLockPickCircle(circles, seconds)
                    if success then
                        TriggerServerEvent("cr-grandma:server:MedicalAid")
                    else
                        ConstantDevelopmentGrandma(3, "You failed my Challenge and expect me to help you? Are you insane...", Config.IllegalMedical.OkOkNotificationTitle)
                    end
                end
            elseif Config.IllegalMedical.Minigame.Enabled == false then
                TriggerServerEvent("cr-grandma:server:MedicalAid")
            end
        end, function()
            ConstantDevelopmentGrandma(3, "You wouldn\'t sit still so I stopped helping you...", Config.IllegalMedical.OkOkNotificationTitle)
        end)
    else
        ConstantDevelopmentGrandma(3, "It seems like you don\'t need any help?", Config.IllegalMedical.OkOkNotificationTitle)
    end
end)

RegisterNetEvent("cr-grandma:client:MedicalAidInjuries", function()
    QBCore.Functions.Progressbar('ConstantDevelopmentIllegalGrandmaMedical', Config.IllegalMedical.PedName..'is helping you..', math.random(2500, 10000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        if Config.IllegalMedical.Minigame.Enabled == true then
            if Config.IllegalMedical.Minigame.PSUI then
                exports['ps-ui']:Circle(function(success)
                    if success then
                        TriggerServerEvent("cr-grandma:server:MedicalAidInjuries")
                    else
                        ConstantDevelopmentGrandma(3, "You failed my Challenge and expect me to help you? Are you insane...", Config.IllegalMedical.OkOkNotificationTitle)
                    end
                end, math.random(3, 6), math.random(5, 10))
            elseif Config.IllegalMedical.Minigame.QBCoreSkillBar then
                local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
                Skillbar.Start({
                    duration = math.random(2500, 6000),
                    pos = math.random(10, 30),
                    width = math.random(10, 20),
                }, function()
                    TriggerServerEvent("cr-grandma:server:MedicalAidInjuries")
                end, function()
                    ConstantDevelopmentGrandma(3, "You failed my Challenge and expect me to help you? Are you insane...", Config.IllegalMedical.OkOkNotificationTitle)
                end)
            elseif Config.IllegalMedical.Minigame.QBCoreNPInspiredLock then
                local seconds = math.random(5, 10)
                local circles = math.random(3, 6)
                local success = exports['qb-lock']:StartLockPickCircle(circles, seconds)
                if success then
                    TriggerServerEvent("cr-grandma:server:MedicalAidInjuries")
                else
                    ConstantDevelopmentGrandma(3, "You failed my Challenge and expect me to help you? Are you insane...", Config.IllegalMedical.OkOkNotificationTitle)
                end
            end
        elseif Config.IllegalMedical.Minigame.Enabled == false then
            TriggerServerEvent("cr-grandma:server:MedicalAidInjuries")
        end
    end, function()
        ConstantDevelopmentGrandma(3, "You wouldn\'t sit still so I stopped helping you...", Config.IllegalMedical.OkOkNotificationTitle)
    end)
end)
