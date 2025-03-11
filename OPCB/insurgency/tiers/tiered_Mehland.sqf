MehlandTieredUnits = createHashMap;
MehlandInfantryTiers = createHashMapFromArray [
	[
		1, // Tier #1 Looters
		[
			"I_L_Hunter_F",
			"I_L_Looter_Rifle_F",
			"I_L_Looter_SG_F",
			"I_L_Criminal_SG_F",
			"I_L_Looter_SMG_F"	
		]
		
	],
	[
		2, // Tier 2 Looters + Militia
		[			
			"I_L_Hunter_F",
			"I_L_Looter_Rifle_F",
			"I_L_Looter_SG_F",
			"I_L_Criminal_SG_F",
			"I_L_Looter_SMG_F",
			"UK3CB_LNM_I_TL",
			"UK3CB_LNM_I_SEN_1",
			"UK3CB_LNM_I_SEN_3",
			"UK3CB_LNM_I_SEN_2",
			"UK3CB_LNM_I_SEN_4",
			"UK3CB_LNM_I_SL",
			"UK3CB_LNM_I_RIF_2",
			"UK3CB_LNM_I_RIF_1",
			"UK3CB_LNM_I_OFF",
			"UK3CB_LNM_I_MD",
			"UK3CB_LNM_I_MK",
			"UK3CB_LNM_I_MG",
			"UK3CB_LNM_I_LMG",
			"UK3CB_LNM_I_LAT",
			"UK3CB_LNM_I_GL",
			"UK3CB_LNM_I_ENG",
			"UK3CB_LNM_I_DEM",
			"UK3CB_LNM_I_COM",
			"UK3CB_LNM_I_AR",
			"UK3CB_LNM_I_AT"
		]
	],
	[
		3, // Tier 3 Militia
		[
			"UK3CB_LNM_I_TL",
			"UK3CB_LNM_I_SEN_1",
			"UK3CB_LNM_I_SEN_3",
			"UK3CB_LNM_I_SEN_2",
			"UK3CB_LNM_I_SEN_4",
			"UK3CB_LNM_I_SL",
			"UK3CB_LNM_I_RIF_2",
			"UK3CB_LNM_I_RIF_1",
			"UK3CB_LNM_I_OFF",
			"UK3CB_LNM_I_MD",
			"UK3CB_LNM_I_MK",
			"UK3CB_LNM_I_MG",
			"UK3CB_LNM_I_LMG",
			"UK3CB_LNM_I_LAT",
			"UK3CB_LNM_I_GL",
			"UK3CB_LNM_I_ENG",
			"UK3CB_LNM_I_DEM",
			"UK3CB_LNM_I_COM",
			"UK3CB_LNM_I_AR",
			"UK3CB_LNM_I_AT"
		]
	],
	[
		4, // Tier 4 Armored Milltia + Militia
		[
			"UK3CB_LNM_I_TL",
			"UK3CB_LNM_I_SEN_1",
			"UK3CB_LNM_I_SEN_3",
			"UK3CB_LNM_I_SEN_2",
			"UK3CB_LNM_I_SEN_4",
			"UK3CB_LNM_I_SL",
			"UK3CB_LNM_I_RIF_2",
			"UK3CB_LNM_I_RIF_1",
			"UK3CB_LNM_I_OFF",
			"UK3CB_LNM_I_MD",
			"UK3CB_LNM_I_MK",
			"UK3CB_LNM_I_MG",
			"UK3CB_LNM_I_LMG",
			"UK3CB_LNM_I_LAT",
			"UK3CB_LNM_I_GL",
			"UK3CB_LNM_I_ENG",
			"UK3CB_LNM_I_DEM",
			"UK3CB_LNM_I_COM",
			"UK3CB_LNM_I_AR",
			"UK3CB_LNM_I_AT",
			"UK3CB_LNM_I_SF_TL",
			"UK3CB_LNM_I_SF_SL",
			"UK3CB_LNM_I_SF_RIF_2",
			"UK3CB_LNM_I_SF_RIF_1",
			"UK3CB_LNM_I_SF_MD",
			"UK3CB_LNM_I_SF_MK",
			"UK3CB_LNM_I_SF_MG",
			"UK3CB_LNM_I_SF_LMG",
			"UK3CB_LNM_I_SF_LAT",
			"UK3CB_LNM_I_SF_GL",
			"UK3CB_LNM_I_SF_ENG",
			"UK3CB_LNM_I_SF_DEM",
			"UK3CB_LNM_I_SF_AR",
			"UK3CB_LNM_I_SF_AT"
		]
	],
	[
		5, // Tier 5 Armored Militia
		[
			"UK3CB_LNM_I_SF_TL",
			"UK3CB_LNM_I_SF_SL",
			"UK3CB_LNM_I_SF_RIF_2",
			"UK3CB_LNM_I_SF_RIF_1",
			"UK3CB_LNM_I_SF_MD",
			"UK3CB_LNM_I_SF_MK",
			"UK3CB_LNM_I_SF_MG",
			"UK3CB_LNM_I_SF_LMG",
			"UK3CB_LNM_I_SF_LAT",
			"UK3CB_LNM_I_SF_GL",
			"UK3CB_LNM_I_SF_ENG",
			"UK3CB_LNM_I_SF_DEM",
			"UK3CB_LNM_I_SF_AR",
			"UK3CB_LNM_I_SF_AT"
		]
	],
	[
		6, // Tier 6 Millitary
		[
			"UK3CB_LDF_I_TL",
			"UK3CB_LDF_I_SL",
			"UK3CB_LDF_I_RIF_1",
			"UK3CB_LDF_I_RIF_2",
			"UK3CB_LDF_I_MK",
			"UK3CB_LDF_I_MG",
			"UK3CB_LDF_I_LAT",
			"UK3CB_LDF_I_JNR_OFF",
			"UK3CB_LDF_I_GL",
			"UK3CB_LDF_I_ENG",
			"UK3CB_LDF_I_AR",
			"UK3CB_LDF_I_AT",
			"UK3CB_LDF_I_MD"
		]
	],
	[
		7, // Tier 7 Spec-Ops
		[
			"UK3CB_LDF_I_SF_TL",
			"UK3CB_LDF_I_SF_SPOT",
			"UK3CB_LDF_I_SF_SNI",
			"UK3CB_LDF_I_SF_SL",
			"UK3CB_LDF_I_SF_RIF_2",
			"UK3CB_LDF_I_SF_RIF_1",
			"UK3CB_LDF_I_SF_MD",
			"UK3CB_LDF_I_SF_MK",
			"UK3CB_LDF_I_SF_MG",
			"UK3CB_LDF_I_SF_LAT",
			"UK3CB_LDF_I_SF_GL",
			"UK3CB_LDF_I_SF_ENG",
			"UK3CB_LDF_I_SF_DEM",
			"UK3CB_LDF_I_SF_AR",
			"UK3CB_LDF_I_SF_AT"
		]
	],
	[
		8, // Tier 8 PMC
		[
			"UK3CB_ION_I_Woodland_TL",
			"UK3CB_ION_I_Woodland_SL",
			"UK3CB_ION_I_Woodland_SPOT",
			"UK3CB_ION_I_Woodland_SNI",
			"UK3CB_ION_I_Woodland_RIF_1",
			"UK3CB_ION_I_Woodland_RIF_2",
			"UK3CB_ION_I_Woodland_MD",
			"UK3CB_ION_I_Woodland_MK",
			"UK3CB_ION_I_Woodland_MG",
			"UK3CB_ION_I_Woodland_LAT",
			"UK3CB_ION_I_Woodland_GL",
			"UK3CB_ION_I_Woodland_ENG",
			"UK3CB_ION_I_Woodland_ENG",
			"UK3CB_ION_I_Woodland_DEM",
			"UK3CB_ION_I_Woodland_AR",
			"UK3CB_ION_I_Woodland_AT"
		]
	],
	[
		9, // Tier 9 PMC Spec Ops
		[
		"UK3CB_ION_I_Woodland_SF_TL",
		"UK3CB_ION_I_Woodland_SF_SNI",
		"UK3CB_ION_I_Woodland_SF_SPOT",
		"UK3CB_ION_I_Woodland_SF_SL",
		"UK3CB_ION_I_Woodland_SF_RIF_1",
		"UK3CB_ION_I_Woodland_SF_RIF_2",
		"UK3CB_ION_I_Woodland_SF_RIF_4",
		"UK3CB_ION_I_Woodland_SF_RIF_3",
		"UK3CB_ION_I_Woodland_SF_MD",
		"UK3CB_ION_I_Woodland_SF_MK",
		"UK3CB_ION_I_Woodland_SF_MG",
		"UK3CB_ION_I_Woodland_SF_LAT",
		"UK3CB_ION_I_Woodland_SF_GL",
		"UK3CB_ION_I_Woodland_SF_ENG",
		"UK3CB_ION_I_Woodland_SF_DEM",
		"UK3CB_ION_I_Woodland_SF_AT"
		]
	]
];

