_SOAR = ["76561198142692277","76561198117073327","76561198086630094","76561198059583284","76561198080263934","76561198027293421"];//76561198080263934 -Geo2013 , 76561198142692277 -Alex. K., 76561198086630094 -G.Drunken, 76561198027293421- S.Werben, 76561198117073327 - A.Randy   76561198059583284 - Vittex?
if(getPlayerUID _this in _SOAR) then {

	hint "Welcome to the Whitelist Club!";
	heli_jeff addAction ["<t color='#FF0000'>Aircraft Spawner</t>","[] spawn CHAB_fnc_spawn_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
	heli_jeff addAction ["<t color='#FF0000'>I want my Aircraft removed!</t>","[] spawn CHAB_fnc_remover_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
} 
else 
{
	["epicFail",false,2] call BIS_fnc_endMission;		
};	