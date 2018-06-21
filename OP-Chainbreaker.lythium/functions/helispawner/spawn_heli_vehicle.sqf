
disableSerialization;
_loadouts = (findDisplay 9900) displayCtrl 1561;
_loadout = lbCurSel _loadouts;
if(_loadout != -1) then  
{	
	_vehiclelist = (findDisplay 9900) displayCtrl 1500;
	_heli = lbCurSel _vehiclelist;

	_vehicle = _vehiclelist lbData _heli;
	_loadout_type = _loadouts lbText _loadout;
	_index = Helicopter_loadouts find _vehicle;
	_loadoutska = Helicopter_loadouts select (_index +1); //array
	_pylons_number = _loadoutska find _loadout_type;

	_pylons = _loadoutska select (_pylons_number +1);

	_nObjects= nearestObjects [getPos heli_spawnpos, ["all"], 7];

	_maxAttackChoppers = missionNamespace getVariable ["MaxAttackHelis",0];
	_maxTransChoppers = missionNamespace getVariable ["MaxTransHelis",0];
	_attackType = ["RHS_UH60M_ESSS_d","RHS_MELB_AH6M","I_Heli_light_03_dynamicLoadout_F","RHS_UH1Y_d","B_Plane_Fighter_01_F","B_Plane_CAS_01_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","RHS_AH1Z","RHS_A10","RHS_AH64D","I_Plane_Fighter_04_F","O_Heli_Light_02_dynamicLoadout_F","B_UAV_02_dynamicLoadout_f"];

	if (count _nObjects == 1) then {

		if (_vehicle in _attackType) then 
		{
		  if (_maxAttackChoppers != 2) then
		  {
		  	_maxAttackChoppers = _maxattackchoppers + 1;
		  	missionNamespace setVariable ["MaxAttackHelis",_maxattackchoppers];
		    [_vehicle,_pylons,1] remoteExec ["CHAB_fnc_spawn_helicopter_server",2];

		  } else {hint "There are already 2 attack helicopters in game";};

		} else 
		{
		  if (_maxTransChoppers != 3) then
		  {
		  	_maxTransChoppers = _maxTransChoppers + 1;
		  	missionNamespace setVariable ["MaxTransHelis",_maxTransChoppers];
		    [_vehicle,_pylons,0] remoteExec ["CHAB_fnc_spawn_helicopter_server",2];

		  } else{hint "3 Transport helicopters are already in game.";};
		};

	  	
	} else {hint "Spawn position is not empty";};
}
else
{
	hint "Select a loadout first";
};
