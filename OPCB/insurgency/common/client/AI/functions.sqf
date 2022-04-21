aiArray = [];
for "_i" from 1 to 20 do {
	aiArray pushBack objNull;
};

aiMonitor = {
    private ["_ai","_gun","_ais","_guns","_gunner"];
    
    _ais  = nearestEastMen(getPosATL player,100,true,"array");
	_guns = nearestObjects[getPosATL player, eastStationaryGuns+eastVclClasses, 500];
	_guns = _guns apply {_gunner = gunner _x; if (alive _gunner && {!isplayer _gunner} && {(lifeState _gunner) != "UNCONSCIOUS"}) then {_gunner} else {objNull}};
	_guns = _guns - [objNull];
	_ai   = objNull;
	_gun  = objNull;
	if (count _ais > 0) then { if (vehicle (_ais select 0) == (_ais select 0)) exitWith { _ai = _ais select 0; }; };
	if (count _guns > 0) then { _gun = _guns select 0; };
	if (!isNull _gun) then {
		if (local _gun) then {
			[objNull,player,_gun] spawn aiMonitorRemote;
		} else {
			[objNull,player,_gun] remoteExec ["aiMonitorRemote",_gun,false];
		};
	};
	if (!isNull _ai) then {
		if (local _ai) then {
			[_ai,player,objNull] spawn aiMonitorRemote;
		} else {
			[_ai,player,objNull] remoteExec ["aiMonitorRemote",_ai,false];
		};		
	};
};

// findHousesFront; find enterable houses close to the player
findHousesFront = { 
	private ["_buildings","_minPositions","_enterables"];
    
	// find houses within a certain radius based on a position
	_buildings = nearestObjects [_this select 0, ["House"], _this select 1, true]; 
	// house should have _minPositions spawn points, 0 based
	_minPositions = (_this select 2) - 1; 
	_enterables = []; 	
	{ 
		//checking if enough spawn positions are found in the house ([0,0,0] returned means illegal position),
		//if it's a house from OA (optional through mapping defines), is not listed in 'ILLEGALHOUSES', is not damaged and player can see it
		if (
		(format["%1", _x buildingPos _minPositions] != "[0,0,0]") && 
		{EP1HOUSES} &&
		{!(typeOf _x in ILLEGALHOUSES)} && 
		{damage _x < 0.3} &&
		{canSee(player,_x,60)}
		) then { 
			_enterables pushBack _x; 
		}; 
	} forEach _buildings; 
	_enterables
}; 

// makes up the AI name based on player squad name plus a incrementing number and returns it
// each player has its "own" AI spawned, defined by the count defined in the mission params
// from 1 AI up to 20 AIs per player
findSquadAIName = {
	private ["_i","_squad","_str","_unit","_plrs","_pos","_arr"];
    _squad = _this select 0;
    _i     = _this select 1;  
  _unit = aiArray select _i;
	if !alive _unit exitWith { _i };
		_pos = getPosATL _unit;
		_plrs = nearestPlayers(_pos,SPAWNRANGE,true,"array");
	if ( 
	alive _unit &&
	{ (count _plrs == 0 || {!arrCanSee(_plrs,_unit,90,100)}) || {!(player in _plrs) && {!arrCanSee(_plrs,_unit,35,50)}} }
	) exitWith { _i };	
	if (({alive _x} count aiArray) >= maxAIPerPlayer) exitWith { -1 };  
	[_squad, _i+1] call findSquadAIName; 
}; 

#define findSquadAIName(X) ([X,0] call findSquadAIName)

#define exitCondition ((!alive player) || {findSquadAIName(player) == -1})

