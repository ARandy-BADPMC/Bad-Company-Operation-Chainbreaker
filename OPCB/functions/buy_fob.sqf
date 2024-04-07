disableSerialization;
_foblist = (findDisplay 74819) displayCtrl 2000;
_fobselectIdx = lbCurSel _foblist;
_fobselect = _foblist lbData _fobselectIdx;
_fob_pos = getMarkerPos _fobselect;
_houses = [_fob_pos, 1000, 3, true] call findHouses;
_clearfob = true;
if (_fobselect in Hz_pers_var_boughtFobs) exitWith {
	hint format["You have already bought %1!", markerText _fobselect];
};
{
	_pos = _x call getGridPos;
	_gmkr = str _pos;
	_mkrVar = format["%1cleared", _gMkr];	
	_marker_clear = missionNamespace getVariable [_mkrVar, false];
	if (!_marker_clear) exitWith {
		clearfob = false;
	};
} forEach (_houses);

if (_clearfob) then {
	if (OPCB_econ_currentTier < 6) then {
		if (OPCB_econ_credits >= fobPrice) then {
			[west, _fob_pos] call BIS_fnc_addRespawnPosition;
			OPCB_econ_credits = OPCB_econ_credits - fobPrice;
			Hz_pers_var_boughtFobs pushBackUnique _fobselect;
			publicVariableServer "Hz_pers_var_boughtFobs";
			hint format["You have successfuly bought %1!", markerText _fobselect];
		} else {
		};
	} else {
		hint "You will need at least tier 5 to buy a FOB."
	}
} else {
	hint format["You cannot buy %1, 1km radius need to be clear around it.", markerText _fobselect];
};