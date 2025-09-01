disableSerialization;
#include "..\..\data\uavRentalClassnames.sqf"

createDialog "flips_uavrental";  // must match the class name above
waitUntil { !isNull (findDisplay 9915) };

private _disp = findDisplay 9915;
private _lb   = _disp displayCtrl 1500;
lbClear _lb;

{
    private _name   = _x select 0;
    private _class  = _x select 1;
    private _cost   = _x select 2;
    private _refund = _x select 3;

    _lb lbAdd format ["%1  —  %2 C  (Get %3 C back)", _name, _cost, _refund];
    _lb lbSetData [_forEachIndex, _class];   // keep exact case (no toUpper)
} forEach OPCB_uavRental_list;

_lb lbSetCurSel 0;

private _txt = format ["<t color='#07FFFF'>Credits Available:</t> <t>%1 C</t>", (missionNamespace getVariable ["OPCB_econ_credits",0])];
(_disp displayCtrl 1001) ctrlSetStructuredText parseText _txt;
