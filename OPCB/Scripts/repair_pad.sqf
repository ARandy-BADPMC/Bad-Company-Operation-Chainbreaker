
_type = typeOf _this;

x_reload_time_factor = 5;

_this setVehicleAmmo 1;
_this engineOn false;
_this vehicleChat format ["Servicing %1... Please stand by...", _type];

_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

if (count _magazines > 0) then {
	_removed = [];
	{
		if (!(_x in _removed)) then {
			_this removeMagazines _x;
			_removed = _removed + [_x];
		};
	} forEach _magazines;
	{
		_this vehicleChat format ["Reloading %1", _x];
		sleep x_reload_time_factor;
		_this addMagazine _x;
	} forEach _magazines;
};

_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

if (_count > 0) then {
	for "_i" from 0 to (_count - 1) do {
		scopeName "xx_reload2_xx";
		_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
		_magazines = getArray(_config >> "magazines");
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_this removeMagazines _x;
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_this vehicleChat format ["Reloading %1", _x];
			sleep x_reload_time_factor;
			_this addMagazine _x;
			sleep x_reload_time_factor;
		} forEach _magazines;
		_count_other = count (_config >> "Turrets");
		if (_count_other > 0) then {
			for "_i" from 0 to (_count_other - 1) do {
				_config2 = (_config >> "Turrets") select _i;
				_magazines = getArray(_config2 >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_this removeMagazines _x;
						_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_this vehicleChat format ["Reloading %1", _x]; 
					sleep x_reload_time_factor;
					_this addMagazine _x;
					sleep x_reload_time_factor;
				} forEach _magazines;
			};
		};
	};
};
_this setVehicleAmmo 1;	// Reload turrets / drivers magazine

sleep x_reload_time_factor;
_this vehicleChat "Repairing...";
_this setDamage 0;

/* sleep x_reload_time_factor;
_this vehicleChat "Refueling...";
while {fuel _this < 0.99} do {
	//_this setFuel ((fuel _vehicle + 0.1) min 1);
	_this setFuel 1;
	sleep 0.01;
};*/

sleep x_reload_time_factor;
_this vehicleChat format ["%1 is ready...", _type];

if (true) exitWith {};
