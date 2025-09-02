#define patrolSpawnPositionLogics [vclSpawn1, vclSpawn2, vclSpawn3]
#define stationaryGunsHigh 	["rhs_KORD_high_MSV","RHS_ZU23_MSV","RHS_AGS30_TriPod_MSV","rhsgref_ins_DSHKM","rhs_Igla_AA_pod_vdv","rhs_Kornet_9M133_2_vmf","O_G_HMG_02_high_F"]
#define stationaryGunsMed	["rhsgref_ins_DSHKM","RHS_AGS30_TriPod_MSV","rhs_KORD_high_MSV","rhs_Igla_AA_pod_vdv","RHS_TOW_TriPod_D"]
#define stationaryGunsLow	["RHS_AGS30_TriPod_MSV","RHS_ZU23_MSV","rhsgref_ins_DSHKM","rhs_KORD_high_MSV","rhs_Igla_AA_pod_vdv","rhs_Metis_9k115_2_vmf","O_G_HMG_02_F"]
#define eastInfCount		(count(CENTERPOS nearObjects [eastInfClasses, AORADIUS]))
#define maxStaticGuns		40
//min distance between rooftop guns
#define staticWepDistances	1000
#define gunDistanceFromStartLocation	1300
//removed "Igla_AA_pod_TK_EP1", "LandRover_SPG9_TK_INS_EP1"