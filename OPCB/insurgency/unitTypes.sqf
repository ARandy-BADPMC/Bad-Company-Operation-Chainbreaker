switch (toLower worldName) do {
	
	// South america
	case "sara" : {
	
		eastInfClasses = [
			//"LOP_SLA_Infantry_AA"
			"LOP_SLA_Infantry_GL",
			"LOP_SLA_Infantry_Corpsman",
			"LOP_SLA_Infantry_AT",
			"LOP_SLA_Infantry_MG",
			"LOP_SLA_Infantry_Marksman",
			"LOP_SLA_Infantry_Rifleman",
			"LOP_SLA_Infantry_Rifleman_2"			
		];
		
		vclCrewClass = "LOP_SLA_Infantry_Rifleman_2";
		staticClass = "LOP_SLA_Infantry_Rifleman_2";
		
		eastVclClasses = [
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
			
		];
		
	};
	
	// Middle east, good ol' Takistan insurgency
	default {
	
		eastInfClasses = [
			"LOP_AM_OPF_Infantry_Rifleman_4",
			"LOP_AM_OPF_Infantry_Rifleman",
			"LOP_AM_OPF_Infantry_AR",
			"LOP_AM_OPF_Infantry_GL",
			"LOP_AM_OPF_Infantry_Corpsman",
			"LOP_AM_OPF_Infantry_Marksman",
			"LOP_AM_OPF_Infantry_Rifleman_5",
			"LOP_AM_OPF_Infantry_AT",
			"LOP_AM_OPF_Infantry_AR_Asst",
			"LOP_AM_OPF_Infantry_Rifleman_9",
			"LOP_AM_OPF_Infantry_Rifleman_2",
			"LOP_AM_OPF_Infantry_Rifleman_7",
			"LOP_AM_OPF_Infantry_SL"
		];
		
		vclCrewClass = "LOP_AM_OPF_Infantry_Rifleman_5";
		staticClass = "LOP_AM_OPF_Infantry_Rifleman_5";
		
		eastVclClasses = [
			"LOP_TKA_Mi24V_UPK23",
			"rhsgref_BRDM2_ins",
			"LOP_TKA_T34",
			"LOP_AM_OPF_Landrover_M2",
			"LOP_AM_OPF_Offroad_AT",
			"LOP_TKA_T55",
			"LOP_TKA_BTR70",
			"LOP_TKA_BTR60",
			"LOP_AM_OPF_Landrover_SPG9",
			"LOP_AM_OPF_Nissan_PKM",
			"LOP_AM_OPF_Offroad_M2",
			"LOP_AM_OPF_UAZ_AGS",
			"LOP_AM_OPF_UAZ_DshKM",
			"LOP_AM_OPF_UAZ_SPG",
			"LOP_TKA_BMP1",
			"LOP_TKA_BMP2",
			"LOP_TKA_Mi8MTV3_UPK23",
			"LOP_AM_OPF_Landrover",
			"LOP_AM_OPF_Offroad",
			"LOP_AM_OPF_UAZ",
			"LOP_AFR_OPF_M113_W",
			"LOP_AM_OPF_UAZ_Open",
			"C_Van_01_transport_F",
			"C_Quadbike_01_F",
			"rhsgref_ins_zil131_flatbed",
			"rhsgref_ins_zil131_flatbed_cover",
			"rhsgref_ins_ural_work",
			"rhsgref_ins_gaz66_repair",
			"rhsgref_ins_gaz66_ammo",
			"rhsgref_ins_ural_Zu23"
		];
	
	};
	
};
