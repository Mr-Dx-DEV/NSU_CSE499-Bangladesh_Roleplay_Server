Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'HOME' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- It returnes 64 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["StoreRobbery"] = {
        minimum = 2,
        busy = false,
    },
    ["BankRobbery"] = {
        minimum = 4,
        busy = false,
    },
    ["Jewellery"] = {
        minimum = 4,
        busy = false,
    },
    ["Pacific"] = {
        minimum = 8,
        busy = false,
    },
}

-- Current Cops Online
Config.CurrentCops = 0

-- Current Ambulance / Doctors Online
Config.CurrentAmbulance = 0

-- Show ID's for all players or Opted in Staff
Config.ShowIDforALL = true