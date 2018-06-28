  _vehicle = _this select 0;
  _seat = _this select 1;
  _player = _this select 2;
  _jets = _player getvariable ["can_fly_jets",0];
  _helis = _player getvariable ["can_fly_helicopters",0];
  _helisa = _player getvariable ["can_fly_helicopters_attack",0];
  
 if (_vehicle isKindOf "Plane") then 
 {
    if(_seat == "driver") then 
      {
      if (_jets == 0) then {
				moveOut _player;
				_vehicle engineOn false;
		  };
	};
} else {
   if(_seat == "driver") then 
      {
        if (_helis == 0 || _helisa == 0) then {
				moveOut _player;
				_vehicle engineOn false;
		  };
	};
};