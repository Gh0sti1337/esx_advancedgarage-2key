
-- Hier bitte keine AddTextEntry hinzufügen. 
-- Der Server lädt auch diese Config. Und schmeißt beim Start Fehler ohne Ende
-- Dafür bitte in die Client Datei schauen

Config = {}
Config.Locale = 'en'

Config.KickPossibleCheaters = true -- If true it will kick the player that tries store a vehicle that they changed the Hash or Plate.
Config.UseCustomKickMessage = true -- If KickPossibleCheaters is true you can set a Custom Kick Message in the locales.

Config.UseDamageMult = true -- If true it costs more to store a Broken Vehicle.
Config.DamageMult = 0.5 -- Higher Number = Higher Repair Price.

Config.CarPoundPrice      = 5000 -- Car Pound Price.
Config.BoatPoundPrice     = 1000 -- Boat Pound Price.
Config.AircraftPoundPrice = 20000 -- Aircraft Pound Price.

Config.PolicingPoundPrice  = 2500 -- Policing Pound Price.
Config.AmbulancePoundPrice = 1500 -- Ambulance Pound Price.

Config.UseCarGarages        = true -- Allows use of Car Garages.
Config.UseGangGarages        = true -- Allows use of Gang Garages.
Config.UseBoatGarages       = true -- Allows use of Boat Garages.
Config.UseAircraftGarages   = true -- Allows use of Aircraft Garages.
Config.UseAircraftGangGarages   = true -- Allows use of Aircraft Garages.
Config.UsePrivateCarGarages = false -- Allows use of Private Car Garages.
Config.UseJobCarGarages     = true -- Allows use of Job Garages.

Config.DontShowPoundCarsInGarage = false -- If set to true it won't show Cars at the Pound in the Garage.
Config.ShowVehicleLocation       = true -- If set to true it will show the Location of the Vehicle in the Pound/Garage in the Garage menu.
Config.UseVehicleNamesLua        = true -- Must setup a vehicle_names.lua for Custom Addon Vehicles.

Config.ShowGarageSpacer1 = false -- If true it shows Spacer 1 in the List.
Config.ShowGarageSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowGarageSpacer3 = true -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.ShowPoundSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowPoundSpacer3 = true -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.MarkerType   = 27
Config.DrawDistance = 100.0

-- MySQL Einstellung für die 2t-Schlüssel:
-- https://stackoverflow.com/questions/23921117/disable-only-full-group-by
Config.EnableSecondKeyMarkers = true
Config.EnableSecondKeyBlips = true

Config.SecondKeyStation = {
	SouthSide1 = {
		x = 226.53,
		y = -1530.1,
		z = 28.2,
		blip = false
	},
	SouthSide2 = {
		x = 231.88,
		y = -1535.3,
		z = 28.2,
		blip = true
	},
	SouthSide3 = {
		x = 229.2,
		y = -1515.1,
		z = 28.2,
		blip = false
	},
	SouthSide4 = {
		x = 258.8,
		y = -1515.2,
		z = 28.2,
		blip = false
	},
	Sandy1 = {
		x = 1709.77,
		y = 3773.5,
		z = 33.5,
		blip = false
	},
	Sandy2 = {
		x = 1706.6,
		y = 3764.5,
		z = 33.5,
		blip = true
	},
	Paleto1 = {
		x = 141.6,
		y = 6637.7,
		z = 30.99,
		blip = true
	},
	Paleto2 = {
		x = 162.7,
		y = 6618.4,
		z = 30.99,
		blip = false
	},
    Beach1 = {
		x = -1657.8,
		y = -839.65,
		z = 8.6,
		blip = false
    },
    Beach2 = {
		x = -1650.7,
		y = -844.7,
		z = 8.55,
		blip = true
    },
    Beach3 = {
		x = -1643.4,
		y = -850.6,
		z = 8.6,
		blip = false
    },
    Beach4 = {
		x = -1636.9,
		y = -856.0,
		z = 8.65,
		blip = false
	},
}

Config.BlipGarage = {
	Sprite = 290,
	Color = 38,
	Display = 2,
	Scale = 1.0
}

Config.BlipGaragePrivate = {
	Sprite = 290,
	Color = 53,
	Display = 2,
	Scale = 1.0
}

Config.BlipPound = {
	Sprite = 67,
	Color = 64,
	Display = 2,
	Scale = 1.0
}

