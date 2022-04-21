//Original by Xeno, adapted to Ins by Kol9yN

private ["_vehicle","_menu_lift_shown","_nearest","_id","_pos","_npos"];

INS_COMMON_PATH = "common\Lift\";

HTextRed = {"<t color='#f0ff0000'>" + _this + "</t>"};
HTextBlue = {"<t color='#f00000ff'>" + _this + "</t>"};

_vehicles_lift_list = [];
_vehicles_nolift_list = []; // unfortunately, all kinds of "wheeled_apc" are of type "cars" as well

_advtype_lift1 = ["ATV_US_EP1","MMT_Civ","M1030_US_DES_EP1"]; 
_advtype_lift2 = ["ATV_US_EP1","MMT_Civ","hilux1_civil_3_open_EP1","M1030_US_DES_EP1","HMMWV_M2","HMMWV_MK19","HMMWV_Ambulance_DES_EP1","Lada2_TK_CIV_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","HMMWV_M1151_M2_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC","SUV_PMC_BAF","HMMWV_M998A2_SOV_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC"];
_advtype_lift3 = ["M1130_CV_EP1","ATV_US_EP1","MMT_Civ","hilux1_civil_3_open_EP1","M1030_US_DES_EP1","HMMWV_M2","HMMWV_MK19","HMMWV_Ambulance_DES_EP1","Lada2_TK_CIV_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","HMMWV_M1151_M2_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC","SUV_PMC_BAF","HMMWV_M998A2_SOV_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC"];
_advtype_lift4 = ["M1130_CV_EP1","hilux1_civil_3_open_EP1","HMMWV_M2","HMMWV_MK19","HMMWV_Ambulance_DES_EP1","Lada2_TK_CIV_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","HMMWV_M1151_M2_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC","SUV_PMC_BAF","HMMWV_M998A2_SOV_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC"];
_advtype_lift5 = ["ATV_US_EP1","MMT_Civ","hilux1_civil_3_open_EP1","M1030_US_DES_EP1","HMMWV_M2","HMMWV_MK19","HMMWV_Ambulance_DES_EP1","Lada2_TK_CIV_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","HMMWV_M1151_M2_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC","SUV_PMC_BAF","HMMWV_M998A2_SOV_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC"];
_advtype_lift6 = [];
_advtype_lift7 = ["ATV_US_EP1","MMT_Civ","hilux1_civil_3_open_EP1","M1030_US_DES_EP1","HMMWV_M2","HMMWV_MK19","HMMWV_Ambulance_DES_EP1","Lada2_TK_CIV_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","HMMWV_M1151_M2_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC","SUV_PMC_BAF","HMMWV_M998A2_SOV_DES_EP1","BAF_Jackal2_GMG_D","BAF_Jackal2_L2A1_D","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","BAF_Offroad_D","ArmoredSUV_PMC","SUV_PMC"];

if(INS_AdvanceType == 1)then{_vehicles_lift_list = _advtype_lift1; _vehicles_nolift_list = ["M1130_CV_EP1"];} else {

if(INS_AdvanceType == 2)then{_vehicles_lift_list = _advtype_lift2; _vehicles_nolift_list = ["M1130_CV_EP1"];} else {

if(INS_AdvanceType == 3)then{_vehicles_lift_list = _advtype_lift3;} else {

if(INS_AdvanceType == 4)then{_vehicles_lift_list = _advtype_lift4;} else {

if(INS_AdvanceType == 5)then{_vehicles_lift_list = _advtype_lift5; _vehicles_nolift_list = ["M1130_CV_EP1"];} else {

if(INS_AdvanceType == 6)then{_vehicles_lift_list = _advtype_lift6; _vehicles_nolift_list = ["M1130_CV_EP1"];} else {

_vehicles_lift_list = _advtype_lift7; _vehicles_nolift_list = ["M1130_CV_EP1"];

}}}}}};

if ( not local player) exitWith {};
_vehicle = _this select 0;

Vehicle_Attached = false;
Vehicle_Released = false;
_menu_lift_shown = false;
vehicle_attached_list = [];
_nearest = objNull;
_id = -1;

sleep 0.1;

WaitUntil{(alive _vehicle) && (alive player) && (driver _vehicle == player)};
while {(alive _vehicle) && (alive player) && (driver _vehicle == player)} do {
	if ((driver _vehicle) == player) then {
		_pos = getPos _vehicle;
		
		if (!Vehicle_Attached && (_pos select 2 > 2.5) && (_pos select 2 < 8)) then {
			_nearest = nearestObjects [_vehicle,["LandVehicle"],50];
			_nearest = if(count _nearest > 0) then {_nearest select 0} else {ObjNull};
			sleep 0.1;

			if (!(isNull _nearest) && {_nearest isKindOf _x} count _vehicles_lift_list > 0 && {_nearest isKindOf _x} count _vehicles_nolift_list == 0) then {
				_nearest_pos = getPos _nearest;
				_nx = _nearest_pos select 0;_ny = _nearest_pos select 1;_px = _pos select 0;_py = _pos select 1;
				if ((_px <= _nx + 6 && _px >= _nx - 6) && (_py <= _ny + 6 && _py >= _ny - 6)) then {
					if (!_menu_lift_shown) then {
						_id = _vehicle addAction ["Lift Vehicle" call HTextRed, (INS_COMMON_PATH+"heli_action.sqf")];
						_menu_lift_shown = true;
					};
				} else {
					_nearest = objNull;
					if (_menu_lift_shown) then {
						_vehicle removeAction _id;
						_menu_lift_shown = false;
					};
				};
			};
		} else {
			if (_menu_lift_shown) then {
				_vehicle removeAction _id;
				_menu_lift_shown = false;
			};
			
			sleep 0.1;
			
			if (isNull _nearest) then {
				Vehicle_Attached = false;
				Vehicle_Released = false;
			} else {
				if (Vehicle_Attached) then {
					_release_id = _vehicle addAction ["Drop Vehicle" call HTextBlue, (INS_COMMON_PATH+"heli_release.sqf")];
					vehicle_attached_list = vehicle_attached_list + [_nearest];

					_nearest attachTo [_vehicle,[-1,0,-8]];
					_nearest engineOn false;
					while {!Vehicle_Released && alive _vehicle && alive _nearest && alive player && (driver _vehicle == player)} do {sleep 1};
					detach _nearest;
					
					Vehicle_Attached = false;
					Vehicle_Released = false;
					
					vehicle_attached_list = vehicle_attached_list - [_nearest];
					
					if (!alive _vehicle) then {
						_vehicle removeAction _release_id;
					} else {
					};
					
					waitUntil {(getPos _nearest) select 2 < 10};
					
					_npos = getPos _nearest;
					_nearest setPos [_npos select 0, _npos select 1, 0];
					
					sleep 1.012;
				};
			};
		};
	};
	sleep 0.51;
};

if (!(alive _vehicle) || !(alive player)) then {
	_vehicle removeAction vec_id;
};

if (true) exitWith {};