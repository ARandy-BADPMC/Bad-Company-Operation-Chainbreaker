spawnAIVehicle = {
	private ["_track","_speed","_grp","_type","_obj","_pos","_vcl","_ai"];
	waitUntil {
		sleep 3;
		((count playableUnits) > 1) || {!isMultiplayer}
	};
	
	waitUntil {
		sleep 1;
		({_logic = _x; (({(_logic distance _x) < 2200} count playableUnits) == 0)} count patrolSpawnPositionLogics) > 0
	};
	
	_obj = selectRandom (patrolSpawnPositionLogics select {_logic = _x; (({(_logic distance _x) < 2000} count playableUnits) == 0)});
	
	_grp = createGroup east;
	_type = selectRandom eastVclClasses; 		
	_pos 	= getPosATL _obj; 
	_vcl 	= createVehicle [_type, _pos, [], 0, "NONE"];
	_vcl setDir getDir _obj;
	_vcl setPosATL ((getPosATL _vcl) vectorAdd [0,0,1]);
	_vcl setVectorUp (surfaceNormal _pos);
	
	// Hunter: anti-bad driving fix (does not cover flipping...)
	_vcl spawn {
		sleep 5;
		 _this removeAllEventHandlers "HandleDamage";
		 _this addEventHandler ["HandleDamage",{
		 
			_return = _this select 2;
			_source = _this select 3;
			_unit = _this select 0;
			_ammo = _this select 4;
			_selection = _this select 1;
			
			if ((_ammo == "") && {(isnull _source) || {_source == _unit}}) then {
				if (_selection isEqualTo "") then {
					_return = damage _unit;
				} else {
					_return = _unit getHit _selection;
				};
			} else {
				if ((_unit getVariable ["ace_vehicle_damage_handleDamage", -99]) != -99) then {
					_return = _this call ace_vehicle_damage_fnc_handleDamage;
				};
			};
			
			_return
		}];
	};
	
	_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
	_ai setRank (eastRanks select 2);
	_ai moveInDriver _vcl;
	
	private _withPassengers = false;
	
	if (((_vcl emptyPositions "Gunner") == 0)
			|| {((count ((allTurrets [_vcl, true]) - (allTurrets [_vcl, false]))) + (_vcl emptyPositions "Cargo")) > 2}) then {	
		_withPassengers = true;	
	};
	
	if (_withPassengers) then {
				
		{
			_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
			_ai setRank (eastRanks select 4); 
			_ai moveInTurret [_vcl, _x];
		} foreach (allTurrets [_vcl, true]) - (allTurrets [_vcl, false]);
		
		sleep 0.1;
		_cargoSeats = _vcl emptyPositions "Cargo";
		if (_cargoSeats > 0) then {
			for "_i" from 1 to _cargoSeats do {
				_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];	
				_ai setRank (eastRanks select 4);
				_ai moveInCargo _vcl;
				sleep 0.05;
			};
		};

	}; 
	
	{
		_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
		_ai setRank (eastRanks select 0);
		_ai moveInTurret [_vcl, _x];
	} foreach allTurrets [_vcl, false];
	
	{
			_x spawn {
				sleep 2;
				_this removeAllEventHandlers "HandleDamage";
				_this addEventHandler ["HandleDamage", {
				
				_return = _this select 2;
				_source = _this select 3;
				_unit = _this select 0;
				_selection = _this select 1;
				
				if (((_this select 4) == "") && {(isnull _source) || {((side _source) getFriend (side _unit)) >= 0.6}}) then {
					if (_selection isEqualTo "") then {
						_return = damage _unit;
					} else {
						_return = _unit getHit _selection;
					};
				} else {
					if ((missionnamespace getVariable ["ace_medical_ai_enabledFor",0]) != 0) then {
						_return = _this call ace_medical_engine_fnc_handleDamage;
					};
				};
				
			_return 
			}];
		};	
	} foreach (units _grp);

	_track = ""; 
	if (DEBUG) then { _track = "track"; }; 
	_grp deleteGroupWhenEmpty true;
	sleep 1;
	cleanupVics pushBack _vcl;
	_vcl setVehicleLock "LOCKED";
	patrolVehicles pushBack _vcl;
	// 2nd argument (marker) is deprecated, just pass empty string
	[_vcl, "", "noslow", "nowait", _track] execVM "insurgency\common\server\AI\UPS.sqf";
};

patrolVehicles = [];

spawnAIVehicles = {

	while {true} do {
		waitUntil {
			sleep 10;
			patrolVehicles = patrolVehicles select {canMove _x};
			(count patrolVehicles) < eastVehicleNum
		};
		call spawnAIVehicle;
		sleep patrolSpawnDelay;
	};

}; 	

