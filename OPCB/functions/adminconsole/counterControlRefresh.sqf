disableSerialization;
params ["_display"];

if (isNull _display) exitWith {};

private _ctrl = _display displayCtrl 1100;
if (isNull _ctrl) exitWith {};

private _liveShopGround = count (vehicles select {
	alive _x
	&& {_x getVariable ["OPCB_shopSlot", ""] in ["Tank", "APC", "Vehicle"]}
	&& {!(_x getVariable ["OPCB_shopSlotReleased", false])}
});

private _liveLandNoStatics = count (vehicles select {
	alive _x
	&& {_x isKindOf "LandVehicle"}
	&& {!(_x isKindOf "StaticWeapon")}
});

private _normalVehicleCount = missionNamespace getVariable ["ShopVehicleCount", 0];

private _text = format [
	"<t size='1.05'>Vehicles: %1 / 8<br/>Tanks: %2 / 1<br/>Attack helis: %3<br/>Transport helis: %4<br/>APCs: %5 / 3<br/>Boats: %6<br/>Crates: %7 / 20<br/><br/>Live tracked vehicles: %8<br/>Live land vehicles (no statics): %9</t>",
	_normalVehicleCount,
	missionNamespace getVariable ["MaxTanks", 0],
	missionNamespace getVariable ["MaxAttackHelis", 0],
	missionNamespace getVariable ["MaxTransHelis", 0],
	missionNamespace getVariable ["MaxAPC", 0],
	missionNamespace getVariable ["MaxBoats", 0],
	missionNamespace getVariable ["CrateCount", 0],
	_liveShopGround,
	_liveLandNoStatics
];

_ctrl ctrlSetStructuredText parseText _text;
