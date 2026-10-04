params ["_delta"];
if (!isServer) exitWith {};

private _relation = missionNamespace getVariable ["OPCB_civRelation", 50];
OPCB_civRelation = ((_relation + _delta) max 0) min 100;
publicVariable "OPCB_civRelation";
call CHAB_fnc_civRelationsUpdatePressure;
