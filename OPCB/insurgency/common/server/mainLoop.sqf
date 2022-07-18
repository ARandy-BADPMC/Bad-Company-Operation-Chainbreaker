private ["_PGroup","_WCTime","_BCTime"];

//_PGroup     		= group pilotController;
_WCTime     		= time;
_BCTime                 = time;

while { true } do { 
	call aiDespawn;
	call quickCleanup;	
	call longCleanup;	
	sleep 20;
}; 