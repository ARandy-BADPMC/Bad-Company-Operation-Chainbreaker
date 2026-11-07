if (!isServer) exitWith {};

[] spawn {
	waitUntil {
		!isNil "SM_Rewards"
	};

	[] spawn SM_fnc_ambientFlyby;

	sleep 10;
	while {true} do {
		waitUntil {
			sleep 10;
			{isPlayer _x && {!(_x isKindOf "HeadlessClient_F")}} count allPlayers > 0
		};

		SM_TaskActive = true;

		private _randomTask = selectRandom keys SM_Rewards;
		(SM_Rewards get _randomTask) params ["_reward", "_sm"];
		private _taskId = format ["SM_TaskNumber_%1", SM_TaskNumber];
		SM_activeTaskId = _taskId;
		SM_activeTaskType = _randomTask;

		private _handle = [_taskId] call _sm;

		waitUntil { 
			sleep 10;
			scriptDone _handle
		};

		SM_TaskNumber = SM_TaskNumber + 1;

		private _state = [_taskId] call BIS_fnc_taskState;

		if (_state == "SUCCEEDED") then {
			OPCB_econ_credits = OPCB_econ_credits + _reward;
			publicVariable "OPCB_econ_credits";

			format ["You earned %1 C for successfully completing the side mission!", _reward] remoteExec ["hint"];
		};

		SM_TaskActive = false;
		SM_activeTaskId = "";
		SM_activeTaskType = "";

		sleep random [1800, 2400, 3600];  

	};
};
