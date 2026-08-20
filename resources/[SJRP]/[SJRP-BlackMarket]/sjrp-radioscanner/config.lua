Config = {}

Config.UpdateInterval = 20 -- minutes
Config.Markedbills = true -- if true, the player will get markedbills. Otherwise straight cash
Config.Guards = {
    amount = 5,
    accuracy = 0,
    armour = 100,
    weapon = {
        `WEAPON_MICROSMG`,
        `WEAPON_ASSAULTSMG`,
        `WEAPON_COMBATMG`,
        `WEAPON_COMBATPDW`,
        `WEAPON_PUMPSHOTGUN`
    },
    ammo = 400,
    ped = {
        `a_m_m_hillbilly_01`,
        `a_m_m_hillbilly_02`,
        `a_m_m_beach_01`,
        `a_m_m_eastsa_01`,
        `a_m_m_eastsa_02`
    }
}

Config.Items = {
    ["boxofxtc"] = {
        min = 150,
        max = 300,
        sellcoords = vector3(-62.43, -2509.43, 11.34)
    },
}