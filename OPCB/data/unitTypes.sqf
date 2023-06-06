switch (toLower worldName) do {
	
	// South america
	case "sara" : {
	
		// single unit types
		OPCB_unitTypes_inf_ins_TL = "LOP_SLA_Infantry_TL";
		
		OPCB_unitTypes_inf_ins_commander = "LOP_SLA_Infantry_Officer";
		OPCB_unitTypes_inf_commander = "LOP_RACS_Infantry_SL";
		
		
		// unit type arrays		
		OPCB_unitTypes_inf_ins = [
			"LOP_SLA_Infantry_AA",
			"LOP_SLA_Infantry_AT_Asst",
			"LOP_SLA_Infantry_Corpsman",
			"LOP_SLA_Infantry_Engineer",
			"LOP_SLA_Infantry_GL",
			"LOP_SLA_Infantry_AT",
			"LOP_SLA_Infantry_MG",
			"LOP_SLA_Infantry_MG_Asst",
			"LOP_SLA_Infantry_Marksman",
			"LOP_SLA_Infantry_Rifleman",
			"LOP_SLA_Infantry_Rifleman_2",
			"LOP_SLA_Infantry_SL",
			"LOP_SLA_Infantry_TL"
		];
		
		OPCB_unitTypes_inf = [
			"LOP_RACS_Infantry_Corpsman",
			"LOP_RACS_Infantry_Engineer",
			"LOP_RACS_Infantry_GL",
			"LOP_RACS_Infantry_GL_2",
			"LOP_RACS_Infantry_AT",
			"LOP_RACS_Infantry_AT_Asst",
			"LOP_RACS_Infantry_MG",
			"LOP_RACS_Infantry_MG_Asst",
			"LOP_RACS_Infantry_Marksman",
			"LOP_RACS_Infantry_Rifleman",
			"LOP_RACS_Infantry_Rifleman_2",
			"LOP_RACS_Infantry_Rifleman_3",
			"LOP_RACS_Infantry_SL",
			"LOP_RACS_Infantry_TL"
		];
		
		OPCB_unitTypes_veh_ins_armor = [
			"LOP_SLA_ZSU234",
			"LOP_SLA_T72BA",
			"LOP_SLA_T72BB"
		];
		
		OPCB_unitTypes_veh_armor = [
			"LOP_RACS_T72BA",
			"LOP_RACS_T72BB"
		];
		
		
		// groups: must all be array of configs!
		OPCB_unitTypes_grp_ins_inf = [
			(configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Infantry" >> "LOP_SLA_AA_section"),
			(configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Infantry" >> "LOP_SLA_AT_section"),
			(configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Infantry" >> "LOP_SLA_Rifle_squad"),
			(configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Infantry" >> "LOP_SLA_Support_section")
		];
		
		OPCB_unitTypes_grp_inf = [
			(configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Infantry" >> "LOP_RACS_AT_section"),
			(configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Infantry" >> "LOP_RACS_Rifle_squad"),
			(configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Infantry" >> "LOP_RACS_Support_section")
		];
				
		OPCB_unitTypes_grp_ins_mech = [
			(configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Mechanized" >> "LOP_SLA_Mech_squad_BMP1"),
			(configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Mechanized" >> "LOP_SLA_Mech_squad_BMP2")
		];
		
		// RACS doesn't actually seem to have proper mechanised groups...
		OPCB_unitTypes_grp_mech = [
			(configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Armored" >> "LOP_RACS_T72_Platoon"),
			(configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Motorized" >> "LOP_RACS_Motor_squad_LR")
		];
		
	};
	
	default {
	
	
	
	};
	
};