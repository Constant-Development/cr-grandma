Config = {}

Config.Framework = {

    Target = 'qb-target',
    -- 'qb-target' = QBCore Target
    -- 'qtarget' = QTarget

    Notifications = 'QBCore',
    -- 'QBCore' = QBCoreNotify
    -- 'okok' = okokNotify
    -- 'mythic' = mythic_notify
    -- 'tnj' = tnj-notify
    -- 'chat' = Chat Message
    -- 'other' = Add Custom Notification

    Logs = false, -- Currrently setup via QBCore Logs
    -- True = Logs Enabled
    -- False = Logs Disabled

    Debug = false,
    -- True = Prints Enabled
    -- False = Prints Disabled

}

Config.IllegalMedical = {
    Coords = vector4(1126.3740, -471.7325, 66.4872, 76.4781), -- Entire Vector3 Coordinate
    PedModel = 'cs_mrs_thornhill', -- Ped Hash (https://docs.fivem.net/docs/game-references/ped-models/)
    PedName = "Grandma", -- Ped Name
    TargetIcon = "fas fa-user-injured",
    PaymentType = 'cash', -- 'cash' = QBCore Player Cash Money | 'bank' = QBCore Player Bank Money | 'crypto' = QBCore Player Crypto Money
    PaymentCost = 0, -- Amount of Money
    HealPlayerInjuries = false,
    OkOkNotificationTitle = "Grandma Aid"
}
