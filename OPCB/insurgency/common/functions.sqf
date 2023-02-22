// find all valid houses which offer a certain minimum count of positions
findHouses = { 
	private ["_buildings","_minPositions","_enterables","_alive"];
	_buildings = nearestObjects [_this select 0, ["House"], _this select 1, true]; 
	_minPositions = (_this select 2) - 1;
	_alive = _this select 3;
	
	_enterables = []; 	
	{ 
		if (
			((count (_x buildingPos -1)) >= _minPositions)
		&& {EP1HOUSES} 
		&& {(alive _x || {!_alive}) && {!(typeOf _x in ILLEGALHOUSES)} }
		) then { 
			_enterables pushBack _x; 
		}; 
	} forEach _buildings; 
	_enterables
}; 

setSurrendered = {
	if !isDedicated then {
		if (player distance _this <= 20) then { 
			private "_txt";
			switch (round random 1) do {
				case 0: {	_txt = "I Surrender!"; };
				case 1: {	_txt = "I give up!"; };
			};
			_this globalChat format["%1: %2", getText (configFile >> "CfgVehicles" >> typeOf _this >> "displayName"), _txt];
		};
	};	
	if isServer then {
		removeAllWeapons _this;
		_this setUnitPos "UP";
		_this disableAI "move";	
		_this playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
		_this disableAI "anim";	
	};	
};

get_Dir2 = {
    private ["_dirW","_dirS","_pos"];

    _dirW			= screenToWorld [0.5,0.5];
		_pos = getPosATL player;
	_dirS 		= ((_dirW select 0) - (_pos select 0)) atan2 ((_dirW select 1) - (_pos select 1));   
	((_dirS+360) % 360)
};

#define getDir2 (call get_Dir2)

nearest_Weapons = {	
	private ["_wep","_pos","_rds","_alive","_type","_result"];
	_wep   = _this select 0;
	_pos   = _this select 1;
	_rds   = _this select 2;
	_alive = _this select 3;
	_type  = _this select 4;
    
	if (_type == "count") then { _result = 0; } else { _result = []; };	
	{
		if (_x isKindOf "man" && {!alive _x || {_alive}}) then {
			if (_wep in weapons _x) then { 
				if (_type == "count") then { _result = _result + 1; } else { _result = _result + [_x]; }; 
			};
		} else {
			if (_wep in (getWeaponCargo _x select 0)) then { 
				if (_type == "count") then { _result = _result + 1; } else { _result = _result + [_x]; }; 
			};
		};
	} forEach nearestObjects[_pos,["weaponHolder","man","ReammoBox","AllVehicles"],_rds];
	_result
};

#define nearestWeapons(V,W,X,Y,Z)	([V,W,X,Y,Z] call nearest_Weapons)


nearest_Players = {
	private ["_result","_pos","_range","_type","_alive","_arr"];
	_pos   = _this select 0;
	_range = _this select 1;
	_alive = _this select 2;
	_type  = _this select 3;
	
	if (_type == "count") then { _result = 0; } else { _result = []; }; 
	{
		_plr = _x;
		if (!isNull _plr) then {
			if ((alive _plr || {!_alive}) && {(_plr distance _pos) <= _range}) then { 
				if (_type == "count") then { _result = _result + 1; } else { _result pushBack _plr; };
			};
		};
	} forEach (call BIS_fnc_listPlayers);
	_result
};
	
#define nearestPlayers(W,X,Y,Z)	([W,X,Y,Z] call nearest_Players)

nearest_EastMen = { 
	private ["_result","_arr","_alive","_type"];
	_arr  = (_this select 0) nearEntities [["LandVehicle","CAManBase"], _this select 1];
	_alive = _this select 2;
	_type  = _this select 3;
    
	if (_type == "count") then {	
		_result = 0; 
		{ 
			{ 
				if (((lifeState _x) != "INCAPACITATED") && {(typeOf _x) in eastInfClasses} ) then { 
					_result = _result + 1;
				};
			} forEach crew _x; 
		} foreach _arr;	
	} else {	
		_result = []; 
		{ 
			{ 
				if (((lifeState _x) != "INCAPACITATED") && {(typeOf _x) in eastInfClasses} ) then { 
					 _result pushBack _x;
				};
			} forEach crew _x; 
		} foreach _arr;	
	}; 	 
	_result
}; 

