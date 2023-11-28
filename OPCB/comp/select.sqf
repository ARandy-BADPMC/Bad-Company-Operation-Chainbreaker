params ["_taskobjective"];
private ["_radius","_currentTasknumber","_base","_selected"];

_callerRE = remoteExecutedOwner;

_baseMarker = markerPos "base_marker";

_closeFriendlies = {(_baseMarker distance2d _x) < 1000 } count playableUnits;

if ( _closeFriendlies < 2 && {isNil "_taskobjective"}) exitWith {
	"At least 2 people are required to be at base to request a mission!" remoteExec["hint", _callerRE];
};

if (isNil "_taskobjective") then {
	_selected = "";
} else {
	_selected = _taskobjective;
};

if (IsATaskRunning) exitWith {
	"This option is unavailable at the moment" remoteExec ["hint", _callerRE];
};

#include "..\data\tasks.sqf";

if (count _selected == 0) then {
	_selected = selectRandom (keys _tasks);
};

TaskNumber = TaskNumber + 1;

_currentTasknumber = format ["TaskNumberFinal_%1",TaskNumber];

_radius = (_tasks get _selected) select 0;

private _credits = (_tasks get _selected) select 1;

_base = [_radius] call CHAB_fnc_findSpot;

IsATaskRunning = true;
switch ( _selected) do { 
	case "Neutralize" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Neutralize;
	}; 
	case "Exterminate" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Exterminate;
	};
	case "Eliminate" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Eliminate;
	}; 
	case "Technology" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Technology;
	};
	case "Destroy" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Destroy;
	};  
	case "Annihilate and Destroy" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Annihilate_and_Destroy;
	};  
	case "Secure" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Secure;
	}; 
	case "Capture" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Capture;
	};  
	case "Bomb" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Bomb;
	}; 
	case "IDAP" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_IDAP;
	};  
	case "Resupply" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_Resupply;
	};  
	case "Retrieve" : {
		[_currentTasknumber, _credits] call CHAB_fnc_Retrieve;
	};  
	case "Attack" : {
		[_currentTasknumber, _credits] call CHAB_fnc_Attack;
	}; 
	case "Clear out" : {
		[_currentTasknumber, _credits] call CHAB_fnc_Clear_out;
	};
	case "GDrunken" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_GDrunken;
	};  
	case "Minefield" : {
		[_currentTasknumber, _credits] call CHAB_fnc_Minefield;
	};
	case "El Chapo" : {
		[_base,_currentTasknumber, _credits] call CHAB_fnc_El_Chapo;
	};  
	default { 
		"Failed to spawn a task, try again" remoteExec["hint", _callerRE];
	}; 
};
IsATaskRunning = false;