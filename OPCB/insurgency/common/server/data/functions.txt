GUNROOFPOSITIONS retrieved using:
for "_h" from 0 to 1 step 0.1 do { if!([_checkPos, _dir, _h] call viewBlocked) exitWith { _class = _h; diag_log format["gunHouse %1, pos %2 verified", _i, _j]; }; };

arr = nearestObjects[player,["Land_dum_istan2b"],2000]
pos = (arr select 0) buildingPos 0; 
player setPosATL pos;
dir = (([0,0,0] select 0) - (pos select 0)) atan2 (([0,0,0] select 1) - (pos select 1)); hint str dir;
[pos, dir, 1] call viewBlocked;

 findHighPositions = { 
	private "_i"; 
	_house 		 = _this select 0; 
	_arr	     = _this select 1; 
	_i 		     = _this select 2; 
	_hPos	     = format["%1", _house buildingPos _i]; 
	if (_hPos == "[0,0,0]") exitWith { _arr}; 
	_hPos      = call compile _hPos; 
	if (_hPos select 2 > 2) then { _arr set [count _arr, _i]; }; 
	[_house, _arr, _i+1] call findHighPositions; 
}; 

#define highPosList(X) ([X,[],0] call findHighPositions)

posIsIndoors = { 	
	private "_i"; 
	_indoors = true; 
	_dir		 = getDir _house; 
	for "_i" from 0 to 360 step 90 do { 
		_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"]; 
		_bullet setPosATL [_checkPos select 0,_checkPos select 1,(_checkPos select 2) + 0.1]; 
		_bullet setVelocity [(sin (_i+_dir))*25,(cos (_i+_dir))*25,30]; 
		_d = 0; 
		waitUntil { if (getPosATL _bullet select 0 != 0) then { _d = getPosATL _bullet select 2; }; _d >= 10 || getPosATL _bullet select 0 == 0}; 		
		if (_d >= 10) then {
			_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"]; 
			_bullet setPosATL [_checkPos select 0,_checkPos select 1,(_checkPos select 2) + 0.3]; 
			_bullet setVelocity [(sin (_i+_dir))*25,(cos (_i+_dir))*25,0]; 
			_d = 0; 
			waitUntil { if (getPosATL _bullet select 0 != 0) then { _d = _bullet distance _checkPos; }; _d >= 4 || getPosATL _bullet select 0 == 0}; 		
			if (_d >= 4) then { _indoors = false; }; 						
		}; 		
		if (!_indoors) exitWith {}; 
	}; 
	_indoors
}; 

posIsOutdoors = { 
	private ["_i","_checkPos"]; 
	_checkPos = _this;
	
	_outdoors = true; 
	for "_i" from 0 to 360 step 90 do { 		
		_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"]; 
		_bullet setPosATL _checkPos; 
		_bullet setVelocity [(sin _i)*10,(cos _i)*10,30]; 
		_d = 0; 
		waitUntil { if (getPosATL _bullet select 0 != 0) then { _d = getPosATL _bullet select 2; }; _d >= 10 || getPosATL _bullet select 0 == 0}; 
		if (_d < 10) exitWith { _outdoors = false; }; 
	}; 
	_outdoors
}; 

viewBlocked = { 
	_pos = _this select 0; 
	_lvl = _this select 1; 
	blocked = 0; 
	for "_i" from 0 to 360 step 30 do { 
		_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"];
		_bullet setPosATL  [(_pos select 0), (_pos select 1), (_pos select 2)+_lvl]; // [(_pos select 0)-(sin _i)*2, (_pos select 1)-(sin _i)*2, (_pos select 2)+_lvl]; 
		_bullet setVelocity [(sin _i)*30, (cos _i)*30, 0]; 
		_d = 0; 
		player sideChat format["shooting bullet %1",_i];
		waitUntil { ((velocity(_bullet) distance [0,0,0]) < 0.1) };
		_d = _bullet distance _pos;
		player sideChat format["distance: %1",_d];	
		if (_d < 10) then { blocked = blocked + 1; }; 
	}; 
	player sideChat format["blocked %1",blocked];
	if (blocked <= 6) then { false } else { true }; 
}; 

