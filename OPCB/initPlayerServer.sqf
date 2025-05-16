params ["_playerUnit", "_didJIP"];

_uid = getPlayerUID _playerUnit;
_playerNetId = netId _playerUnit;
private ["_whiteList"];
if(!isDedicated) then {
	_whiteList = [_uid];
} else {
	_whiteList = parseSimpleArray (preprocessFile "badco_data\whitelist.sqf");
};

if (_uid in _whiteList) then {
	_playerUnit setVariable ["WhiteListed", true, true];
};

#include "data\developers.sqf";

if(_uid in _developers) then {
	_playerUnit setVariable ["Developer", true, true];
};

#include "data\admin_spectators.sqf";

if(_uid in _admin_spectators) then {
	_playerUnit setVariable ["AdminSpectator", true, true];
};

private _zoneWhiteList = [];
if (!isDedicated) then {
    _zoneWhiteList = [_uid];
} else {
    _zoneWhiteList = parseSimpleArray (preprocessFile "data\zonewhitelist.sqf");
};

if (_uid in _zoneWhiteList) then {
    _playerUnit setVariable ["zonelisted", true, true];
};


_playerUnit setVariable ["InitDone", true, true];


