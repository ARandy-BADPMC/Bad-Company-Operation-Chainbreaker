skinapplier = {
params ["_vehicle"];
_vehicleType = typeOf _vehicle;

switch _vehicleType do 
{
	//aircraft
	case "I_Plane_Fighter_04_F": 
		{
			[_vehicle,["CamoGrey",1],true] call BIS_fnc_initVehicle;
		};
	case "I_Heli_light_03_unarmed_F";
	case "I_Heli_light_03_dynamicLoadout_F": 
		{ 
			[_vehicle,["Green",1],true] call BIS_fnc_initVehicle;
		};
		
	case "O_Heli_Light_02_unarmed_F";
	case "rhs_ka60_c";
	case "rhs_ka60_grey";
	case "O_Heli_Light_02_dynamicLoadout_F": 
		{ 
			_vehicle setObjectTextureGlobal [0,"a3\air_f\heli_light_02\data\heli_light_02_ext_co.paa"];
		};
	case "O_Heli_Transport_04_ammo_F";
	case "O_Heli_Transport_04_bench_F";
	case "O_Heli_Transport_04_repair_F";
	case "O_Heli_Transport_04_F";
	case "O_Heli_Transport_04_medevac_F"; 
	case "O_Heli_Transport_04_fuel_F": 
	{
		[_vehicle,["Black",1], true] call BIS_fnc_initVehicle;
	};		
	//special
	case "B_T_APC_Wheeled_01_cannon_F";
	case "B_APC_Wheeled_01_cannon_F": 
		{
			[_vehicle,["Sand",1],["showBags",0,"showCamonetHull",1,"showCamonetTurret",1,"showSLATHull",0,"showSLATTurret",1]] call BIS_fnc_initVehicle; 
		};
	
	case "I_LT_01_AT_F";
	case "I_LT_01_AA_F";
	case "I_LT_01_cannon_F";
	case "I_LT_01_scout_F":
	{
		[_vehicle,["Indep_Olive",1],["showTools",0,"showCamonetHull",0,"showBags",0,"showSLATHull",0]] call BIS_fnc_initVehicle;

	};
	
	default {};
	};
if (_vehicle isKindOf "AIR") then 
	{
		_vehicle enableCopilot false;
	};

if (_vehicle iskindof "CAR") then {_vehicle setPlateNumber "Bad Co"; [_vehicle, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;};
	
};