gunPosits = {
	gunPositions = []; 
	_gunHouses = [CENTERPOS, AORADIUS, 4, true] call findHouses; 
	for "_i" from 0 to (count _gunHouses - 1) do { 
		_house 	     = _gunHouses select _i; 
		_type		 = typeOf _house; 
		_highPosList = highPosList(_house); 
		_arr		 = []; 
		if!(_type in gunPositions) then { 
			for "_j" from 0 to (count _highPosList - 1) do {
				diag_log format["examining view of gunHouse %1 with pos %2", _i, _j];
				_checkPos = _house buildingPos (_highPosList select _j); 
				if !([_checkPos, 1] call viewBlocked) then { 
					diag_log format["view of gunHouse %1 is free, verifying pos %2", _i, _j];
					_class = -1; 				
					for "_h" from 0 to 1 step 0.1 do { 
						if!([_checkPos, _h] call viewBlocked) exitWith { _class = _h; diag_log format["gunHouse %1, pos %2 verified", _i, _j]; }; 
					};
					_arr = _arr + [[(_highPosList select _j),_class]]; 
				}; 				
			}; 	
			if (count _arr > 0) then { gunPositions = gunPositions + [_type] + [_arr]; }; 
		}; 
		diag_log format["gunHouse %1 of %2 done", _i+1, count _gunHouses];
		copyToClipboard str gunPositions; 
	}; 
	/* for "_i" from 0 to (count GUNROOFPOSITIONS - 1) step 2 do { 
		_type = GUNROOFPOSITIONS select _i; 
		_arr  = GUNROOFPOSITIONS select (_i+1); 
		_hse  = nearestObjects[getPosATL player, [_type], 3000] select 0; 
		for "_j" from 0 to (count _arr - 1) do { 
			_arr2 = _arr select _j; 
			_id		= _arr2 select 0; 
			_h    = _arr2 select 1; 
		  player setPosATL (_hse buildingPos _id); 
		  player groupChat str _h; 
		  waitUntil { !wait}; wait=true; 
		}; 
	}; */
};

 cachePosits = {
	cachePositions = []; 
	_cacheHouses = [CENTERPOS, AORADIUS, 4, true] call findHouses; 
	for "_i" from 0 to (count _cacheHouses - 1) do { 
		_house 	     = _cacheHouses select _i; 
		_type		 = typeOf _house; 
		_nPos        = nPos(_house); 
		_highPosList = highPosList(_house); 
		_arr		 = []; 
		if !(_type in cachePositions || ((boundingBox _house select 1) select 2) > 15) then { 
			for "_j" from 0 to (count _highPosList - 1) do { 			
				_checkPos = _house buildingPos (_highPosList select _j); 	
				if (call posIsIndoors) then { _arr = _arr + [(_highPosList select _j)]; };							
			}; 
			if (count _arr <= 1) then { 
				for "_j" from 0 to (_nPos - 1) do { 	
					if!(_j in _highPosList) then { 
						_checkPos = _house buildingPos _j; 			
						if!(_j in _arr) then { 
							if (call posIsIndoors) then { _arr = _arr + [_j]; };	
						}; 					
					}; 
				}; 
			}; 
			if (count _arr > 0) then { cachePositions = cachePositions + [_type] + [_arr]; }; 
		}; 
		server globalChat format["cacheHouse %1 of %2 done", _i+1, count _cacheHouses]; 
		copyToClipboard str cachePositions; 	
	}; 
};


---------------------

gunPositions = []; 
_gunHouses = [getPosATL center, AORADIUS, 4, true] call findHouses; 
for "_i" from 0 to (count _gunHouses - 1) do { 
	_house 	     = _gunHouses select _i; 
	_type			   = typeOf _house; 
	_highPosList = highPosList(_house); 
	_arr			   = []; 
	if!(_type in gunPositions) then { 
		for "_j" from 0 to (count _highPosList - 1) do { 				
			_checkPos = _house buildingPos (_highPosList select _j); 
			_dir 		  = ((getPosATL startLocation select 0) - (_checkPos select 0)) atan2 ((getPosATL startLocation select 1) - (_checkPos select 1)); 
			if (call posIsOutdoors && !([_checkPos, _dir, 1] call viewBlocked)) then { 
				_class = -1; 				
				for "_h" from 0 to 1 step 0.1 do { 
					if!([_checkPos, _dir, _h] call viewBlocked) exitWith { _class = _h; }; 					
				}; 				
				_arr = _arr + [[(_highPosList select _j),_class]]; 
			}; 				
		}; 	
		if (count _arr > 0) then { gunPositions = gunPositions + [_type] + [_arr]; }; 
	}; 
	server globalChat format["gunHouse %1 of %2 done", _i+1, count _gunHouses]; 	
	copyToClipboard str gunPositions; 
}; 
for "_i" from 0 to (count GUNROOFPOSITIONS - 1) step 2 do { 
	_type = GUNROOFPOSITIONS select _i; 
	_arr  = GUNROOFPOSITIONS select (_i+1); 
	_hse  = nearestObjects[getPosATL player, [_type], 3000] select 0; 
	for "_j" from 0 to (count _arr - 1) do { 
		_arr2 = _arr select _j; 
		_id		= _arr2 select 0; 
		_h    = _arr2 select 1; 
	  player setPosATL (_hse buildingPos _id); 
	  player groupChat str _h; 
	  waitUntil { !wait}; wait=true; 
	}; 
}; 

