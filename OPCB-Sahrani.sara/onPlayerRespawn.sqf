//params [<newUnit>, <oldUnit>, <respawn>, <respawnDelay>];
_admins = ["76561198117073327","76561198142692277","76561198017258138","76561198002110130","76561197998271838","76561197992821044","76561197988793826","76561198048254349"]; //76561197998271838-GOMEZ 76561197992821044-GRAND 76561197988793826-WEEDO  76561198117073327-Randy  76561198142692277-Alex.K   76561198017258138 - A.Mitchell 76561198002110130 K.Hunter
if ((getPlayerUID player) in _admins) then {
  player addAction ["<t color='#FF0000'>Admin Console</t>","[] spawn CHAB_fnc_adminconsole;",nil, 1, false, true, "", "true", 10, false,""];
};

player allowDamage false;
	titleText ["\n\nSpawn Protection is ACTIVATED","PLAIN DOWN"];
	titleFadeOut 5;
	sleep 60;
	titleText ["\n\nSpawn Protection is DEACTIVATED","PLAIN DOWN"];
	titleFadeOut 5;
	player allowDamage true;