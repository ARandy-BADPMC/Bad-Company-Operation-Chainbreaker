_callerRE = remoteExecutedOwner;

if (CrateCount > 19) exitWith {
	"You have reached the box limit!" remoteExec ["hint", _callerRE];
};

_ctrl = (findDisplay 74815) displayCtrl 1500;
_select = lbCurSel _ctrl;
_tankpos = markerPos "tank_spawner";

if (_select != -1) then {

	_nObjects = nearestObjects [_tankpos, ["all"], 7];
	if (count _nObjects <= 1) then {
	
		_crateType = _ctrl lbData _select;
		
		"Box delivered" remoteExec ["hint", _callerRE];
			
		CrateCount = CrateCount + 1;
		
		_crate = _crateType createVehicle (_tankpos);	
		_crate setdir 40;
		
		_cargoRequirement = 0;
		{
			if ((_x select 0) == _crateType) exitWith {
				_cargoRequirement = _x select 1;
			};
		} foreach OPCB_econ_vehicleCargoSizes;
		
		[_crate, _cargoRequirement] call ace_cargo_fnc_setSize;
		
		_crate call Hz_pers_API_addCrate;
		
		_crate addMPEventHandler ["MPKilled",
		{
			if (isServer) then {
				CrateCount = CrateCount - 1;
			};
		}];
		
		if (_crateType != "ACE_MEDICALSUPPLYCRATE") then {
			clearBackpackCargoGlobal _crate;
			clearWeaponCargoGlobal _crate;
			clearMagazineCargoGlobal _crate;
			clearItemCargoGlobal _crate;
		};
		
	} else {
		"Spawn position is not empty" remoteExec ["hint", _callerRE];
	};

} else {
	"Select a box first" remoteExec ["hint", _callerRE];
};