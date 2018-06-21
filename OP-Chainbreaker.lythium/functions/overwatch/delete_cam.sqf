_uid = _this select 0;
_cams = player getVariable ["cams",[]];
for "_i" from 0 to count _cams -1 do {
		_item = _cams select _i;
		_unitID = _item select 0;
		_cam = _item select 1;
		if (_unitID isEqualTo _uid) then {
			_cams deleteAt _i;
			//_cam cameraEffect ["terminate","back"];
			camDestroy _cam;
		};
	};
player setVariable ["cams",_cams];