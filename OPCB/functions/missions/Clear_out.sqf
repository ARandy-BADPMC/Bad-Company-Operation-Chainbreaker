private _reward = 40;
params ["_current_tasknumber"];

_journalistCount = selectRandom [1,2]; 

_city = selectRandom Cities;
_citypos = locationPosition _city;

CityMarker setMarkerPos _citypos;

_msg = format ["There is a riot going on. Clear out the area and capture the leader. We also have intel of %1 captured journalists, which need to be rescued.",_journalistCount];

[_current_tasknumber ,west,[_msg,"Clear out and rescue",CityMarker],_citypos,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_guardgroup = createGroup [east,true];
_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_TL, _citypos, [], 2, "NONE"];
removeAllWeapons _guard;
_guard disableAI "AUTOCOMBAT";
_guard setunitpos "MIDDLE";
_rescuegroup = createGroup [civilian,true];

_houses = nearestObjects [_citypos, ["house"], 400];

_missionObjectives = [_guard];

for "_i" from 0 to _journalistCount -1 do { 
  _house = selectRandom _houses;
  _position = _house buildingPos -1;
  while {count _position == 0} do {
    _house = selectRandom _houses;
    _position = _house buildingPos -1;
  };
  _posmax = count _position;
  _journal = _rescuegroup createUnit ["C_journalist_F", _citypos, [], 2, "NONE"];
  _journal setPosATL (_house buildingpos (_posmax -1)); 
  [_journal, true] call ACE_captives_fnc_setSurrendered;
  _missionObjectives pushBack _journal;
};

[_guard] call CHAB_fnc_spawn_city_ins;

[_guard,10,1,1] call CHAB_fnc_spawn_ins;

[] call CHAB_fnc_enemycount;

waitUntil {
  sleep 2;
  _missionObjectives findIf {!alive _x} != -1 || { { _x distance (getPos dropoffpoint) < 10 } count _missionObjectives == (_journalistCount + 1)} 
};

if(_missionObjectives findIf { !alive _x} == -1) then {
  [_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
  OPCB_econ_credits = OPCB_econ_credits + _reward;
  publicVariable "OPCB_econ_credits";
      
  (format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
}
else {
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
};

[_citypos] call CHAB_fnc_endmission;

[_missionObjectives] spawn {
  params ["_missionObjectives"];
  sleep 60;
  {
    deleteVehicle _x;
  } forEach _missionObjectives;
};