#include "unitTypes.sqf"
#include "data\helicopterLoadouts.sqf"

enableSaving [false, false];
enableSentences true;
enableTeamswitch false;


call compileFinal preprocessFileLineNumbers "economy\init.sqf";

[] execVM "Scripts\ied.sqf";
[] execVM "insurgency\init.sqf";
[] execVM "Vcom\VcomInit.sqf";

Resistance setFriend [EAST, 1]; Resistance setFriend [WEST, 0]; Resistance setFriend [Civilian, 1];

EAST setFriend [Resistance, 1]; EAST setFriend [WEST, 0]; EAST setFriend [Civilian, 1];	

WEST setFriend [EAST, 0]; WEST setFriend [Resistance, 0]; WEST setFriend [Civilian, 1]; 	

Civilian setFriend [EAST, 1]; Civilian setFriend [WEST, 1]; Civilian setFriend [Resistance, 1];

Hz_pers_var_insurgencyClearedMarkers = [];
Hz_pers_customLoadFunction = compileFinal preprocessFileLineNumbers "Hz_pers_customLoadFunction.sqf";
Hz_pers_firstTimeLaunchFunction = compileFinal preprocessFileLineNumbers "Hz_pers_firstTimeLaunchFunction.sqf";	

["Initialize"] call BIS_fnc_dynamicGroups;
#include "functions\BADCO_Arsenal.sqf"

IsATaskRunning = false;
TaskNumber = 0;
EnemyGroups = [];

CrateCount = 0;
publicVariable "CrateCount";
MaxTanks = 0;
publicVariable "MaxTanks";
MaxAttackHelis = 0;
publicVariable "MaxAttackHelis";
MaxTransHelis = 0;
publicVariable "MaxTransHelis";
MaxAPC = 0;
publicVariable "MaxAPC";
MaxStatic = 0;
publicVariable "MaxStatic";

Developers = ["76561198117073327","76561198142692277","76561198002110130","76561198048254349"];  //76561198142692277 -Alex. K., 76561198117073327 - A.Randy,
publicVariable "Developers";

ZeusGroup = createGroup sideLogic;

{
	_x allowDamage false;
	[_x, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim;
} forEach [officer_jeff,tank_spawner,heli_jeff]; 

globalWaterPos = [3067.06,16839.7,10.1122]; //universal for all maps, has to be changed manually 

CityMarker = createMarker ["citymarker",  getpos officer_jeff];

_axis = worldSize / 2;
_center = [_axis, _axis , 0];

Cities = nearestLocations [_center, ["NameCity","NameCityCapital","NameVillage"], _axis];

// for AI -- let's see if this strains the server too much (with more AI)
setViewDistance 3500;
setObjectViewDistance 3500;

