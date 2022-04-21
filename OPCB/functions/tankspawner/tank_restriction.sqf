
	_vehicle = _this select 0;
	
	_vehicle addEventHandler ["GetIn",{_this call CHAB_fnc_checkdriver}];
	_vehicle addEventHandler ["Engine",{_this call CHAB_fnc_checktankengine}];
