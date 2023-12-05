if(hasInterface && !isServer) exitWith{};

[] spawn {
	waitUntil {
		!isNil "SM_Rewards"
	};

	[] spawn SM_fnc_ambientFlyby;

	sleep 10;
	while {true} do {
		SM_TaskActive = true;
		private _randomTask = selectRandom keys SM_Rewards;
		(SM_Rewards get _randomTask) params ["_reward", "_sm"];

		private _handle = [] call _sm;

		waitUntil { 
			sleep 10;

			scriptDone _handle
		};

		private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];
		SM_TaskNumber = SM_TaskNumber + 1;

		OPCB_econ_credits = OPCB_econ_credits + _reward;
		publicVariable "OPCB_econ_credits";

		[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;

		(format ["You earned %1 C for successfully completing the side mission!", _reward]) remoteExec ["hint"];

		SM_TaskActive = false;

		sleep random [1800, 2400, 3600];
	};
}