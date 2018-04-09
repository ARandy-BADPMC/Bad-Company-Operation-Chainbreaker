jey_adminconsole = 
{
	disableSerialization;
	createDialog "jey_adminconsole_dialog";

	waitUntil {
	  !isNull (findDisplay 9999)
	};

	_ctrl = (findDisplay 9999) displayCtrl 1500;

	{
		_id = getPlayerUID _x;
		_row = format ["name: %1 : Id: %2",(name _x),_id];
		_ctrl lbAdd _row;
	} forEach allPlayers;
	
};
jey_kick = 
{
	disableSerialization;
	_ctrl = (findDisplay 9999) displayCtrl 1500;
	_unit = lbCurSel _ctrl;
	if(_unit != -1) then 
	{
		_name = _ctrl lbText _unit;
		_array = _name splitString ":";
		_select = _array select 3;
		[_select] remoteExec ["jey_kick_server",2];
		_ctrl lbDelete _unit;
	}
	else
	{
		hint "Select a player first!";
	}
};
jey_hint =
{
	_asd = _this select 0;
	hint format ["the number is : %1",_asd];	
};
jey_restart_server = 
{
		" " serverCommand "#restartserver";
};
jey_ban = 
{
	disableSerialization;
	_ctrl = (findDisplay 9999) displayCtrl 1500;
	_unit = lbCurSel _ctrl;
	if(_unit != -1) then 
	{
		_name = _ctrl lbText _unit;
		_array = _name splitString ":";
		_select = _array select 3;
		[_select] remoteExec ["jey_ban_server",2];
		_ctrl lbDelete _unit;
	}
	else
	{
		hint "Select a player first!";
	}
};
jey_ban_server = 
{	
	_id = _this select 0;
	_array = _id splitString "'";
 	_newid = _array select 0;
 	_array2 = _newid splitString " ";
 	_newid = _array2 select 0;

	_command = format ["#exec ban %1",str _newid];
	" " serverCommand _command;
};
jey_kick_server =
{
 	_id = _this select 0;
 	_array = _id splitString "'";
 	_newid = _array select 0;
 	_array2 = _newid splitString " ";
 	_newid = _array2 select 0;

 	_command = format ["#exec kick %1",str _newid];
	" " serverCommand _command;
};
jey_getgroups =
{
	_groups = allGroups;
	_number = count _groups;
	hint format ["The number of groups is : %1",_number];
};
jey_restart = 
{
		" " serverCommand "#restart";
};
jey_zeus = 
{
	_istherezeus = missionNamespace getVariable["zeus_enabled",1];
	if(_istherezeus == 0) then {
		hint "You are now the Zeus of the mission.";
		[player] remoteExec ["jey_zeus_server"];
	} else {
	hint "There is already a Zeus operator!";
	};
};
jey_zeus_server = 
{
	missionNamespace setVariable["zeus_enabled",1];
	_player = _this select 0;
	_player assignCurator zeus_admin;
	waitUntil {
	  sleep 1;
	  _istherezeus = missionNamespace getVariable["zeus_enabled",1];
	  !alive _player || _istherezeus == 0
	};
	remoteExec ["jey_zeus_out_server"];
};
jey_zeus_out = 
{
	remoteExec ["jey_zeus_out_server"];
	hint "Zeus removed!";
};
jey_zeus_out_server =
{
	missionNamespace setVariable["zeus_enabled",0];
	unassignCurator zeus_admin;
};
jey_getpilots =
{
	private ["_unitname"];
	_names = [];

	{
		if(typeOf _x == "rhsusf_army_ocp_helipilot" || typeOf _x == "rhsusf_airforce_jetpilot") then
			{
				_unitname = name _x;
    			_names pushBack _unitname;
			};
	} forEach allUnits;

	hint format ["The current pilots : %1",_names];
};
jey_gettankcrew =
{
	private ["_unitname"];
	_names = [];

	{
		if(typeOf _x == "rhsusf_army_ocp_engineer") then
			{
				_unitname = name _x;
    			_names pushBack _unitname;
			};
	} forEach allUnits;

	hint format ["The current engineers : %1",_names];
};
jey_spectate = 
{
	["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
};
jey_skip12 = 
{
	[12] remoteExec ["skipTime",2];
};
jey_skip6 = 
{
	[6] remoteExec ["skipTime",2];
};
