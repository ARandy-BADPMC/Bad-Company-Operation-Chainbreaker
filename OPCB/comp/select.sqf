params ["_taskobjective"];
private ["_radius","_currentTasknumber","_base","_selected"];

_callerRE = remoteExecutedOwner;

if (( {((markerpos 'base_marker') distance2d _x) < 1000} count playableUnits > 1) && {isNil "_taskobjective"}) exitWith {
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
	_selected = ((selectRandom _tasks) select 0);
};

TaskNumber = TaskNumber + 1;

_currentTasknumber = format ["TaskNumberFinal_%1",TaskNumber];

{
	if (_selected isEqualTo (_x select 0)) exitWith {
		_radius = (_x select 1);
	};
	_radius = 9999;
} forEach _tasks;

_base = [_radius] call CHAB_fnc_findSpot;

IsATaskRunning = true;
switch ( _selected) do { 
	case "Neutralize2" : {
		[_base,_currentTasknumber] call CHAB_fnc_Neutralize2;
	}; 
	case "Neutralize" : {
		[_base,_currentTasknumber] call CHAB_fnc_Neutralize;
	}; 
	case "Exterminate" : {
		[_base,_currentTasknumber] call CHAB_fnc_Exterminate;
	};
	case "Eliminate" : {
		[_base,_currentTasknumber] call CHAB_fnc_Eliminate;
	}; 
	case "Technology" : {
		[_base,_currentTasknumber] call CHAB_fnc_Technology;
	};
	case "Destroy" : {
		[_base,_currentTasknumber] call CHAB_fnc_Destroy;
	};  
	case "Annihilate and Destroy" : {
		[_base,_currentTasknumber] call CHAB_fnc_Annihilate_and_Destroy;
	};  
	case "Secure" : {
		[_base,_currentTasknumber] call CHAB_fnc_Secure;
	}; 
	case "Capture" : {
		[_base,_currentTasknumber] call CHAB_fnc_Capture;
	};  
	case "IDAP" : {
		[_base,_currentTasknumber] call CHAB_fnc_IDAP;
	};  
	case "Resupply" : {
		[_base,_currentTasknumber] call CHAB_fnc_Resupply;
	};  
	case "Retrieve" : {
		[_currentTasknumber] call CHAB_fnc_Retrieve;
	};  
	case "Attack" : {
		[_currentTasknumber] call CHAB_fnc_Attack;
	}; 
	case "Clear out" : {
		[_currentTasknumber] call CHAB_fnc_Clear_out;
	};
	case "GDrunken" : {
		[_base,_currentTasknumber] call CHAB_fnc_GDrunken;
	};  
	case "Minefield" : {
		[_currentTasknumber] call CHAB_fnc_Minefield;
	};
	case "El Chapo" : {
		[_base,_currentTasknumber] call CHAB_fnc_El_Chapo;
	};  
	default { 
		"Failed to spawn a task, try again" remoteExec["hint", _callerRE];
	}; 
};
IsATaskRunning = false;