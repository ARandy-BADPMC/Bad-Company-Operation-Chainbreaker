_vehicle = _this select 0;
_seat = _this select 1;
_player = _this select 2;
_helis = _player getvariable ["can_fly_helicopters",0];

if(_seat == "driver") then 
  {
	if (_helis == 0) then
	  {
		moveOut _player;
	  };
  };