params [["_counter", ""]];

if (!isServer) exitWith {
	hint "Only server can reset counters";
};

if (isRemoteExecuted && {(allPlayers findIf {owner _x == remoteExecutedOwner && {_x getVariable ["Developer", false]}}) < 0}) exitWith {};
if !(missionNamespace getVariable ["Hz_pers_serverInitialised", false]) exitWith {};

private _groundSlots = switch (_counter) do {
	case "": { ["Tank", "APC", "Vehicle"] };
	case "ALL": { ["Tank", "APC", "Vehicle"] };
	case "MaxTanks": { ["Tank"] };
	case "MaxAPC": { ["APC"] };
	case "ShopVehicleCount": { ["Vehicle"] };
	default { [] };
};
if !(_groundSlots isEqualTo []) then {
	{
		if ((_x getVariable ["OPCB_shopSlot", ""]) in _groundSlots) then {
			_x setVariable ["OPCB_shopSlotReleased", true, true];
			_x setVariable ["OPCB_shopSlot", "", true];
		};
	} forEach vehicles;
	call CHAB_fnc_shopGroundReconcile;
};

if (_counter == "" || _counter == "ALL") exitWith {
	MaxAttackHelis = 0;
	publicVariable "MaxAttackHelis";

	MaxTransHelis = 0;
	publicVariable "MaxTransHelis";

	MaxBoats = 0;
	publicVariable "MaxBoats";

	CrateCount = 0;
	publicVariable "CrateCount";

	hint "All counters reset to 0";
};

switch (_counter) do {
	case "MaxTanks": {
		hint "MaxTanks reset to 0";
	};
	case "MaxAttackHelis": {
		MaxAttackHelis = 0;
		publicVariable "MaxAttackHelis";
		hint "MaxAttackHelis reset to 0";
	};
	case "MaxTransHelis": {
		MaxTransHelis = 0;
		publicVariable "MaxTransHelis";
		hint "MaxTransHelis reset to 0";
	};
	case "MaxAPC": {
		hint "MaxAPC reset to 0";
	};
	case "MaxBoats": {
		MaxBoats = 0;
		publicVariable "MaxBoats";
		hint "MaxBoats reset to 0";
	};
	case "ShopVehicleCount": {
		hint "ShopVehicleCount reset to 0";
	};
	case "CrateCount": {
		CrateCount = 0;
		publicVariable "CrateCount";
		hint "CrateCount reset to 0";
	};
	default {
		hint format ["Unknown counter: %1", _counter];
	};
};
