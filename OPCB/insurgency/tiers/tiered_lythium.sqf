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
			"LOP_TKA_Infantry_Corpsman",
			"LOP_TKA_Infantry_Rifleman_3",
			// "LOP_TKA_Infantry_AA",
			"LOP_TKA_Infantry_MG",
			"LOP_TKA_Infantry_MG_Asst"	
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
			// "LOP_TKA_Infantry_AA",
			"LOP_TKA_Infantry_MG",
			"LOP_TKA_Infantry_MG_Asst",
			"LOP_TKA_Infantry_AT"	
		]
	],
	[
		5,
		[
			"LOP_ISTS_OPF_Infantry_SL",
			"LOP_ISTS_OPF_Infantry_Rifleman_5",
			"LOP_ISTS_OPF_Infantry_Corpsman",
			"LOP_ISTS_OPF_Infantry_Engineer",
			"LOP_ISTS_OPF_Infantry_Marksman",
			"LOP_ISTS_OPF_Infantry_AR_2",
			"LOP_ISTS_OPF_Infantry_Rifleman_3",
			"LOP_ISTS_OPF_Infantry_AT",
			"LOP_ISTS_OPF_Infantry_Rifleman_9"		
		]
	],
	[
		6,
		[
			"LOP_PMC_Infantry_TL",
			"LOP_PMC_Infantry_SL",
			"LOP_PMC_Infantry_Engineer",
			"LOP_PMC_Infantry_Rifleman_4",
			"LOP_PMC_Infantry_Marksman_2",
			"LOP_PMC_Infantry_Corpsman",
			"LOP_PMC_Infantry_Rifleman",
			"LOP_PMC_Infantry_Rifleman_3",
			"LOP_PMC_Infantry_MG",
			"LOP_PMC_Infantry_MG_Asst",
			"LOP_PMC_Infantry_GL",
			"LOP_PMC_Infantry_Rifleman_2",
			"LOP_PMC_Infantry_Marksman",
			"LOP_PMC_Infantry_EOD",
			"LOP_PMC_Infantry_AT",
			// "LOP_PMC_Infantry_AA",
			"LOP_PMC_Infantry_AT_Asst"
		]
	]
];

lythiumVehicleCrewTiers = createHashMapFromArray [[1,["LOP_AM_OPF_Infantry_Rifleman_7"]], [2,["LOP_TKA_Infantry_Rifleman_3"]]];
lythiumStaticCrewTiers = createHashMapFromArray [[1,["LOP_AM_OPF_Infantry_Rifleman_7"]], [2,["LOP_TKA_Infantry_Rifleman_3"]]];

lythiumVehicleTiers = createHashMapFromArray [
	[
		1,
		[
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
		]

	],
	[
		2,
		[
			"LOP_TKA_Mi24V_UPK23",
			"LOP_TKA_Mi8MT_Cargo",
			"LOP_TKA_Mi8MTV3_UPK23",
			"LOP_TKA_UAZ",
			"LOP_TKA_UAZ_AGS",
			"LOP_TKA_UAZ_SPG",
			"LOP_TKA_ZSU234",
			"LOP_TKA_BTR70",
			"LOP_TKA_T55",
			"LOP_TKA_T72BA",
			"LOP_IRAN_CH47F",
			"LOP_IRAN_AH1Z_WD",
			"LOP_IRAN_M113_C"
		]

	]
];

lythiumTieredUnits set ["world_name", "lythium"];
lythiumTieredUnits set ["infantry_tiers", lythiumInfantryTiers];
lythiumTieredUnits set ["vehicle_crew_tiers", lythiumVehicleCrewTiers];
lythiumTieredUnits set ["static_crew_tiers", lythiumStaticCrewTiers];
lythiumTieredUnits set ["vehicle_tiers", lythiumVehicleTiers];

tieredUnits set ["lythium", lythiumTieredUnits];
