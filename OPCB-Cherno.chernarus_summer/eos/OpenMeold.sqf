EOS_Spawn = compile preprocessfilelinenumbers "eos\core\eos_launch.sqf";Bastion_Spawn=compile preprocessfilelinenumbers "eos\core\b_launch.sqf";null=[] execVM "eos\core\spawn_fnc.sqf";onplayerConnected {[] execVM "eos\Functions\EOS_Markers.sqf";};
/* EOS 1.98 by BangaBob 
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20

EXAMPLE CALL - EOS
 null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call EOS_Spawn;
 null=[["M1","M2","M3"],[HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY], [STATIC VEHICLES,PROBABILITY],[HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call EOS_Spawn;

EXAMPLE CALL - BASTION
 null = [["BAS_zone_1"],[3,1],[2,1],[2],[0,0],[0,0,EAST,false,false],[10,2,120,TRUE,TRUE]] call Bastion_Spawn;
 null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS],[LIGHT VEHICLES,SIZE OF CARGO],[ARMOURED VEHICLES],[HELICOPTERS,SIZE OF HELICOPTER CARGO],[FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG],[INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]] call Bastion_Spawn;
*/
VictoryColor="colorBlue";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units

null = [["EOSinf_1","EOSinf_2"],[3,1],[2,3,75],[0,0],[0],[0],[0,0],[0,0,350,EAST,TRUE]] call EOS_Spawn;
null = [["EOSmot_1","EOSmot_2"],[0,0],[0,0],[3,1,90],[2,60],[0],[1,0,90],[0,0,350,EAST,FALSE]] call EOS_Spawn;
null = [["BAS_zone_1"],[0,1],[0,2],[0],[1,2],[0,0,EAST,TRUE],[0,2,120,TRUE,FALSE]] call Bastion_Spawn;

null = [["mkr"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr1"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr2"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr3"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr4"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr5"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr6"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr7"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr8"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr9"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr10"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr11"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr12"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr13"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr14"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr15"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr16"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr17"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr18"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr19"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr20"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr21"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr22"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr23"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr24"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr25"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr26"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr27"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr28"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr29"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr30"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr31"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr32"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr33"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr34"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr35"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr36"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr37"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr38"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr39"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr40"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr41"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr42"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr43"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr44"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr45"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr46"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr47"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr48"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr49"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr50"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr51"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr52"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr53"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr54"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr55"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr56"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
null = [["mkr57"],[3,1,70],[1,2,50],[1,1,20],[1,5],[2,50],[0,0,0],[5,0,300,EAST,FALSE]] call EOS_Spawn;
