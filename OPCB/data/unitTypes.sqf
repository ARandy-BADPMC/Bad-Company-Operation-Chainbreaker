private _configParser = {
	params ["_configGroups"];
	_return = [];
	for "_i" from 1 to count _configGroups - 1 do { //always skip first item as it's the CfgGroups's Name
		_return pushBack (_configGroups select _i);
	};
	_return
};

switch (toLower worldName) do {
	
	// South america
	case "sara" : {

		OPCB_Commanders_Insurgents = ["LOP_SLA_Infantry_Officer"];

		OPCB_InfantryGroups_Insurgents = [configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Infantry"] call _configParser;

		OPCB_MechanizedGroups_Insurgents = [configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Motorized"] call _configParser;

		OPCB_ArmoredVehicles_Insurgents = [
			"LOP_RACS_T72BB",
			"LOP_RACS_T72BA"
		];

		OPCB_Artillery_Insurgents = ["LOP_SLA_BM21"];

		OPCB_TransportVehicles_Insurgents = [
			"LOP_RACS_Landrover",
			"LOP_RACS_Landrover_M2",
			"LOP_RACS_Truck",
			"LOP_RACS_Offroad",
			"LOP_RACS_M113_W",
			"LOP_RACS_Offroad_M2"
		]; 

		OPCB_StaticVehicles_Insurgents = [
			"LOP_RACS_Static_M2_MiniTripod",
			"LOP_RACS_Static_Mk19_TriPod",
			"LOP_RACS_Static_M2"
		];

		OPCB_TransportHelicopters_Insurgents = [
			"LOP_RACS_UH60M",
			"LOP_RACS_MH9"
		];

		OPCB_AttackHelicopters_Insurgents = [
			"LOP_RACS_MH9_armed"
		];

		OPCB_Commanders_OPFOR = ["LOP_SLA_Infantry_Officer"];

		OPCB_InfantryGroups_OPFOR = [configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Infantry"] call _configParser;

		OPCB_MechanizedGroups_OPFOR = [configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Mechanized"] call _configParser;

		OPCB_ArmoredVehicles_OPFOR = [
			"LOP_SLA_ZSU234",
			"LOP_SLA_BTR60",
			"LOP_SLA_BTR70",
			//"LOP_SLA_BM21", artillery
			"LOP_SLA_BMP1",
			"LOP_SLA_BMP1D",
			"LOP_SLA_BMP2",
			"LOP_SLA_BMP2D",
			"LOP_SLA_T72BA",
			"LOP_SLA_T72BB"
		];

		OPCB_Artillery_OPFOR = ["LOP_SLA_BM21"];

		OPCB_TransportVehicles_OPFOR = [
			"LOP_SLA_UAZ",
			"LOP_SLA_UAZ_AGS",
			"LOP_SLA_UAZ_DshKM",
			"LOP_SLA_UAZ_Open",
			"LOP_SLA_UAZ_SPG",
			"LOP_SLA_Ural",
			"LOP_SLA_Ural_open"
		]; 

		OPCB_StaticVehicles_OPFOR = [
			"LOP_SLA_Static_D30",
			"LOP_SLA_Static_AT4",
			"LOP_SLA_Igla_AA_pod",
			"LOP_SLA_AGS30_TriPod",
			"LOP_SLA_Static_DSHKM",
			"LOP_SLA_Kord",
			"LOP_SLA_Kord_High",
			"LOP_SLA_NSV_TriPod",
			"LOP_SLA_Static_SPG9",
			"LOP_SLA_ZU23"
		];

		OPCB_TransportHelicopters_OPFOR = [
			"LOP_SLA_Mi8MT_Cargo"
		];

		OPCB_AttackHelicopters_OPFOR = [
			"LOP_SLA_Mi8MTV3_FAB",
			"LOP_SLA_Mi8MTV3_UPK23"
		];



		//old code from here on
		
		
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
		
	};
	
	// Lythium Insurgents
	case "lythium" : {
		OPCB_Commanders_Insurgents = ["LOP_TKA_Infantry_Officer"];

		OPCB_InfantryGroups_Insurgents = [configfile >> "CfgGroups" >> "Indep" >> "LOP_AM_OPF" >> "Infantry"] call _configParser;

		OPCB_MechanizedGroups_Insurgents = [configfile >> "CfgGroups" >> "Indep" >> "LOP_AM_OPF" >> "Motorized"] call _configParser;

		OPCB_ArmoredVehicles_Insurgents = [
			"LOP_TKA_T34",
			"LOP_TKA_T55",
			"LOP_TKA_T72BA"
		];

		OPCB_Artillery_Insurgents = ["LOP_TKA_BM21"];

		OPCB_TransportVehicles_Insurgents = [
			"LOP_TKA_UAZ_AGS",
			"LOP_TKA_UAZ_DshKM",
			"LOP_TKA_UAZ_Open",
			"LOP_TKA_BMP2D",
			"LOP_AM_BTR60",
			"LOP_TKA_BMP1D",
			"LOP_TKA_UAZ_Open",
			"LOP_TKA_UAZ_SPG"
		]; 

		OPCB_StaticVehicles_Insurgents = [
			"LOP_AM_Static_SPG9",
			"LOP_AM_AGS30_TriPod",
			"LOP_AM_Kord_High",
			"LOP_AM_Igla_AA_pod"
		];

		OPCB_TransportHelicopters_Insurgents = [
			"LOP_TKA_Mi8MTV3_UPK23"
		];

		OPCB_AttackHelicopters_Insurgents = [
			"LOP_TKA_Mi24V_AT"
		];

		OPCB_Commanders_OPFOR = ["LOP_TKA_Infantry_Officer"];

		OPCB_InfantryGroups_OPFOR = [configfile >> "CfgGroups" >> "East" >> "LOP_TKA" >> "Infantry"] call _configParser;

		OPCB_MechanizedGroups_OPFOR = [configfile >> "CfgGroups" >> "East" >> "LOP_TKA" >> "Mechanized"] call _configParser;

		OPCB_ArmoredVehicles_OPFOR = [
			"LOP_TKA_ZSU234",
			"LOP_TKA_BTR60",
			"LOP_TKA_BTR70",
			"LOP_TKA_BMP1D",
			"LOP_TKA_BMP2D",
			"LOP_TKA_T34",
			"LOP_TKA_T55",
			"LOP_TKA_T72BB"
		];

		OPCB_Artillery_OPFOR = ["LOP_TKA_BM21"];

		OPCB_TransportVehicles_OPFOR = [
			"LOP_TKA_UAZ",
			"LOP_TKA_UAZ_AGS",
			"LOP_TKA_UAZ_DshKM",
			"LOP_TKA_UAZ_Open",
			"LOP_TKA_UAZ_SPG",
			"LOP_TKA_BTR60"
		]; 

		OPCB_StaticVehicles_OPFOR = [
			"LOP_TKA_Static_D30",
			"LOP_TKA_Static_AT4",
			"LOP_TKA_Igla_AA_pod",
			"LOP_TKA_AGS30_TriPod",
			"LOP_TKA_Static_DSHKM",
			"LOP_TKA_NSV_TriPod",
			"LOP_TKA_Static_SPG9",
			"LOP_TKA_ZU23"
		];

		OPCB_TransportHelicopters_OPFOR = [
			"LOP_TKA_Mi8MT_Cargo"
		];

		OPCB_AttackHelicopters_OPFOR = [
			"LOP_TKA_Mi24V_AT",
			"LOP_TKA_Mi8MTV3_UPK23"
		];



		//old code from here on
		
		
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
	
	
	};

		default {
		OPCB_Commanders_Insurgents = ["LOP_SLA_Infantry_Officer"];

		OPCB_InfantryGroups_Insurgents = [configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Infantry"] call _configParser;

		OPCB_MechanizedGroups_Insurgents = [configfile >> "CfgGroups" >> "Indep" >> "LOP_RACS" >> "Motorized"] call _configParser;

		OPCB_ArmoredVehicles_Insurgents = [
			"LOP_RACS_T72BB",
			"LOP_RACS_T72BA"
		];

		OPCB_Artillery_Insurgents = ["LOP_SLA_BM21"];

		OPCB_TransportVehicles_Insurgents = [
			"LOP_RACS_Landrover",
			"LOP_RACS_Landrover_M2",
			"LOP_RACS_Truck",
			"LOP_RACS_Offroad",
			"LOP_RACS_M113_W",
			"LOP_RACS_Offroad_M2"
		]; 

		OPCB_StaticVehicles_Insurgents = [
			"LOP_RACS_Static_M2_MiniTripod",
			"LOP_RACS_Static_Mk19_TriPod",
			"LOP_RACS_Static_M2"
		];

		OPCB_TransportHelicopters_Insurgents = [
			"LOP_RACS_UH60M",
			"LOP_RACS_MH9"
		];

		OPCB_AttackHelicopters_Insurgents = [
			"LOP_RACS_MH9_armed"
		];

		OPCB_Commanders_OPFOR = ["LOP_SLA_Infantry_Officer"];

		OPCB_InfantryGroups_OPFOR = [configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Infantry"] call _configParser;

		OPCB_MechanizedGroups_OPFOR = [configfile >> "CfgGroups" >> "East" >> "LOP_SLA" >> "Mechanized"] call _configParser;

		OPCB_ArmoredVehicles_OPFOR = [
			"LOP_SLA_ZSU234",
			"LOP_SLA_BTR60",
			"LOP_SLA_BTR70",
			//"LOP_SLA_BM21", artillery
			"LOP_SLA_BMP1",
			"LOP_SLA_BMP1D",
			"LOP_SLA_BMP2",
			"LOP_SLA_BMP2D",
			"LOP_SLA_T72BA",
			"LOP_SLA_T72BB"
		];

		OPCB_Artillery_OPFOR = ["LOP_SLA_BM21"];

		OPCB_TransportVehicles_OPFOR = [
			"LOP_SLA_UAZ",
			"LOP_SLA_UAZ_AGS",
			"LOP_SLA_UAZ_DshKM",
			"LOP_SLA_UAZ_Open",
			"LOP_SLA_UAZ_SPG",
			"LOP_SLA_Ural",
			"LOP_SLA_Ural_open"
		]; 

		OPCB_StaticVehicles_OPFOR = [
			"LOP_SLA_Static_D30",
			"LOP_SLA_Static_AT4",
			"LOP_SLA_Igla_AA_pod",
			"LOP_SLA_AGS30_TriPod",
			"LOP_SLA_Static_DSHKM",
			"LOP_SLA_Kord",
			"LOP_SLA_Kord_High",
			"LOP_SLA_NSV_TriPod",
			"LOP_SLA_Static_SPG9",
			"LOP_SLA_ZU23"
		];

		OPCB_TransportHelicopters_OPFOR = [
			"LOP_SLA_Mi8MT_Cargo"
		];

		OPCB_AttackHelicopters_OPFOR = [
			"LOP_SLA_Mi8MTV3_FAB",
			"LOP_SLA_Mi8MTV3_UPK23"
		];



		//old code from here on
		
		
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
	
	
	};
	
};