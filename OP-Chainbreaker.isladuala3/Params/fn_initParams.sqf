/*
	Author: Karel Moricky

	Description:
	Initialize mission params

	Parameter(s):
	NONE

	Returns:
	BOOL
*/

if (isclass (missionconfigfile >> "params")) then {
	_fnc_scriptName = "param";
	_diaryArray = [];
	BIS_fnc_initParams_paramsArray = compilefinal str paramsArray; //--- Save protected variant for outside use
	{
		private ["_value","_isGlobal","_valueText"];
		_value = [paramsArray,_foreachindex,getnumber (_x >> "default"),[0]] call bis_fnc_paramIn;

		//--- Activate
		_isGlobal = getnumber (_x >> "isGlobal") > 0;
		if (isserver || _isGlobal) then {
			private ["_functionVar","_scriptFile"];
			_functionVar = gettext (_x >> "function");
			_scriptFile = gettext (_x >> "file");
			if (_functionVar != "" || _scriptFile != "") then {
				private ["_function"];
				_function = if (_functionVar == "") then {compile preprocessfilelinenumbers _scriptFile} else {missionnamespace getvariable _functionVar};
				if !(isnil "_function") then {
					["%1 (%2)",if (_functionVar == "") then {_scriptFile} else {_functionVar},_value] call bis_fnc_logFormat;
					[_value] call _function;
				} else {
					["Function '%1' not found, cannot initialize '%2' mission param.",_functionVar,configname _x] call bis_fnc_error;
				};
			};
		};

		//--- Document
		_valueID = (getarray (_x >> "values")) find _value;
		_valueText = if (_valueID < 0) then {str _value} else {[getarray (_x >> "texts"),_valueID,""] call bis_fnc_paramIn;};
		if (typename _valueText != typename "") then {_valueText = str _valueText;};
		_diaryArray set [count _diaryArray,[gettext (_x >> "title"),_valueText]];

	} foreach ((missionconfigfile >> "params") call bis_fnc_returnchildren);

	//--- Add diary record
	if (!isnull player && count _diaryArray > 0) then {
		private ["_text"];
		_text = "";
		{

			_text = _text + format ["<img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br /><br /><font>%1</font><br /><font size='16' face='PuristaLight'>%2</font><br />",_x select 0,_x select 1];
		} foreach _diaryArray;

		[player,localize "STR_DISP_XBOX_EDITOR_WIZARD_PARAMS",_text] call bis_fnc_createlogrecord;
	};
};
true