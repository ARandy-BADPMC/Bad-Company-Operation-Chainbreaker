if (!isServer) exitWith {};

if (isNil "OPCB_civBaseMaxAIPerPlayer") then {
    OPCB_civBaseMaxAIPerPlayer = missionNamespace getVariable ["maxAIPerPlayer", 2.8];
};
if (isNil "OPCB_civBaseEastVehicleNum") then {
    OPCB_civBaseEastVehicleNum = missionNamespace getVariable ["eastVehicleNum", 8];
};

private _relation = missionNamespace getVariable ["OPCB_civRelation", 50];
private _pressure = (((50 - _relation) / 50) max 0) min 1;
private _extra = (((30 - _relation) / 30) max 0) min 1;
// +1 step per 10 trust lost below 40
private _steps = (ceil ((40 - _relation) / 10)) max 0;
maxAIPerPlayer = OPCB_civBaseMaxAIPerPlayer + (1.2 * _pressure) + (0.5 * _steps);
publicVariable "maxAIPerPlayer";
eastVehicleNum = OPCB_civBaseEastVehicleNum + round ((4 * _pressure) + (3 * _extra));

OPCB_townCivs = (missionNamespace getVariable ["OPCB_townCivs", []]) select {!isNull _x};
{ [_x] call CHAB_fnc_civApplyTrustState; } forEach OPCB_townCivs;
