_vehicle = _this select 0;
_seat = _this select 1;
_player = _this select 2;

if(_seat == "driver") then 
  {
	if (typeof _player != "rhsusf_army_ocp_helipilot") then
	  {
		moveOut _player;
	  };
  };