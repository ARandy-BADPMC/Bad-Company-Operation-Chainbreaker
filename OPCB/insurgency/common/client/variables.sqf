//Gear
respawnWeapons   = weapons player;
respawnMagazines = magazines player;  
startWeapon      = primaryWeapon player; 

//Misc
isAdmin 		= false;
playerNames		= ["","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]; 
serverLoadHint	= false; 
mapInUse        = false;
startTime       = time;
startGroup      = group player;
oldGroup        = group player;

ppEffectsOn 	= false;
ppUnconscious 	= ppEffectCreate [["radialblur", 170], ["colorcorrections", 1580]];
mapClickBool 	= false;


//Timers
_A10Timer  		= 0;
_ArtyTimer 		= 0;

//Respawn
camPlayer       = objNull;
enterSpawn      = false; 
respawnCamera   = objNull;
camMap          = false;
deadPos         = CENTERPOS;

//Support
A10available     = false;
artyAvailable    = false;
requestingPlayer = objNull;

//User Interface
keyblock 		= false; 
tagsOn			= true;
