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

{
	_x allowDamage false;
	[_x, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim;
} forEach [officer_jeff,tank_spawner,heli_jeff,boat_jeff_1]; 

globalWaterPos = [3067.06,16839.7,10.1122]; //universal for all maps, has to be changed manually 

CityMarker = createMarker ["citymarker",  getpos officer_jeff];

_axis = worldSize / 2;
_center = [_axis, _axis , 0];

#include "data\blackListedCities.sqf";

Cities = nearestLocations [_center, ["NameCity","NameCityCapital","NameVillage"], _axis] select { !((text _x) in _blackListedCities)};

// for AI -- let's see if this strains the server too much (with more AI)
setViewDistance 3500;
setObjectViewDistance 3500;

addMissionEventHandler ["PlayerDisconnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	{
		_playerUid = _x getVariable "ZeusUser";
		if(isNil "_playerUid" || _playerUid == _uid) then {
			deleteVehicle _x
		};
	} forEach allCurators;
}];
