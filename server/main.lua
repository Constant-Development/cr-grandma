local QBCore = exports['qb-core']:GetCoreObject()

local function ConstantDevelopmentGrandma(notifType, message, title)
    local src = source
    if Config.Notifications == 'qb' or 'tnj' then
        if notifType == 1 then
            TriggerClientEvent('QBCore:Notify', src, message, 'success')
        elseif notifType == 2 then
            TriggerClientEvent('QBCore:Notify', src, message, 'primary')
        elseif notifType == 3 then
            TriggerClientEvent('QBCore:Notify', src, message, 'error')
        end
    elseif Config.Notifications == 'okok' then
        if notifType == 1 then
            TriggerClientEvent('okokNotify:Alert', src, title, message, 5000, 'success')
        elseif notifType == 2 then
            TriggerClientEvent('okokNotify:Alert', src, title, message, 5000, 'info')
        elseif notifType == 3 then
            TriggerClientEvent('okokNotify:Alert', src, title, message, 5000, 'error')
        end
    elseif Config.Notifications == 'mythic' then
        if notifType == 1 then
            TriggerClientEvent('mythic_notify:client:SendAlert:custom', src, { type = 'success', text = message, length = 5000})
        elseif notifType == 2 then
            TriggerClientEvent('mythic_notify:client:SendAlert:custom', src, { type = 'inform', text = message, length = 5000})
        elseif notifType == 3 then
            TriggerClientEvent('mythic_notify:client:SendAlert:custom', src, { type = 'error', text = message, length = 5000})
        end
    elseif Config.Notifications == 'chat' then
        TriggerClientEvent('chatMessage', src, message)
    end
end

RegisterNetEvent('cr-grandma:server:hug', function(coords)
    TriggerClientEvent("cr-grandma:client:hug", -1, coords)
end)

RegisterNetEvent('cr-grandma:server:idle', function(coords)
    TriggerClientEvent("cr-grandma:client:idle", -1, coords)
end)

RegisterNetEvent('cr-grandma:server:MedicalAid', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.IllegalMedical.PaymentType == 'cash' or 'bank' or 'crypto' then
        if Player.Functions.GetMoney(Config.IllegalMedical.PaymentType) >= Config.IllegalMedical.PaymentCost then
            Player.Functions.RemoveMoney(Config.IllegalMedical.PaymentType, Config.IllegalMedical.PaymentCost)
            ConstantDevelopmentGrandma(1, "Wow, looks like you are certified to be helped!", Config.IllegalMedical.OkOkNotificationTitle)
            TriggerClientEvent("hospital:client:Revive", src)
            Wait(2500 * 10)
            if Config.Framework.Logs then
                TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Health Helped', 'green', '**Player : **'..GetPlayerName(src)..'\n**MoneyType : **'..Config.IllegalMedical.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
            end
            ConstantDevelopmentGrandma(2, Config.IllegalMedical.PedName.." has helped you with your Health Issues...", Config.IllegalMedical.OkOkNotificationTitle)
        else
            ConstantDevelopmentGrandma(3, "Your really trying to get help without Money, are you Crazy!?", Config.IllegalMedical.OkOkNotificationTitle)
        end
    elseif Config.IllegalMedical.PaymentType == 'item' then
        if Player.Functions.GetItemByName(Config.IllegalMedical.Item) then
            Player.Functions.RemoveItem(Config.IllegalMedical.Item, Config.IllegalMedical.ItemAmount)
            ConstantDevelopmentGrandma(1, "Wow, looks like you are certified to be helped!", Config.IllegalMedical.OkOkNotificationTitle)
            TriggerClientEvent("hospital:client:Revive", src)
            Wait(2500 * 10)
            ConstantDevelopmentGrandma(2, Config.IllegalMedical.PedName.." has helped you with your Health Issues...", Config.IllegalMedical.OkOkNotificationTitle)
            if Config.Framework.Logs then
                TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Health Helped', 'green', '**Player : **'..GetPlayerName(src)..'\n**MoneyType : **'..Config.IllegalMedical.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
            end
        else
            ConstantDevelopmentGrandma(3, "It seems as if you don\'t have the essential Items!?", Config.IllegalMedical.OkOkNotificationTitle)
        end
    end
end)

RegisterNetEvent('cr-grandma:server:MedicalAidInjuries', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.IllegalMedicalTarget.InjuryTarget == true then
        if Config.MedicalAidInjuries.PaymentType == 'cash' or 'bank' or 'crypto' then
            if Player.Functions.GetMoney(Config.MedicalAidInjuries.PaymentType) >= Config.MedicalAidInjuries.PaymentCost then
                Player.Functions.RemoveMoney(Config.MedicalAidInjuries.PaymentType, Config.MedicalAidInjuries.PaymentCost)
                ConstantDevelopmentGrandma(1, "Wow, looks like you are certified to be helped!", Config.IllegalMedical.OkOkNotificationTitle)
                TriggerClientEvent("hospital:client:HealInjuries", src, "full")
                Wait(2500 * 10)
                if Config.Framework.Logs then
                    TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Injuries Helped', 'green', '**Player : **'..GetPlayerName(src)..'\n**MoneyType : **'..Config.MedicalAidInjuries.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
                end
                ConstantDevelopmentGrandma(2, Config.IllegalMedical.PedName.." has helped you with your Health Issues...", Config.IllegalMedical.OkOkNotificationTitle)
            else
                ConstantDevelopmentGrandma(3, "Your really trying to get help without Money, are you Crazy!?", Config.IllegalMedical.OkOkNotificationTitle)
            end
        elseif Config.MedicalAidInjuries.PaymentType == 'item' then
            if Player.Functions.GetItemByName(Config.IllegalMedical.Item) then
                Player.Functions.RemoveItem(Config.MedicalAidInjuries.Item, Config.MedicalAidInjuries.ItemAmount)
                ConstantDevelopmentGrandma(1, "Wow, looks like you are certified to be helped!", Config.IllegalMedical.OkOkNotificationTitle)
                TriggerClientEvent("hospital:client:HealInjuries", src, "full")
                Wait(2500 * 10)
                if Config.Framework.Logs then
                    TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Injuries Helped', 'green', '**Player : **'..GetPlayerName(src)..'\n**MoneyType : **'..Config.MedicalAidInjuries.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
                end
                ConstantDevelopmentGrandma(2, Config.IllegalMedical.PedName.." has helped you with your Health Issues...", Config.IllegalMedical.OkOkNotificationTitle)
            else
                ConstantDevelopmentGrandma(3, "It seems as if you don\'t have the essential Items!?", Config.IllegalMedical.OkOkNotificationTitle)
            end
        end
    else
        ConstantDevelopmentGrandma(2, "Uhhh, well I currently can\'t help with your Medical Injuries at this time...", Config.IllegalMedical.OkOkNotificationTitle)
    end
end)
