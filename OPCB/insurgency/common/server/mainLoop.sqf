// used by cleanup timers
private ["_WCTime","_BCTime"];
_WCTime = time;
_BCTime = time;

// AI rearm & refuel
[] spawn {

	scriptName "ins_AIresupply";

	while {true} do {
	
		sleep 600;
		
		{
			if ((local _x) && {canMove _x} && ((side _x) in [resistance, east]) && {({(alive _x) && {(lifeState _x) != "INCAPACITATED"}} count crew _x) > 0} && {(_x isKindOf "LandVehicle") || {_x isKindOf "Air"} || {_x isKindOf "Ship"} || {_x isKindOf "StaticWeapon"}}) then {
				_x setFuel 1;
				_x setVehicleAmmo 1;
			};
			sleep 0.1;
		} foreach vehicles;
		
	};

};

#ifdef ENABLE_PERSISTENCY

	[] spawn {

		private _recapGrid = {
			
			private _mkr = _this;
			if (!(_mkr in Hz_pers_var_insurgencyClearedMarkers)) exitWith {};
			private _mkrVar = format["%1cleared", _mkr];
			missionNamespace setVariable [_mkrVar, nil];
			publicVariable _mkrVar;
			
			// grid markers work locally and the server doesn't know about them, so create a local marker first
			createMarkerLocal [_mkr, call compile _mkr];
			_mkr setMarkerShapeLocal "RECTANGLE";
			_mkr setMarkerTypeLocal "SOLID";
			_mkr setMarkerSizeLocal [50,50];
			_mkr setMarkerAlphaLocal 0.2;
			
			// propagates over network and syncs with clients
			_mkr setMarkerColor "ColorRed";
			
			Hz_pers_var_insurgencyClearedMarkers = Hz_pers_var_insurgencyClearedMarkers - [_mkr];
			
		};
		
		scriptName "ins_gridRecapture";
		
		private _thresholdGridCount = round (ins_halfMarkerCount / 2);
		systemChat "Waiting for init of grid Retaking System";
		
		waitUntil {
			sleep 10;
			serverTime > 300
		};
		waitUntil {
			sleep 10;
			!isNil "Hz_pers_var_insurgencyClearedMarkers"
		};
		waitUntil {
			sleep 10;
			!isNil "centerOfGridRetakingStr"
		};
		waitUntil {
			sleep 10;
			(count Hz_pers_var_insurgencyClearedMarkers) > 20
		};
		private _spiral_traversal = [[100, 0], [100, 100], [0, 100], [-100, 100], [-100, 0], [-100, -100], [0, -100], [100, -100], [200, -100], [200, 0], [200, 100], [200, 200], [100, 200], [0, 200], [-100, 200], [-200, 200], [-200, 100], [-200, 0], [-200, -100], [-200, -200], [-100, -200], [0, -200], [100, -200], [200, -200]];
		private _numGridsToRecap = 0;
		private _newTier = -1;
		private _timeSlept = 0;
		// ["Init grid Retaking System"] remoteExec ["systemChat"];
		if (isNil "centerOfGridRetakingStr" or centerOfGridRetakingStr == "") then {
			// ["Changing Grid Retaking position to random"] remoteExec ["systemChat"];
			centerOfGridRetakingStr = selectRandom Hz_pers_var_insurgencyClearedMarkers;
			centerOfGridRetakingStr call _recapGrid;
			centerOfGridRetaking = parseSimpleArray centerOfGridRetakingStr;
		} else {
			// ["Using loaded Grid Retaking position"] remoteExec ["systemChat"];
			centerOfGridRetaking = parseSimpleArray centerOfGridRetakingStr;
		};
		// ["Starting grid Retaking System"] remoteExec ["systemChat"];
		while {true} do {
			if ((count Hz_pers_var_insurgencyClearedMarkers) > _thresholdGridCount) then {
				private _completionRatio = (count Hz_pers_var_insurgencyClearedMarkers) / ins_allMarkerCount * 10/8;
				// linear fashion: | tier6 -> 4 grids/h | tier 5 -> 3 grids/h | tier 4 -> 2 grid/h  | tier 3 -> 1 grid/h
				private _total_time_to_sleep = 3600 * 1.5;
				private _numGridsToRecap = ceil(_completionRatio * 6) - 2;
				if ((count allPlayers) < 2) then {
					_total_time_to_sleep = 3600 * 4;
					_numGridsToRecap = 1;
				};
				sleep 600;
				_timeSlept = _timeSlept + 600;
				if(_timeSlept >= _total_time_to_sleep) then {
					_timeSlept = 0;
					_grids_retaken = 0;
					private _i = 0;
					while { _grids_retaken < _numGridsToRecap } do {
						offset = _spiral_traversal select _i;
						grid_to_retake = [(centerOfGridRetaking select 0) + (offset select 0), (centerOfGridRetaking select 1) + (offset select 1), 0];
						// [format ["Recapturing grid %1", grid_to_retake]] remoteExec ["systemChat"];
						if ((str grid_to_retake) in Hz_pers_var_insurgencyClearedMarkers) then {
							// [format ["Actually recapturing grid %1", grid_to_retake]] remoteExec ["systemChat"];
							(str grid_to_retake) call _recapGrid;
							_grids_retaken = _grids_retaken + 1;
						};
						_i = _i + 1;
						sleep 2;
						if (_i >= (count _spiral_traversal) - 1) then {
							offset = _spiral_traversal select _i;
							grid_to_retake = [(centerOfGridRetaking select 0) + (offset select 0), (centerOfGridRetaking select 1) + (offset select 1), 0];
							break
						};
					};
					private _useLastGridAsCenter = false;
					for "_i" from 0 to (count _spiral_traversal -1) do {
						offset = _spiral_traversal select _i;
						next_grid_to_retake = [(grid_to_retake select 0) + (offset select 0), (grid_to_retake select 1) + (offset select 1), 0];
						if ((str next_grid_to_retake) in Hz_pers_var_insurgencyClearedMarkers) then {
							_useLastGridAsCenter = true;
							break
						};
					};
					if (_useLastGridAsCenter) then {
						centerOfGridRetaking = grid_to_retake;
						centerOfGridRetakingStr = str centerOfGridRetaking;
						// ["Changing location to last grid"] remoteExec ["systemChat"];
					} else {
						centerOfGridRetakingStr = selectRandom Hz_pers_var_insurgencyClearedMarkers;
						centerOfGridRetaking = parseSimpleArray centerOfGridRetakingStr;
						// ["Changing location to random location"] remoteExec ["systemChat"];
					};
					publicVariable "centerOfGridRetakingStr";
					// check if we progressed a tier and update
					_newTier = (ceil (10 - ((1 min ((count Hz_pers_var_insurgencyClearedMarkers) / ins_halfMarkerCount))*10))) - 1;
					if (_newTier != OPCB_econ_currentTier) then {
						OPCB_econ_currentTier = _newTier;
						publicVariable "OPCB_econ_currentTier";
					};		
				};
			} else {
				// if cleared grids are below threshold, sleep for an hour and then check again
				sleep 3600;
			}
		};
	};

#endif

scriptName "ins_cleanup";

while { true } do {

	call aiDespawn;

	// disable cleanup
	//call quickCleanup;	
	// (dead cleanup disabled inside)
	call longCleanup;

	sleep 20;

}; 
