aiArray = [];
for "_i" from 1 to (maxAIPerPlayer*3) do {
	aiArray pushBack objNull;
};

aiMonitor = {
    private ["_ai","_gun","_ais","_guns","_gunner"];
    
  _ais  = nearestEastMen(getPos player,750,true,"array");
	_guns = nearestObjects[getPos player, eastStationaryGuns+eastVclClasses, 1200];
	_guns = _guns apply {_gunner = gunner _x; if (alive _gunner && {!isplayer _gunner} && {(lifeState _gunner) != "UNCONSCIOUS"}) then {_gunner} else {objNull}};
	_guns = _guns - [objNull];
	_ai   = objNull;
	_gun  = objNull;
	{
		if ((vehicle _x) == _x) exitWith {
			_ai = _x;
		}; 
	} foreach _ais;
	if (count _guns > 0) then { _gun = _guns select 0; };
	if (!isNull _gun) then {
		if (local _gun) then {
			[objNull,vehicle player,_gun] spawn aiMonitorRemote;
		} else {
			[objNull,vehicle player,_gun] remoteExec ["aiMonitorRemote",_gun,false];
		};
	};
	if (!isNull _ai) then {
		if (local _ai) then {
			[_ai,vehicle player,objNull] spawn aiMonitorRemote;
		} else {
			[_ai,vehicle player,objNull] remoteExec ["aiMonitorRemote",_ai,false];
		};		
	};
};

// findHousesFront; find enterable houses close to the player
findHousesFront = { 
	private ["_buildings","_minPositions","_enterables"];
    
	// find houses within a certain radius based on a position
	_buildings = nearestObjects [_this select 0, ["House"], _this select 1, true]; 
	// house should have _minPositions spawn points
	_minPositions = _this select 2; 
	_enterables = []; 	
	{ 
		//checking if enough spawn positions are found in the house ([0,0,0] returned means illegal position),
		//if it's a house from OA (optional through mapping defines), is not listed in 'ILLEGALHOUSES', is not damaged and player can see it
		if (
		((count (_x buildingPos -1)) >= _minPositions) && 
		//{EP1HOUSES} &&
		//{!(typeOf _x in ILLEGALHOUSES)} && 
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
	
	if (({alive _x} count aiArray) >= maxAIPerPlayer) exitWith { -1 };
	
	if (!alive _unit) exitWith { _i };
	
	[_squad, _i+1] call findSquadAIName;
	
}; 

#define findSquadAIName(X) ([X,0] call findSquadAIName)

#define exitCondition ((!alive player) || {findSquadAIName(player) == -1})

fillHouseEast = {

	private ["_pID","_pos","_posASL", "_magazine", "_weapon", "_intersections", "_manPackingRadius", "_numOfNearbyBuildings",	"_intersectionPosASL", "_isVisibleToPlayer", "_unit","_name","_class","_ai","_house","_cCount","_hID","_wUnits","_i","_group","_skill"];
	
	scopeName "fillHouseEastMain";
	
	_house	 = _this select 0;
	_wUnits  = _this select 1;
	
	_manPackingRadius = 20;
	_numOfNearbyBuildings = count (nearestObjects [_house, ["House"], 200, true]); 
	if (_numOfNearbyBuildings < 10) then {
		_manPackingRadius = 3;
	} else {
		if (_numOfNearbyBuildings < 50) then {
			_manPackingRadius = 10;
		};
	};
	
	// 0 based count of OPFOR infantry class members
	_cCount		= count eastInfClasses - 1;
	
	_wUnits = _wUnits apply {eyepos _x};
	
	{
		_pos = _x;		

		
		if (count nearestObjects[_pos, ["CAManBase"], _manPackingRadius] == 0) then {
		
			_name  = findSquadAIName(player);
			if (_name == -1) exitWith { breakTo "fillHouseEastMain"; };
			
			_isVisibleToPlayer = false;
			_posASL = AGLToASL _pos;
			
			{
			
				_intersections = lineIntersectsSurfaces [_posASL,_x];
				
				if ((count _intersections) == 0) exitWith {
					_isVisibleToPlayer = true;
				};
				
				_intersectionPosASL = (_intersections select 0) select 0;
				
				if ((_intersectionPosASL distance2D _x) < 20) exitWith {
					_isVisibleToPlayer = true;
				};
				
			} foreach _wUnits;
			
			if (!_isVisibleToPlayer) then {
			
				// if there are no appropriate AI units around,  prepare for spawning them
				if DEBUG then { server globalChat format["spawning %1", _name]; };
				
				_class = eastInfClasses select (random _cCount);
				_group  = [player, "EastAIGrp", "", "east"] call getGroup; // create an AI group
				_ai    = _group createUnit [_class, spawnPos, [], 0, "NONE"];
				
				// insurgent RPG-wielders!!!! :D								
				if (((secondaryWeapon _ai) != "") && {(random 1) < 0.3}) then {
					_ai spawn {
						_ai = _this;
						
						// need to wait for a long time to make sure all types of launchers are loaded, or magazine will be nil!
						sleep 30;
						if (!alive _ai) exitWith {};
						if ((count (secondaryWeaponMagazine _ai)) == 0) exitWith {};
											
						//remove all mags since otherwise they prefer to switch to grenades...
						_magazine = (secondaryWeaponMagazine _ai) select 0;
						_weapon = secondaryWeapon _ai;
						removeAllWeapons _ai;
						_ai addWeapon _weapon;
						_ai addSecondaryWeaponItem _magazine;
						_ai addMagazines [_magazine, 6];
						_ai selectWeapon _weapon;
						_ai addItem "ACE_bandage";
						_ai addItem "ACE_bandage";
						
					};				
				};

				
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
				//_ai addMagazine (IEDList select (random (count IEDList - 1)));
				//_ai addMagazine (IEDList select (random (count IEDList - 1)));
			
			};

		};
		
		sleep 0.5;
		
	} foreach (_house buildingPos -1);

}; 

aiSpawn = {   	
    private ["_inc","_hPos","_eCount","_wUnits","_wUnitVehicles","_wCount","_house","_clear","_gMkr","_houses","_hCount"];
    
    if exitCondition exitWith {}; // player dead or has no name for ai squad name generation, then exit
	_houses = [getPosATL player, SPAWNRANGE, 3] call findHousesFront; // find available houses for spawn posits
	_hCount = count _houses;
	if (_hCount == 0) exitWith {};	
	
	for "_j" from 0 to (count _houses - 1) do {				
		_house 	= _houses select _j; 
		_clear  = _house getVariable "cleared";
		_gMkr   = str(_house call getGridPos);
		if ((isNil "_clear") && {markerColor _gMkr == "ColorRed"}) then {  // make sure it's a red square
			_hPos   = getPosATL _house;	
			_eCount = count nearestObjects[_hPos, ["CAManBase"], 10];			
			// players need not to be within SPAWNRANGE-200 from a house or they need not to see the spawn position for its AI to spawn
			if (_eCount < maxAIPerPlayer) then {
				_wUnits = nearestPlayers(_hPos,SPAWNRANGE*2,true,"array");
				_wUnitVehicles = [];
				{
					_wUnitVehicles pushBackUnique (vehicle _x);
				} foreach _wUnits;
				[_house, _wUnitVehicles] call fillHouseEast;
				sleep 1;
			};
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