QBShared = QBShared or {}
-- Jobs
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
    ['admin'] = {
		label = 'SJRP',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Gov',
                payment = 0
            },
        },
	},

	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
	-- police job
	['police'] = {
		label = 'Bangladesh Police',
		defaultDuty = true,
		grades = {
			['0'] = {name = "CONSTABLE",						            payment = 750},
			['1'] = {name = "ASI",				                            payment = 750},
			['2'] = {name = "Sergeant",										payment = 750},
			['3'] = {name = "SI",										    payment = 750},
			['4'] = {name = "Inspector",									payment = 750},
			['5'] = {name = "ASP",									        payment = 750},
			['6'] = {name = "SR.ASP",	                       	            payment = 750},
            ['7'] = {name = "SP",	                       	                payment = 750},
            ['8'] = {name = "DIG",	                       	                payment = 750},
            ['9'] = {name = "AIGP",				            isboss = true,	payment = 750},
		   ['10'] = {name = "IGP",				            isboss = true,	payment = 750},
        },
	},
	-------------- / EMS
	['ambulance'] = {
		label = 'Bangladesh Medical',
		defaultDuty = true,
		grades = {
            ['0'] = {name = 'Medical Intern',							    payment = 1500},
            ['1'] = {name = 'Doctor',									    payment = 1500},
			['2'] = {name = 'Senior Doctor',								payment = 1500},
			['3'] = {name = 'Medicine Specialist',							payment = 1500},
			['4'] = {name = 'Assistant Surgeon',						    payment = 1500},
			['5'] = {name = 'Surgeon',						                payment = 1500},
			['6'] = {name = 'Medical Professor',							payment = 1500},
			['7'] = {name = 'Advisor',							            payment = 1500},
			['8'] = {name = 'Civil Surgeon',								payment = 1500},
			['9'] = {name = 'Deputy Chief',				                    payment = 1500},
           ['10'] = {name = 'Chief',	            isboss = true,		    payment = 1500},
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
     ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {label = 'Car Dealer',
		defaultDuty = true,
		grades = {
            ['0'] = {name = "PDM Trainer",									payment = 1100},
			['1'] = {name = "PDM Employee",							        payment = 1100},
			['2'] = {name = "PDM Worker",								    payment = 1100},
			['3'] = {name = "PDM Finance",                                  payment = 1100},
			['4'] = {name = "PDM Manager",                                  payment = 1100},
			['5'] = {name = "PDM Boss",		isboss = true,			        payment = 1100},
        },
	},
	['luxury'] = {label = 'luxury Dealer',
		defaultDuty = true,
		grades = {
            ['0'] = {name = "luxury Trainer",									payment = 1100},
			['1'] = {name = "luxury Employee",							        payment = 1100},
			['2'] = {name = "luxury Worker",								    payment = 1100},
			['3'] = {name = "luxury Finance",                                   payment = 1100},
			['4'] = {name = "luxury Manager",                                   payment = 1100},
			['5'] = {name = "luxury Boss",		isboss = true,			        payment = 1100},
        },
	},
	['edm'] = {label = 'Real Cars',
		defaultDuty = true,
		grades = {
			['0'] = {name = "Admin Boss",		isboss = true,			        payment = 1100},
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
		defaultDuty = true,
		grades = {
			['0'] = {name = "Mechanic Trainee",								        payment = 1200},
			['1'] = {name = "Mechanic Employee",									payment = 1200},
			['2'] = {name = "Mechanic Worker",										payment = 1200},
			['3'] = {name = "Mechanic Manager",				isboss = true,			payment = 1200},
			['4'] = {name = "Mechanic BOSS",				isboss = true,		    payment = 1200},
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Laal Chandan',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Beboshayi',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
    ['miner'] = {
        label = 'Miner',
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
    },
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
	["tequilala"] = {
        label = "Tequi-la-la",
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = "DJ",
                payment = 50
            },
            ['1'] = {
                name = "Bartender",
                payment = 75
            },
            ['2'] = {
                name = "Bouncer",
                payment = 100
            },
            ['3'] = {
                name = "Manager",
                payment = 125
            },
            ['4'] = {
                name = "Owner",
                isboss = true,
                payment = 150
            },
        },
    },
	["burgershot"] = {
        label = "Burgershot",
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = "Employee",
                payment = 50
            },
            ['1'] = {
                name = "Waiter",
                payment = 75
            },
            ['2'] = {
                name = "Cooker",
                payment = 100
            },
            ['3'] = {
                name = "Manager",
                payment = 125
            },
            ['4'] = {
                name = "Owner",
                isboss = true,
                payment = 150
            },
        },
    },
    ['planepilot'] = {
        label = 'Delivery',
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = 'Pilot',
                payment = 250
            },
        },
    },
}
