checkpilot = 
{
  _vehicle = _this select 0;
  _seat = _this select 1;
  _player = _this select 2;

    if(_seat == "driver") then 
      {
        if (typeOf _player != "rhsusf_army_ocp_helipilot")
          then
          {
            moveOut _player;
          };
      };
};

checkdriver = 
{
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
};

checkjetpilot= 
{
  _vehicle = _this select 0;
  _seat = _this select 1;
  _player = _this select 2;
  _SOAR = ["76561198142692277","76561198117073327","76561198086630094","76561198059583284","76561198080263934","76561198027293421"];//76561198080263934 -Geo2013 , 76561198142692277 -Alex. K., 76561198086630094 -G.Drunken, 76561198027293421- S.Werben, 76561198117073327 - A.Randy
  _playerid = getPlayerUID _player;

    if(_seat == "driver") then 
      {
	  	if(_playerid in _SOAR) then {} else {			  
				moveOut _player;
				_vehicle engineOn false;
		  };
	};
};

checkengine = 
{
  _vehicle = _this select 0;
  _pilot = driver _vehicle;

  if ((typeOf _pilot != "rhsusf_army_ocp_helipilot") || isNull _pilot)
    then {
    _vehicle engineOn false; 
  };
};
checktankengine = 
{
  _vehicle = _this select 0;
  _pilot = driver _vehicle;

  if ((typeOf _pilot != "rhsusf_army_ocp_engineer") || isNull _pilot)
    then {
    _vehicle engineOn false; 
  };
};

checkdronepilot = 
{
  _vehicle = _this select 0;
  _seat = _this select 1;
  _player = _this select 2;

    if(_seat == "driver") then 
      {
        if (typeOf _player != "rhsusf_airforce_jetpilot")
          then
          {
            moveOut _player;
          };
      };
};

/*
this addAction ["<t color='#FF0000'>Blin</t>", {
  _itemsplayer = items player; 
  _backpack = backpackItems player; 
  copyToClipboard str _backpack;
  _theClassnames = [];
  _cfgWeapons = configFile >> "CfgWeapons"; 
  _cfgMagazines = configFile >> "CfgMagazines"; 
  {
    for "_i" from 0 to count _cfgWeapons -1 do 
    {
      _item = _cfgWeapons select _i;
      if (isClass _item) then 
      {
        _weapondisplay = getText(_item >> "displayName");
        if (_x == _weapondisplay) then {
          _theClassnames pushBack _item;
        };
      };
    };



    for "_i" from 0 to count _cfgMagazines -1 do {
      _item = _cfgMagazines select _i;
      if (isClass _item) then 
      {
        _weapondisplay = getText(_item >> "displayName");
        if (_x == _weapondisplay) then {
          _theClassnames pushBack _item;
        };
      };
    };

  } forEach _itemsplayer;
}, nil, 1, false, true, "", "true", 10, false,""];*/

