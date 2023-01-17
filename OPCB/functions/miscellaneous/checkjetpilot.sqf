_vehicle = _this select 0;
_seat = _this select 1;
_player = _this select 2;
_playerid = getPlayerUID _player;
_SOAR = ["76561198142692277","76561198117073327","76561198086630094","76561198059583284","76561198080263934","76561198027293421","76561198067590754","76561199005382007","76561198047632810"];//76561198080263934 -Geo2013 , 76561198142692277 -Alex. K., 76561198086630094 -G.Drunken, 76561198027293421- S.Werben, 76561198117073327 - A.Randy,   76561198059583284 - Vittex?, 76561198067590754 - Mas Pater, 76561199005382007 - W.Frost, 76561198047632810 - Defiance
  
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
        if (typeof _player == "rhsusf_army_ocp_helipilot" && _playerid in _SOAR) then {} else {
				moveOut _player;
				_vehicle engineOn false;
		  };
	};
};
