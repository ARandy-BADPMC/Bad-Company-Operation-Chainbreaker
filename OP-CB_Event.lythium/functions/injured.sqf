jey_injured = 
{
	//_counter = floor (random 600);
	//if(_counter < 300) then {_counter == 300};
	private ["_unit","_counter"];
	_unit = _this;
	_group = group _unit;

	{
		_x setUnconscious true;

		_counter = floor (random 600);
		if(_counter < 300) then {_counter = _counter +100};

		[_x] remoteExec ["jey_injured_unit", 0, true];

		_x setVariable ["counter",_counter,true];
		[_x] spawn jey_injured_counter;


		_wound = selectRandom ["body", "head"];
		[_x, 0.3, _wound, "stab"] call ace_medical_fnc_addDamageToUnit;
		sleep 2;

		_wound = selectRandom ["hand_r", "hand_l"];
		[_x, 0.3, _wound, "stab"] call ace_medical_fnc_addDamageToUnit;
		sleep 2;

		_wound = selectRandom ["leg_l", "leg_r"];
		[_x, 0.2, _wound, "stab"] call ace_medical_fnc_addDamageToUnit;
		sleep 2;

		[_x] call ace_medical_fnc_handleDamage_advancedSetDamage;
		
	} forEach units _group;

	
};
jey_injured_unit = 
{
	_unit = _this select 0;

	_unit addAction ["<t color='#FF0000'>Stabilize</t>", jey_stable, [_unit], 1, false, true, "", "true", 10, false,""];

};
jey_remove_injured =
{
	_unit = _this select 0;
	_actions = _this select 1;
	_unit removeAction (_actions select 0);
};
jey_stable = 
{
	_unit = _this select 3 select 0;
	_actions = actionIDs _unit;

	//remoteExec ["_unit removeAction (_actions select 0)", 0, true]; 
	[_unit,_actions] remoteExec ["jey_remove_injured", 0, true];
	// _unit removeAction (_actions select 0);

	if(alive _unit) then 
	{
		if(typeOf player != "rhsusf_army_ocp_medic") then
		{
			disableUserInput true;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    disableUserInput false;
		    [_unit] remoteExec ["jey_not_stable", 0, true];
		    _id = clientOwner;
		    _counter = _unit getVariable "counter";
		    _counter = _counter + 120;
		    _unit setVariable ["counter",_counter,true];
			//"This soldier still needs a medic" remoteExec ["hint",_id];
			hint "This soldier still needs a medic";
		}
		else
		{
			disableUserInput true;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic4";
		    sleep 4.545;
		    player playMoveNow "AinvPknlMstpSnonWrflDr_medic3";
		    sleep 6.545;
		    disableUserInput false;
			_id = clientOwner;
			//"This soldier is now Stable" remoteExec ["hint",_id];
			hint "This soldier is now stable";
			_counter = _unit getVariable "counter";
		    _counter = _counter + 1200;
		    _unit setVariable ["counter",_counter,true];
		};
	} else 
	{
		_id = clientOwner;
		//"This soldier is dead" remoteExec ["hint",_id];
		hint "This soldier is dead";
	}
};
jey_not_stable =
{
	_unit = _this select 0;
	sleep 120;
	//_unit addAction ["<t color='#FF0000'>Stabilize</t>", "[_unit] remoteExec ['jey_stable',0]", nil, 1, false, true, "", "true", 10, false,""];
	_unit addAction ["<t color='#FF0000'>Stabilize</t>", jey_stable, [_unit], 1, false, true, "", "true", 10, false,""];
};
jey_injured_counter =
{
	_unit = _this select 0;
	_counter = _unit getVariable "counter";
	_time = 0;

	while {_time < _counter && alive _unit} do {
	  sleep 5;
	  _time = _time + 5;
	  _counter = _unit getVariable "counter";
	  if ( _time > _counter) then {_unit setDamage 1};
	};
};