#define nearestEastMen(W,X,Y,Z)	([W,X,Y,Z] call nearest_EastMen)

getBearing = {
	private ["_dirTo","_unit","_obj","_uDir"];
    
    _unit  = _this select 0;
    _obj   = _this select 1;
	
    _dirTo = abs(getDirTo(_unit,_obj));
    _uDir  = getDir(vehicle _unit);	
	if (abs(_dirTo - _uDir) > 180) then { _dirTo = -1*(360 - _dirTo); };
	(_dirTo - _uDir)
};

// canSee; returns true if a _unit looks at the _obj within a certain _arc (field of view) in degrees
can_See = {
	private ["_unit","_obj","_dirTo","_uDir","_vcl","_arc"];
	_unit  = _this select 0;
	_obj   = _this select 1;
	_arc   = _this select 2;
	
	_dirTo = getDirTo(_unit,_obj); // vector from _unit to _obj
	_uDir  = getDir (vehicle _unit); // heading of _unit
	if (vehicle _unit != _unit) then {
		// if it's a vehicle and _unit is in a turret we take the heading of that turret
		_vcl = vehicle _unit;
		if (_vcl turretUnit [0] == _unit) then {
			_uDir = _vcl weaponDirection (_vcl weaponsTurret [0] select 0);
			_uDir = (_uDir select 0) atan2 (_uDir select 1);
		};
	};
	if (abs(_dirTo - _uDir) > 180) then { _uDir = -1*(360 - _uDir); };
	abs(_dirTo - _uDir) <= _arc

};
			
#define canSee(X,Y,Z) ([X,Y,Z] call can_See)

arr_CanSee = {
	private ["_arc","_pos","_arr","_rng","_canSee"];
	_arr = _this select 0;
	_pos = _this select 1;
	_arc = _this select 2;
	_rng = _this select 3;
    
	_canSee = false;
	{
		if (alive _x && {(lifeState _x) != "INCAPACITATED"} && {(_x distance _pos <= _rng) || {canSee(_x,_pos,_arc)}}) exitWith { _canSee = true; };
	} foreach _arr;
	_canSee
};

#define arrCanSee(W,X,Y,Z) ([W,X,Y,Z] call arr_CanSee)

canSee_Arr = {	
    private ["_canSee","_pos","_arr","_arc"];
    _pos = _this select 0;
	_arr = _this select 1;
	_arc = _this select 2;
    
	_canSee = true;
	{
		if !canSee(_pos,_x,_arc) exitWith { _canSee = false; };
	} foreach _arr;
	_canSee
};

#define canSeeArr(X,Y,Z) ([X,Y,Z] call canSee_Arr)

