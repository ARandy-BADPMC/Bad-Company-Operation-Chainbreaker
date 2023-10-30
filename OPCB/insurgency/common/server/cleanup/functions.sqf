aiDespawn = {

	private ["_var","_plrs","_pos"];
	
	private _AIunits = (allunits - playableUnits) select {((group _x) getVariable ["insAI", false]) && {!isPlayer _x} && {(typeof _x) in eastInfClasses}};
	private _dude = objNull;
	private _nearDudes = 0;
	private _nearPlayers = 0;
	private _playerDist = SPAWNRANGE+200;
	private _nearPlayer = objNull;
	private _nearPlayersCount = 0;
	
	{
		if (!isNull _x) then {
			_dude = _x;
			_nearDudes = {(_x distance2D _dude) < 200} count _AIunits;
			_nearPlayers = playableUnits select {(_x distance2D _dude) < _playerDist};
			_nearPlayersCount = count _nearPlayers;
			if (_nearPlayersCount == 0) then {
				deleteVehicle _dude;
			} else {
				_nearPlayer = _nearPlayers select 0;
				if (_nearPlayersCount < (_nearDudes/(_nearPlayer call getEffectiveMaxAICount))) then {
					deleteVehicle _dude; 
				};
			};			
			sleep 0.3;
		};
	} foreach _AIunits;

};

quickCleanup = {
    private ["_wep","_cargoTypes"];
    
    if (time - _WCTime < 10) exitWith {};
	_WCTime = time;
	{
		if( _x getVariable ["disableInsurgencyCleanup", false] ) exitWith {}; //fuck insurgency cleanup
		if (nearestPlayers(getPosATL _x,WEP_DESPAWN_RANGE,true,"count") == 0 
		 && {nearestEastMen(getPosATL _x,WEP_DESPAWN_RANGE,true,"count") == 0}) then { 
			if (typeOf _x == "WeaponHolder") exitWith { deleteVehicle _x; };
			if (typeOf _x == "WeaponHolderSimulated") exitWith { deleteVehicle _x; };
			if ((typeOf _x == "CraterLong" || {typeOf _x == "Crater"} || {typeOf _x == "CraterLong_02_base_F"}) && {nearestPlayers(getPosATL _x,SPAWNRANGE,true,"count") == 0}) exitWith { 
				hint "deleted by insurgency";
				deleteVehicle _x;
				 };
			if (!alive _x && {_x isKindOf "LandVehicle" || {_x isKindOf "Air"} || {_x isKindOf "Ship"}} && {nearestPlayers(getPosATL _x,SPAWNRANGE,false,"count") == 0}) exitWith { 
				hint "deleted by insurgency";
				deleteVehicle _x;
				 };
			private _locked = locked _x;
			if ((_locked == 2) || {_locked == 3}) exitWith {};
		};	
		sleep 0.005;				
	} forEach nearestObjects[CENTERPOS,["CraterLong","Crater","CraterLong_02_base_F","WeaponHolderSimulated","WeaponHolder","LandVehicle","Air","Ship"],AORADIUS];
};