
disableSerialization;
_tank = (findDisplay 9901) displayCtrl 1500;
_tankselect = lbCurSel _tank;
_tankpos = markerPos "tank_spawner";
if(_tankselect != -1) then  
{	
	_vehicle = _tank lbData _tankselect;

	_nObjects = nearestObjects [_tankpos, ["LandVehicle", "Thing", "Static", "Ship", "Air", "Man"], 7];

	//remoteExec ["CHAB_fnc_setServerVariables",2];
	_maxtanks = missionNamespace getVariable ["MaxTanks",1];
	_maxAPC = missionNamespace getVariable ["MaxAPC",1];
	_maxStatics = missionNamespace getVariable ["MaxStatic",1];

	_staticType = [
		"rhs_Metis_9k115_2_vmf",
		"rhs_Kornet_9M133_2_vmf",
		"RHS_Stinger_AA_pod_D",
		"RHS_M2StaticMG_D",
		"RHS_M2StaticMG_MiniTripod_D",
		"RHS_TOW_TriPod_D",
		"RHS_MK19_TriPod_D",
		"B_Mortar_01_F",
		"B_Static_Designator_01_F"
	];
	
	if (count _nObjects <= 1) then {

		if ((toUpper _vehicle) in OPCB_econ_vehicleGroundAttackTypes) then 
		{
		  if (_maxtanks == 0) then
		  {
			
				_tier = ["ENG", _vehicle] call OPCB_econ_fnc_getVehicleTier;
				_cost = ["ENG", _tier] call OPCB_econ_fnc_getTierCost;				
				// just in case
				if (_tier == -1) then {
					_tier = ["INF", _vehicle] call OPCB_econ_fnc_getVehicleTier;
					_cost = ["INF", _tier] call OPCB_econ_fnc_getTierCost;
				};
				
				if (OPCB_econ_credits < _cost) exitWith {
					hint "You don't have enough credits to buy this vehicle!";
				};
				
				OPCB_econ_credits = OPCB_econ_credits - _cost;
				publicVariable "OPCB_econ_credits";
				
				hint "Vehicle delivered";
			
		  	missionNamespace setVariable ["MaxTanks",_maxtanks + 1,true];
		    [_vehicle,1] remoteExec ["CHAB_fnc_spawn_tank_server",2];

		  } else {hint "There is already a tank/SPG in game";};

		} else 
		{
		
		if (_vehicle in _staticType) then 
		
		{
		  if (_maxStatics != 5) then 
		  {
			_maxStatics = _maxStatics + 1;
			missionNamespace setVariable ["MaxStatic",_maxStatics,true];
			[_vehicle,0] remoteExec ["CHAB_fnc_spawn_tank_server",2]; 
			
		  } else {hint "5 statics are already in game";};
		} else
		{
		  if (_maxAPC != 12) then
		  {	
				
				_tier = ["INF", _vehicle] call OPCB_econ_fnc_getVehicleTier;
				_cost = ["INF", _tier] call OPCB_econ_fnc_getTierCost;				
				// just in case
				if (_tier == -1) then {
					_tier = ["ENG", _vehicle] call OPCB_econ_fnc_getVehicleTier;
					_cost = ["ENG", _tier] call OPCB_econ_fnc_getTierCost;
				};
				
				if (OPCB_econ_credits < _cost) exitWith {
					hint "You don't have enough credits to buy this vehicle!";
				};
				
				OPCB_econ_credits = OPCB_econ_credits - _cost;
				publicVariable "OPCB_econ_credits";
				
				hint "Vehicle delivered";
			
		  	missionNamespace setVariable ["MaxAPC",_maxAPC + 1,true];
		    [_vehicle,0] remoteExec ["CHAB_fnc_spawn_tank_server",2];

		  } else{hint "12 vehicles are already in game. Recover or destroy existing ones.";};
		};
		};
	  	
	} else {hint "Spawn position is not empty";};
}
else
{
	hint "Select a vehicle first";
};
