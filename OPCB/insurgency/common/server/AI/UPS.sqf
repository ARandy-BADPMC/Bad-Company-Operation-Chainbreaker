#include "..\defines.sqf"
#define startLocation       (markerpos "base_marker")
// =========================================================================================================
//  Urban Patrol Script  
//  Version: 2.1.0
//  Author: Kronzky (www.kronzky.info / kronzky@gmail.com)
//	Modified by pogoman for insurgency
// ---------------------------------------------------------------------------------------------------------
//  Required parameters:
//    unit          = Unit to patrol area (1st argument)
//    markername    = Name of marker that covers the active area. (2nd argument)
//    (e.g. nul=[this,"town"] execVM "ups.sqf")
//
//  Optional parameters: 
//    nomove        = Unit will stay at start position until enemy is spotted.
//    nofollow      = Unit will only follow an enemy within the marker area.
//    delete:n      = Delete dead units after 'n' seconds.
//    nowait        = Do not wait at patrol end points.
//    noslow        = Keep default behaviour of unit (don't change to "safe" and "limited").
//    noai          = Don't use enhanced AI for evasive and flanking maneuvers.
//    trigger       = Display a message when no more units are left in sector.
//    empty:n       = Consider area empty, even if 'n' units are left.
//    track         = Display a position and destination marker for each unit.
//
// =========================================================================================================

// how far opfors should move away if they're under attack
// set this to 200-300, when using the script in open areas (rural surroundings)
#define SAFEDIST 150

// how close unit has to be to target to generate a new one 
#define CLOSEENOUGH 100

// how close units have to be to each other to share information
#define SHAREDIST (worldSize/8)

// how long AI units should be in alert mode after initially spotting an enemy
#define ALERTTIME 300

private __CENTERPOS = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
__CENTERPOS set [2, 0];

#define DEFAULT_RANGEX (worldSize/2)
#define DEFAULT_RANGEY (worldSize/2)

nearestPlayers = {
	private ["_result","_pos","_range","_type","_alive"];
	_pos   = _this select 0;
	_range = _this select 1;
	_alive = _this select 2;
	_type  = _this select 3;
	if (_type == "count") then { _result = 0; } else { _result = []; };	
	{
		_plr = _x;
		if (!isNull _plr) then {
			if ((alive _plr || {!_alive}) && {((side _npc) knowsAbout _plr) > 0} && {(_plr distance startLocation) > 1500} && {(_plr distance _pos) < _range}) then { 
				if (_type == "count") then { _result = _result + 1; } else { _result = _result + [_plr]; };
			};
		};
	} forEach (call BIS_fnc_listPlayers);
	_result
};
	
#define nearestPlayers(W,X,Y,Z)	([W,X,Y,Z] call nearestPlayers)

// ---------------------------------------------------------------------------------------------------------
//echo format["[K] %1",_this]; 

// convert argument list to uppercase
_UCthis = []; 
for [{ _i=0},{ _i<count _this},{ _i=_i+1}] do { _e=_this select _i; if (typeName _e=="STRING") then { _e=toUpper(_e)}; _UCthis set [_i,_e]}; 

if ((count _this)<2) exitWith { 
	if (format["%1",_this]!="INIT") then { hint "UPS: Unit and marker name have to be defined!"}; 
}; 
_exit = false; 
_onroof = false; 

// ---------------------------------------------------------------------------------------------------------
KRON_UPS_Instances =	KRON_UPS_Instances + 1; 

// get name of area marker 
/*
_areamarker = _this select 1; 
if (isNil ("_areamarker")) exitWith { 
	hint "UPS: Area marker not defined.\n(Typo, or name not enclosed in quotation marks?)"; 
}; 	
*/

