#define ENABLE_PERSISTENCY

//spawnPos must remain available in global missionNamespace, a definition does not
// do not touch any of these except the last two
spawnPos =					[0,0,50000];
#define CENTERPOS			getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")
#define AORADIUS 			((sqrt 2 / 2 * worldSize)*0.9)

// TODO Hunter: modernise house checks and get rid of these...
#define CACHEHOUSEPOSITIONS ["Land_House_K_1_EP1",[1,2,3,4],"Land_House_L_4_EP1",[6],"Land_House_C_5_V3_EP1",[0,2,6],"Land_House_C_12_EP1",[5,6],"Land_House_K_3_EP1",[9,1,2,3,5],"Land_House_C_5_V2_EP1",[4,0,1,5],"Land_House_L_8_EP1",[7,8],"Land_House_C_4_EP1",[7,12,13,15],"Land_House_C_2_EP1",[1,2,5,6,7,8,9],"Land_House_L_7_EP1",[0,1,2,3,4,5],"Land_House_C_10_EP1",[7,8,9,10,11,12,13,14],"Land_House_K_6_EP1",[6,7,8,9,10],"Land_House_C_11_EP1",[7,8,9,10],"Land_House_C_9_EP1",[2,3,4,5],"Land_House_C_3_EP1",[7,8,9,10,11,12,13,28,29,30,31,32],"Land_A_Office01_EP1",[5,6],"Land_A_Mosque_small_1_EP1",[3,4,5],"Land_A_Stationhouse_ep1",[6,9,13],"Land_House_C_5_EP1",[3,4,5],"Land_House_K_7_EP1",[4,5,6,11],"Land_Mil_ControlTower_EP1",[2,3,4,6],"Land_House_C_5_V1_EP1",[6,7],"Land_House_K_8_EP1",[4,0,1,2,3],"Land_A_BuildingWIP_EP1",[18,20,24,25,26,27,28,29,30,31],"Land_A_Villa_EP1",[4,6,7,8,9],"Land_House_C_1_EP1",[3],"Land_House_L_6_EP1",[4,0,3],"Land_House_L_3_EP1",[0,1,2],"Land_House_K_5_EP1",[1,2],"Land_House_C_1_v2_EP1",[0,1,2,3]]
#define GUNROOFPOSITIONS   	["Land_House_L_4_EP1",[[2,0],[3,0.2],[5,0]],"Land_House_L_3_EP1",[[3,0.8],[4,0.1]],"Land_House_C_12_EP1",[[7,0.9],[8,0.9],[9,0.6],[10,0.5]],"Land_House_C_5_V2_EP1",[[6,0.6],[7,0.7]],"Land_House_L_8_EP1",[[10,0.9],[11,0.9],[12,0.9],[13,1],[14,0.2],[15,0.8],[17,0.8]],"Land_House_C_4_EP1",[[5,0.1],[14,0.2]],"Land_House_L_6_EP1",[[1,0],[2,0]],"Land_House_C_10_EP1",[[18,0.9],[19,0.9],[20,0.6],[21,0.9]],"Land_House_K_6_EP1",[[11,0.1]],"Land_House_C_9_EP1",[[6,0.2]],"Land_House_C_3_EP1",[[14,0],[15,0],[16,0.4],[18,0],[19,0.4],[20,0],[21,0.1],[22,0],[23,0.3],[24,0.4],[25,0.4],[26,0.3],[27,0.4]],"Land_A_Office01_EP1",[[1,0.5]],"Land_A_Minaret_Porto_EP1",[[3,0],[5,0],[8,0],[9,0],[10,0.9],[11,0],[12,0],[13,0]],"Land_A_Stationhouse_ep1",[[14,0.8],[15,0.8],[16,0],[17,0],[18,0.1],[19,0],[20,0.1],[22,0.1],[23,0.3],[24,0.1],[25,0.2]],"Land_House_C_5_EP1",[[0,0.7],[1,0.9],[2,1],[6,0.8],[7,0.6]],"Land_House_K_7_EP1",[[12,0.1],[13,0],[14,0]],"Land_Mil_ControlTower_EP1",[[9,0.2],[10,0],[11,0],[12,0],[13,0],[14,0.3],[15,0],[16,0]],"Land_A_Mosque_big_hq_EP1",[[11,1],[12,0]],"Land_A_Mosque_big_minaret_2_EP1",[[2,0.9]],"Land_House_C_5_V1_EP1",[[0,0.7],[1,0.7],[5,0.6]],"Land_A_BuildingWIP_EP1",[[19,0.7],[22,0.9],[23,0.4],[33,0.1],[39,0.6],[40,0.5],[41,0.6],[47,0],[48,0.5],[53,0.6],[54,0.5],[55,0.1],[56,0.3],[57,0.2],[60,0.3]],"Land_House_K_8_EP1",[[5,0.2],[12,0.1]],"Land_Ind_Oil_Tower_EP1",[[2,0],[3,0],[4,0]],"Land_A_Villa_EP1",[[10,0.5],[11,0.5],[12,0.5],[13,0.5],[14,0.5]]]
#define ILLEGALHOUSES		["Land_Mil_hangar_EP1", "Land_Mil_ControlTower_EP1", "Land_Mil_Guardhouse_EP1", "Land_Mil_Repair_center_EP1","Land_Mil_Barracks_i_EP1","Land_A_Minaret_EP1","Land_Ind_Coltan_Main_EP1"]
// set EP1HOUSES to 'true' in order to have the param ignored and AI will spawn in every building, which got positions
//#define EP1HOUSES			(configName(inheritsFrom (configFile >> "CfgVehicles" >> typeOf _x)) == "HOUSE_EP1")
#define EP1HOUSES			true

#define randPos				[(CENTERPOS select 0)+random 6000-random 6000,(CENTERPOS select 1)+random 6000-random 6000, 0]
#define cacheRadius		 	1000 // min distance at which players and other caches need to be to spawn a new cache
#define intelRadius			4000 // starting intel distance to cache
