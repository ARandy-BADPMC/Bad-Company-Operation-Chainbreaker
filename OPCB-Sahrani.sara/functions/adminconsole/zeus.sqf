_istherezeus = missionNamespace getVariable["zeus_enabled",1];
	if(_istherezeus == 0) then {
		hint "You are now the Zeus of the mission.";
		[player] remoteExec ["CHAB_fnc_zeus_server"];
	} else {
	hint "There is already a Zeus operator!";
	};