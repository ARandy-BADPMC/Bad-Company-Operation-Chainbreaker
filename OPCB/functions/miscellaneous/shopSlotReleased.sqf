params ["_object"];

if (!isServer || {isNull _object}) exitWith {};
if (_object getVariable ["OPCB_shopSlotReleased", false]) exitWith {};

_object setVariable ["OPCB_shopSlotReleased", true, true];

switch (_object getVariable ["OPCB_shopSlot", ""]) do {
	case "Tank": {
		call CHAB_fnc_shopGroundReconcile;
	};
	case "APC": {
		call CHAB_fnc_shopGroundReconcile;
	};
	case "Vehicle": {
		call CHAB_fnc_shopGroundReconcile;
	};
	case "Crate": {
		CrateCount = ((missionNamespace getVariable ["CrateCount", 0]) - 1) max 0;
		publicVariable "CrateCount";
	};
};
