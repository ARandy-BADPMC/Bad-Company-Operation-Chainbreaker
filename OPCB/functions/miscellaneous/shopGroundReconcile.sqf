if (!isServer) exitWith {};

private _tracked = vehicles select {
	alive _x && {!(_x getVariable ["OPCB_shopSlotReleased", false])}
};

{
	_x params ["_slot", "_counter"];
	private _count = {_x getVariable ["OPCB_shopSlot", ""] == _slot} count _tracked;
	if ((missionNamespace getVariable [_counter, -1]) != _count) then {
		missionNamespace setVariable [_counter, _count, true];
	};
} forEach [["Vehicle", "ShopVehicleCount"], ["APC", "MaxAPC"], ["Tank", "MaxTanks"]];
