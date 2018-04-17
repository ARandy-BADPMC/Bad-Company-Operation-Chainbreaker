_jip = _this select 0;
_jipuid = _this select 1;
_jipclient = _this select 2;

if ((clientOwner == 2) || (clientOwner == _jipclient)) then 
{
	diag_log format ["jipcam: %1 joined the game",name _jip];
}
else
{
	_localID = getPlayerUID player;
	diag_log format [" playerkecske : %1 %2 %3",_localID,player,clientOwner];
	_pipcam = "camera" camCreate [0,0,0];
	_allscreens = player getVariable ["allscreens",0];
	_target = str(_allscreens) + "screen";
	player setVariable ["allscreens",_allscreens +1];
	_pipcam cameraEffect ["Internal", "Back", _target];
	_pipcam camSetFov 0.5;

	_campos = eyePos _jip;
	_pipcam setpos _campos;
	_pipcam setDir ((eyeDirection _jip) select 0);
	_pipcam attachTo [_jip,[0.05,0.02,0.15],"head"];

	_final = [_jipuid,_pipcam,_target];
	_cams = player getVariable["cams",[]];
	_cams pushBack _final;
	player setVariable["cams",_cams];  
};