_centerpos = []; 
_centerX = []; 
_centerY = []; 
_rangeX = 0; 
_rangeY = 0; 
_areadir = 0; 
_areaname = ""; 
_areatrigger = objNull; 
_showmarker = "HIDEMARKER"; 
_mindist=500; 
_getAreaInfo = { 
	_obj = nearestPlayers(getPosATL _this,20000,true,"array");
	_centerpos = __CENTERPOS;
	_rangeX = DEFAULT_RANGEX; 
	_rangeY = DEFAULT_RANGEY; 
	if ((count _obj) > 0) then {
	
		// get closest player
		private _closestDist = 9999999;
		private _closestPlayer = _obj select 0;
		{
			private _thisDist = _this distance2D _x;
			if (_thisDist < _closestDist) then {
				_closestPlayer = _x;
				_closestDist = _thisDist;
			};
		} foreach _obj;
		
		_obj = _closestPlayer;
		_centerpos = getPos _obj;
		_areadir = (getDir _obj); 
		_rangeX = 1500; 
		_rangeY = 1500; 
	};
	_centerX = abs(_centerpos select 0); 
	_centerY = abs(_centerpos select 1); 
		
	_areaname = "DEFAULT"; 
};

// unit that's moving
_obj = _this select 0; 		
_npc = _obj; 
_npc call _getAreaInfo; 
// is anybody alive in the group?
_exit = true; 		
if (typename _npc=="OBJECT") then { 
	if (alive _npc) then { _exit = false; }		
} else { 
	if (count _npc>0) then { 
		{ if (alive _x) then { _npc = _x; _exit = false; }} forEach _npc; 
	}; 
}; 

// give this group a unique index
_grpidx = format["%1",KRON_UPS_Instances]; 
_grpname = format["%1_%2",(side _npc),_grpidx]; 

// remember the original group members, so we can later find a new leader, in case he dies
_members = units _npc; 
KRON_UPS_Total = KRON_UPS_Total + (count _members); 

// what type of "vehicle" is unit ?
_isman = _npc isKindOf "Man"; 
_isLandVehicle = _npc isKindOf "LandVehicle"; 
_isboat = _npc isKindOf "Ship"; 
_isair = _npc isKindOf "Air"; 

_vicHasNoGun = false;

if (_isLandVehicle) then {
	_npc setUnloadInCombat [true, true];
	if ((isNull (gunner _npc)) && {(_npc emptyPositions "Gunner") == 0}) then {
		_vicHasNoGun = true;
	};
} else {
	_npc setUnloadInCombat [false, false];
};

// check to see whether group is an enemy of the player (for attack and avoidance maneuvers)
// since countenemy doesn't count vehicles, and also only counts enemies if they're known, 
// we just have to brute-force it for now, and declare *everyone* an enemy who isn't a civilian
_issoldier = side _npc != civilian; 

_friends=[]; 
_enemies=[]; 	
_sharedenemy=0; 
//TODO: FIND A WAY TO DETERMINE ASSOCIATION OF RESISTANCE UNITS
if (_issoldier) then { 
	switch (side _npc) do { 
		case west:
			{ _friends=_friends+KRON_AllWest; _enemies=_enemies+KRON_AllEast+KRON_AllRes; _sharedenemy=0; }; 
		case east:
			{ _friends=_friends+KRON_AllEast; _enemies=_enemies+KRON_AllWest+KRON_AllRes; _sharedenemy=1; }; 
		case resistance:
			{ _enemies=_enemies+KRON_AllEast+KRON_AllWest; _sharedenemy=2; }; 
	}; 
	{ 
		_friends=_friends-[_x]; 
		_x disableAI "autotarget"; 
	} forEach _members; 
}; 

// global unit variable to externally influence script 
_named = false; 
_npcname = str(side _npc); 
if ("NAMED" in _UCthis) then { 
	_named = true; 
	_npcname = format["%1",_npc]; 
	_grpidx = _npcname; 
}; 
// create global variable for this group
call compile format ["KRON_UPS_%1=1",_npcname]; 

// store some trig calculations
_cosdir=cos(_areadir); 
_sindir=sin(_areadir); 

// minimum distance of new target position
if (_rangeX==0) exitWith { 
	hint format["UPS: Cannot patrol Sector: %1\nArea Marker doesn't exist",_areaname]; 
}; 

// remember the original mode & speed
_orgMode = behaviour _npc; 
_orgSpeed = speedmode _npc; 
_speedmode = _orgSpeed; 

// set first target to current position (so we'll generate a new one right away)
_currPos = getPosATL _npc; 
_orgPos = _currPos; 
_orgWatch=[_currPos,50,getDir _npc] call KRON_relPos; 
_orgDir = getDir _npc; 
_avoidPos = [0,0]; 
_flankPos = [0,0]; 
_attackPos = [0,0]; 

