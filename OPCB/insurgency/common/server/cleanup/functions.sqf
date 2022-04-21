aiDespawn = {
	private ["_var","_plrs","_pos"];
	
	{
		if (((group _x) getVariable ["insAI", false]) && {!isPlayer _x} && {(typeof _x) in eastInfClasses}) then {
			if alive _x then {
				_pos = getpos _x;
				_plrs = playableUnits apply {if ((_x distance2D _pos) > (SPAWNRANGE+200)) then {objNull} else {_x}};
				_plrs = _plrs - [objNull];
				if (count _plrs == 0) then {
					deleteVehicle _x; 
				};
				sleep 0.3;	
			};			
		};
	} foreach (allunits - playableUnits);
};

quickCleanup = {
    private ["_wep","_cargoTypes"];
    
    if (time - _WCTime < 10) exitWith {};
	_WCTime = time;
	{
		if (nearestPlayers(getPosATL _x,WEP_DESPAWN_RANGE,true,"count") == 0 
		 && {nearestEastMen(getPosATL _x,WEP_DESPAWN_RANGE,true,"count") == 0}) then { 
			if (typeOf _x == "WeaponHolder") exitWith { deleteVehicle _x; };
			if (typeOf _x == "WeaponHolderSimulated") exitWith { deleteVehicle _x; };
			if ((_x isKindOf "StaticWeapon" || {typeOf _x == "CraterLong"} || {typeOf _x == "Crater"} || {typeOf _x == "CraterLong_02_base_F"}) && {nearestPlayers(getPosATL _x,SPAWNRANGE,true,"count") == 0}) exitWith { deleteVehicle _x; };
			if (!alive _x && {_x isKindOf "LandVehicle" || {_x isKindOf "Air"} || {_x isKindOf "Ship"}} && {nearestPlayers(getPosATL _x,SPAWNRANGE,false,"count") == 0}) exitWith { deleteVehicle _x; };
			private _locked = locked _x;
			if ((_locked == 2) || {_locked == 3}) exitWith {};
		};	
		sleep 0.005;				
	} forEach nearestObjects[CENTERPOS,["CraterLong","Crater","CraterLong_02_base_F","WeaponHolderSimulated","WeaponHolder","LandVehicle","Air","Ship"],AORADIUS];
};

longCleanup = {
    private ["_wUnits"];
    
    if (time - _BCTime < 600) exitWith {};
	_BCTime = time;
	/*
	{
		if (damage _x > 0.1 && damage _x < 1) then {
			_wUnits = nearestPlayers(getPosATL _x,SPAWNRANGE,true,"array");
			if (count _wUnits > 0 && arrCanSee(_wUnits,getPosATL _x,45,200)) exitWith {};
			_x setDamage 1;
			sleep 0.001;
		};
	} forEach nearestObjects[CENTERPOS,["House"],AORADIUS];
	*/
	{
		if ((alive _x) && {(count crew _x) == 0} && {nearestPlayers(getPosATL _x,SPAWNRANGE,true,"count") == 0}) then { deleteVehicle _x; };
		sleep 0.001;
	} forEach cleanupVics;
	cleanupVics = cleanupVics - [objNull];
	{
		if (nearestPlayers(getPosATL _x,SPAWNRANGE,true,"count") == 0) then { deleteVehicle _x; };
		sleep 0.001;
	} forEach allDead;
	{ if (count units _x == 0) then { deleteGroup _x; }; sleep 0.001; } forEach allGroups;
};