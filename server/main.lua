local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('cr-grandma:server:MedicalAid', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.IllegalMedical.PaymentType == 'cash' or 'bank' or 'crypto' then
        Player.Functions.RemoveMoney(Config.IllegalMedical.PaymentType, Config.IllegalMedical.PaymentCost)
        TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 1, "Wow, looks like you are certified to be helped!")
        TriggerClientEvent("hospital:client:Revive", source)
        Wait(2500)
        TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 2, Config.IllegalMedical.PedName..'has helped you with your Health Issues...')
        if Config.Framework.Logs then
            TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Health Helped', 'green', '**Player : **'..GetPlayerName(source)..'\n**MoneyType : **'..Config.IllegalMedical.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
        end
    elseif Config.IllegalMedical.PaymentType == 'item' then
        if Player.Functions.GetItemByName(Config.IllegalMedical.Item) then
            Player.Functions.RemoveItem(Config.IllegalMedical.Item, Config.IllegalMedical.ItemAmount)
            TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 1, "Wow, looks like you are certified to be helped!")
            TriggerClientEvent("hospital:client:Revive", source)
            Wait(2500)
            TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 2, Config.IllegalMedical.PedName..'has helped you with your Health Issues...')
            if Config.Framework.Logs then
                TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Health Helped', 'green', '**Player : **'..GetPlayerName(source)..'\n**MoneyType : **'..Config.IllegalMedical.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
            end
        else
            TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 3, 'It seems as if you don\'t have the essential Items!?')
        end
    end
end)

RegisterNetEvent('cr-grandma:server:MedicalAidInjuries', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.IllegalMedicalTarget.InjuryTarget == true then
        if Config.MedicalAidInjuries.PaymentType == 'cash' or 'bank' or 'crypto' then
            Player.Functions.RemoveMoney(Config.MedicalAidInjuries.PaymentType, Config.MedicalAidInjuries.PaymentCost)
            TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 1, "Wow, looks like you are certified to be helped!")
            TriggerClientEvent("hospital:client:HealInjuries", source, "full")
            Wait(2500)
            TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 2, Config.IllegalMedical.PedName..'has helped you with your Medical Injuries...')
            if Config.Framework.Logs then
                TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Injuries Helped', 'green', '**Player : **'..GetPlayerName(source)..'\n**MoneyType : **'..Config.MedicalAidInjuries.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
            end
        elseif Config.MedicalAidInjuries.PaymentType == 'item' then
            if Player.Functions.GetItemByName(Config.IllegalMedical.Item) then
                Player.Functions.RemoveItem(Config.MedicalAidInjuries.Item, Config.MedicalAidInjuries.ItemAmount)
                TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 1, "Wow, looks like you are certified to be helped!")
                TriggerClientEvent("hospital:client:HealInjuries", source, "full")
                Wait(2500)
                TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 2, Config.IllegalMedical.PedName..'has helped you with your Medical Injuries...')
                if Config.Framework.Logs then
                    TriggerEvent('qb-log:server:CreateLog', 'constantdevelopmentgrandma', 'User Injuries Helped', 'green', '**Player : **'..GetPlayerName(source)..'\n**MoneyType : **'..Config.MedicalAidInjuries.PaymentType..' **Amount : **'..Config.IllegalMedical.PaymentCost)
                end
            else
                TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 3, 'It seems as if you don\'t have the essential Items!?')
            end
        end
    else
        TriggerClientEvent("cr-grandma:client:MedicalAidNotification", 2, 'Uhhh, well I currently can\'t help with your Medical Injuries at this time...')
    end
end)