_dist = 0; 
_lastdist = 0; 
_lastmove1 = 0; 
_lastmove2 = 0; 
_maxmove=0; 
_moved=0; 

_damm=0; 
_dammchg=0; 
_lastdamm = 0; 
_curTimeontarget = 0; 

_fightmode = "walk"; 
_fm=0; 
_gothit = false; 
_hitPos=[0,0,0]; 
_react = 99; 
_lastdamage = 0; 
_lastknown = 0; 
_opfknowval = 0; 

_sin90=1; _cos90=0; 
_sin270=-1; _cos270=0; 

// set target tolerance high for choppers & planes
_closeenough=CLOSEENOUGH; 
if (_isair) then { _closeenough=2500}; 

// ***************************************** optional arguments *****************************************

// wait at patrol end points
_pause = if ("NOWAIT" in _UCthis) then { "NOWAIT"} else { "WAIT"}; 
// don't move until an enemy is spotted
_nomove  = if ("NOMOVE" in _UCthis) then { "NOMOVE"} else { "MOVE"}; 
// don't follow outside of marker area
_nofollow = if ("NOFOLLOW" in _UCthis) then { "NOFOLLOW"} else { "FOLLOW"}; 
// share enemy info 
_shareinfo = if ("NOSHARE" in _UCthis) then { "NOSHARE"} else { "SHARE"}; 
// "area cleared" trigger activator
_usetrigger = if ("TRIGGER" in _UCthis) then { "TRIGGER"} else { if ("NOTRIGGER" in _UCthis) then { "NOTRIGGER"} else { "SILENTTRIGGER"}}; 
// suppress fight behaviour
if ("NOAI" in _UCthis) then { _issoldier=false}; 
// adjust cycle delay 
_cycle = ["CYCLE:",5,_UCthis] call KRON_getArg; 
// drop units at random positions
_initpos = "ORIGINAL"; 
if ("RANDOM" in _UCthis) then { _initpos = "RANDOM"}; 
if ("RANDOMUP" in _UCthis) then { _initpos = "RANDOMUP"}; 
if ("RANDOMDN" in _UCthis) then { _initpos = "RANDOMDN"}; 
// don't position groups or vehicles on rooftops
if ((_initpos!="ORIGINAL") && ((!_isman) || (count _members)>1)) then { _initpos="RANDOMDN"}; 
// set behaviour modes (or not)
_noslow = if ("NOSLOW" in _UCthis) then { "NOSLOW"} else { "SLOW"}; 
if (_noslow!="NOSLOW") then { 
	_npc setbehaviour "safe"; 
	_npc setSpeedMode "limited"; 
	_speedmode = "limited"; 
}; 

// track unit
_track = 	if (("TRACK" in _UCthis) || KRON_UPS_Debug) then { "TRACK"} else { "NOTRACK"}; 
_trackername = ""; 
_destname = ""; 
if (_track=="TRACK") then { 
	_track = "TRACK"; 
	_trackername=format["trk_%1",_grpidx]; 
	_markerobj = createMarker[_trackername,[0,0]]; 
	_markerobj setMarkerShape "ICON"; 
	_markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Dot")) then { "WTF_DOT"} else { "DOT"}; 
	_trackername setMarkerType _markertype; 
	_markercolor = switch (side _npc) do { 
		case west: { "ColorGreen"}; 
		case east: { "ColorRed"}; 
		case resistance: { "ColorBlue"}; 
		default { "ColorBlack"}; 
	}; 
	_trackername setMarkerColor _markercolor; 
	_trackername setMarkerText format["%1",_grpidx]; 
	_trackername setmarkerpos _currPos; 
	_trackername setMarkerSize [.5,.5]; 
	
	_destname=format["dest_%1",_grpidx]; 
	_markerobj = createMarker[_destname,[0,0]]; 
	_markerobj setMarkerShape "ICON"; 
	_markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Flag")) then { "WTF_FLAG"} else { "FLAG"}; 
	_destname setMarkerType _markertype; 
	_destname setMarkerColor _markercolor; 
	_destname setMarkerText format["%1",_grpidx]; 
	_destname setMarkerSize [.5,.5]; 
}; 	

// delete dead units
_deletedead = ["DELETE:",0,_UCthis] call KRON_getArg; 
if (_deletedead>0) then { 
	{ _x addEventHandler['killed',format["[_this select 0,%1] spawn KRON_deleteDead",_deletedead]]}forEach _members; 
}; 

