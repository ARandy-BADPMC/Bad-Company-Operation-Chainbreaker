missionNamespace setVariable["zeus_enabled",1];
	_player = _this select 0;
	_player assignCurator zeus_admin;
	waitUntil {
	  sleep 1;
	  _istherezeus = missionNamespace getVariable["zeus_enabled",1];
	  !alive _player || _istherezeus == 0
	};
	remoteExec ["CHAB_fnc_zeus_out_server",2];