fillHouseEast = { 
	private ["_x","_process","_arr","_inc","_pID","_pos","_bool","_unit","_name","_class","_ai","_nPos","_house","_cCount","_hID","_wCount","_i","_group","_skill"];
	scopeName "fillHouseEastMain";
	
	_house	 = _this select 0;
	_wCount  = _this select 1;
	_inc	 = _this select 2;
	
	// when this is true, setVehicleInit is processed (i.e. AI is created)
	_process	= false;
	// number of spawn positions in a house
	_nPos		= nPos(_house);
	// 0 based count of OPFOR infantry class members
	_cCount		= count eastInfClasses - 1;
	// random spawn position
	_x			= round random (_nPos-1); 	
	// checks if the house is a valid house for AI spawns (if not it's -1)
	_hID		= CACHEHOUSEPOSITIONS find (typeOf _house);
	_arr		= [];
	if (_hID != -1 && {_wCount > 0}) then {
		_arr = CACHEHOUSEPOSITIONS select (_hID + 1);		
	};
	
	for [{ _i=_x},{ _i<((_nPos-1)+_x)},{ _i=_i+_inc}] do {  
		if ((_wCount > 0) && {_hID != -1} && {count _arr == 0}) exitWith {};	
		_pos   = _house buildingPos (_i % _nPos); 
		if (count _arr > 0) then {
			_pID = (_arr select 0);
			_pos = _house buildingPos _pID;
			_arr = _arr - [(_arr select 1)] - [_pID];
		};
		// create an AI at _pos if no other "Man" in radus of 3 meters of _pos
		if (count nearestObjects[_pos, ["Man"], 3] == 0) then {
			_name  = findSquadAIName(player);
			if (_name == -1) exitWith { breakTo "fillHouseEastMain"; };
			_unit = aiArray select _name;
			_bool = alive _unit;
			// when the AI unit (found by name) is alive, make sure it's healthy and, make it 
			// "look-alive" by issuing a move command
			if _bool exitWith {				
				_unit setPosATL _pos; 
				_unit setDamage 0;
				_unit doMove (getPosATL _unit);
				sleep 1;
				doStop _unit;
				if DEBUG then { server globalChat format["moving %1", _name]; };
			};
			// if there are no appropriate AI units around,  prepare for spawning them
			if DEBUG then { server globalChat format["spawning %1", _name]; };
			_class = eastInfClasses select (random _cCount);
			_group  = [player, "EastAIGrp", "", "east"] call getGroup; // create an AI group
			_ai    = _group createUnit [_class, spawnPos, [], 0, "NONE"];
			aiArray set [_name, _ai];
			// Hunter: prevent fall damage
			_ai addEventHandler ["HandleDamage",{
				_return = _this select 2;
				_source = _this select 3;
				_unit = _this select 0;		
				if (((_this select 4) == "") && {(isnull _source) || {((side _source) getFriend (side _unit)) >= 0.6}}) then {
					_return = 0;
				};
				_return 
			}];
			_ai setPosATL _pos;
			doStop _ai;
			_ai addMagazine (IEDList select (random (count IEDList - 1)));
			_ai addMagazine (IEDList select (random (count IEDList - 1)));
			_process = true;
		};
		sleep 0.5;
	};
	// spawns the AI prepared with 'setVehicleInit'
	//if _process then { processInitCommands; };
}; 

aiSpawn = {   	
    private ["_inc","_hPos","_eCount","_wUnits","_wCount","_house","_clear","_gMkr","_houses","_hCount"];
    
    if exitCondition exitWith {}; // player dead or has no name for ai squad name generation, then exit
	_houses = [getPosATL player, SPAWNRANGE, 3] call findHousesFront; // find available houses for spawn posits
	_hCount = count _houses;
	if (_hCount == 0) exitWith {};	
	_inc		= 6; 
	if (_hCount < 10) then { _inc = 3; };			
	for "_j" from 0 to (count _houses - 1) do {				
		_house 	= _houses select _j; 
		_clear  = _house getVariable "cleared";
		_gMkr   = str(_house call getGridPos);
		if ((isNil "_clear") && {markerColor _gMkr == "ColorRed"}) then {  // make sure it's a red square
			_hPos   = getPosATL _house;	
			_eCount = count nearestObjects[_hPos, ["Man"], 10];									
			_wUnits = nearestPlayers(_hPos,(SPAWNRANGE-400) max 300,true,"array"); 
			_wCount = count _wUnits;
			// players need not to be within SPAWNRANGE-200 from a house or they need not to see the spawn position for its AI to spawn
			if (_eCount == 0 && {_wCount == 0 || {!arrCanSee(_wUnits,_hPos,30,50)}}) then { [_house, _wCount, _inc] call fillHouseEast; };					
		};
		if exitCondition exitWith {};
	};
};

// this function has no purpose in 0.72 - I assume it was originally used for AIs bought by players and forgotten
/* groupAI = {
    private ["_unit","_waited"];
    
    scopeName "main";
	if (isDead(player) || lifeState player != "ALIVE" || vehicle player != player) exitWith {};
	if (nearestEastMen(getPosATL player,respawnRange,true,"count") > 0) exitWith {};
	if ((round (time*10)) % 50 != 0) exitWith {};
	{
		if !(isNil _x) then {
			_unit = call compile _x;
			if (isNull _unit) exitWith {};
			_waited = _unit getVariable "waited";
			if !(isDead(_unit) && alive _unit && local _unit) exitWith {
				if !(isNil "_waited") then { _unit setVariable ["waited", nil]; };
			};			
			if (isNil "_waited") exitWith { _unit setVariable ["waited", true]; breakTo "main"; };
			_unit setVariable ["waited", nil];
			_unit setPosATL getPosATL player;
			breakTo "main";
		};
	} forEach squadUnitStrings(squadString(player));
}; */