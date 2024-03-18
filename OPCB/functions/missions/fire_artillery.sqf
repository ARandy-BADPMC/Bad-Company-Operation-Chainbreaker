params ["_mortar", "_unit"];
private _flare = "rhs_mag_3vs25m_10";

private _artiWeapon = _mortar currentWeaponTurret [0];

private _availableMagazines = [_artiWeapon] call BIS_fnc_compatibleMagazines;

_reloadMagazines = {
	params ["_availableMagazines", "_mortar"];
	{
		_mortar addMagazineTurret [_x, [0]];
	} forEach _availableMagazines;
};

[_availableMagazines,_mortar] call _reloadMagazines;

while {alive _unit} do {
	{
		private ["_markpos"];

		private _ammos = getArtilleryAmmo [_mortar];

		if(count _ammos > 0) then {
			private _ammo = selectRandom _ammos;
		
			private _distance = [random 200,random 360];

			if (daytime >= 20 || {daytime <= 5}) then {
				if(_flare in _ammos) then {
					_ammo = _flare;
				};
			};

			_markpos = (getPos _x) getPos _distance;
			if (_markpos inRangeOfArtillery [[_mortar], _ammo] ) exitWith {
				_mortar commandArtilleryFire [_markpos, _ammo, 1];
			};  
		} else {
			[_availableMagazines,_mortar] call _reloadMagazines;
		};
		   
  	} forEach playableUnits;

	sleep random [10, 30, 40];
};
