
params ["_taskobjective"];
//copyToClipboard str [_taskobjective];
private ["_radius","_comp","_current_task","_tasknumber","_current_tasknumber","_base","_taskobjective","_selected"];
_taskIsrunning = missionNamespace getVariable ["running_task",1];

if(_taskIsrunning == 0) then {


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
//["Retrieve",9999],
["Minefield",9999]

];
_done =false;
{
	_name = (_x select 0);
	if (_name isEqualTo _taskobjective) exitWith {
		_selected = (_x select 0);
		_done = true;
	};
} forEach _tasks;

if (!_done) then {
	_selected = ((selectRandom _tasks) select 0);
};

_tasknumber = (missionNamespace getVariable ["TaskNumber",-1]) + 1;
missionNamespace setVariable ["TaskNumber",_tasknumber];
_current_tasknumber = format ["TaskNumberFinal_%1",_tasknumber];

//_selected = "Eliminate";

{
	if (_selected isEqualTo (_x select 0)) exitWith{
		_radius = (_x select 1);


	};
} forEach _tasks;

_handle = [_radius] spawn CHAB_fnc_findSpot;
waitUntil {
scriptDone _handle
};
_base = missionNamespace getVariable ["task_spot",[5840,5700,0]];

missionNamespace setVariable ["running_task",1];
switch ( _selected) do { 
	case "Neutralize2" : {
		[_base,_current_tasknumber] call CHAB_fnc_Neutralize2;
	}; 
	case "Neutralize" : {
		[_base,_current_tasknumber] call CHAB_fnc_Neutralize;
	}; 
	case "Exterminate" : {
		[_base,_current_tasknumber] call CHAB_fnc_Exterminate;
	};
	case "Eliminate" : {
		[_base,_current_tasknumber] call CHAB_fnc_Eliminate;
	}; 
	case "Technology" : {
		[_base,_current_tasknumber] call CHAB_fnc_Technology;
	};
	case "Destroy" : {
		[_base,_current_tasknumber] call CHAB_fnc_Destroy;
	};  
	case "Annihilate and Destroy" : {
		[_base,_current_tasknumber] call CHAB_fnc_Annihilate_and_Destroy;
	};  
	case "Secure" : {
		[_base,_current_tasknumber] call CHAB_fnc_Secure;
	}; 
	case "Capture" : {
		[_base,_current_tasknumber] call CHAB_fnc_Capture;
	};  
	case "IDAP" : {
		[_base,_current_tasknumber] call CHAB_fnc_IDAP;
	};  
	case "Resupply" : {
		[_base,_current_tasknumber] call CHAB_fnc_Resupply;
	};  
	case "Retrieve" : {
		[_base,_current_tasknumber] call CHAB_fnc_Retrieve;
	};  
	case "Attack" : {
		[_base,_current_tasknumber] call CHAB_fnc_Attack;
	}; 
	case "Clear out" : {
		[_base,_current_tasknumber] call CHAB_fnc_Clear_out;
	};  
	case "Minefield" : {
		[_base,_current_tasknumber] call CHAB_fnc_Minefield;
	};  
	default { 
		"Failed to spawn a task, try again" remoteExec["hint",0];
	}; 
};
missionNamespace setVariable ["running_task",0];

} 
else 
{
	_callerRE = remoteExecutedOwner;
  "This option is unavailable at the moment" remoteExec ["hint",_callerRE];
};