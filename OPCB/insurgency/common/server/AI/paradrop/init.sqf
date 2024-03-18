paraLandSafe = 
{
	private ["_unit"];
	_unit = _this select 0;
	_chuteheight = _this select 1;
	//(vehicle _unit) allowDamage false;
	if (isPlayer _unit) then {[_unit,_chuteheight] spawn OpenPlayerchute};
	waitUntil {sleep 1; isTouchingGround _unit || (position _unit select 2) < 1 };
	_unit action ["eject", vehicle _unit];
	sleep 1;
	_inv = name _unit;
	[_unit, [missionNamespace, format["%1%2", "Inventory",_inv]]] call BIS_fnc_loadInventory;// Reload Loadout.
	//_unit allowdamage true;// Now you can take damage.
};

OpenPlayerChute =
{
	private ["_paraPlayer"];
	_paraPlayer = _this select 0;
	_chuteheight = _this select 1;
	waitUntil {uisleep 1; (position _paraPlayer select 2) <= _chuteheight};
	_paraPlayer action ["openParachute", _paraPlayer];
};

paraEject = compileFinal preprocessFileLineNumbers "insurgency\common\server\AI\paradrop\eject.sqf";