spawnAIGuns = {

	params ["_gunsDistanceInBetween"];
	private ["_id","_gCount","_house","_houses","_bpos","_gunTypes"]; 
	
	_houses = [CENTERPOS,AORADIUS, 5, true] call findHouses; 	
	_gCount	= 0;
	
	while{ _gCount < maxStaticGuns && count _houses > 0} do { 
	
		_house = _houses select random(count _houses - 1);
		
		if ((_house distance startLocation > gunDistanceFromStartLocation)
		&& {(count nearestObjects[getPosATL _house, eastStationaryGuns, _gunsDistanceInBetween]) == 0}
		// add an extra check for grid for better persistency (no guns on green grids)
		&& {private _mkr = str (_house call getGridPos);
				private _var = missionNamespace getVariable format["%1cleared", _mkr];
				isNil "_var"
			}
		) then {
		
			_bpos = [];
			_gunTypes = [];
			
			{		
				_bpos = AGLToASL _x;
				
				private _roofpos = _bpos vectorAdd [0,0,50];

				private _collisions = lineIntersectsSurfaces [_bpos,_roofpos];
				private _topCollision = false;

				if ((count _collisions) > 0) then {
					_topCollision = true;
				};
								
				private _sidePositions = [
					_bpos vectorAdd [50,0,0],
					_bpos vectorAdd [-50,0,0],
					_bpos vectorAdd [0,50,0],
					_bpos vectorAdd [0,-50,0]
				];
				
				private _collisionCount = 0;
				{
					_collisions = lineIntersectsSurfaces [_bpos,_x];
					if ((count _collisions) > 0) then {
						_collisionCount = _collisionCount + 1;
					};
				} foreach _sidePositions;
						
				if (_collisionCount < 3) then {
					if (!_topCollision) then {
						_bpos = _x;
						if ((_bpos select 2) > 1.6) then {
							_gunTypes = stationaryGunsHigh;
						} else {
							_gunTypes = stationaryGunsMed;
						};
					} else {
						_gunTypes = stationaryGunsMed;
						_bpos = _x;
					};
				};
							
				if ((count _gunTypes) > 0) exitWith {};
			
			} foreach (_house buildingPos -1);
			
			if ((count _gunTypes) > 0) then { 
				[_bpos, _house, selectRandom _gunTypes] call createRoofGun; 	
				_gCount = _gCount + 1; 
			}; 
			
		}; 
		
		_houses = _houses - [_house]; 	
		
	}; 
	
	_gCount
	
}; 

createRoofGun = { 	
	private ["_class","_pos","_housePositions","_id","_housePosition","_classId","_gun","_house","_dir","_grp","_gCount","_ai"]; 
	_pos		= _this select 0;
	_house	= _this select 1;
	_class = _this select 2;

	_gun = createVehicle [_class, spawnPos, [], 500, "None"]; 
	for "_j" from 0 to 10 do { _gun addMagazine (magazines _gun select 0); };	
	_dir = ((boundingCenter _house select 0) - (getPosATL _gun select 0)) atan2 ((boundingCenter _house select 1) - (getPosATL _gun select 1)); 
	_dir = (360 - _dir); 
	_dummy = "Land_Wrench_F" createVehicle _pos;
	_dummy setDir _dir;
	_dummy setPosATL (_pos vectorAdd [0,0,2]);
	uiSleep 3;
	//_dummypos = getPosATL _dummy;	
	//_dummy setPosATL (_dummypos vectorAdd [0,0,0.03]);
	_dummy setVectorUp [0,0,1];
	uisleep 3;
	_gun attachto [_dummy, [0,0,1.5]]; 		
	_dirOffset = -(getDir _dummy);
	private _maxAngle = getnumber (configfile >> "cfgvehicles" >> (typeof _gun) >> "Turrets" >> "MainTurret" >> "maxTurn");
	if (_maxAngle < 180) then {
		_maxAngle = (_maxAngle - 15) max 5;
		[_gun, _maxAngle, _dirOffset] spawn {
			params ["_gun", "_maxAngle","_dirOffset"];
			while {true} do {
				sleep 10;
				_gunner = gunner _gun;
				if (!alive _gunner) exitWith {};
				if ((lifeState _gunner) != "INCAPACITATED") then {
					_target = assignedTarget _gunner;
					if (!isnull _target) then {
						_bearing = ([_gun,_target] call BIS_fnc_dirTo) % 360;
						if ((abs ((getdir _gun) - _bearing)) > _maxAngle) then {
							_gun setDir (_dirOffset + _bearing);
						};
					};
				};
			};
		};
	};		
	
	_grp = createGroup east;
	_ai  = _grp createUnit [staticClass, spawnPos, [], 100, "NONE"];	
	_ai assignAsGunner _gun; 
	_ai moveInGunner _gun;	
	_grp setFormDir _dir;
	_grp deleteGroupWhenEmpty true;
	
	_gun enableWeaponDisassembly false;
	_gun setVariable ["ace_dragging_canDrag", false, true];
	_gun setVehicleLock "LOCKED";
	
	if DEBUG then { [_house, _ai] call createDebugMarker; };  		
}; 