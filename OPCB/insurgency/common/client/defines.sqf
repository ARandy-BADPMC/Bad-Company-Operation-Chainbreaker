
//Misc
#define night						(daytime >= 18 || daytime <= 6)
#define time2                   	(time - startTime)
#define remoteControlling       	(typeOf cameraOn == HELITYPE && (driver cameraOn in units group player || !(player in crew cameraOn)))
#define sTypes						["#ZRPole", "#ZRTrava"]

//Gear
#define leaderItems              	[]

//Respawn
#define respawnRange            	300
#define A10respawn         			1800
#define artyRespawn					1800
