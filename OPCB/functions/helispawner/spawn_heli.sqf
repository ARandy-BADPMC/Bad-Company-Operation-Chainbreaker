disableSerialization;
createDialog "jey_helispawner";

waitUntil {
  !isNull (findDisplay 9900) && {!(isNil "OPCB_econ_initDone") && {OPCB_econ_initDone}}
};

#include "..\..\data\vehicleDriverUnitTypes.sqf";

if !((typeof player) in (_jetPilotTypes + _helicopterPilotTypes)) exitWith {

	closeDialog 0;
	hint "You must be a pilot to use the aircraft spawner!";

};

_helicopters = [];

_ctrl = (findDisplay 9900) displayCtrl 1500;
_imageCtrl = (findDisplay 9900) displayCtrl 1618;

{
	if ((["AIR", _x] call OPCB_econ_fnc_getVehicleTier) >= OPCB_econ_currentTier) then {
		_helicopters pushBack _x;
	};
} foreach OPCB_econ_vehicleTypes_AIR;

{
	_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_ctrl lbAdd _text;
	_ctrl lbSetData [_foreachIndex,_x];
} forEach _helicopters;

_ctrl lbSetSelected [0, true];

_classname = _ctrl lbData 0;
_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
_imageCtrl ctrlSetText _picture;

_ctrl ctrlAddEventHandler ["LBSelChanged",{
	params ["_control", "_selectedIndex"];
	
	_classname = _control lbData _selectedIndex;
	_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
	_imageCtrl = (findDisplay 9900) displayCtrl 1618;
	_imageCtrl ctrlSetText _picture;
	
	_ctrl = (findDisplay 9900) displayCtrl 1001;	
	_tier = ["AIR", _classname] call OPCB_econ_fnc_getVehicleTier;
	_cost = ["AIR", _tier] call OPCB_econ_fnc_getTierCost;
		
	_textFormat = "<t color='#07FFFF'>Vehicle Cost:   </t><t>" + (str _cost) + " C" + "</t><t color='#07FFFF'>        Vehicle Tier:   </t><t>" + (str (_tier + 1)) + "</t><t color='#07FFFF'>        Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
	_ctrl ctrlSetStructuredText parseText _textFormat;
	
}];

_ctrl = (findDisplay 9900) displayCtrl 1001;	
_tier = ["AIR", _classname] call OPCB_econ_fnc_getVehicleTier;
_cost = ["AIR", _tier] call OPCB_econ_fnc_getTierCost;
	
_textFormat = "<t color='#07FFFF'>Vehicle Cost:   </t><t>" + (str _cost) + " C" + "</t><t color='#07FFFF'>        Vehicle Tier:   </t><t>" + (str (_tier + 1)) + "</t><t color='#07FFFF'>        Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
_ctrl ctrlSetStructuredText parseText _textFormat;