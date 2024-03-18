aiArray = [];
for "_i" from 1 to (maxAIPerPlayer*4) do {
	aiArray pushBack objNull;
};

aiMonitor = {
    private ["_ai","_gun","_ais","_guns","_gunner"];
  
	_guns = nearestObjects[getPos player, eastStationaryGuns+eastVclClasses, 1200];
	_guns = _guns apply {_gunner = gunner _x; if (alive _gunner && {!isplayer _gunner} && {(lifeState _gunner) != "INCAPACITATED"}) then {_gunner} else {objNull}};
	_guns = _guns - [objNull];
	
	_gun  = objNull;
	if (count _guns > 0) then { _gun = _guns select 0; };
	if (!isNull _gun) then {
		if (local _gun) then {
			[objNull,vehicle player,_gun] spawn aiMonitorRemote;
		} else {
			[objNull,vehicle player,_gun] remoteExec ["aiMonitorRemote",_gun,false];
		};
	};
	
	_ais  = nearestEastMen(getPos player,750,true,"array");
	_ai   = objNull;
	{
		if (((vehicle _x) == _x) && {isNull (assignedTarget _x)} && {(speed _x) < 1}) exitWith {
			_ai = _x;
		}; 
	} foreach _ais;	
	
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
	private ["_buildings","_minPositions","_enterables", "_enterable"];
    
	// find houses within a certain radius based on a position
	_buildings = nearestObjects [_this select 0, ["House"], _this select 1, true]; 
	// house should have _minPositions spawn points
	_minPositions = _this select 2; 
	_enterables = []; 	
	{
		_enterable = _x;
		//checking if enough spawn positions are found in the house ([0,0,0] returned means illegal position),
		//if it's a house from OA (optional through mapping defines), is not listed in 'ILLEGALHOUSES', is not damaged and player can see it
		if (
			((count (_enterable buildingPos -1)) >= _minPositions) && 
			//{EP1HOUSES} &&
			//{!(typeOf _enterable in ILLEGALHOUSES)} && 
			{damage _enterable < 0.3} &&
			//{canSee(player,_enterable,60)} &&
			{({(_enterable distance2D _x) < ins_AIspawnMinRange} count playableUnits) == 0}
		) then { 
			_enterables pushBack _enterable; 
		}; 
	} forEach _buildings; 
	_enterables
}; 

// makes up the AI name based on player squad name plus a incrementing number and returns it
// each player has its "own" AI spawned, defined by the count defined in the mission params
// from 1 AI up to 20 AIs per player
findSquadAIName = {

	private ["_str","_unit","_plrs","_pos","_arr"];
	
	params ["_squad","_i"];

  _unit = aiArray select _i;
	
	if (({alive _x} count aiArray) >= (player call getEffectiveMaxAICount)) exitWith { -1 };
	
	if (!alive _unit) exitWith { _i };
	
	[_squad, _i+1] call findSquadAIName;
	
}; 

#define findSquadAIName(X) ([X,0] call findSquadAIName)

#define exitCondition ((!alive player) || {findSquadAIName(player) == -1})

fillHouseEast = {

	private ["_pID","_pos","_posASL", "_magazine", "_weapon", "_intersections", "_manPackingRadius", "_numOfNearbyBuildings",	"_intersectionPosASL", "_isVisibleToPlayer", "_unit","_name","_class","_ai","_hID","_i","_group","_skill"];
	
	scopeName "fillHouseEastMain";
	
	params ["_house","_wUnits"];
	
	_manPackingRadius = 10;
	_numOfNearbyBuildings = count (nearestObjects [_house, ["House"], 200, true]); 
	if (_numOfNearbyBuildings < 20) then {
		_manPackingRadius = 2.5;
	} else {
		if (_numOfNearbyBuildings < 50) then {
			_manPackingRadius = 5;
		};
	};
		
	_wUnits = _wUnits apply {eyepos _x};
	
	{
		_pos = _x;		
		
		if ((count (_pos nearEntities[["CAManBase"], _manPackingRadius])) == 0) then {
		
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
				
				if ((_intersectionPosASL distance _x) < 10) exitWith {
					_isVisibleToPlayer = true;
				};
				
			} foreach _wUnits;
			
			if (!_isVisibleToPlayer) then {
			
				// if there are no appropriate AI units around,  prepare for spawning them
				if DEBUG then { server globalChat format["spawning %1", _name]; };
				
				_class = selectRandom eastInfClasses;
				_group  = [player, "EastAIGrp", "", "east"] call getGroup; // create an AI group
				
				_group setBehaviour "COMBAT";
				_group setCombatMode "RED";
				
				_ai    = _group createUnit [_class, spawnPos, [], 1000, "NONE"];
				
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
						_ai setUnitPos "MIDDLE";
						_ai addWeapon _weapon;
						_ai addSecondaryWeaponItem _magazine;
						_ai addMagazines [_magazine, 6];
						_ai selectWeapon _weapon;
						_ai addItem "ACE_bandage";
						_ai addItem "ACE_bandage";
						
						private _target = objNull;
						
						while {alive _ai} do {
							waitUntil {
								sleep 2;
								if (isNull (assignedTarget _ai)) then {
									{
										_target = assignedTarget _x;
										if (!isNull _target) exitWith {
											_ai doTarget _target;
										};
									} foreach units _ai;
								};
								(!alive _ai) || {(!isNull (assignedTarget _ai)) && {(lifeState _ai) != "INCAPACITATED"}}
							};
							if (alive _ai) then {
								_ai doSuppressiveFire (assignedTarget _ai);
								sleep 10;
							};
						};
						
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
			_wUnits = nearestPlayers(_hPos,SPAWNRANGE*2,true,"array");
			_wUnitVehicles = [];
			{
				_wUnitVehicles pushBackUnique (vehicle _x);
			} foreach _wUnits;
			[_house, _wUnitVehicles] call fillHouseEast;
			sleep 1;
				
		};
		if exitCondition exitWith {};
	};
};