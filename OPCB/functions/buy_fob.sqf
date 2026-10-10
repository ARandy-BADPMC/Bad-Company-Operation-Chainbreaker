params [
	["_fobselect", "", [""]],
	["_requestOwner", -1, [0]]
];

if (!isServer) exitWith {
	disableSerialization;
	private _foblist = (findDisplay 74819) displayCtrl 2000;
	private _fobselectIdx = lbCurSel _foblist;
	private _selectedFob = _foblist lbData _fobselectIdx;
	[_selectedFob, clientOwner] remoteExecCall ["CHAB_fnc_buyFob", 2];
};

if (_fobselect isEqualTo "") exitWith {};

_fob_pos = getMarkerPos _fobselect;
_houses = [_fob_pos, 1000, 3, true] call findHouses;
_clearfob = true;
if (_fobselect in Hz_pers_var_boughtFobs) exitWith {
	[format["You have already bought %1!", markerText _fobselect]] remoteExecCall ["hint", _requestOwner];
};
{
	_pos = _x call getGridPos;
	_gmkr = str _pos;
	_mkrVar = format["%1cleared", _gmkr];	
	_marker_clear = missionNamespace getVariable [_mkrVar, false];
	if (!_marker_clear) exitWith {
		_clearfob = false;
	};
} forEach (_houses);

if (_clearfob) then {
	if (OPCB_econ_currentTier < 6) then {
		if (OPCB_econ_credits >= fobPrice) then {
			[west, _fob_pos] call BIS_fnc_addRespawnPosition;
			OPCB_econ_credits = OPCB_econ_credits - fobPrice;
			publicVariable "OPCB_econ_credits";
			Hz_pers_var_boughtFobs pushBackUnique _fobselect;
			publicVariable "Hz_pers_var_boughtFobs";
			[format["You have successfuly bought %1!", markerText _fobselect]] remoteExecCall ["hint", _requestOwner];
		} else {
			["You don't have enough credits to buy this FOB!"] remoteExecCall ["hint", _requestOwner];
		};
	} else {
		["You will need at least tier 5 to buy a FOB."] remoteExecCall ["hint", _requestOwner];
	}
} else {
	[format["You cannot buy %1, 1km radius need to be clear around it.", markerText _fobselect]] remoteExecCall ["hint", _requestOwner];
};
