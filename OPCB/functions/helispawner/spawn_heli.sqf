disableSerialization;
createDialog "jey_helispawner";

waitUntil {
  !isNull (findDisplay 9900)
};
_helicopters = [];

_ctrl = (findDisplay 9900) displayCtrl 1500;
_imageCtrl = (findDisplay 9900) displayCtrl 1618;

for "_j" from 0 to count Helicopter_loadouts -1 step 2 do {
	_item = Helicopter_loadouts select _j;
	_helicopters pushBack _item;
};
_i = 0;
{
	_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_ctrl lbAdd _text;
	_ctrl lbSetData [_i,_x];
	_i = _i +1;
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
}];