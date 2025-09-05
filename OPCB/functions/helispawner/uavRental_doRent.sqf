disableSerialization;
#include "..\..\data\uavRentalClassnames.sqf"

private _disp = findDisplay 9915;
if (isNull _disp) exitWith { systemChat "[UAV RENT] dialog not found"; };
private _lb  = _disp displayCtrl 1500;
if (isNull _lb) exitWith { systemChat "[UAV RENT] listbox not found"; };
private _idx = lbCurSel _lb;  if (_idx < 0) exitWith { systemChat "[UAV RENT] nothing selected"; };


private _classname = _lb lbData _idx;
private _entry     = OPCB_uavRental_list select _idx;
private _name      = _entry select 0;
private _cost      = _entry select 2;
private _refund    = _entry select 3;

if (getMarkerPos "aircraft_spawner" isEqualTo [0,0,0]) exitWith { hint "Marker 'aircraft_spawner' missing"; };

if (isNil "OPCB_econ_credits") then { OPCB_econ_credits = 0; };
if (OPCB_econ_credits < _cost) exitWith { hint "Not enough credits."; };
OPCB_econ_credits = OPCB_econ_credits - _cost;
publicVariable "OPCB_econ_credits";

[(getPlayerUID player), _classname] remoteExecCall ["CHAB_fnc_uavRental_spawn_server", 2];

hint format ["%1 rented for %2 C. Return alive at Jeff for %3 C back.", _name, _cost, _refund];
closeDialog 0;