Config.BlipJobPound = {
	Sprite = 67,
	Color = 49,
	Display = 2,
	Scale = 1.0
}

Config.SecondKeyPoundMarker = {
	r = 255, g = 255, b = 0,     -- Red Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.PointMarker = {
	r = 0, g = 255, b = 0,     -- Green Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.DeleteMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 3.5, y = 3.5, z = 1.0  -- Big Size Circle
}

Config.PoundMarker = {
	r = 0, g = 0, b = 100,     -- Blue Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.JobPoundMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

-- Start of Jobs

Config.PolicePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
		SpawnPoint = {
                { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
            },
        },
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = {
                { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
            },
        },
	Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.49 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
}

Config.AmbulancePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
		SpawnPoint = {
                { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
            },
        },
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = {
            { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
        },
    },
	Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.49 },
		SpawnPoint = {
            { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
        },
    }
}

-- End of Jobs
-- Start of Cars

Config.CarGarages = {
	Garage_MP = {
		GaragePoint = { x = 214.76, y = -805.46, z = 29.9722 },
		SpawnPoint = {
            { x = 229.70, y = -800.120, z = 29.67, h = 157.80 },
            { x = 238.9, y = -807.42, z = 29.4, h = 66.7 },
            { x = 243.9, y = -796.8, z = 29.4, h = 70.0 },
            { x = 239.0, y = -783.82, z = 29.5, h = 70.0 },
            { x = 258.81, y = -788.67, z = 29.5, h = 340.0 },
            { x = 249.2, y = -769.0, z = 29.5, h = 70.0 },
            { x = 232.3, y = -762.2, z = 29.8, h = 70.0 },
            { x = 216.6, y = -778.1, z = 29.8, h = 70.0 },
            { x = 208.5, y = -791.5, z = 29.8, h = 70.0 },
        },
		DeletePoint = {x = 215.124, y = -791.377, z = 29.946}
    },
    Garage_HafenGarage = {
		GaragePoint = {x = 985.5, y = -3240.6, z = 4.95},
		SpawnPoint = {
            {x = 961.3, y = -3209.9, z = 4.4, h = 180.0},
            {x = 953.3, y = -3210.0, z = 4.4, h = 180.0},
            {x = 945.2, y = -3209.85, z = 4.4, h = 180.0},
            {x = 932.9, y = -3208.8, z = 4.4, h = 180.0},
            {x = 993.25, y = -3208.9, z = 4.4, h = 180.0},
            {x = 1001.5, y = -3208.9, z = 4.4, h = 180.0},
        },
		DeletePoint = {x = 978.5, y = -3240.8, z = 4.95}
    },
    Garage_HafenGarage2 = {
		GaragePoint = {x = 193.3, y = -2503.9, z = 6.3},
		SpawnPoint = {
            {x = 200.9, y = -2498.1, z = 4.4, h = 180.0},
            {x = 187.1, y = -2523.66, z = 4.4, h = 85.0},
            {x = 203.4, y = -2511.7, z = 4.4, h = 90.0},
            {x = 202.5, y = -2517.4, z = 4.4, h = 90.0},
        },
		DeletePoint = {x = 180.8, y = -2506.5, z = 5.01}
	},
	Garage_EntranceBaumarkt = {
		GaragePoint = {x = 2773.8, y = 3474.8, z = 54.55},
		SpawnPoint = {
            {x = 2765.2, y = 3483.1, z = 53.92, h = 340.0}
        },
		DeletePoint = {x = 2768.7, y = 3474.1, z = 54.75}
	},
	Garage_PDM = {
		GaragePoint = { x = -74.44,   y = -1171.14, z = 25.1 },
		SpawnPoint = {
            { x = -69.07,   y = -1160.81, z = 25.9, h = 178.55 },
            { x = -66.7,   y = -1168.5, z = 25.05, h = 15.55 },
            { x = -52.23,   y = -1160.6, z = 25.1, h = 355.55 },
            { x = -61.3,   y = -1165.1, z = 25.1, h = 355.55 },
            { x = -57.23,   y = -1151.1, z = 25.1, h = 270.55 },
            { x = -45.83,   y = -1150.1, z = 25.1, h = 270.55 },
            { x = -35.6,   y = -1150.1, z = 25.1, h = 270.55 },
            { x = -28.33,   y = -1149.9, z = 25.1, h = 270.55 },
		},
		DeletePoint = {x = -58.83, y = -1166.95, z = 25.21}
	},
	Garage_LSSpawn = {
		GaragePoint = {x = 68.71, y = 14.41, z = 68.26},
		SpawnPoint = {
            {x = 73.74, y = 13.92, z = 68.14, h = 157.84 },
            {x = 54.8, y = 19.92, z = 68.5, h = 340.0 },
            {x = 57.8, y = 28.5, z = 69.0, h = 250.0 },
            {x = 67.81, y = 25.2, z = 69.0, h = 250.0 },
            {x = 76.41, y = 21.62, z = 69.0, h = 150.0 },
		},
		DeletePoint = {x = 63.64, y = 16.1, z = 68.24}
	},
	Garage_Sandy = {
		GaragePoint = { x = 1737.59, y = 3710.2, z = 33.2 },
		SpawnPoint = {
            { x = 1737.84, y = 3719.28, z = 33.04, h = 21.22 },
            { x = 1747.2, y = 3718.9, z = 33.04, h = 21.22 },
            { x = 1750.6, y = 3730.3, z = 33.04, h = 30.22 },
            { x = 1763.9, y = 3735.9, z = 33.04, h = 213.5 },
            { x = 1706.1, y = 3748.6, z = 33.04, h = 214.0 },
            { x = 1704.5, y = 3718.6, z = 33.04, h = 20.0 },
		},
		DeletePoint = { x = 1722.66, y = 3713.74, z = 33.3 }
	},
	Garage_Paleto = {
		GaragePoint = { x = 105.359, y = 6613.586, z = 31.46 },
		SpawnPoint = {
            { x = 128.7822, y = 6622.9965, z = 30.7828, h = 315.01 },
            { x = 117.6, y = 6599.2, z = 31.1, h = 272.1 },
            { x = 126.4, y = 6590.1, z = 31.5, h = 272.1 },
            { x = 134.9, y = 6584.7, z = 31.5, h = 272.1 },
            { x = 141.5, y = 6575.7, z = 31.5, h = 272.1 },
            { x = 145.9, y = 6568.9, z = 31.5, h = 272.1 },
            { x = 155.4, y = 6603.5, z = 31.5, h = 272.1 },
		},
		DeletePoint = { x = 126.3572, y = 6608.4150, z = 30.9565 }
    },
	Garage_Impound = {
		GaragePoint = {x = 420.15, y = -1628.88, z = 28.39},
		SpawnPoint = {
            {x = 420.15, y = -1628.88, z = 28.39, h = 139.0 },
            {x = 404.20, y = -1636.30, z = 28.3, h = 230.0 },
            {x = 398.6, y = -1646.3, z = 28.3, h = 230.0 },
            {x = 405.4, y = -1651.4, z = 28.3, h = 230.0 },
            {x = 417.5, y = -1651.4, z = 28.3, h = 230.0 },
		},
		DeletePoint = {x = 421.0, y = -1635.81, z = 28.39 }
	},
	Garage_LiveInvader = {
		GaragePoint = { x = -896.9, y = -155.3, z = 40.9 },
		SpawnPoint = {
            { x = -906.4, y = -150.6, z = 41.0, h = 124.24 },
            { x = -907.5, y = -161.2, z = 41.0, h = 22.24 },
            { x = -917.4, y = -166.1, z = 41.0, h = 22.24 },
            { x = -927.4, y = -170.7, z = 41.0, h = 22.24 },
            { x = -937.92, y = -176.5, z = 41.0, h = 22.24 },
            { x = -944.76, y = -179.2, z = 41.0, h = 26.24 },
            { x = -941.3, y = -164.6, z = 41.0, h = 300.24 },
		},
		DeletePoint = { x = -902.0, y = -160.3, z = 40.9 }
	},
	Garage_Observatorium = {
		GaragePoint = { x = -424.97, y = 1207.6, z = 324.76 },
		SpawnPoint = {
            { x = -420.99, y = 1203.02, z = 325.64, h = 239.92 },
            { x = -421.22, y = 1203.3, z = 325.64, h = 235.92 },
            { x = -416.4, y = 1220.3, z = 325.64, h = 235.92 },
            { x = -413.2, y = 1232.3, z = 325.64, h = 235.92 },
            { x = -403.9, y = 1233.9, z = 325.64, h = 160.92 },
            { x = -384.8, y = 1222.7, z = 325.64, h = 110.92 },
            { x = -385.8, y = 1211.1, z = 325.64, h = 105.92 },
		},
		DeletePoint = { x = -418.34, y = 1210.92, z = 324.75 }
	},
    Garage_LSBM = {
		GaragePoint = { x = -154.77, y = -642.61, z = 31.52 },
		SpawnPoint = {
            { x = -143.7, y = -575.98, z = 32.42, h = 162.46 },
            { x = -140.0, y = -587.8, z = 32.42, h = 82.46 },
            { x = -142.1, y = -599.5, z = 32.42, h = 73.46 },
            { x = -148.6, y = -616.5, z = 32.42, h = 66.46 },
            { x = -162.3, y = -613.0, z = 32.42, h = 71.46 },
            { x = -176.1, y = -608.5, z = 32.42, h = 243.73 },
		},
		DeletePoint = { x = -153.74, y = -629.96, z = 31.52 }
	},
	Garage_Fahrschule = {
		GaragePoint = { x = 279.3, y = -1351.08, z = 31.0 },
		SpawnPoint = {
            { x = 279.3, y = -1351.08, z = 31.0, h = 146.8 },
            { x = 277.6, y = -1361.1, z = 31.0, h = 50.8 },
            { x = 273.9, y = -1346.9, z = 31.0, h = 161.8 },
            { x = 246.2, y = -1336.6, z = 31.0, h = 142.8 },
		},
		DeletePoint = {x = 284.25, y = -1355.47, z = 31.0}
	},
	Garage_Airport = {
		GaragePoint = { x = -1012.0, y = -2702.3, z = 13.1 },
		SpawnPoint = {{ x = -1007.1, y = -2704.5, z = 12.9, h = 145.0 }},
		DeletePoint = {x = -1007.1, y = -2704.5, z = 12.9}
	},
	Garage_hospitaldown = {
		GaragePoint = { x = 324.1, y = -618.7, z = 28.3 },
		SpawnPoint = {{ x = 332.5, y = -617.74, z = 28.3, h = 188.9 }},
		DeletePoint = {x = 332.5, y = -617.74, z = 28.3}
	},
	Garage_mccansy = {
		GaragePoint = { x = 2107.5, y = 4770.8, z = 40.25 },
		SpawnPoint = {
			{ x = 2102.8, y = 4767.7, z = 41.2, h = 88.0 },
		},
		DeletePoint = {x = 2111.6, y = 4766.7, z = 40.3 }
	},
	Garage_BlackSkullOfficial = {
		GaragePoint = { x = 2546.4, y = -270.6, z = 92.2 },
		SpawnPoint = {
			{ x = 2541.6, y = -273.7, z = 92.0, h = 196.0 },
		},
		DeletePoint = {x = 2542.4, y = -266.8, z = 92.0 }
    },
    Garage_BelowTuner = {
		GaragePoint = { x = 1000.0, y = -2490.1, z = 27.3 },
		SpawnPoint = {
            { x = 1012.95, y = -2490.6, z = 27.3, h = 335.0 },
            { x = 1006.23, y = -2488.2, z = 27.3, h = 345.0 },
            { x = 1013.85, y = -2512.6, z = 27.3, h = 85.0 },
            { x = 1014.1, y = -2522.1, z = 27.3, h = 78.0 },
            { x = 1003.0, y = -2524.5, z = 27.3, h = 358.0 },
		},
		DeletePoint = {x = 1004.75, y = -2493.5, z = 27.3 }
		},
	Garage_Beach = {
		GaragePoint = { x = -1186.0, y = -1508.5, z = 3.4 },
		SpawnPoint = {
            { x = -1190.7, y = -1497.22, z = 3.4, h = 304.0 }
        },
		DeletePoint = {x = -1190.7, y = -1497.22, z = 3.4 }
	},
	Garage_JustinKuschnig = {	
		GaragePoint = { x = -815.12, y = 801.35, z = 201.19 },
        SpawnPoint = {{ x = -810.99, y = 807.41, z = 201.14, h = 16.89 }},
        DeletePoint = { x = -812.31, y = 805.32, z = 201.19 }
	},
	Garage_LeftHighway = {	
		GaragePoint = { x = -2522.7, y = 2344.35, z = 32.1 },
        SpawnPoint = {{x = -2526.1, y = 2340.74, z = 32.2, h = 213.3 }},
        DeletePoint = { x = -2525.5, y = 2340.1, z = 32.1 }
	},
	Garage_BetweenJustizandMazebank = {	
		GaragePoint = { x = -340.65, y = 268.9, z = 84.7 },
        SpawnPoint = {{ x = -345.9, y = 272.5, z = 84.4, h = 269.2 }},
        DeletePoint = { x = -349.0, y = 272.6, z = 84.2 }
	},
	Garage_RichterHighway = {	
		GaragePoint = { x = 2586.8, y = 462.2, z = 107.7 },
        SpawnPoint = {{ x = 2579.3, y = 439.5, z = 107.5, h = 357.6 }},
        DeletePoint = { x = 2579.3, y = 439.5, z = 107.5 }
    },
    Garage_GewerbeLSPDStelle = {	
		GaragePoint = { x = 818.55, y = -1330.32, z = 25.1 },
        SpawnPoint = {
            { x = 826.97467041016, y = -1338.6505126954, z = 26.099361419678},
            { x = 825.88403320312, y = -1344.5927734375, z = 26.098226547242},
            { x = 825.9594116211, y = -1350.187133789, z = 26.100898742676},
            { x = 846.45501708984, y = -1353.8112792968, z = 26.093072891236},
            { x = 846.17041015625, y = -1347.2954101562, z = 26.090438842774},
            { x = 846.8676147461, y = -1341.1114501954, z = 26.084865570068},
            { x = 846.77447509766, y = -1335.4890136718, z = 26.112442016602},
            { x = 864.3666381836, y = -1376.2510986328, z = 26.130460739136},
            { x = 861.03729248046, y = -1380.9208984375, z = 26.13790512085},
            { x = 858.35681152344, y = -1386.1414794922, z = 26.151313781738},
            { x = 855.26208496094, y = -1391.5501708984, z = 26.141868591308},
            { x = 852.15209960938, y = -1395.5704345704, z = 26.133420944214},
        },
        DeletePoint = { x = 832.61, y = -1365.4, z = 25.2 }
	},
}

