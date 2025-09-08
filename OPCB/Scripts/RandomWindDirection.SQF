
_windDirChange 			= (random [300, 1200, 1800]);
_InitialWindDir 		= (random [90,180,270]);

sleep 1;
_windDirChange setWindDir _InitialWindDir;

systemChat "Random Wind Direction Running";

while {true} do {
	_windDirChange 			= (random [300, 1200, 1800]);
	_newWindDir 			= (random [windDir - 135,windDir,windDir + 135]);
	_windDirChange setWindDir _newWindDir;
	sleep (_windDirChange / timeMultiplier);
	};

systemChat "Error: Random Wind Direction Stopped";