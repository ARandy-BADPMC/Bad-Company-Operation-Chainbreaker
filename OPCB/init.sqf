if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
enableSaving [false, false];
enableSentences true;
enableTeamswitch false;

Resistance setFriend [EAST, 1]; Resistance setFriend [WEST, 0]; Resistance setFriend [Civilian, 1];

EAST setFriend [Resistance, 1]; EAST setFriend [WEST, 0]; EAST setFriend [Civilian, 1];	

WEST setFriend [EAST, 0]; WEST setFriend [Resistance, 0]; WEST setFriend [Civilian, 1]; 	

Civilian setFriend [EAST, 1]; Civilian setFriend [WEST, 1]; Civilian setFriend [Resistance, 1];

[] execVM "Vcom\VcomInit.sqf";

execVM"Scripts\ied.sqf";

RHSDecalsOff = true;

