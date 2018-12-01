
_cities = missionNamespace getVariable["Cities",0];
_city = selectRandom _cities;
_citypos = locationPosition _city;

_citymarker = missionNamespace getVariable ["citymarker",_citypos];
_citymarker setMarkerPos _citypos;
[_current_tasknumber ,west,["Enemy forces laid mines to stop our advance against them. These mines are not just a threat to us, but also for the local population. Clear the minefields, but be careful, the enemy might be watching them.","Minefield",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;
_guardgroup = createGroup [resistance,true];
_guard = _guardgroup createUnit ["rhs_g_Soldier_TL_F", getMarkerPos _citymarker, [], 2, "NONE"];
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