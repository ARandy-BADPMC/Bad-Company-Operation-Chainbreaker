spawnAIVehicle = {
	private ["_num","_track","_speed","_grp","_type","_obj","_mkr","_pos","_vcl","_ai","_unum"];
	_unum = _this;
	waitUntil {sleep 3; (count playableUnits) > 0};
	_num	= _unum % 3; 
	if (_num == 0) then { _num = 3; }; 
	//_grp	= ["","vclGrp",_unum+1,"east"] call getGroup; 
	_grp = createGroup east;
	_type = eastVehiclesFreq select round(random (count eastVehiclesFreq - 1)); 		
	_obj 	= call compile ("vclSpawn" + str(_num)); 
	_mkr 	= str _unum; 
	_pos 	= getPosATL _obj; 
	_vcl 	= createVehicle [_type, _pos, [], 0, "NONE"];
	_vcl setPosATL ((getPosATL _vcl) vectorAdd [0,0,1]);
	_vcl setVectorUp (surfaceNormal _pos);	
	// Hunter: anti-bad driving fix (does not cover flipping...)
	_vcl addEventHandler ["HandleDamage",{
		_return = _this select 2;
		_source = _this select 3;
		_unit = _this select 0;		
		if (((_this select 4) == "") && {(isnull _source) || {((side _source) getFriend (side _unit)) >= 0.6}}) then {
			_return = 0;
		};
		_return 
	}];
	
	if (DEBUG) then { server globalChat format["AI VEHICLE %1 of TYPE %2 CREATED! POSITION: %3", _unum, str _vcl, str _pos]; };
	_vcl setDir getDir _obj;
	
	_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
	_ai setRank (eastRanks select 2);
	_ai moveInDriver _vcl;
	
	if (typeOf _vcl in withPassenger) then {
				
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
		
		_vcl setUnloadInCombat [true,true];

	}; 
	
	{
		_ai = _grp createUnit [vclCrewClass, _pos, [], 100, "None"];
		_ai setRank (eastRanks select 0);
		_ai moveInTurret [_vcl, _x];
	} foreach allTurrets [_vcl, false];

	if !(typeOf _vcl in eastLightVehicles) then {
		_vcl lockDriver true;
		_vcl lockTurret [[0], true];
	};
	_speed = "slow"; 
	_track = ""; 
	if (DEBUG) then { _track = "track"; }; 
	if (typeOf _vcl in eastLightVehicles) then { _speed = "noslow"; }; 
	_grp deleteGroupWhenEmpty true;
	sleep 1;
	cleanupVics pushBack _vcl;
	[_vcl, _mkr, _speed, "nowait", _track] execVM "insurgency\common\server\AI\UPS.sqf";
};

spawnAIVehicles = { 
	private "_num";

	for "_i" from 1 to eastVehicleNum do { 		
		_i call spawnAIVehicle;
		if (DEBUG) then { server globalChat format ["SPAWNING AI VEHICLE %1", _i]; };
		sleep 240; 
	};
}; 	

spawnAIGuns = {

	params ["_gunsDistanceInBetween"];
	private ["_id","_gCount","_house","_houses","_bpos","_gunTypes"]; 
	
	_houses = [CENTERPOS,AORADIUS, 5, true] call findHouses; 	
	_gCount	= 0;
	
	while{ _gCount < maxStaticGuns && count _houses > 0} do { 
	
		_house = _houses select random(count _houses - 1);
		
		if ((_house distance startLocation > _gunsDistanceInBetween)
		&& {(count nearestObjects[getPosATL _house, eastStationaryGuns, staticWepDistances]) == 0}
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
				if ((lifeState _gunner) != "UNCONSCIOUS") then {
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
	if DEBUG then { [_house, _ai] call createDebugMarker; };  		
}; 