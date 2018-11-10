_vehicle = _this select 0;
_seat = _this select 1;
_player = _this select 2;
_playerid = getPlayerUID _player;
  
 if (_vehicle isKindOf "Plane") then 
 {
    if(_seat == "driver") then 
      {
		if (typeof _player != "rhsusf_airforce_jetpilot") then {
				moveOut _player;
				_vehicle engineOn false;
		  };
	};
} else {
   if(_seat == "driver") then 
      {
        if (typeof _player == "rhsusf_army_ocp_helipilot" && _playerid in SOAR) then {} else {
				moveOut _player;
				_vehicle engineOn false;
		  };
	};
};
