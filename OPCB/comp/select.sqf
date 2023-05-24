params ["_taskobjective"];
private ["_radius","_currentTasknumber","_base","_selected"];

_selected = _taskobjective;

if (IsATaskRunning) exitWith {
	_callerRE = remoteExecutedOwner;
	"This option is unavailable at the moment" remoteExec ["hint", _callerRE];
};

_tasks = [
	["Eliminate",100],
	["Technology",100],
	["Destroy",60],
	["Annihilate and Destroy",45],
	["Secure",60],
	["Capture",25],
	["Exterminate",25],
	["Neutralize",40],
	["Neutralize2",45], 
	["Attack",9999],
	["Clear out",9999],
	["Resupply",100],
	["IDAP",85],
	["Retrieve",9999],
	["GDrunken",80],
	["Minefield",9999]
];

if (count _selected == 0) then {
	_selected = ((selectRandom _tasks) select 0);
};

TaskNumber = TaskNumber + 1;

_currentTasknumber = format ["TaskNumberFinal_%1",TaskNumber];

{
	if (_selected isEqualTo (_x select 0)) exitWith{
		_radius = (_x select 1);
	};
	_radius = 9999;
} forEach _tasks;

_handle = [_radius] spawn CHAB_fnc_findSpot;
waitUntil {
	scriptDone _handle
};
_base = TaskSpot;

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
		[_base,_currentTasknumber] call CHAB_fnc_Retrieve;
	};  
	case "Attack" : {
		[_base,_currentTasknumber] call CHAB_fnc_Attack;
	}; 
	case "Clear out" : {
		[_base,_currentTasknumber] call CHAB_fnc_Clear_out;
	};
	case "GDrunken" : {
		[_base,_currentTasknumber] call CHAB_fnc_GDrunken;
	};  
	case "Minefield" : {
		[_base,_currentTasknumber] call CHAB_fnc_Minefield;
	};
	case "El Chapo" : {
		[_base,_currentTasknumber] call CHAB_fnc_El_Chapo;
	};  
	default { 
		IsATaskRunning = false;
		"Failed to spawn a task, try again" remoteExec["hint",0];
	}; 
};