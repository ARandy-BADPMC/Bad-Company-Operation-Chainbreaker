saraTieredUnits = createHashMap;
saraInfantryTiers = createHashMapFromArray [
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
			"LOP_RACS_Infantry_TL",
			"LOP_RACS_Infantry_SL",
			"LOP_RACS_Infantry_Rifleman_3",
			"LOP_RACS_Infantry_Rifleman_2",
			"LOP_RACS_Infantry_Rifleman",
			"LOP_RACS_Infantry_Corpsman"
		]
	],
	[
		5,
		[
			"LOP_RACS_Infantry_TL",
			"LOP_RACS_Infantry_SL",
			"LOP_RACS_Infantry_Rifleman_3",
			"LOP_RACS_Infantry_Rifleman_2",
			"LOP_RACS_Infantry_Rifleman",
			"LOP_RACS_Infantry_Marksman",
			"I_LOPRACS_Machinegunner_01",
			"I_LOPRACS_Anti_Tank_01",
			"LOP_RACS_Infantry_GL_2",
			"LOP_RACS_Infantry_GL",
			"LOP_RACS_Infantry_Corpsman"			
		]
	],
	[
		6,
		[
			"I_SahraniArmy_Teamleader_01",
			"I_SahraniArmy_Anti_Air_01",
			"I_SahraniArmy_AT_Assistent_01",
			"I_SahraniArmy_AT_Heavy_01",
			"I_SahraniArmy_AT_Light_01",
			"I_SahraniArmy_Engineer_01",
			"I_SahraniArmy_EOD_01",
			"I_SahraniArmy_Grenadier_01",
			"I_SahraniArmy_Machinegunner_01",
			"I_SahraniArmy_Marksman_01",
			"I_SahraniArmy_Medic_01",
			"I_SahraniArmy_Rifleman_1_01",
			"I_SahraniArmy_Rifleman_2_01"
		]
	]
];

saraVehicleCrewTiers = createHashMapFromArray [[1,"LOP_SLA_Infantry_Rifleman_2"], [2,"LOP_RACS_Infantry_Rifleman_2"]];
saraStaticCrewTiers = createHashMapFromArray [[1,"LOP_SLA_Infantry_Rifleman_2"], [2,"LOP_RACS_Infantry_Rifleman_2"]];

saraVehicleTiers = createHashMapFromArray [
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
		"rhsgref_cdf_Mi35"

	],
	[
		2, 
		"LOP_RACS_Landrover_M2",
		"LOP_RACS_Landrover",
		"LOP_RACS_M113_W",
		"LOP_IRAN_AH1Z_WD",
		"LOP_IRAN_CH47F",
		"LOP_RACS_UH60M",
		"rhsgref_cdf_t80bv_tv",
		"rhsusf_m1a1hc_wd",
		"I_C_Offroad_02_AT_F"
	]
];

saraTieredUnits set ["world_name", "sara"];
saraTieredUnits set ["infantry_tiers", saraInfantryTiers];
saraTieredUnits set ["vehicle_crew_tiers", saraVehicleCrewTiers];
saraTieredUnits set ["static_crew_tiers", saraStaticCrewTiers];
saraTieredUnits set ["vehicle_tiers", saraVehicleTiers];

tieredUnits set ["sara", saraTieredUnits];