// init done
_makenewtarget=true; 
_newpos=false; 
_targetPos = _currPos; 
_swimming = false; 
_waiting = if (_nomove=="NOMOVE") then { 9999} else { 0}; 

// exit if something went wrong during initialization (or if unit is on roof)
if (_exit) exitWith { 
	if ((KRON_UPS_Debug) && !_onroof) then { hint "Initialization aborted"}; 
}; 

_vcl = vehicle _npc; 
_grp = group _npc; 
	
// ***********************************************************************************************************
// ************************************************ MAIN LOOP ************************************************
_loop=true; 
_currcycle=_cycle; 
_suppressTimer = 0;
while { _loop} do { 
	sleep .01; 
	// keep track of how long we've been moving towards a destination
	_curTimeontarget=_curTimeontarget+_currcycle; 
	_react=_react+_currcycle; 
		
	//Hunter: update enemies and point it to players 
	_enemies = nearestPlayers(getPosATL _npc,20000,true,"array");
	
	if ((count allplayers) == 0) then {
		{
			(vehicle _x) setpos [50000,50000,0];
			(vehicle _x) setDamage 1;
		} foreach _members;
	};
	
	// did anybody in the group got hit?
	_newdamage=0; 
	{ 
		if ((damage _x)>0.2) then { 
			_newdamage=_newdamage+(damage _x); 
			// damage has increased since last round
			if (_newdamage>_lastdamage) then { 
				_lastdamage=_newdamage; 
				_gothit=true; 
			}; 
			_hitPos= getPosATL _x; 
			if (!alive _x) then { 
				_members=_members-[_x]; 
				_friends=_friends-[_x]; 
			}; 			
		}; 
	} forEach _members; 
	sleep .01; 
	
	_suppressTimer = _suppressTimer + 1;
	if (_suppressTimer == 2) then {
		{
			_assTarget = assignedTarget _x;
			if (!isNull _assTarget)  then {
				_x doSuppressiveFire _assTarget;
			};
		} foreach _members;
		_suppressTimer = 0;
		sleep 3;
	};
	
	// nobody left alive, exit routine
	if (count _members==0) then { 
		_exit=true; 
		if (KRON_UPS_Debug) then { server globalChat format["UPS group %1 all dead or surrendered", _grpidx]; };
		//deleteGroup (group _npc);
		sleep (300+(random aiVehicleRespawnTime));
		(call compile _grpidx) call spawnAIVehicle;
	} else { 
		// did the leader die?
		if (!alive _npc) then { 
			_npc = _members select 0; 
			group _npc selectLeader _npc;
			_isman = _npc isKindOf "Man"; 
			_isLandVehicle = _npc isKindOf "LandVehicle"; 
			_isboat = _npc isKindOf "Ship"; 
			_isair = _npc isKindOf "Air"; 			
			if (isPlayer _npc) then { _exit=true}; 
		}; 
	}; 
	
	// current position
	_currPos = getPosATL _npc; _currX = _currPos select 0; _currY = _currPos select 1; 
	if (_track=="TRACK") then { _trackername setmarkerpos _currPos; }; 
	
	// if the AI is a civilian we don't have to bother checking for enemy encounters
	if ((_issoldier) && ((count _enemies)>0) && !(_exit)) then { 

		// if the leader comes across another unit that's either injured or dead, go into combat mode as well. 
		// If the other person is still alive, share enemy information.
		if ((_shareinfo=="SHARE") && (behaviour _npc=="SAFE")) then { 
			_others=_friends-_members; 
			{ 
				if ((!(isNull _x) && (_npc distance _x<SHAREDIST)) && ((damage _x>.5) || (behaviour _x in ["AWARE","COMBAT"]))) exitWith { 
					_npc setBehaviour "aware"; 
					_gothit=true; 
					if ((_hitPos select 0)==0) then { _hitPos = getPosATL _x}; 
					if (_npc knowsabout _x>3) then { 
						if (alive _x) then { _npc reveal (KRON_KnownEnemy select _sharedenemy)}; 
					}; 
				}; 
			}forEach _others; 
		}; 
		sleep .01; 
			
		// did the group spot an enemy?
		_lastknown=_opfknowval; 
		_opfknowval=0; 
		_maxknowledge=0; 
		{ 
			_knows=_npc knowsabout _x; 
			if ((alive _x) && (_knows>0.2) && (_knows>_maxknowledge)) then { 
				KRON_KnownEnemy set [_sharedenemy,_x]; 
				_opfknowval=_opfknowval+_knows; 
				_maxknowledge=_knows; 
			}; 
			if (!alive _x) then { _enemies=_enemies-[_x]}; 
			if (_maxknowledge==4) exitWith {}; 
		}forEach _enemies; 
		sleep .01; 
		
		_pursue=false; 
		_accuracy=100; 
		// opfor spotted an enemy or got shot, so start pursuit
		if (_opfknowval>_lastknown || _gothit) then {
			_npc setbehaviour "combat";
			_npc setcombatmode "RED";
			{
				_x enableAI "autotarget";
			} foreach _members;
                        
			if (_isLandVehicle) then {
				//unload passengers
				if (_vicHasNoGun) then {
					doGetOut driver _npc;
				};                           
				{
					if ((_x != driver _npc) && {_x != gunner _npc} && {_x != commander _npc}) then {
						doGetOut _x;
					};
				} forEach crew _npc;
			};
                        
			if (_isair) then {
				_paradroppers = [];
				{
					_role = assignedVehicleRole _x;
					if (((count _role) > 0) && {(_role select 0) == "Cargo"}) then {_paradroppers pushBack _x;};
				} forEach crew _npc;
				if ((count _paradroppers) > 0) then {
					[_npc,100,_paradroppers] spawn paraEject;
				};
			};
                        
			_pursue=true; 
			// make the exactness of the target dependent on the knowledge about the shooter
			_accuracy=21-(_maxknowledge*5); 
		}; 
		
		if (isNull (KRON_KnownEnemy select _sharedenemy)) then { 
			_pursue=false; 
		}; 

		// don't react to new fatalities if less than 60 seconds have passed since the last one
		if ((_react<60) && (_fightmode!="walk")) then { _pursue=false}; 

		if (_pursue) then	{ 
			// get position of spotted unit in player group, and watch that spot
			_offsx=_accuracy/2-random _accuracy; _offsY=_accuracy/2-random _accuracy; 
			_targetPos = getPosATL (KRON_KnownEnemy select _sharedenemy); 
			_targetPos = [(_targetPos select 0) + _offsX, (_targetPos select 1) + _offsY]; 
			_targetX = _targetPos select 0; _targetY = _targetPos select 1; 
			{ _x dowatch _targetPos} foreach units _npc; 
			sleep .01; 			

			// also go into "combat mode"
			_npc setSpeedMode "full"; 
			_speedmode = "full"; 
			_npc setbehaviour "combat";
			_npc setcombatmode "RED"; 
			{
				_x enableAI "autotarget";
			} foreach _members;
			_pause="NOWAIT"; 
			_waiting=0; 
			
			// angle from unit to target
			_dir1 = [_currPos,_targetPos] call KRON_getDirPos; 
			// angle from target to unit (reverse direction)
			_dir2 = (_dir1+180) mod 360; 
			// angle from fatality to target
			_dir3 = if (_hitPos select 0!=0) then { [_hitPos,_targetPos] call KRON_getDirPos} else { _dir1}; 
			_dd=(_dir1-_dir3); 
			
			// unit position offset straight towards target
			_relUX = sin(_dir1)*SAFEDIST; _relUY = cos(_dir1)*SAFEDIST; 
			// target position offset straight towards unit
			_relTX = sin(_dir2)*SAFEDIST; _relTY = cos(_dir2)*SAFEDIST; 
			// go either left or right (depending on location of fatality - or randomly if no fatality)
			_sinU=_sin90; _cosU=_cos90; _sinT=_sin270; _cosT=_cos270; 
			if ((_dd<0) || (_dd==0 && (random 1)>.5)) then { _sinU=_sin270; _cosU=_cos270; _sinT=_sin90; _cosT=_cos90}; 

			// avoidance position (right or left of unit)
			_avoidX = _currX + _cosU*_relUX - _sinU*_relUY; 
			_avoidY = _currY + _sinU*_relUX + _cosU*_relUY; 
			_avoidPos = [_avoidX,_avoidY]; 
			// flanking position (right or left of target)
			_flankX = _targetX + _cosT*_relTX - _sinT*_relTY; 
			_flankY = _targetY + _sinT*_relTX + _cosT*_relTY; 
			_flankPos = [_flankX,_flankY]; 
			// final target position
			_attackPos = _targetPos; 
			// for now we're stepping a bit to the side
			_targetPos = _avoidPos; 

			if (_nofollow=="NOFOLLOW") then { 
				_avoidPos = [_avoidPos,_centerpos,_rangeX,_rangeY,_areadir] call KRON_stayInside; 
				_flankPos = [_flankPos,_centerpos,_rangeX,_rangeY,_areadir] call KRON_stayInside; 
				_attackPos = [_attackPos,_centerpos,_rangeX,_rangeY,_areadir] call KRON_stayInside; 
				_targetPos = [_targetPos,_centerpos,_rangeX,_rangeY,_areadir] call KRON_stayInside; 
			}; 
			
			_react=0; 
			_fightmode="fight"; 
			_curTimeontarget=0; 
			_fm=1; 
			 if (KRON_UPS_Debug) then { 
				"dead" setmarkerpos _hitPos; "avoid" setmarkerpos _avoidPos; "flank" setmarkerpos _flankPos; "target" setmarkerpos _attackPos; 
			}; 
			_newpos=true; 
			// speed up the cycle duration after an incident
			if (_currcycle>=_cycle) then { _currcycle=1}; 
		}; 
	}; 
	sleep .01; 
	
	if !(_newpos) then { 
		// calculate new distance
		// if we're waiting at a waypoint, no calculating necessary
		if (_waiting<=0) then {
			// distance to target
			_dist = [_currPos,_targetPos] call KRON_distancePosSqr; 
			if (_lastdist==0) then { _lastdist=_dist}; 
			_moved = abs(_dist-_lastdist); 
			// adjust the target tolerance for fast moving vehicles
			if (_moved>_maxmove) then { _maxmove=_moved; if ((_maxmove/40) > _closeenough) then { _closeenough=_maxmove/40}}; 
			// how much did we move in the last three cycles?
			_totmove=_moved+_lastmove1+_lastmove2; 
			_damm = damage _npc; 
			// is our damage changing (increasing)?
			_dammchg = abs(_damm - _lastdamm); 
			
			// we're either close enough, seem to be stuck, or are getting damaged, so find a new target 
			if ((!_swimming) && ((_dist<=_closeenough) || (_totmove<.2) || (_dammchg>0.01) || (_curTimeontarget>ALERTTIME))) then {
			
				_makenewtarget=true; 
				// Hunter: try to get stuck ones moving again...
					if (_totmove<.2) then {
					{
						(vehicle _x) doMove _targetPos;
					} foreach (_members select {_x == (effectiveCommander vehicle _x)});
					sleep 60;
				};
			
			}; 

			// in 'attack (approach) mode', so follow the flanking path (don't make it too predictable though)
			if ((_fightmode!="walk") && (_dist<=_closeenough)) then { 
				if ((random 1)<.95) then { 
					if (_flankPos select 0!=0) then { 
						_targetPos=_flankPos; _flankPos=[0,0]; _makenewtarget=false; _newpos=true; 
						_fm=1; 
					} else { 
						if (_attackPos select 0!=0) then { 
							_targetPos=_attackPos; _attackPos=[0,0]; _makenewtarget=false; _newpos=true; 
							_fm=2; 
						}; 
					}; 
				}; 
			}; 
			sleep .01; 

			// make new target
			if (_makenewtarget) then { 
				if ((_nomove=="NOMOVE") && (_curTimeontarget>ALERTTIME)) then { 
					if (([_currPos,_orgPos] call KRON_distancePosSqr)<_closeenough) then { 
						_newpos = false; 
					} else { 
						_targetPos=_orgPos; 
					}; 
				} else {
					// re-read marker position/size
					_npc call _getAreaInfo; 
					// find a new target that's not too close to the current position
					_targetPos=_currPos; 
					_tries=0; 
					while { ((([_currPos,_targetPos] call KRON_distancePosSqr) < _mindist) || {surfaceIsWater _targetPos}) && (_tries<100)} do { 
						_tries=_tries+1; 
						// generate new target position (on the road)
						_targetPos=[_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
						_posX = _targetPos select 0;
						_posY = _targetPos select 1;
						if (isNil "_posX" || isNil "_posY") then { _targetPos = __CENTERPOS; };
						_roadlist = _targetPos nearRoads 200;
						if (count _roadlist>0) then { _targetPos = getPosATL (_roadlist select 0); };
						//_road=[_targetPos,(_isair||_isboat),_road] call KRON_OnRoad; 
						sleep .01; 			
					}; 
				}; 
				_avoidPos = [0,0]; _flankPos = [0,0]; _attackPos = [0,0]; 
				_gothit=false; 
				_hitPos=[0,0,0]; 
				_fm=0; 
				_npc setSpeedMode _orgSpeed; 
				_newpos=true; 
	
				// if we're waiting at patrol end points then don't create a new target right away. Keep cycling though to check for enemy encounters
				if ((_pause!="NOWAIT") && (_waiting<0)) then { _waiting = (15 + random 20)}; 
			}; 
		}; 
	}; 
	sleep .01; 

	// if in water, get right back out of it again
	if (surfaceIsWater _currPos) then { 
		if (_isman && !_swimming) then { 
			_drydist=999; 
			// look around, to find a dry spot
			for [{ _a=0}, { _a<=270}, { _a=_a+90}] do { 
				_dp=[_currPos,30,_a] call KRON_relPos; 
				if !(surfaceIsWater _dp) then { _targetPos=_dp}; 
			}; 
			_newpos=true; 
			_swimming=true; 
		}; 
	} else { 
		_swimming=false; 
	}; 
		
	_waiting = _waiting - _currcycle; 
	if ((_waiting<=0) && _newpos) then { 
		// tell unit about new target position
		if (_fightmode!="walk") then { 
			// reset patrol speed after following enemy for a while
			if (_curTimeontarget>ALERTTIME) then { 
				_fightmode="walk"; 
				_speedmode = _orgSpeed; 
				{ 
					_vcl = vehicle _npc; 
					if (_vcl != _npc && !(_x in _vcl)) then { _x moveInCargo _vcl; _x assignAsCargo _vcl; }; 
					_x setSpeedMode _speedmode; 
					_x setBehaviour _orgMode; 
					_x setCombatMode "YELLOW";
					{
						_x disableai "autotarget";
					} foreach _members;
				}forEach _members; 
			}; 
			// use individual doMoves if pursuing enemy, 
			// as otherwise the group breaks up too much
			{ _x doMove _targetPos}forEach _members; 
		} else { 
			(group _npc) move _targetPos; 
			(group _npc) setSpeedMode _speedmode; 
		}; 
		if (_track=="TRACK") then { 
			switch (_fm) do { 
				case 1: 
					{ _destname setmarkerSize [.4,.4]}; 
				case 2: 
					{ _destname setmarkerSize [.6,.6]}; 
				default
					{ _destname setmarkerSize [.5,.5]}; 
			}; 
			_destname setMarkerPos _targetPos; 
		}; 
		_dist=0; 
		_moved=0; 
		_lastmove1=10; 
		_waiting=-1; 
		_newpos=false; 
		_swimming=false; 
		_curTimeontarget = 0; 
	}; 

	// move on
	_lastdist = _dist; _lastmove2 = _lastmove1; _lastmove1 = _moved; _lastdamm = _damm; 

	// check external loop switch
	_cont = (call compile format ["KRON_UPS_%1",_npcname]); 
	if (_cont==0) then { _exit=true}; 

	_makenewtarget=false; 
	if ((_exit) || (isNil("_npc"))) then { 
		_loop=false; 
	} else { 
		// slowly increase the cycle duration after an incident
		if (_currcycle<_cycle) then { _currcycle=_currcycle+.5}; 
		sleep _currcycle; 
	}; 
}; 

if !(isNil("_npc")) then { 
	{ doStop _x; _x domove getPosATL _x; _x move getPosATL _x} forEach _members; 
}; 

KRON_UPS_Exited=KRON_UPS_Exited+1; 
if (_track=="TRACK") then { 
	_trackername setMarkerType "Dot"; 
	_destname setMarkerType "Empty"; 
}; 
_friends=nil; 
_enemies=nil; 