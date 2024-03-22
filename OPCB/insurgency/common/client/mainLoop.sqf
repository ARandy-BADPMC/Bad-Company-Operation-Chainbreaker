private ["_sign","_weapons","_oldPlayerGroup","_playerGroupMembers","_pos","_oldUnit","_Block","_A10Timer","_c","_ctrlText","_playergrp","_HQstate", "_dir", "_xpos", "_ypos", "_vector"]; 

_Block     	= 10;
_A10Timer	= time;
//_ArtyTimer 	= time;   // arty is definitely an overkill in Insurgency
_playergrp 		= grpNull;
_HQstate 			= startLocation;


[] spawn {

	scriptName "ins_AIhandler";
 
	_aiTimer = time;
	while { true } do {
		//AI			
		call aiSpawn;
		//if (time - _aiTimer > 30) then { _aiTimer = time + (random 10) - 5; };
		//call groupAI;
		sleep 1;
		if (((player distance2D startLocation) > 1000) && {(east knowsAbout player) > 1}) then {
			call aiMonitor; 
		};		
		sleep (25 + (random 10));
	};
};

scriptName "ins_gridHandler";

while { true } do {

	//Markers
	call gridPath;

	//Misc
	call clearHouses;

	//
	call updateTier;

	sleep 1;
};	