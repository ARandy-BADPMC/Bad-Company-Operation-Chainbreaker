_marker = _this select 0;

while {(count (waypoints group uav_drone)) > 0} do
 {
  deleteWaypoint ((waypoints group uav_drone) select 0);
 };

_wp = group uav_drone addWaypoint [getMarkerPos _marker, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointLoiterRadius 1500;
_wp setWaypointBehaviour "STEALTH";

//uav_drone lockCameraTo [getMarkerPos _marker, [0]];
missionNamespace setVariable ["uavTarget",_marker];

//[_marker] remoteExecCall ["CHAB_fnc_uavReassignCam",-2,false];