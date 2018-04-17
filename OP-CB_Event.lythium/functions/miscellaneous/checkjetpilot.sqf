_vehicle = _this select 0;
_seat = _this select 1;
_player = _this select 2;
_SOAR = ["76561198142692277","76561198117073327","76561198086630094","76561198059583284","76561198080263934","76561198027293421"];//76561198080263934 -Geo2013 , 76561198142692277 -Alex. K., 76561198086630094 -G.Drunken, 76561198027293421- S.Werben, 76561198117073327 - A.Randy
_playerid = getPlayerUID _player;

if(_seat == "driver") then 
{
	if(_playerid in _SOAR) then {} else 
  {			  
	    moveOut _player;
	   _vehicle engineOn false;
  };
};
