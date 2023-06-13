private _reward = 40;
params ["_current_tasknumber"];

_journalistCount = selectRandom [1,2]; 

_city = selectRandom Cities;
_citypos = locationPosition _city;

CityMarker setMarkerPos _citypos;

_msg = format ["A riot has erupted in the area, posing a significant threat to public safety and stability. Our mission is to swiftly clear the rioting area, apprehend the leader responsible for inciting the unrest, and rescue the journalists who have been captured. The primary objective of this operation is to swiftly bring an end to the riot, capture the leader, and rescue the journalists held captive. By restoring order and ensuring the safety of the civilian population, we aim to reestablish a sense of security and stability in the area.",_journalistCount];

[_current_tasknumber ,west,[_msg,"Operation Rapid Resolve",CityMarker],_citypos,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_officerGroup = createGroup [east,true];
_officer = _officerGroup createUnit [selectRandom OPCB_Commanders_Insurgents, _citypos, [], 2, "NONE"];
removeAllWeapons _officer;
_officer disableAI "AUTOCOMBAT";
_officer setunitpos "MIDDLE";
_rescuegroup = createGroup [civilian,true];

_houses = nearestObjects [_citypos, ["house"], 400];

_missionObjectives = [_officer];

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

[_citypos] call CHAB_fnc_spawn_city_ins;

[_citypos,resistance] call CHAB_fnc_enemySpawner;

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