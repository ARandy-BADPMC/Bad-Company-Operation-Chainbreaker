private _reward = 40;
params ["_current_tasknumber"];

_city = selectRandom Cities;
_citypos = locationPosition _city;

CityMarker setMarkerPos _citypos;
[_current_tasknumber ,west,["Enemy forces laid mines to stop our advance against them. These mines are not just a threat to us, but also for the local population. Clear the minefields, but be careful, the enemy might be watching them."
,"Minefield",CityMarker],_citypos,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

_guardgroup = createGroup [east,true];
_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_TL, _citypos, [], 2, "NONE"];
_guardpos = getPos _guard;
_mines = [_guard] call CHAB_fnc_minefield_spawn;
[_guard,6,0,2] call CHAB_fnc_spawn_ins;

deleteVehicle _guard;
{
  resistance revealMine _x;
  civilian revealMine _x;
  east revealMine _x;
} forEach _mines;

waitUntil {
	sleep 2;
	_mines findIf {alive _x } == -1
};

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
[_base] call CHAB_fnc_endmission;

[_mines] spawn {
  params ["_mines"];
  sleep 60;
  {
    deleteVehicle _x;
  } forEach _mines;
};