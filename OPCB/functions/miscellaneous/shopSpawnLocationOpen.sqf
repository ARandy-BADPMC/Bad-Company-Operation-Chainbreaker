params ["_shopType", "_payload", "_normalMarker"];
if (!hasInterface) exitWith {};

uiNamespace setVariable ["OPCB_pendingShopSpawn", [_shopType, _payload, _normalMarker]];
uiNamespace setVariable ["OPCB_shopSpawnConfirmed", false];
closeDialog 0;

[] spawn {
    uiSleep 0.05;
    if !(createDialog "shopSpawnLocation") exitWith {
        uiNamespace setVariable ["OPCB_pendingShopSpawn", nil];
    };

    private _list = (findDisplay 74820) displayCtrl 74821;
    private _request = uiNamespace getVariable ["OPCB_pendingShopSpawn", []];
    if (_request isEqualTo []) exitWith { closeDialog 0; };
    private _normalMarker = _request select 2;

    _list lbAdd "Normal shop spawn";
    _list lbSetData [lbSize _list - 1, _normalMarker];

    {
        if ((_x find "Fob_spawner") == 0) then {
            private _label = markerText _x;
            if (_label == "") then { _label = _x; };
            _list lbAdd _label;
            _list lbSetData [lbSize _list - 1, _x];
        };
    } forEach allMapMarkers;

    _list lbSetCurSel 0;
};
