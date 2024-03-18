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
		
		waitUntil {
			sleep 10;
			serverTime > 300
		};
		waitUntil {
			sleep 10;
			!isNil "Hz_pers_var_insurgencyClearedMarkers"
		};
		
		private _numGridsToRecap = 0;
		private _randGrid = "";
		private _newTier = -1;
		
		while {true} do {
		
			sleep 3600;
		
			if ((count Hz_pers_var_insurgencyClearedMarkers) > _thresholdGridCount) then {
			
				if ((count allPlayers) > 0) then {
					_numGridsToRecap = 10;
				} else {
					_numGridsToRecap = 3;
				};
				
				for "_i" from 1 to _numGridsToRecap do {
					_randGrid = selectRandom Hz_pers_var_insurgencyClearedMarkers;
					_randGrid call _recapGrid;
					sleep 2;
				};
				
				// check if we progressed a tier and update
				_newTier = (ceil (10 - ((1 min ((count Hz_pers_var_insurgencyClearedMarkers) / ins_halfMarkerCount))*10))) - 1;
				if (_newTier != OPCB_econ_currentTier) then {
					OPCB_econ_currentTier = _newTier;
					publicVariable "OPCB_econ_currentTier";
				};
				
			};
		
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