Config.CarPounds = {
    Pound_LosSantos = {
        PoundPoint = { x = 408.61, y = -1625.47, z = 28.30 },
        SpawnPoint = {
            { x = 405.64, y = -1643.4, z = 27.61, h = 229.54 }
        },
    },
    Pound_Sandy = {
        PoundPoint = { x = 1651.38, y = 3804.84, z = 37.7 },
        SpawnPoint = {
                { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
            },
        },
    Pound_Paleto = {
        PoundPoint = { x = 121.5, y = 6625.7, z = 30.95 },
        SpawnPoint = {
                { x = 155.87, y = 6605.75, z = 30.3, h = 001.5 },
                { x = 145.93, y = 6600.20, z = 30.3, h = 175.5 }
            },
        },
}

-- End of Cars

-- Start of Gangs
Config.GangGarages = {
    Garage_KoortzAutos = {	
		GaragePoint = { x = -2317.1, y = 310.3, z = 168.7 },
        SpawnPoint = {{ x = -2316.6, y = 280.85, z = 168.5, h = 26.91 }},
        DeletePoint = { x = -2320.5, y = 305.7, z = 168.5 }
	},
    Garage_Lifeinvader = {
        GaragePoint = {
            x = -1050.51,
            y = -243.46,
            z = 37.00
        },
        SpawnPoint = {
            {
                x = -1054.5,
                y = -243.57,
                z = 37.50,
                h = 208.95
            },
        },
        DeletePoint = {
            x = -1054.5,
            y = -243.57,
            z = 37.00
        },
    },
    Garage_TruckerChef = {
        GaragePoint = {
            x = -698.85,
            y = 5808.5,
            z = 16.3
        },
        SpawnPoint = {
            {
                x = -693.94,
                y = 5817.4,
                z = 15.9,
                h = 246.0
            },
            {
                x = -695.9,
                y = 5814.5,
                z = 15.9,
                h = 245.0
            },
            {
                x = -680.65,
                y = 5829.2,
                z = 15.9,
                h = 310.0
            },
            {
                x = -682.9,
                y = 5831.6,
                z = 15.9,
                h = 315.0
            },
            {
                x = -584.4,
                y = 5844.9,
                z = 15.9,
                h = 330.0
            },
        },
        DeletePoint = {
            x = -696.2,
            y = 5814.5,
            z = 16.33
        },
    },
    Garage_LandwirtChef = {
        GaragePoint = {
            x = 274.6,
            y = -1947.7,
            z = 23.65
        },
        SpawnPoint = {
            {
                x = 280.6,
                y = -1929.2,
                z = 24.7,
                h = 320.0
            },
            {
                x = 286.4,
                y = -1932.1,
                z = 24.65,
                h = 230.4
            },
        },
        DeletePoint = {
            x = 280.95,
            y = -1928.3,
            z = 24.75
        },
    },
    Garage_Detekt = {
        GaragePoint = {
            x = -1570.2,
            y = -234.5,
            z = 48.6
        },
        SpawnPoint = {
            {
                x = -1562.2,
                y = -255.9,
                z = 47.4,
                h = 146.8
            },
        },
        DeletePoint = {
            x = -1565.8,
            y = -250.7,
            z = 47.4
        }
    },
    Garage_Grove = {
        GaragePoint = {
            x = 78.76,
            y = -1975.17,
            z = 19.93
        },
        SpawnPoint = {
            {
                x = 85.39,
                y = -1970.84,
                z = 20.75,
                h = 320.00
            },
        },
        DeletePoint = {
            x = 86.39,
            y = -1970.84,
            z = 19.9
        }
    },
    Garage_Sanchez = {
        GaragePoint = {
            x = -877.07,
            y = -54.94,
            z = 37.1
        },
        SpawnPoint = {
            {
                x = -870.56,
                y = -53.58,
                z = 38.42,
                h = 283.96
            },
        },
        DeletePoint = {
            x = -876.34,
            y = -47.95,
            z = 37.19
        }
    },
    Garage_Prison = {
        GaragePoint = {
            x = 1852.28,
            y = 2596.64,
            z = 44.97
        },
        SpawnPoint = {
            {
                x = 1855.11,
                y = 2592.72,
                z = 44.67,
                h = 274.8
            },
        },
        DeletePoint = {
            x = 1870.44,
            y = 2577.58,
            z = 44.97
        }
    },
    Garage_Kroside = {
        GaragePoint = {
            x = -1788.35,
            y = 348.97,
            z = 87.56
        },
        SpawnPoint = {
            {
                x = -1789.58,
                y = 353.22,
                z = 88.57,
                h = 68.58
            },
        },
        DeletePoint = {
            x = -1795.02,
            y = 348.1,
            z = 87.55
        }
    },
    Garage_Justin88 = {
        GaragePoint = {
            x = -932.73,
            y = 15.57,
            z = 46.9
        },
        SpawnPoint = {
            {
                x = -926.71,
                y = 10.67,
                z = 47.8,
                h = 220.64
            },
        },
        DeletePoint = {
            x = -926.71,
            y = 10.67,
            z = 46.8
        }
    },
    Garage_Mechaniker = {
        GaragePoint = {
            x = 1012.43,
            y = -2325.5,
            z = 29.51
        },
        SpawnPoint = {
            {
                x = 1005.58,
                y = -2327.52,
                z = 29.51,
                h = 30.51
            },
        },
        DeletePoint = {
            x = 1003.09,
            y = -2336.01,
            z = 29.51
        }
    },
}

Config.GangPounds = {
}

-- End of Gangs

-- Start of Boats

Config.BoatGarages = {
	Garage_LSDock = {
		GaragePoint = { x = -735.87, y = -1325.08, z = 0.6 },
		SpawnPoint = {
            { x = -718.87, y = -1320.18, z = -0.47477427124977, h = 220.0 },
        },
         DeletePoint = { x = -731.15, y = -1334.71, z = 0.1 }
	},
	Garage_SandyDock = {
		GaragePoint = { x = 1333.2, y = 4269.92, z = 30.6 },
		SpawnPoint = {
            { x = 1334.61, y = 4264.68, z = 29.86, h = 237.87 },
        },
        DeletePoint = { x = 1323.73, y = 4269.94, z = 31.0 }
	},
	Garage_PaletoDock = {
		GaragePoint = { x = -283.74, y = 6629.51, z = 6.36 },
		SpawnPoint = {{ x = -293.1, y = 6637.82, z = -0.47477427124977, h = 329.7 }},
		DeletePoint = { x = -314.37, y = 6626.49, z = 0.6 }
	},
	Garage_PaletoDock = {
		GaragePoint = { x = -190.9, y = 791.25, z = 197.2},
		SpawnPoint = {{ x = -193.5, y = 782.2, z = 195.4, h = 230.0 }},
		DeletePoint = { x = -193.5, y = 782.2, z = 195.4 }
	},
	Garage_Jacht = {
		GaragePoint = { x = -2020.98, y = -1044.58, z = 1.50},
		SpawnPoint = {{ x = -2013.27, y = -1062.3, z = 0.6, h = 250.0 }},
		DeletePoint = { x = -2011.22, y = -1022.89, z = 0.7 }
	},
	Garage_Chicken = {
		GaragePoint = { x = -283.7, y = 6629.6, z = 6.4},
		SpawnPoint = {{ x = -297.7, y = 6643.4, z = 1.0, h = 90.0 }},
		DeletePoint = { x = -297.7, y = 6643.4, z = 1.0 }
	},
}

Config.BoatPounds = {
	Pound_LSDock = {
		PoundPoint = { x = -738.67, y = -1400.43, z = 4.05 },
		SpawnPoint = {
                { x = -738.33, y = -1381.51, z = 0.12, h = 137.85 }
            },
        },
	Pound_SandyDock = {
		PoundPoint = { x = 1299.36, y = 4217.93, z = 32.95 },
		SpawnPoint = {
                { x = 1294.35, y = 4226.31, z = 29.86, h = 345.0 }
            },
        },
	Pound_PaletoDock = {
		PoundPoint = { x = -270.2, y = 6642.43, z = 6.4 },
		SpawnPoint = {
            { x = -290.38, y = 6638.54, z = -0.47477427124977, h = 130.0 }
        },
    },
}

-- End of Boats
-- Start of Aircrafts

Config.AircraftGarages = {
	Garage_LSAirport = {
		GaragePoint = { x = -1617.14, y = -3145.52, z = 12.99 },
		SpawnPoint = {
            { x = -1657.99, y = -3134.38, z = 12.99, h = 330.11 },
        },
        DeletePoint = { x = -1642.12, y = -3144.25, z = 12.99 }
	},
	Garage_SandyAirport = {
		GaragePoint = { x = 1723.84, y = 3288.29, z = 40.2 },
		SpawnPoint = {
            { x = 1710.85, y = 3259.06, z = 40.69, h = 104.66 },
        },
        DeletePoint = { x = 1714.45, y = 3246.75, z = 40.17 }
	},
	Garage_GrapeseedAirport = {
		GaragePoint = { x = 2152.83, y = 4797.03, z = 40.19 },
		SpawnPoint = {{ x = 2122.72, y = 4804.85, z = 40.78, h = 115.04 }},
		DeletePoint = { x = 2082.36, y = 4806.06, z = 40.07 }
	},
	Garage_LSAirImpound = {
		GaragePoint = { x = -1239.2, y = -3386.8, z = 13.0 },
		SpawnPoint = {{ x = -1263.9, y = -3385.99, z = 13.0, h = 325.0 }},
		DeletePoint = { x = -1263.9, y = -3385.99, z = 13.0 }
	},
}

Config.AircraftGangGarages = {
	Garage_CasinoAirport = {
		GaragePoint = { x = 977.57, y = 46.12, z = 122.12 },
		SpawnPoint = {
            { x = 965.86, y = 42.35, z = 122.12, h = 157.16 },
        },
        DeletePoint = { x = 965.86, y = 42.35, z = 122.12, }
    },
}

Config.AircraftPounds = {
	Pound_LSAirport = {
		PoundPoint = { x = -1243.0, y = -3391.92, z = 13.0 },
		SpawnPoint = {
            { x = -1272.27, y = -3382.46, z = 12.94, h = 330.25 }
        },
    },
	
	Pound_SandyAirport = {
		PoundPoint = { x = 1727.49, y = 3290.21, z = 40.20 },
		SpawnPoint = {
            { x = 1704.24, y = 3254.18, z = 41.00, h = 101.87 }
        },
    },
}

-- End of Aircrafts
Config.PrivateCarGarages = {
	
}