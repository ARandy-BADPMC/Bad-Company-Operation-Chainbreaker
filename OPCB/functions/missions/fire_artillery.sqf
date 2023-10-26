params ["_mortar", "_village"];

private _unit = (crew _mortar) select 0;
private _flare = "8Rnd_82mm_Mo_Flare_white";

while {alive _unit} do {
	{
		private ["_markpos", "_ammo"];

		private _ammos = getArtilleryAmmo [_mortar];
		if(count _ammos > 0) then {
			private _distance = [0,0];
			if (daytime >= 20 || {daytime <= 5}) then {
				_distance = [random 300,random 360];
				if(_flare in _ammos) then {
					_ammo = _flare;
				}
			}
			else {
				_distance = [random 100,random 360];
				_ammo = _ammos select 0;
			};

			_markpos = (getPos _x) getPos _distance;
			private _pos = ASLToAGL (getPosASL _markpos);
			if (_pos inRangeOfArtillery [[_mortar], _ammo] ) exitWith {
				_mortar commandArtilleryFire [_pos, _ammo, 1];
			};  
		}
		   
  	} forEach playableUnits;

	sleep random [100, 300, 400];
};
