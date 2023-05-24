call compile preprocessFileLineNumbers "unitTypes.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;
call compileFinal preprocessfilelinenumbers "functions\BADCO_skin_applier.sqf";
call compileFinal preprocessfilelinenumbers "Scripts\BADCO_Arsenal.sqf";

IsATaskRunning = false;
TaskSpot = [5840,5700,0];
TaskNumber = 0;
EnemyGroups = [];
ChapoTrigger = false;

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

ZeusGroup = createGroup sideLogic;

{
	_x allowDamage false;
	[_x, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim;
} forEach [officer_jeff,tank_spawner,heli_jeff]; 

globalWaterPos = [3067.06,16839.7,10.1122]; //universal for all maps, has to be changed manually 
WorldCenter = [5840,5700,0];

CityMarker = createMarker ["citymarker",  getpos officer_jeff];

Cities = nearestLocations [[5840,5700,0], ["NameCity","NameCityCapital","NameVillage"], 8000];

// for AI -- let's see if this strains the server too much (with more AI)
setViewDistance 3500;
setObjectViewDistance 3500;
