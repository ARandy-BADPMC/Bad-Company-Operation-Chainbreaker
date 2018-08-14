["Initialize"] call BIS_fnc_dynamicGroups; // Initializes the Dynamic Groups framework	
call compile preprocessfilelinenumbers "functions\heliskinapply.sqf";
call compile preprocessFileLineNumbers "functions\retrieve.sqf";
missionNamespace setVariable ["running_task",0];
missionNamespace setVariable ["zeus_enabled",0];
missionNamespace setVariable ["current_task","asd"];
missionNamespace setVariable ["TaskObjective","none"];
missionNamespace setVariable ["uavTarget",jeff];

uav_drone lockDriver true; 
uav_drone enableUAVWaypoints false;

uav_drone addEventHandler["Fuel",
{
	_vehicle = _this select 0;
	_fuel = _this select 1;
	if (!_fuel) then {
		[_vehicle,1] remoteExecCall ["setFuel",_vehicle,false];
		[_vehicle,true] remoteExecCall ["engineOn",_vehicle,false];
		//_vehicle engineOn true;
	};
}];

//uav_drone lockCameraTo [jeff, [0]];
uav_drone flyInHeight 2500;

_wp = group uav_drone addWaypoint [position jeff, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointLoiterRadius 2500;

[] spawn {
	while {true} do {
		_istask = missionNamespace getVariable ["running_task",0];
		if (_istask == 1) then 
		{
			_objective = missionNamespace getVariable ["TaskObjective","none"];
			if (_objective isEqualTo "none") then {
				sleep 60;
			}
			else
			{
				if (_objective isEqualTo "IDAP" || _objective isEqualTo "Retrieve" || _objective isEqualTo "Attack" || _objective isEqualTo "Minefield" || _objective isEqualTo "Clear out") then 
				{
					_marker = missionNamespace getVariable ["citymarker",jeff];
					[_marker] call CHAB_fnc_sendDrone;
				}
				else
				{
					_marker = missionNamespace getVariable ["current_task",jeff];
					[_marker] call CHAB_fnc_sendDrone;
				};
			};
			waitUntil {
			  sleep 1;
			
			  (missionNamespace getVariable ["running_task",0]) == 0
			};
		}
		else
		{
			sleep 60;
		};
	};
};

["player_camera_delete", "onPlayerDisconnected", {

[_uid] remoteExecCall ["CHAB_fnc_delete_cam",-2,false];

}] call BIS_fnc_addStackedEventHandler;

officer_jeff allowDamage false;
[officer_jeff, "LISTEN_BRIEFING", "NONE"] call BIS_fnc_ambientAnim;

[tank_spawner, "LISTEN_BRIEFING", "NONE"] call BIS_fnc_ambientAnim;
tank_spawner allowDamage false;

heli_jeff allowDamage false;
[heli_jeff, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim; 

_citymarker = createMarker ["citymarker",  getpos officer_jeff];
missionNamespace setVariable ["citymarker",_citymarker];

fnc_cleanup = compileFinal preprocessFileLineNumbers "cleanup.sqf";

[] spawn {

	while {true} do {        

		[] call fnc_cleanup;

	sleep 1200;
	};
};
/*
flares_server =
{
	_markpos = [getPos (_this select 0), random 150, random 359] call BIS_fnc_relPos;
	artilerry1 commandArtilleryFire [_markpos,getArtilleryAmmo [artilerry1] select 1,1];
	artilerry2 commandArtilleryFire [_markpos,getArtilleryAmmo [artilerry2] select 1,1];
};*/

[] execVM "EPD\Ied_Init.sqf";
