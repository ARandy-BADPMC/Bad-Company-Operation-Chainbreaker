_crateCount = missionNamespace getVariable ["crateCount",0];

if (_crateCount > 19) exitWith {
	hint "You have reached the box limit!";
	closeDialog 0;
};

_ctrl = (findDisplay 74815) displayCtrl 1500;
_select = lbCurSel _ctrl;
_tankpos = getPos tank_spawnpos;

if (_select != -1) then {

	_nObjects = nearestObjects [_tankpos, ["all"], 7];
	if (count _nObjects <= 1) then {
	
		_crateType = _ctrl lbData _select;
		
		hint "Box delivered";
			
		missionNamespace setVariable ["crateCount",_crateCount + 1,true];
		
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
			if (local (_this select 0)) then {
				_crateCount = missionNamespace getVariable ["crateCount",1];
				_crateCount = _crateCount -1;
				missionNamespace setVariable ["crateCount",_crateCount,true];
			};
		}];
		
		if (_crateType != "ACE_MEDICALSUPPLYCRATE") then {
			clearBackpackCargoGlobal _crate;
			clearWeaponCargoGlobal _crate;
			clearMagazineCargoGlobal _crate;
			clearItemCargoGlobal _crate;
		};
		
	} else {
		hint "Spawn position is not empty";
	};

} else {
	hint "Select a box first";
};

closeDialog 0;