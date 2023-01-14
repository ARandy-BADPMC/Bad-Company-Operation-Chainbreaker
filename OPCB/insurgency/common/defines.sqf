#define DEBUG		false

//Constants
#define VIEWDISTANCE		3500
#define SPAWNRANGE 			ins_AIspawnMaxRange
#define WEP_DESPAWN_RANGE	1000

//AI
#define infDeleteTime		180

#define eastStationaryGuns	["rhs_KORD_high_MSV","rhsgref_ins_DSHKM","RHS_ZU23_MSV","RHS_AGS30_TriPod_MSV"]

#define eastRanks			["CAPTAIN","LIEUTENANT","SERGEANT","CORPORAL","PRIVATE"] 

#define IEDList             ["IEDUrbanSmall_Remote_Mag","IEDUrbanBig_Remote_Mag","IEDLandSmall_Remote_Mag","IEDLandBig_Remote_Mag"]

//Misc Functions

#define startLocation (markerpos "base_marker")

// getDirTo - vector of X towards Y in degrees while Y can be either a position or an object; 
// if X is in the East of Y, vector is from 0.01° to 179.99° and if on the West it's from -0.01° to -179.99° (N is 0°, S is 180°)
#define getDirTo(X,Y)       (((if(typeName Y == "OBJECT")then{getPosATL Y}else{Y} select 0) - (getPosATL X select 0)) atan2 ((if(typeName Y == "OBJECT")then{getPosATL Y}else{Y} select 1) - (getPosATL X select 1)))  

aiMonitorRemote = {
	_ai  = _this select 0;
	_plr = _this select 1;
	_gun = _this select 2;
	if !isNull _ai then {
		_ai reveal _plr;
		_ai setUnitPos "UP";
		//_ai doWatch _plr;
		_ai doWatch (getpos _plr);
		_ai doMove getPosATL _plr;
		
		// RPG-wielders in arma 3 won't do shit against infantry unless ordered to "suppress"
		if (((primaryWeapon _ai) == "") && {(secondaryWeapon _ai) != ""}) then {
			_ai doSuppressiveFire _plr;
		};
	};
	if !isNull _gun then {
		_gun reveal _plr;
		/*
		_dir = ((getPosATL _plr select 0) - (getPosATL _gun select 0)) atan2 ((getPosATL _plr select 1) - (getPosATL _gun select 1)); 
		group _gun setFormDir _dir;		
		_gun doTarget _plr;
		sleep 5;
		_curTime = time;
		while { time - _curTime < 5 } do {
			vehicle _gun fireAtTarget [_plr,currentWeapon vehicle _gun];
			sleep (0.1 + random 0.2);
		};
		*/
		private _target = assignedTarget _gun;
		if (!isNull _target) then {
			_gun doSuppressiveFire _target;
		};
	};
};