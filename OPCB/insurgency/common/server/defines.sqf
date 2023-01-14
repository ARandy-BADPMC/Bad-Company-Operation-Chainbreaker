#define patrolSpawnDelay 1800
#define patrolSpawnPositionLogics [vclSpawn1, vclSpawn2, vclSpawn3]
#define stationaryGunsHigh 	["rhs_KORD_high_MSV","RHS_ZU23_MSV","RHS_AGS30_TriPod_MSV","rhsgref_ins_DSHKM"]
#define stationaryGunsMed	["rhsgref_ins_DSHKM","RHS_AGS30_TriPod_MSV","rhs_KORD_high_MSV"]
#define stationaryGunsLow	["RHS_AGS30_TriPod_MSV","RHS_ZU23_MSV","rhsgref_ins_DSHKM","rhs_KORD_high_MSV"]
#define eastInfCount		(count(CENTERPOS nearObjects [eastInfClasses, AORADIUS]))
#define maxStaticGuns		40
//min distance between rooftop guns
#define staticWepDistances	1000
#define gunDistanceFromStartLocation	1000
//removed "Igla_AA_pod_TK_EP1", "LandRover_SPG9_TK_INS_EP1"