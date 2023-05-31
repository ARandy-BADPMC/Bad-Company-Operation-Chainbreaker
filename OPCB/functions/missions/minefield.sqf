private _reward = 40;
_city = selectRandom Cities;
_citypos = locationPosition _city;

CityMarker setMarkerPos _citypos;
[_current_tasknumber ,west,["Enemy forces laid mines to stop our advance against them. These mines are not just a threat to us, but also for the local population. Clear the minefields, but be careful, the enemy might be watching them.","Minefield",CityMarker],getMarkerPos CityMarker,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;
_guardgroup = createGroup [east,true];
_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_TL, getMarkerPos CityMarker, [], 2, "NONE"];
_guardpos = getPos _guard;
_mines = [_guard] call CHAB_fnc_minefield_spawn;
[_guard,6,0,2] call CHAB_fnc_spawn_ins;
{
  resistance revealMine _x;
  civilian revealMine _x;
} forEach _mines;

waitUntil {
	_van = 1;
  	{
  	 	if ( alive _x ) exitWith { _van = 1;};
  	 	_van = 0;
  	} forEach _mines;

  _van == 0
};
deleteVehicle _guard;
[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
[_base] call CHAB_fnc_endmission;