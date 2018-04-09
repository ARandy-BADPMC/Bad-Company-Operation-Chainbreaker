if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
enableSaving [false, false];
enableSentences true;
enableTeamswitch false;

Resistance setFriend [EAST, 1]; Resistance setFriend [WEST, 0]; Resistance setFriend [Civilian, 1];

EAST setFriend [Resistance, 1]; EAST setFriend [WEST, 0]; EAST setFriend [Civilian, 1];	

WEST setFriend [EAST, 0]; WEST setFriend [Resistance, 0]; WEST setFriend [Civilian, 1]; 	

Civilian setFriend [EAST, 1]; Civilian setFriend [WEST, 1]; Civilian setFriend [Resistance, 1];

[] execVM "VCOMAI\init.sqf";

RHSDecalsOff = true;

[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};

//Grab parameters and put them into readable variables
/*for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do
{
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};*/

jey_fnc_lander_action = 
{
	_off = _this select 0;
	_off addAction ["<t color='#FF0000'>Join my group</t>", jey_fnc_lander, [_off], 1, false, true, "", "true", 10, false,""];
};

jey_fnc_lander = 
{
	_ember = _this select 3 select 0;

	[_ember] joinSilent grpNull;
	_nearestplayer = [_ember] call jey_fnc_nearest;
	[_ember] join (group _nearestplayer);
};

	//sholef ammo ["32Rnd_155mm_Mo_shells","2Rnd_155mm_Mo_guided","6Rnd_155mm_Mo_mine","2Rnd_155mm_Mo_Cluster","6Rnd_155mm_Mo_smoke","2Rnd_155mm_Mo_LG","6Rnd_155mm_Mo_AT_mine"]

	
