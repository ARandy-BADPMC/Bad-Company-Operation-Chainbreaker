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

private _zoneWhitelist = [];

if (isDedicated) then {
 
    _zoneWhitelist = parseSimpleArray (preprocessFile "badco_data/zonewhitelist.sqf");
} else {
       _zoneWhitelist = [];
};

if (_uid in _zoneWhitelist) then {
    _playerUnit setVariable ["zonelisted", true, true];
};

_playerUnit setVariable ["InitDone", true, true];


