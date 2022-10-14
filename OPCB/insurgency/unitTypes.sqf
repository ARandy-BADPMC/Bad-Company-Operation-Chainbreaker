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
		
	};
	
	// Middle east, good ol' insurgency
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
	
	};
	
};
