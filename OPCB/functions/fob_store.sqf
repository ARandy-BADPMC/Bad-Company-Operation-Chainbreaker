disableSerialization;
createDialog "fobStore";

waitUntil {
  !isNull (findDisplay 74819) && { !(isNil "OPCB_econ_initDone") && {OPCB_econ_initDone}}
};

private _fob_markers = allMapMarkers select {["fob_", _x] call BIS_fnc_inString};
if (count _fob_markers == 0) exitWith {hint "There no FOBs to purchase on this map !"};

_ctrl = (findDisplay 74819) displayCtrl 2000;

{
	_text = markerText _x;
	_ctrl lbAdd _text;
	_ctrl lbSetData [_foreachIndex,_x]; 
} forEach _fob_markers;
_ctrl lbSetSelected [0, true];

_classname = _ctrl lbData 0;

_ctrl ctrlAddEventHandler ["LBSelChanged",{
	params ["_control", "_selectedIndex"];
	
	_classname = _control lbData _selectedIndex;
	_tier = 0,
	_textFormat = "<t color='#07FFFF'>Fob Cost:   </t><t>" + (str fobPrice) + " C" + "</t><t color='#07FFFF'>         Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
	_ctrl ctrlSetStructuredText parseText _textFormat;
	
}];

_ctrl = (findDisplay 74819) displayCtrl 2003;

_tier = 0,
_textFormat = "<t color='#07FFFF'>Fob Cost:   </t><t>" + (str fobPrice) + " C" + "</t><t color='#07FFFF'>         Current Tier:   </t><t>" + (str (OPCB_econ_currentTier + 1))+ "</t><br/><br/>" + "<t color='#07FFFF'>Credits available:    </t><t>" + (str OPCB_econ_credits) + " C" + "</t>";
_ctrl ctrlSetStructuredText parseText _textFormat;
