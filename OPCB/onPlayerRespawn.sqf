//params [<newUnit>, <oldUnit>, <respawn>, <respawnDelay>];
_devs = ["76561198117073327","76561198142692277","76561198002110130","76561198048254349"];
if ((getPlayerUID player) in _devs) then {
	player addAction ["<t color='#00AAFF'>Developer Console</t>","[] spawn CHAB_fnc_adminconsole;",nil, -99, false, true, "", "true", 10, false,""];
};

player allowDamage false;
titleText ["\n\nSpawn Protection is ACTIVATED","PLAIN DOWN"];
titleFadeOut 5;
sleep 60;
titleText ["\n\nSpawn Protection is DEACTIVATED","PLAIN DOWN"];
titleFadeOut 5;
player allowDamage true;