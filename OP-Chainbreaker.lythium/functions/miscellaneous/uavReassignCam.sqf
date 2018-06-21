_marker = _this select 0;
_cam = player getVariable ["uav_cam",0];

if (typeName _cam isEqualTo "OBJECT") then {
	_uav_cam camSetTarget _cam;
}
else
{
	_uav_cam camSetTarget (getMarkerPos _cam);
};