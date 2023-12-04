disableSerialization;
createDialog "staticspawner";

waitUntil {
  !isNull (findDisplay 74817) && { !(isNil "OPCB_econ_initDone") && {OPCB_econ_initDone}}
};

private _vehicles = [];
{
	if ((["STAT", _x] call OPCB_econ_fnc_getVehicleTier) >= OPCB_econ_currentTier) then {
		_vehicles pushBack _x;
	};
} foreach OPCB_econ_vehicleTypes_STAT;

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
	_tier = ["STAT", _classname] call OPCB_econ_fnc_getVehicleTier;
	_cost = ["STAT", _tier] call OPCB_econ_fnc_getTierCost;
	
	_textFormat = "<t color='#07FFFF'>Static Cost:   </t><t>" + (str _cost) + " C" + "</t><t color='#07FFFF'>        Static Tier:   </t><t>" + (str (_tier + 1)) + "</t><t color='#07FFFF'>        Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
	_ctrl ctrlSetStructuredText parseText _textFormat;
	
}];

_ctrl = (findDisplay 9901) displayCtrl 1001;

_tier = ["STAT", _classname] call OPCB_econ_fnc_getVehicleTier;
_cost = ["STAT", _tier] call OPCB_econ_fnc_getTierCost;

_textFormat = "<t color='#07FFFF'>Static Cost:   </t><t>" + (str _cost) + " C" + "</t><t color='#07FFFF'>        Static Tier:   </t><t>" + (str (_tier + 1)) + "</t><t color='#07FFFF'>        Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
_ctrl ctrlSetStructuredText parseText _textFormat;
