
//Spawns a logic from a composition

private _logic = objNull;
params[ "_cfg" ];

private _presence = [ ( _cfg >> "presence" ), "NUM", 1 ] call LARs_fnc_getCfgValue;
private _preCondition = [ ( _cfg >> "presenceCondition" ), "TXT", "true" ] call LARs_fnc_getCfgValue; //TODO: does this need defering

if ( random 1 <= _presence && { call compile _preCondition } ) then {

	private _type = getText( _cfg >> "type" );
	private _position = [ ( _cfg >> "PositionInfo" >> "position" ), "ARRAY", [0,0,0] ] call LARs_fnc_getCfgValue;
	private _ATLOffset = getNumber( _cfg >> "atlOffset" );
	private _rotation = [ ( _cfg >> "PositionInfo" >> "angles" ), "ARRAY", [0,0,0] ] call LARs_fnc_getCfgValue;
	private _varName = getText( _cfg >> "name" );

	//FIX: Seems to not to be saved in the composition ??
	//_placementRadius = getNumber( _cfg >> "Attributes" >> "placementRadius" );

	//TODO: Split logics into proper module grps
	private _group = group BIS_functions_mainscope;
	_logic = _group createUnit [ _type, [0,0,0], [], 0, "CAN_COLLIDE" ]; //No randomStart for logics

	_position = [ _logic, _position, _rotation, _ATLOffset ] call LARs_fnc_setPositionandRotation;

	if !( _varName isEqualTo "" ) then {
		_logic setVehicleVarName _varName;
		missionNamespace setVariable [ _varName, _logic, true ];
	};

	private _init = getText( _cfg >> "init" );
	private _nul = _inits pushBack [ _logic, format[ "this = _this; %1", _init ] ];

};

_logic
