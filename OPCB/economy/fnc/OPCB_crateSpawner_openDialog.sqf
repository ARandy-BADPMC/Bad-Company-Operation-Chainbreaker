disableSerialization;

waitUntil {
	(!isNil "OPCB_econ_initDone") && {OPCB_econ_initDone}
};

createDialog "crateSpawner";

waitUntil {
  !isNull (findDisplay 74815)
};

_ctrl = (findDisplay 74815) displayCtrl 1500;
_imageCtrl = (findDisplay 74815) displayCtrl 1608;
 
{
	_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_ctrl lbAdd _text;
	_ctrl lbSetData [_foreachIndex,_x]; 
} forEach OPCB_econ_crateTypes;
_ctrl lbSetSelected [0, true];

_classname = _ctrl lbData 0;
_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
_imageCtrl ctrlSetText _picture;

_ctrl ctrlAddEventHandler ["LBSelChanged",{
	params ["_control", "_selectedIndex"];
	
	_classname = _control lbData _selectedIndex;
	_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
	_imageCtrl = (findDisplay 74815) displayCtrl 1608;
	_imageCtrl ctrlSetText _picture;
	
	_ctrl = (findDisplay 74815) displayCtrl 1001;
	
	_cargoRequirement = 0;
	{
		if ((_x select 0) == _classname) exitWith {
			_cargoRequirement = _x select 1;
		};
	} foreach OPCB_econ_vehicleCargoSizes;
	_textFormat = "<t color='#FFFFAA'>Required Cargo Capacity (for transport):   </t><t>" + (str _cargoRequirement) + "</t>";
	_ctrl ctrlSetStructuredText parseText _textFormat;
	
}];

_ctrl = (findDisplay 74815) displayCtrl 1001;

_cargoRequirement = 0;
{
	if ((_x select 0) == _classname) exitWith {
		_cargoRequirement = _x select 1;
	};
} foreach OPCB_econ_vehicleCargoSizes;
_textFormat = "<t color='#FFFFAA'>Required Cargo Capacity (for transport):   </t><t>" + (str _cargoRequirement) + "</t>";
_ctrl ctrlSetStructuredText parseText _textFormat;
