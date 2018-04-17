_start = uav_drone selectionPosition "laserstart";
_end = uav_drone selectionPosition "commanderview";
_vdir = _start vectorFromTo _end;
_vSide = [-(_vDir select 1), _vDir select 0, 0];
_vUp = _vDir vectorCrossProduct _vSide;

_uav_cam = "camera" camCreate [0,0,0];
_uav_cam cameraEffect ["Internal", "Back", "uavrtt"];

_uav_cam attachTo [uav_drone, [0,0,0], "laserstart"];

_uav_cam camSetFov 0.05; //0.01 - 8.5 ig

"uavrtt" setPiPEffect [2]; //2 thermal, 1 NV

/*_camtrg = "Sign_Sphere10cm_F" createVehicleLocal position _uav_cam;
hideObject _camtrg;
_camtrg attachTo [uav_drone, [0,0,0], "commanderview"];*/

/*_cmtarget = missionNamespace getVariable ["uavTarget",jeff];
if (typeName _cmtarget isEqualTo "OBJECT") then {
	_uav_cam camSetTarget _cmtarget;
}
else
{
	_uav_cam camSetTarget (getMarkerPos _cmtarget);
};*/
//_uav_cam camCommit 1;
_bb = testpc;
_bb setObjectTexture [0, "#(argb,512,512,1)r2t(uavrtt,1)"];

player setVariable ["uav_cam",_uav_cam];

addMissionEventHandler ["Draw3D", {
	_uav_cam = player getVariable ["uav_cam",0];
    _dir = 
        (uav_drone selectionPosition "laserstart") 
            vectorFromTo 
        (uav_drone selectionPosition "commanderview");
    _uav_cam setVectorDirAndUp [
        _dir, 
        _dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]
    ];
}];