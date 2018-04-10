
if (!isServer) exitWith {
	diag_log "** CleanUP: This is no server/host  EXITING!! **";
};

if ((count _this) > 1)    exitWith {
	diag_log "** CleanUP: To many params passed, only none or one parameters allowed (trigger or 'markername') **";
};

private [
	"_remove_empty_groups", "_remove_gear", "_remove_dead", "_remove_deadveh", "_remove_empty_damveh",
	"_remove_emptyveh", "_set_maxvehdam", "_remove_ruins", "_i", "_rem_count", "_break"
];

//----------------------------EDIT DOWN THERE------------------------------------------------------//

_remove_empty_groups = false;    //true to delete all empty groups
_remove_empty_damveh = true;    //true to delete all damaged vehicles without crew
_remove_emptyveh = false;       //true to delete all vehicles without crew
_remove_ruins = false;           //true to delete destroyed buildings, objects
_remove_gear = true;            //true to delete all dropped gear
_remove_dead = false;            //true to delete all dead bodies
_remove_deadveh = false;         //true to delete all wrecks
_set_maxvehdam = 0.8;           //value 0.1 - 0.95 set the damage threshold above which vehicles should be deleted.                           


_rem_count = [];
_i= 0;
_break = false;

if ((count _this) < 1) then {

	diag_log format [
		"** CleanUP: running for whole %1 with:
		empty groups %2,
		damaged vehicles %3,
		empty vehicles %4,
		ruins %5,
		dropped gear %6,
		all killed %7,
		wrecks %8,
		veh damage threshold %9**",
		worldName,
		_remove_empty_groups,
		_remove_empty_damveh,
		_remove_emptyveh,
		_remove_ruins,
		_remove_gear,
		_remove_dead,
		_remove_deadveh,
		_set_maxvehdam
	];

	if (_remove_dead) then {

		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				deleteVehicle _x;
				_i = _i + 1;
			};
		} forEach allDeadMen;
	};

	_rem_count set [0, _i];
	_i= 0;

	if (_remove_gear) then {

		private _szrot_obj = (
			allMissionObjects "WeaponHolder" +
			allMissionObjects "GroundWeaponHolder" +
			allMissionObjects "WeaponHolderSimulated"
		);
		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				deleteVehicle _x;
				_i = _i + 1;
			};
		} forEach _szrot_obj;
	};

	_rem_count set [1, _i];
	_i= 0;

	if (_remove_ruins) then {

		private _ruins = allMissionObjects "Ruins";
		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				deleteVehicle _x;
				_i = _i + 1;
			};
		} forEach _ruins;
	};

	_rem_count set [2, _i];
	_i= 0;

	if (_remove_deadveh) then {

		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				 _x setdamage 1;
				_i = _i + 1;
			};  
		} forEach allDead;
	};

	_rem_count set [3, _i];
	_i= 0;

	if (_remove_empty_damveh) then {

		{
			if ((damage _x > _set_maxvehdam || {!canMove _x}) && {{alive _x} count crew _x == 0}) then {

				if !(_x getVariable ["dnt_remove_me",false]) then {
					 _x setdamage 1;
					_i = _i + 1;
				};
			};
		} forEach vehicles;
	};

	_rem_count set [4, _i];
	_i= 0;

	if (_remove_emptyveh) then {

		{                    
			if ({alive _x} count crew _x == 0) then {

				if !(_x getVariable ["dnt_remove_me",false]) then {
					 _x setdamage 1;
					_i = _i + 1;
				};
			};
		} forEach vehicles;
	};

	_rem_count set [5, _i];
	_i= 0;

	if (_remove_empty_groups) then {

		{
			if ((count (units _x)) == 0) then {
				deleteGroup _x;
				_x = grpNull;
				_x = nil;
				_i = _i + 1;
			};
		} foreach allGroups;
	};

	_rem_count set [6, _i];    

} else {

	params ["_zoneName"];

	diag_log format [
		"** CleanUP: running for zone %1 with:
		empty groups %2,
		damaged vehicles %3,
		empty vehicles %4,
		ruins %5,
		dropped gear %6,
		all killed %7,
		wrecks %8,
		veh damage threshold %9
		**", 
		_zoneName, 
		_remove_empty_groups, 
		_remove_empty_damveh, 
		_remove_emptyveh,
		_remove_ruins, 
		_remove_gear, 
		_remove_dead, 
		_remove_deadveh, 
		_set_maxvehdam
	];

	switch (typeName _zoneName) do {

		case "STRING": {
			if !(_zoneName in allMapMarkers) then {
				_break = true;
			};
		};
		
		case "OBJECT": {
			if !(_zoneName isKindOf "EmptyDetector") then {
				_break = true;
			};
		};
		default {_break = true;};
	};

	if (_break) exitWith {
		diag_log "** CleanUP: wrong param passed, only trigger or 'markername' allowed **";
	};

	if (_remove_dead) then {

		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				deleteVehicle _x;
				_i = _i + 1;
			};  
		} forEach (allDeadMen inAreaArray _zoneName);
	};

	_rem_count set [0, _i];
	_i= 0;

	if (_remove_gear) then {

		private _szrot_obj = (
		allMissionObjects "WeaponHolder" +
		allMissionObjects "GroundWeaponHolder" +
		allMissionObjects "WeaponHolderSimulated"
		) inAreaArray _zoneName;

		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				deleteVehicle _x;
				_i = _i + 1;
			};   
		} forEach _szrot_obj;
	};

	_rem_count set [1, _i];
	_i= 0;

	if (_remove_ruins) then {

		private _ruins = (allMissionObjects "Ruins") inAreaArray _zoneName;

		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				deleteVehicle _x;
				_i = _i + 1;       
			};
		} forEach _ruins;
	};

	_rem_count set [2, _i];
	_i= 0;

	if (_remove_deadveh) then {

		{
			if !(_x getVariable ["dnt_remove_me",false]) then {
				 _x setdamage 1;
				_i = _i + 1;
			};
		} forEach (vehicles inAreaArray _zoneName);
	};

	_rem_count set [3, _i];
	_i= 0;

	if (_remove_empty_damveh) then {

		{
			if ((damage _x > _set_maxvehdam || {!canMove _x}) && {{alive _x} count crew _x == 0}) then {

				if !(_x getVariable ["dnt_remove_me",false]) then {
					 _x setdamage 1;
					_i = _i + 1;
				};

			};

		} forEach (vehicles inAreaArray _zoneName);
	};

	_rem_count set [4, _i];
	_i= 0;

	if (_remove_emptyveh) then {

		{                    
			if ({alive _x} count crew _x == 0) then {

				if !(_x getVariable ["dnt_remove_me",false]) then {
					 _x setdamage 1;
					_i = _i + 1;
				};
			};
		} forEach (vehicles inAreaArray _zoneName);
	};

	_rem_count set [5, _i];
	_i= 0;

	if (_remove_empty_groups) then {

		{
			if ((count (units _x)) == 0) then {
				deleteGroup _x;
				_x = grpNull;
				_x = nil;
				_i = _i + 1;
			};
		} foreach allGroups;
	};

	_rem_count set [6, _i];
};

if !(_break) then {

	diag_log format [
		"** CleanUP: deleted objects:
		%1 -dead bodies,
		%2 -dropped gear places,
		%3 -destroyed objects,
		%4 -wrecks,
		%5 -empty damaged vehicles,
		%6 -empty vehicles,
		%7 -empty groups
		**",
		_rem_count select 0,
		_rem_count select 1,
		_rem_count select 2,
		_rem_count select 3,
		_rem_count select 4,
		_rem_count select 5,
		_rem_count select 6
	];
};