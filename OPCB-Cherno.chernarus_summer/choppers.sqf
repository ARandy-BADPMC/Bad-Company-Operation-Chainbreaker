checkpilot = 
{
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
  _jets = _player getvariable ["can_fly_jets",0];

    if(_seat == "driver") then 
      {
        if (jets == 0)
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

