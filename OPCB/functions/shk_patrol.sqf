/*
  SHK_patrol

  Based on BIN_taskPatrol by Binesi
  
  Version 0.22
  Author: Shuko (shuko@quakenet, miika@miikajarvinen.fi)
  http://forums.bistudio.com/showthread.php?163496-SHK_Patrol

  Required Parameters:
    0 Object or Group     The patrolling unit
      
  Optional Parameters:
    1 Number              Distance from the unit's starting position to create waypoints. Default is 250.

  Usage:
    Start from group leader's init field or from init.sqf:
      nul = [params] execVM "shk_patrol.sqf";
      
    Examples:
      nul = this execVM "shk_patrol.sqf";
      nul = [this,350] execVM "shk_patrol.sqf";
      nul = [grpA,300] execVM "shk_patrol.sqf";
*/
DEBUG = false;

if !isserver exitwith {};

// Handle parameters
private ["_grp","_dst"];
_dst = 250;
switch (typename _this) do {
  case (typename grpNull): { _grp = _this };
  case (typename objNull): { _grp = group _this };
  case (typename []): {
    _grp = _this select 0;
    if (typename _grp == typename objNull) then {_grp = group _grp};
    if (count _this > 1) then {_dst = _this select 1};
  };
};

_grp setBehaviour "SAFE";
_grp setSpeedMode "LIMITED";
_grp setCombatMode "YELLOW";
_grp setFormation (selectRandom ["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"]);

private ["_cnt","_ang","_wps","_slack","_aos"];
_cnt = 4 + (floor random 3) + (floor (_dst / 100)); // number of waypoints
_ang = (360 / (_cnt - 1)); // split circle depending on number of waypoints
_wps = [];
_slack = _dst / 5.5;
if (_slack < 20) then {_slack = 20};
_aos = random 360;

// Find positions for waypoints
private ["_a","_p","_pos"];
_pos = getpos leader _grp;

while {count _wps < _cnt} do {
    _a = (count _wps * _ang) + _aos;

    _p = [((_pos select 0) - ((sin _a) * _dst)),
          ((_pos select 1) - ((cos _a) * _dst)),
          0];

    _wps set [count _wps, _p];
};

// Create waypoints
private ["_cur","_wp"];
for "_i" from 1 to (_cnt - 1) do {
    _cur = (_wps select _i);

    _wp = _grp addWaypoint [_cur, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointCompletionRadius (5 + _slack);
    [_grp,_i] setWaypointTimeout [0,2,16];
    
    // When completing waypoint have 33% chance to choose a random next wp
   // [_grp,_i] setWaypointStatements ["true", "if ((random 3) > 2) then { group this setCurrentWaypoint [(group this), (floor (random (count (waypoints (group this)))))];};"];
    
    if (DEBUG) then {
      private "_m";
      _m = createMarker [format["SHK_patrol_WP%1%2",(floor(_cur select 0)),(floor(_cur select 1))],_cur];
      _m setMarkerShape "Ellipse";
      _m setMarkerSize [20,20];
      _m setmarkerColor "ColorRed";
    };
};

// Cycle in case we reach the end
private "_wp1";
_wp1 = _grp addWaypoint [(_wps select 1), 0];
_wp1 setWaypointType "CYCLE";
_wp1 setWaypointCompletionRadius 50;

if (DEBUG) then {
    while {sleep 5; {alive _x} count (units _grp) > 0} do {
      private ["_m","_p"];
      _p = getpos leader _grp;
      _m = createMarker [format["SHK_patrol_%1%2%3",(floor(_p select 0)),(floor(_p select 1)),floor time],_p];
      _m setMarkerShape "Icon";
      _m setMarkerType "mil_dot";
      _m setmarkerColor "ColorBlue";
    };
};