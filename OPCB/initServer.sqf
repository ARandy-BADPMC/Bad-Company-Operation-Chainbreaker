#include "data\unitTypes.sqf"
#include "economy\vehicleCargoSpaces.sqf";
#include "economy\vehicleAttackTypes.sqf";
#include "economy\crateCargoSizes.sqf";

enableSaving [false, false];
enableSentences true;
enableTeamswitch false;
["Initialize"] call BIS_fnc_dynamicGroups;
[] execVM "Scripts\ied.sqf";

Resistance setFriend [EAST, 1]; Resistance setFriend [WEST, 0]; Resistance setFriend [Civilian, 1];

EAST setFriend [Resistance, 1]; EAST setFriend [WEST, 0]; EAST setFriend [Civilian, 1];	

WEST setFriend [EAST, 0]; WEST setFriend [Resistance, 0]; WEST setFriend [Civilian, 1]; 	

Civilian setFriend [EAST, 1]; Civilian setFriend [WEST, 1]; Civilian setFriend [Resistance, 1];

Hz_pers_var_insurgencyClearedMarkers = [];
centerOfGridRetakingStr = "";
Hz_pers_var_boughtFobs = [];
publicVariable "centerOfGridRetakingStr";
publicVariable "Hz_pers_var_boughtFobs";

Hz_pers_customLoadFunction = compileFinal preprocessFileLineNumbers "Hz_pers_customLoadFunction.sqf";
Hz_pers_firstTimeLaunchFunction = compileFinal preprocessFileLineNumbers "Hz_pers_firstTimeLaunchFunction.sqf";	
OPCB_crateSpawner_fnc_spawnCrate_server = compileFinal preprocessFileLineNumbers "economy\fnc\OPCB_crateSpawner_fnc_spawnCrate_server.sqf";

#include "functions\BADCO_Arsenal.sqf"


// tier count is 0-based in code so it goes from 9 to 0! (T10 = 9, T1 = 0)
OPCB_econ_currentTier = 9;
publicVariable "OPCB_econ_currentTier";	
OPCB_econ_credits = 1000;
publicVariable "OPCB_econ_credits";

IsATaskRunning = false;
TaskNumber = 0;
EnemyGroups = [];
CommanderActionUnderway = false;
DP_Queue = [];

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
MaxBoats = 0;
publicVariable "MaxBoats";

VehicleSpawnerHistory = [];
publicVariable "VehicleSpawnerHistory";

if (isNil "OPCB_nextMissionTime") then {
    OPCB_nextMissionTime = 0;
    publicVariable "OPCB_nextMissionTime";
};

{
	_x allowDamage false;
	[_x, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim;
} forEach [officer_jeff,tank_spawner,heli_jeff,boat_jeff_1,officer_pmc]; 

globalWaterPos = [3067.06,16839.7,10.1122]; //universal for all maps, has to be changed manually 

CityMarker = createMarker ["citymarker",  getpos officer_jeff];

_axis = worldSize / 2;
_center = [_axis, _axis , 0];

#include "data\blackListedCities.sqf";

Cities = nearestLocations [_center, ["NameCity","NameCityCapital","NameVillage"], _axis] select { !((text _x) in _blackListedCities)};

// for AI -- let's see if this strains the server too much (with more AI)
setViewDistance 3500;
setObjectViewDistance 3500;

boat_jeff_1 disableConversation true;
tank_spawner disableConversation true;
heli_jeff disableConversation true;
jeff disableConversation true;
officer_pmc disableConversation true;

addMissionEventHandler ["PlayerDisconnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	{
		_playerUid = _x getVariable "ZeusUser";
		if(isNil "_playerUid" || _playerUid == _uid) then {
			deleteVehicle _x
		};
	} forEach allCurators;
}];

[] spawn {
	while {true} do {
		if (fog > 0.005) then {
			1 setFog 0;
		};
		sleep 1800;
	};
};

private _year = date select 0;
private _month = date select 1;
private _day = date select 2;

private _hour = floor (random 24);
private _minute = floor (random 60);

setDate [_year, _month, _day, _hour, _minute];