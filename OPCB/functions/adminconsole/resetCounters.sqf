params [["_counter", ""]];

if (!isServer) exitWith {
	hint "Only server can reset counters";
};

if (_counter == "" || _counter == "ALL") exitWith {
	MaxTanks = 0;
	publicVariable "MaxTanks";

	MaxAttackHelis = 0;
	publicVariable "MaxAttackHelis";

	MaxTransHelis = 0;
	publicVariable "MaxTransHelis";

	MaxAPC = 0;
	publicVariable "MaxAPC";

	MaxBoats = 0;
	publicVariable "MaxBoats";

	ShopVehicleCount = 0;
	publicVariable "ShopVehicleCount";

	CrateCount = 0;
	publicVariable "CrateCount";

	hint "All counters reset to 0";
};

switch (_counter) do {
	case "MaxTanks": {
		MaxTanks = 0;
		publicVariable "MaxTanks";
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
		MaxAPC = 0;
		publicVariable "MaxAPC";
		hint "MaxAPC reset to 0";
	};
	case "MaxBoats": {
		MaxBoats = 0;
		publicVariable "MaxBoats";
		hint "MaxBoats reset to 0";
	};
	case "ShopVehicleCount": {
		ShopVehicleCount = 0;
		publicVariable "ShopVehicleCount";
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
