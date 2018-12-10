_vehicle = _this select 0;
_seat = _this select 1;
_player = _this select 2;
if(_seat == "driver") then 
{
  if (typeOf _player != "rhsusf_army_ocp_engineer")
    then
    {
      moveOut _player;
    };
};