cacheInsidePositions retrieved using:
cachePositions = []; 
_cacheHouses = [getPosATL center, AORADIUS, 4, true] call findHouses; 
for "_i" from 0 to (count _cacheHouses - 1) do { 
	_house 	     = _cacheHouses select _i; 
	_type			   = typeOf _house; 
	_nPos        = nPos(_house); 
	_highPosList = highPosList(_house); 
	_arr			   = []; 
	if!(_type in cachePositions || ((boundingBox _house select 1) select 2) > 15) then { 
		for "_j" from 0 to (count _highPosList - 1) do { 			
			_checkPos = _house buildingPos (_highPosList select _j); 	
			if (call posIsIndoors) then { _arr = _arr + [(_highPosList select _j)]; }; 							
		}; 
		if (count _arr <= 1) then { 
			for "_j" from 0 to (_nPos - 1) do { 	
				if!(_j in _highPosList) then { 
					_checkPos = _house buildingPos _j; 			
					if!(_j in _arr) then { 
						if (call posIsIndoors) then { _arr = _arr + [_j]; }; 		
					}; 					
				}; 
			}; 
		}; 
		if (count _arr > 0) then { cachePositions = cachePositions + [_type] + [_arr]; }; 
	}; 
	server globalChat format["cacheHouse %1 of %2 done", _i+1, count _cacheHouses]; 
	copyToClipboard str cachePositions; 	
}; 

some functions used:
findHighPositions = { 
	private "_i"; 
	_house 		 = _this select 0; 
	_arr	     = _this select 1; 
	_i 		     = _this select 2; 
	_hPos	     = format["%1", _house buildingPos _i]; 
	if (_hPos == "[0,0,0]") exitWith { _arr}; 
	_hPos      = call compile _hPos; 
	if (_hPos select 2 > 2) then { _arr set [count _arr, _i]; }; 
	[_house, _arr, _i+1] call findHighPositions; 
}; 

#define highPosList(X) ([X,[],0] call findHighPositions)

posIsIndoors = { 	
	private "_i"; 
	_indoors = true; 
	_dir		 = getDir _house; 
	for "_i" from 0 to 360 step 90 do { 
		_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"]; 
		_bullet setPosATL [_checkPos select 0,_checkPos select 1,(_checkPos select 2) + 0.1]; 
		_bullet setVelocity [(sin (_i+_dir))*25,(cos (_i+_dir))*25,30]; 
		_d = 0; 
		waitUntil { if (getPosATL _bullet select 0 != 0) then { _d = getPosATL _bullet select 2; }; _d >= 10 || getPosATL _bullet select 0 == 0}; 		
		if (_d >= 10) then { 
			_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"]; 
			_bullet setPosATL [_checkPos select 0,_checkPos select 1,(_checkPos select 2) + 0.3]; 
			_bullet setVelocity [(sin (_i+_dir))*25,(cos (_i+_dir))*25,0]; 
			_d = 0; 
			waitUntil { if (getPosATL _bullet select 0 != 0) then { _d = _bullet distance _checkPos; }; _d >= 4 || getPosATL _bullet select 0 == 0}; 		
			if (_d >= 4) then { _indoors = false; }; 						
		}; 		
		if (!_indoors) exitWith {}; 
	}; 
	_indoors
}; 

posIsOutdoors = { 
	private "_i"; 
	_outdoors = true; 
	for "_i" from 0 to 360 step 90 do { 		
		_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"]; 
		_bullet setPosATL _checkPos; 
		_bullet setVelocity [(sin _i)*10,(cos _i)*10,30]; 
		_d = 0; 
		waitUntil { if (getPosATL _bullet select 0 != 0) then { _d = getPosATL _bullet select 2; }; _d >= 10 || getPosATL _bullet select 0 == 0}; 
		if (_d < 10) exitWith { _outdoors = false; }; 
	}; 
	_outdoors
}; 

viewBlocked = { 
	_pos = _this select 0; 
	_dir = _this select 1; 
	_lvl = _this select 2; 
	blocked = 0; 
	for "_i" from (_dir - 22.5) to (_dir + 22.5) step 22.5 do { 
		_bullet = createVehicle ["B_9x18_Ball", [0,0,100], [], 0, "NONE"]; 
		_bullet setPosATL [(_pos select 0)-(sin _i)*2, (_pos select 1)-(sin _i)*2, (_pos select 2)+_lvl]; 
		_bullet setVelocity [(sin _i)*30, (cos _i)*30, 0]; 
		_d = 0; 
		waitUntil { if (getPosATL _bullet select 0 > 0) then { _d = _bullet distance _pos; }; _d >= 10 || isNull _bullet }; 
		if (_d < 10) then { blocked = blocked + 1; }; 
	}; 
	if (blocked <= 1) then { false} else { true}; 
}; 