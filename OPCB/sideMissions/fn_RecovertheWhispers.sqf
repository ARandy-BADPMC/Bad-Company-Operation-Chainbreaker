if (isNil "CHAB_fnc_playerScale") then {
    CHAB_fnc_playerScale = { 1 };
};

private _missionPos = [150] call CHAB_fnc_findSpot;
private _taskId = format ["SM_TaskNumber_%1", SM_TaskNumber];

private _taskDesc = "The higher-ups have sent out two secret agents to collect data from a high-priority target (classified). The agents have gathered very important information, critical for a future operation! However, the agents have been called back to a small FOB, where they were planned to be transported back to base to deliver the critical information.\n\nBut it seems the enemy wasn’t as naive as we thought. They have figured out the location of the FOB and launched an attack to eliminate our agents your mission is to bring the 2 agents back to base safely!";
[_taskId, west, [_taskDesc, "Recover the Whispers"], _missionPos, "AUTOASSIGNED", 10, true, true, "move", true] call BIS_fnc_setTask;

private _comps = ["fob4", _missionPos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
private _flowerPot = createVehicle ["Land_FlowerPot_01_F", _missionPos, [], 0, "NONE"];
_flowerPot hideObjectGlobal true;

private _crewGroup = createGroup west;
for "_i" from 1 to 7 do {
    private _type = selectRandom [
        "rhsusf_usmc_marpat_wd_rifleman",
        "rhsusf_usmc_marpat_wd_grenadier",
        "rhsusf_usmc_marpat_wd_autorifleman",
        "rhsusf_usmc_marpat_wd_teamleader"
    ];
    private _unit = _crewGroup createUnit [_type, _flowerPot getPos [5 + random 10, random 360], [], 0, "NONE"];
    _unit setUnitPos "MIDDLE";
    _unit setBehaviour "COMBAT";
    _unit setCombatMode "YELLOW";
    _unit doWatch (_flowerPot getPos [50, random 360]);
};

private _agentClass = "C_man_formal_1_F";
private _pos1 = _flowerPot modelToWorld [0.5, 0];
private _pos2 = _flowerPot modelToWorld [-0.5, 0];
private _agent1 = createAgent [_agentClass, _pos1, [], 0, "NONE"];
private _agent2 = createAgent [_agentClass, _pos2, [], 0, "NONE"];
private _agents = [_agent1, _agent2];

{
    _x disableAI "MOVE";
    _x disableAI "AUTOCOMBAT";
    _x disableAI "PATH";
    _x disableAI "TARGET";
    _x setUnitPos "MIDDLE";
    _x setCaptive true;
    _x setVariable ["whispers_safe", false];
} forEach _agents;

[_flowerPot, resistance, 1, 0, 0, 0, false] call CHAB_fnc_enemySpawner;

private _failThreadHandle = [_taskId, _agents, _crewGroup, _flowerPot, _comps] spawn {
    params ["_taskId", "_agents", "_crewGroup", "_flowerPot", "_comps"];
    while { true } do {
        sleep 5;
        if ({ (!alive _x && !(_x getVariable ["whispers_safe", false])) } count _agents > 0) exitWith {
            [_taskId, "FAILED", true] call BIS_fnc_taskSetState;
            { deleteVehicle _x } forEach _agents + (units _crewGroup) + [_flowerPot];
            deleteGroup _crewGroup;
            [_comps] call LARs_fnc_deleteComp;
        };
    };
};

private _deliveryPoint = getMarkerPos "Delivery Point";

waitUntil {
    sleep 5;
    ({ alive _x && (_x distance2D _deliveryPoint) < 10 } count _agents) == 2
};

{
    _x setVariable ["whispers_safe", true];
} forEach _agents;

terminate _failThreadHandle;
[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;

[_agents, _crewGroup, _flowerPot, _comps] call {
    params ["_agents", "_crewGroup", "_flowerPot", "_comps"];
    sleep 4;
    { deleteVehicle _x } forEach _agents + (units _crewGroup) + [_flowerPot];
    deleteGroup _crewGroup;

    [_comps] spawn {
        params ["_comps"];
        sleep 120;
        [_comps] call LARs_fnc_deleteComp;
    };
};
