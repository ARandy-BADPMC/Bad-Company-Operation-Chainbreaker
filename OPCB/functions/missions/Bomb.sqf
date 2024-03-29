params ["_base","_current_tasknumber", "_reward"];

_taskcomp = "bombdefusal";
_current_task = _base getPos[random 600,random 360];

[_current_tasknumber ,west,
["Infiltrate enemy territory, locate, and defuse a planted bomb. Use a specialized terminal at base for defusal, with a teammate relaying essential codes. Expect heightened enemy presence, prioritize coordination, and act swiftly to ensure mission success. The clock is ticking – soldiers, time is of the essence.",
"Operation Codebreaker "], _current_task,"ASSIGNED",10,true,true,"use",true] call BIS_fnc_setTask;

_spawncomps = [_base] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
[_base,east] call CHAB_fnc_enemySpawner;

private _bomb = [_comp, "Land_Bomb_Trolley_01_F"] call CHAB_fnc_findFlowerPots;

[_bomb,["<t color='#FF0000'>Defuse bomb</t>",
{
	createDialog "bombDefusalPanel";
}, nil,1.5, true, true, "", "true", 5, false, ""]] remoteExecCall ["addaction",0,true];

private _terminal = createVehicle ["RuggedTerminal_01_communications_F", getPos jeff, [], 3, "NONE"];

[_terminal,["<t color='#FF0000'>Hack the Bomb (1 time use)</t>",
{
	params ["_target", "_caller", "_actionId", "_arguments"];

	_arguments params ["_bomb"];

	private _nearestPlayerDistance = ([_bomb] call CHAB_fnc_nearest) select 1;

	if(_nearestPlayerDistance > 10) exitWith {
		hint "I can't hack into the terminal from this range. I need to have someone close by to connect me.";
	};

	[_target] remoteExecCall ["CHAB_fnc_bombDefusalHack_server", 2, false];

}, [_bomb] ,1.5, true, true, "", "true", 5, false, ""]] remoteExecCall ["addaction",0,true];

BombTaskDigits = "";
for "_i" from 1 to 4 do { 
	BombTaskDigits = BombTaskDigits + (str floor (random [0,5,9]));
};

waitUntil { 
	sleep 10; 
	!alive _bomb || count BombTaskDigits != 4
};

if(count BombTaskDigits > 0) then {
	"Bo_GBU12_LGB" createVehicle (getPosATL _bomb);
	[_current_tasknumber, "FAILED", true] call BIS_fnc_taskSetState;
} else {
	[_current_tasknumber, "SUCCEEDED", true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
	publicVariable "OPCB_econ_credits";
		
	(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
};

[_bomb] spawn {
	params ["_bomb"];
	sleep 60;
	deleteVehicle _bomb;
};

[_base] call CHAB_fnc_endmission;

[ _comp ] call LARs_fnc_deleteComp;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;