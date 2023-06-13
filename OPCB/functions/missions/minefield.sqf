private _reward = 40;
params ["_current_tasknumber"];

_city = selectRandom Cities;
_citypos = locationPosition _city;

CityMarker setMarkerPos _citypos;
[_current_tasknumber ,west,["Enemy forces have strategically emplaced IEDs to impede our progress and endanger both our troops and the local community. The presence of these deadly devices necessitates immediate action to ensure the safe passage of our forces and protect innocent lives. The primary objective of this operation is to effectively clear the enemy-laid IEDs obstructing our advance and threatening the safety of our forces and the local population. By conducting thorough and cautious mine clearance operations, we will create safe paths, neutralize the enemy's asymmetric warfare tactics, and ensure the successful continuation of our mission."
,"Operation Safe Path",CityMarker],_citypos,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

_mines = [_citypos] call CHAB_fnc_minefield_spawn;
[_citypos,resistance] call CHAB_fnc_enemySpawner;

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