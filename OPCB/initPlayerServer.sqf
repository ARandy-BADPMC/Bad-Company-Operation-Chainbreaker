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

_playerUnit setVariable ["InitDone", true, true];