// create an AI group based on the supplied params and returns the concatenated name
// if the AI group already exists it only returns the name
getGroup = { 
    private ["_side","_prefix","_name","_suffix"];
    _prefix = _this select 0; 
    _name   = _this select 1; 
    _suffix = _this select 2; 
	_side   = _this select 3;
	
	if (typeName _prefix == "OBJECT") then {		
		_suffix = getPlayerUID _prefix;
		_prefix = "";
	};
	
	call compile format ["
		if isNil ""%1%2%3"" exitWith { %1%2%3 = createGroup %4; %1%2%3 setVariable [""insAI"", true, true]; %1%2%3 };
		if isNull %1%2%3 exitWith { %1%2%3 = createGroup %4; %1%2%3 setVariable [""insAI"", true, true]; %1%2%3 }; 
		%1%2%3
	", _prefix, _name, _suffix, _side]; 
}; 

countPositions = { 
	private ["_i","_house","_hPos"]; 
    _house = _this select 0; 
    _i 	 = _this select 1; 
    
	_hPos	 = format["%1", _house buildingPos _i]; 
	if (_hPos == "[0,0,0]") exitWith { _i; }; 
	[_house, _i+1] call countPositions; 
}; 

//#define nPos(X) ([X,0] call countPositions)
#define nPos(X) (count (X buildingPos -1))

getGridPos = { 		
    private ["_pos","_x","_y"];
    
 	_pos = getPosATL _this; 
 	_x = _pos select 0;
 	_y = _pos select 1;
 	_x = _x - (_x % 100); 
 	_y = _y - (_y % 100); 
	[_x + 50, _y + 50, 0]
}; 

getCaches = { 
	private ["_i","_arr","_str","_cache"]; 
    _arr 	= _this select 0; 
    _i	  = _this select 1; 
    
	if (_i >= cacheCount) exitWith { _arr; }; 
    _str   = format["cache%1", _i+1]; 		
    _cache = call compile _str; 
	if (!isNull _cache) then {
		if (alive _cache) then { _arr = _arr + [_cache]; }; 
	};
	[_arr, _i+1] call getCaches; 
}; 

#define cacheList    	  ([[],0] call getCaches)
	
getCache_Markers = { 
	private ["_i","_cache","_arr","_mkr"]; 
    _cache  = _this select 0; 
    _arr    = _this select 1; 
    _i 	  = _this select 2; 
    
	_mkr	 = format["%1intel%2", _cache, _i]; 
	if ((getMarkerPos _mkr select 0) == 0) exitWith { _arr; }; 
	_arr set [_i, _mkr]; 
	[_cache, _arr, _i+1] call getCacheMarkers; 
}; 

#define cacheMarkers(X) ([X,[],0] call getCache_Markers)

createDebugMarker = { 
    private ["_txt","_dir","_unit","_mkr"];
    _unit = _this select 0;
	
	if (isNil "_unit") exitWith { };   
	_mkr = createMarkerLocal["DEBUG" + str _unit, getPosATL _unit]; 
	_mkr setMarkerShapeLocal "ICON";
	_mkr setMarkerTypeLocal "mil_triangle"; 
	_mkr setMarkerSizeLocal [0.5,0.7];  
	_txt = str _unit;
	//if (typeName _txt == "OBJECT") then {_txt = getText (configFile >> "CfgVehicles" >> typeOf vehicle(_this select 1) >> "displayName"); };
	if (str _unit in eastPlayerStrings) then { _txt = name _unit; };
	_mkr setMarkerTextLocal _txt; 
	_mkr setMarkerColorLocal "ColorRed"; 
	_dir = getDir _unit;
	if (vehicle _unit != _unit) then { _dir = formationDirection _unit; };
	_mkr setMarkerDirLocal _dir;
	if (!alive _unit) then { _mkr setMarkerColorLocal "ColorBlack"; };
	[_mkr, _unit] spawn {
        private ["_mkr","_unit"];
        _mkr    = _this select 0;
        _unit   = _this select 1;
        
		while{!isNull _unit && {DEBUG}}do{ 
			_mkr setMarkerPosLocal getPosATL _unit; 
			_mkr setMarkerDirLocal getDir _unit;
			if !alive _unit then { _mkr setMarkerColorLocal "ColorBlack";	};
			sleep 0.1; 
		}; 
		if !DEBUG then { sleep 5; }; 
		deleteMarkerLocal _mkr;
	};
}; 

// solve issue with grids being too easy with very low player count
getEffectiveMaxAICount = {

	private _playerCnt = count allPlayers;

	if (_playerCnt < 5) then {
		if (_playerCnt < 4) then {
			if (_playerCnt < 3) then {
				if (_playerCnt < 2) then {
					maxAIPerPlayer*3
				} else {
					maxAIPerPlayer*2
				}				
			} else {
				round (maxAIPerPlayer*1.5)
			}			
		} else {
			round (maxAIPerPlayer*1.25)
		}
	} else {
		maxAIPerPlayer
	}

};