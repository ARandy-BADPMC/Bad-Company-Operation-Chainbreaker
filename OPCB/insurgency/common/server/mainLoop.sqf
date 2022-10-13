// used by cleanup timers
private ["_WCTime","_BCTime"];
_WCTime     		= time;
_BCTime                 = time;

while { true } do { 
	call aiDespawn;
	call quickCleanup;	
	call longCleanup;	
	sleep 20;
}; 