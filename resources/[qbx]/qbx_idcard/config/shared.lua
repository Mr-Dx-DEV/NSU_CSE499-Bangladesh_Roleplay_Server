return {

    idCardSettings = {
        closeKey = 'Backspace',
        autoClose = {
            status = false, -- or true
            time = 3000
        }
    },

    licenses = {
        ['id_card'] = {
            header = 'National ID Card',
            background = '#ebf7fd',
            backgroundImage = 'https://r2.fivemanage.com/w4aVvxe5Gx1fmKRNTBqw3/f3b7bf6e-0095-4be9-9b7a-edc67364af2b.png',
            prop = 'prop_franklin_dl'
        },
        ['driver_license'] = {
            header = 'Driver License',
            background = '#febbbb',
            backgroundImage = 'https://r2.fivemanage.com/w4aVvxe5Gx1fmKRNTBqw3/f3b7bf6e-0095-4be9-9b7a-edc67364af2b.png',
            prop = 'prop_franklin_dl',
        },
        ['weaponlicense'] = {
            header = 'Weapon License',
            background = '#c7ffe5',
            backgroundImage = 'https://i.ibb.co/vxvGzg1/card.png',
            prop = 'prop_franklin_dl',
        },
        ['lawyerpass'] = {
            header = 'Lawyer Pass',
            background = '#f9c491',
            backgroundImage = 'https://i.ibb.co/vxvGzg1/card.png',
            prop = 'prop_cs_r_business_card'
        }
    }
}
