Config = {}

Config.Framework = {
    Target = 'qb-target',
    -- 'qb-target' = QBCore Target
    -- 'qtarget' = QTarget
    Notifications = 'qb',
    -- 'qb' = QBCoreNotify
    -- 'okok' = okokNotify
    -- 'mythic' = mythic_notify
    -- 'chat' = Chat Message
    DrawText = 'qb-core',
    -- 'qb-core' = QBCore DrawText
    -- 'okok' = okokTextUI
    Logs = false, -- Currrently setup via QBCore Logs
    -- True = Logs Enabled
    -- False = Logs Disabled
    Debug = false,
    -- True = Prints Enabled
    -- False = Prints Disabled
}

Config.IllegalMedicalTarget = {
    Coords = vector3(2441.89, 4985.82, 51.56), -- Coords for the Target
    Width = 0.5, -- Width for the Target
    Length = 0.5, -- Length for the Target
    Heading = 0, -- Heading for the Target
    minZ = 50.56, -- Minimum Z for the Target
    maxZ = 52.36, -- Maximum Z for the Target
    DebugPoly = false, -- Whether you want the Target Poly's Enabled
    TargetDistance = 1.5, -- Distance in which you can Target the Medical Aid
    TargetLabel = "Speak with Grandma about your Health Issues", -- Target Label Description | Text you see for the Target Label
    TargetIcon = "fa-solid fa-skull", -- Another Example: fa-solid fa-skull | Icon you see when Targeting the Medical Aid
    CanInteractLimit = false, -- Limits the Player to Interact with the Target if their Dead or 'InLastStand'

    -- This Configuration plays a toll with the Injury Healing.
    -- If you set 'InjuryTarget' to false than you won't have to edit the 'InjuryTargetLabel' and 'InjuryTargetIcon'
    InjuryTarget = true,
    InjuryTargetLabel = "Speak with Grandma about your Medical Injuries",
    InjuryTargetIcon = "fas fa-user-injured",
}

Config.IllegalMedical = {
    Coords = vector4(2441.8945, 4985.8208, 51.5649, 184.1566), -- Entire Vector4 Coordinate
    PedModel = 'cs_mrs_thornhill', -- Ped Hash (https://docs.fivem.net/docs/game-references/ped-models/)
    PedName = "Grandma", -- Ped Name
    PaymentType = 'cash', -- 'cash' = QBCore Player Cash Money | 'bank' = QBCore Player Bank Money | 'crypto' = QBCore Player Crypto Money | 'item' = QBCore Shared Item
    PaymentCost = 0, -- Amount of Money | If you aren't using a Money Type(cash, bank, or crypto) than you can remove this Configuration
    Item = nil, -- 'ItemName' | ItemName = QBCore Shared Item Name | If you aren't using an Item, you can remove this Configuration and the one below.
    ItemAmount = 0, -- Amount of Items
    OkOkNotificationTitle = "Grandma Aid",
    Minigame = {
        Enabled = true,
        PSUI = true,
        QBCoreSkillBar = false,
        QBCoreNPInspiredLock = false
    }
}

Config.MedicalAidInjuries = {
    PaymentType = 'cash', -- 'cash' = QBCore Player Cash Money | 'bank' = QBCore Player Bank Money | 'crypto' = QBCore Player Crypto Money | 'item' = QBCore Shared Item
    PaymentCost = 0, -- Amount of Money | If you aren't using a Money Type(cash, bank, or crypto) than you can remove this Configuration
    Item = nil, -- 'ItemName' | ItemName = QBCore Shared Item Name | If you aren't using an Item, you can remove this Configuration and the one below.
    ItemAmount = 0, -- Amount of Items
}
