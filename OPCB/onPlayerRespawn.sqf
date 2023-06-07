#include "data\developers.sqf";

if (getPlayerUID player in _developers) then {
	player addAction ["<t color='#00AAFF'>Developer Console</t>","[] spawn CHAB_fnc_adminconsole;",nil, -99, false, true, "", "true", 10, false,""];
};

player allowDamage false;
titleText ["\n\nSpawn Protection is ACTIVATED","PLAIN DOWN"];
titleFadeOut 5;
sleep 60;
titleText ["\n\nSpawn Protection is DEACTIVATED","PLAIN DOWN"];
titleFadeOut 5;
player allowDamage true;