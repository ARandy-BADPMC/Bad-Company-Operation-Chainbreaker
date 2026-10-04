params ["_object", "_slot"];

if (!isServer || {isNull _object}) exitWith {};

_object setVariable ["OPCB_shopSlot", _slot, true];
_object setVariable ["OPCB_shopSlotReleased", false, true];
_object addEventHandler ["Killed", {
	params ["_object"];
	[_object] call CHAB_fnc_shopSlotReleased;
}];
_object addEventHandler ["Deleted", {
	params ["_object"];
	[_object] call CHAB_fnc_shopSlotReleased;
}];