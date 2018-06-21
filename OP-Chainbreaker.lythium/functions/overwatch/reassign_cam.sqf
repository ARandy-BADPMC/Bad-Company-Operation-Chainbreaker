_playerID = _this select 0;
_player = _this select 1;

_cams = player getVariable["cams",[]];
for "_i" from 0 to count _cams -1 do {
	_item = _cams select _i;
	_unitID = _item select 0;
	_cam = _item select 1;
	if (_unitID isEqualTo _playerID) then {
		_cam attachTo [_player,[0.05,0.02,0.15],"head"];
	};
};