MehlandVehicleCrewTiers = createHashMapFromArray [[1,"LOP_AM_OPF_Infantry_Rifleman_7"], [2,"LOP_PMC_Infantry_Rifleman"]];
MehlandStaticCrewTiers = createHashMapFromArray [[1,"LOP_AM_OPF_Infantry_Rifleman_7"], [2,"LOP_TKA_Infantry_Rifleman_3"]];

MehlandVehicleTiers = createHashMapFromArray [
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
			"LOP_PMC_Mi24V_UPK23",
			"LOP_PMC_Mi8AMT",
			"LOP_TKA_Mi8MTV3_UPK23",
			"LOP_PMC_Offroad_M2",
			"I_G_Offroad_01_AT_F",
			"LOP_TKA_ZSU234",
			"LOP_TKA_BTR70",
			"rhsgref_cdf_t80b_tv",
			"LOP_IRAN_CH47F",
			"LOP_PMC_MH9_armed",
			"LOP_RACS_UH60M",
			"LOP_PMC_MH9",
			"LOP_PMC_Truck",
			"O_Heli_Light_02_dynamicLoadout_F",
			"O_Heli_Light_02_unarmed_F"
		]

	]
];

MehlandTieredUnits set ["world_name", "Mehland"];
MehlandTieredUnits set ["infantry_tiers", MehlandInfantryTiers];
MehlandTieredUnits set ["vehicle_crew_tiers", MehlandVehicleCrewTiers];
MehlandTieredUnits set ["static_crew_tiers", MehlandStaticCrewTiers];
MehlandTieredUnits set ["vehicle_tiers", MehlandVehicleTiers];

tieredUnits set ["Mehland", MehlandTieredUnits];
