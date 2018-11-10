/*
	Author: Karel Moricky

	Description:
	Return value of mission param defined in Description.ext

	Parameter(s):
		0: STRING - param class
		1 (Optional): NUMBER - default value used when the param is not found

	Returns:
	NUMBER
*/

private ["_param","_index","_default","_paramsArray"];
_param = [_this,0,"",[""]] call bis_fnc_param;
_default = [_this,1,false,[0,false]] call bis_fnc_param;
_index = -1;
{
	if (configname _x == _param) exitwith {_index = _foreachindex;};
} foreach ((missionconfigfile >> "params") call bis_Fnc_returnchildren);

_paramsArray = call (missionnamespace getvariable ["BIS_fnc_initParams_paramsArray",{missionnamespace getvariable ["paramsArray",[]]}]);
if (_index < count _paramsArray && _index >= 0) then {
	_paramsArray select _index;
} else {
	if (typename _default == typename 0) then {
		_default
	} else {
		//["Param '%1' not found.",_param] call bis_fnc_error;
		0
	};
};