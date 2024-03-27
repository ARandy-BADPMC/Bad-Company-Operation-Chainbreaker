tieredUnits = createHashMap;
lythiumTieredUnits = createHashMap;
lythiumInfantryTiers = createHashMapFromArray [
	[
		1,
		[
			"LOP_AM_OPF_Infantry_SL",
			"LOP_AM_OPF_Infantry_Engineer",
			"LOP_AM_OPF_Infantry_Corpsman",
			"LOP_AM_OPF_Infantry_Rifleman_6",
			"LOP_AM_OPF_Infantry_Rifleman",
			"LOP_AM_OPF_Infantry_Rifleman_7"			
		]
		
	],
	[
		2,
		[
			"LOP_AM_OPF_Infantry_SL",
			"LOP_AM_OPF_Infantry_Engineer",
			"LOP_AM_OPF_Infantry_Corpsman",
			"LOP_AM_OPF_Infantry_Rifleman_6",
			"LOP_AM_OPF_Infantry_Rifleman",
			"LOP_AM_OPF_Infantry_Rifleman_7",
			"LOP_AM_OPF_Infantry_AR",
			"LOP_AM_OPF_Infantry_Marksman",
			"LOP_AM_OPF_Infantry_AT",
			"LOP_AM_OPF_Infantry_Rifleman_8"		
		]
	],
	[
		3,
		[
			"LOP_TKA_Infantry_SL",
			"LOP_TKA_Infantry_Rifleman",
			"LOP_TKA_Infantry_GL",
			"LOP_TKA_Infantry_Engineer",
			"LOP_TKA_Infantry_Corpsman"			
		]
	],
	[
		4,
		[
			"LOP_TKA_Infantry_SL",
			"LOP_TKA_Infantry_Rifleman",
			"LOP_TKA_Infantry_GL",
			"LOP_TKA_Infantry_Engineer",
			"LOP_TKA_Infantry_Corpsman",
			"LOP_TKA_Infantry_Rifleman_3",
			"LOP_TKA_Infantry_AA",
			"LOP_TKA_Infantry_MG",
			"LOP_TKA_Infantry_MG_Asst"
		]
	],
	[
		5,
		[
			"LOP_TKA_Infantry_SL",
			"LOP_TKA_Infantry_Rifleman",
			"LOP_TKA_Infantry_GL",
			"LOP_TKA_Infantry_Engineer",
			"LOP_TKA_Infantry_Corpsman",
			"LOP_TKA_Infantry_Rifleman_3",
			"LOP_TKA_Infantry_AA",
			"LOP_TKA_Infantry_MG",
			"LOP_TKA_Infantry_MG_Asst",
			"LOP_TKA_Infantry_AT"			
		]
	],
	[
		6,
		[
			"LOP_ISTS_OPF_Infantry_SL",
			"LOP_ISTS_OPF_Infantry_Rifleman_5",
			"LOP_ISTS_OPF_Infantry_Corpsman",
			"LOP_ISTS_OPF_Infantry_Engineer",
			"LOP_ISTS_OPF_Infantry_Marksman",
			"LOP_ISTS_OPF_Infantry_AR_2",
			"LOP_ISTS_OPF_Infantry_Rifleman_3",
			"LOP_ISTS_OPF_Infantry_AT",
			"LOP_ISTS_OPF_Infantry_Rifleman_9",
			"LOP_TKA_Infantry_AA"
		]
	]
];

lythiumVehicleCrewTiers = createHashMapFromArray [[1,"LOP_AM_OPF_Infantry_Rifleman_7"], [2,"LOP_TKA_Infantry_Rifleman_3"]];
lythiumStaticCrewTiers = createHashMapFromArray [[1,"LOP_AM_OPF_Infantry_Rifleman_7"], [2,"LOP_TKA_Infantry_Rifleman_3"]];

lythiumVehicleTiers = createHashMapFromArray [
	[
		1,
		"LOP_AM_OPF_BTR60",
		"LOP_AM_OPF_Landrover",
		"LOP_AM_OPF_Nissan_PKM",
		"LOP_AM_OPF_Landrover_SPG9",
		"LOP_TKA_UAZ",
		"LOP_TKA_Mi8MT_Cargo",
		"LOP_TKA_Mi24V_UPK23",
		"LOP_TKA_T34",
		"LOP_TKA_T55",
		"LOP_AM_UAZ_DshKM"

	],
	[
		2, 
		"LOP_TKA_Mi8MT_Cargo",
		"LOP_TKA_Mi24V_UPK23",
		"LOP_TKA_T34",
		"LOP_TKA_T55",
		"LOP_TKA_T72BB",
		"LOP_TKA_UAZ_AGS",
		"LOP_TKA_UAZ",
		"LOP_TKA_UAZ_SPG"

	]
];

lythiumTieredUnits set ["world_name", "lythium"];
lythiumTieredUnits set ["infantry_tiers", lythiumInfantryTiers];
lythiumTieredUnits set ["vehicle_crew_tiers", lythiumVehicleCrewTiers];
lythiumTieredUnits set ["static_crew_tiers", lythiumStaticCrewTiers];
lythiumTieredUnits set ["vehicle_tiers", lythiumVehicleTiers];

tieredUnits set ["lythium", lythiumTieredUnits];
