sara_dbe1TieredUnits = createHashMap;
sara_dbe1InfantryTiers = createHashMapFromArray [
	[
		1,
		[
			"LOP_SLA_Infantry_GL",
			"LOP_SLA_Infantry_Corpsman",
			"LOP_SLA_Infantry_MG",
			"LOP_SLA_Infantry_Rifleman",
			"LOP_SLA_Infantry_Rifleman_2"			
		]
		
	],
	[
		2,
		[
			"LOP_SLA_Infantry_AA",
			"LOP_SLA_Infantry_GL",
			"LOP_SLA_Infantry_Corpsman",
			"LOP_SLA_Infantry_AT",
			"LOP_SLA_Infantry_MG",
			"LOP_SLA_Infantry_Marksman",
			"LOP_SLA_Infantry_Rifleman",
			"LOP_SLA_Infantry_Rifleman_2"			
		]
	],
	[
		3,
		[
			"LOP_SLA_Infantry_AA",
			"LOP_SLA_Infantry_GL",
			"LOP_SLA_Infantry_Corpsman",
			"LOP_SLA_Infantry_AT",
			"LOP_SLA_Infantry_MG",
			"LOP_SLA_Infantry_Marksman",
			"LOP_SLA_Infantry_Rifleman",
			"LOP_SLA_Infantry_Rifleman_2"			
		]
	],
	[
		4,
		[
			"LOP_UA_Infantry_TL",
			"LOP_UA_Infantry_Rifleman",
			"LOP_UA_Infantry_Rifleman_2",
			"LOP_UA_Infantry_GL",
			"LOP_UA_Infantry_Corpsman",
			"LOP_UA_Infantry_Rifleman_3"
		]
	],
	[
		5,
		[
			"LOP_UA_Infantry_TL",
			"LOP_UA_Infantry_Rifleman",
			"LOP_UA_Infantry_Rifleman_2",
			"LOP_UA_Infantry_GL",
			"LOP_UA_Infantry_Corpsman",
			"LOP_UA_Infantry_Rifleman_3",
			"LOP_UA_Infantry_Marksman",
			"LOP_UA_Infantry_AT",
			"LOP_UA_Infantry_MG"
		]
	],
	[
		6,
		[
			"LOP_US_Infantry_Officer",
			"LOP_US_Infantry_TL",
			"LOP_US_Infantry_Rifleman",
			"LOP_US_Infantry_MG",
			"LOP_US_Infantry_Marksman",
			"LOP_US_Infantry_Corpsman",
			"LOP_US_Infantry_AT",
			"LOP_US_Infantry_GL_2",
			"LOP_US_Infantry_GL",
			"LOP_US_Infantry_AA"
		]
	]
];

sara_dbe1VehicleCrewTiers = createHashMapFromArray [[1,"LOP_SLA_Infantry_Rifleman_2"], [2,"LOP_UA_Infantry_Rifleman"]];
sara_dbe1StaticCrewTiers = createHashMapFromArray [[1,"LOP_SLA_Infantry_Rifleman_2"], [2,"LOP_UA_Infantry_Rifleman"]];

sara_dbe1VehicleTiers = createHashMapFromArray [
	[
		1,
		"LOP_SLA_BTR60",
		"LOP_SLA_BTR70",
		"LOP_SLA_ZSU234",
		"LOP_SLA_UAZ",
		"LOP_SLA_UAZ_AGS",
		"LOP_SLA_UAZ_DshKM",
		"LOP_SLA_UAZ_Open",
		"LOP_SLA_UAZ_SPG",
		"LOP_SLA_Mi8MT_Cargo",
		"LOP_SLA_Mi8MTV3_UPK23",
		"LOP_SLA_BMP1D",
		"LOP_SLA_BMP2D",
		"LOP_SLA_T72BA",
		"LOP_SLA_T72BB",
		"LOP_SLA_Ural",
		"LOP_SLA_Ural_open",
		"LOP_UKR_Mi24V_UPK23",
		//"LOP_UKR_Mi24V_FAB",
		//"LOP_SLA_Mi8MTV3_FAB",
		"rhsgref_cdf_Mi35",
		"rhs_btr80a_msv"

	],
	[
		2, 
		"LOP_US_T72BC",
		"LOP_US_BMP2D",
		"LOP_US_UAZ",
		"LOP_US_UAZ_AGS",
		"LOP_US_UAZ_DshKM",
		"LOP_US_UAZ_Open",
		"LOP_US_UAZ_SPG",
		"RHS_Ka52_vvsc",
		"LOP_SLA_Mi8MT_Cargo",
		"LOP_TKA_Mi24V_AT",
		"rhs_t80bv",
		"rhs_btr80a_msv"
	]
];

sara_dbe1TieredUnits set ["world_name", "sara_dbe1"];
sara_dbe1TieredUnits set ["infantry_tiers", sara_dbe1InfantryTiers];
sara_dbe1TieredUnits set ["vehicle_crew_tiers", sara_dbe1VehicleCrewTiers];
sara_dbe1TieredUnits set ["static_crew_tiers", sara_dbe1StaticCrewTiers];
sara_dbe1TieredUnits set ["vehicle_tiers", sara_dbe1VehicleTiers];

tieredUnits set ["sara_dbe1", sara_dbe1TieredUnits];
