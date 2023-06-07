disableSerialization;
createDialog "jey_tankspawner";

waitUntil {
  !isNull (findDisplay 9901) && { !(isNil "OPCB_econ_initDone") && {OPCB_econ_initDone}}
};

private _isEngineer = false;
#include "..\..\data\vehicleDriverUnitTypes.sqf";
if ((typeOf player) in _tankDriverTypes) then {
	_isEngineer = true;
};

private _vehicles = [];
{
	if ((["INF", _x] call OPCB_econ_fnc_getVehicleTier) >= OPCB_econ_currentTier) then {
		_vehicles pushBack _x;
	};
} foreach OPCB_econ_vehicleTypes_INF;

if (_isEngineer) then {
	{
		if ((["ENG", _x] call OPCB_econ_fnc_getVehicleTier) >= OPCB_econ_currentTier) then {
			_vehicles pushBack _x;
		};
	} foreach OPCB_econ_vehicleTypes_ENG;
};

_ctrl = (findDisplay 9901) displayCtrl 1500;
_imageCtrl = (findDisplay 9901) displayCtrl 1608;
 
{
	_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_ctrl lbAdd _text;
	_ctrl lbSetData [_foreachIndex,_x]; 
} forEach _vehicles;
_ctrl lbSetSelected [0, true];

_classname = _ctrl lbData 0;
_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
_imageCtrl ctrlSetText _picture;

_ctrl ctrlAddEventHandler ["LBSelChanged",{
	params ["_control", "_selectedIndex"];
	
	_classname = _control lbData _selectedIndex;
	_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
	_imageCtrl = (findDisplay 9901) displayCtrl 1608;
	_imageCtrl ctrlSetText _picture;
	
	_ctrl = (findDisplay 9901) displayCtrl 1001;
	_tier = ["INF", _classname] call OPCB_econ_fnc_getVehicleTier;
	_cost = 0;
	
	if (_tier == -1) then {
		// must be ENG vehicle
		_tier = ["ENG", _classname] call OPCB_econ_fnc_getVehicleTier;
		_cost = ["ENG", _tier] call OPCB_econ_fnc_getTierCost;
	} else {
		_cost = ["INF", _tier] call OPCB_econ_fnc_getTierCost;
	};
	
	
	_textFormat = "<t color='#07FFFF'>Vehicle Cost:   </t><t>" + (str _cost) + " C" + "</t><t color='#07FFFF'>        Vehicle Tier:   </t><t>" + (str (_tier + 1)) + "</t><t color='#07FFFF'>        Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
	_ctrl ctrlSetStructuredText parseText _textFormat;
	
}];

_ctrl = (findDisplay 9901) displayCtrl 1001;

_tier = ["INF", _classname] call OPCB_econ_fnc_getVehicleTier;
_cost = 0;

if (_tier == -1) then {
	// must be ENG vehicle
	_tier = ["ENG", _classname] call OPCB_econ_fnc_getVehicleTier;
	_cost = ["ENG", _tier] call OPCB_econ_fnc_getTierCost;
} else {
	_cost = ["INF", _tier] call OPCB_econ_fnc_getTierCost;
};

_textFormat = "<t color='#07FFFF'>Vehicle Cost:   </t><t>" + (str _cost) + " C" + "</t><t color='#07FFFF'>        Vehicle Tier:   </t><t>" + (str (_tier + 1)) + "</t><t color='#07FFFF'>        Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
_ctrl ctrlSetStructuredText parseText _textFormat;
