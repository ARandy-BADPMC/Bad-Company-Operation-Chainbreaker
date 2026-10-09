params ["_object"];

if (!isServer || {isNull _object}) exitWith {};
if (_object getVariable ["OPCB_shopSlotReleased", false]) exitWith {};

_object setVariable ["OPCB_shopSlotReleased", true, true];

switch (_object getVariable ["OPCB_shopSlot", ""]) do {
	case "Tank": {
		MaxTanks = ((missionNamespace getVariable ["MaxTanks", 0]) - 1) max 0;
		publicVariable "MaxTanks";
	};
	case "APC": {
		MaxAPC = ((missionNamespace getVariable ["MaxAPC", 0]) - 1) max 0;
		publicVariable "MaxAPC";
	};
	case "Vehicle": {
		ShopVehicleCount = ((missionNamespace getVariable ["ShopVehicleCount", 0]) - 1) max 0;
		publicVariable "ShopVehicleCount";
	};
	case "Crate": {
		CrateCount = ((missionNamespace getVariable ["CrateCount", 0]) - 1) max 0;
		publicVariable "CrateCount";
	};
};
