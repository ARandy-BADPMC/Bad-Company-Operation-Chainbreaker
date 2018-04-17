_unit = _this select 0;
_unitid = _this select 1;
_player = _this select 2;

_pipcam = "camera" camCreate [0,0,0];
_allscreens = _player getVariable ["allscreens",0];
_target = str(_allscreens) + "screen";
_player setVariable ["allscreens",_allscreens +1];
_pipcam cameraEffect ["Internal", "Back", _target];
_pipcam camSetFov 0.5;

_campos = eyePos _unit;
_pipcam setpos _campos;
_pipcam setDir ((eyeDirection _unit) select 0);
_pipcam attachTo [_unit,[0.05,0.02,0.15],"head"];

_final = [_unitid,_pipcam,_target];
_cams = _player getVariable["cams",[]];
_cams pushBack _final;
_player setVariable["cams",_cams];