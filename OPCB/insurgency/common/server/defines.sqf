#define eastVehiclesFreq	["rhsgref_BRDM2_ins","rhsgref_BRDM2_ins","rhsgref_BRDM2_ins","rhsgref_BRDM2_ins",\
"LOP_AM_OPF_Offroad","LOP_AM_OPF_Offroad","LOP_AM_OPF_Offroad","LOP_AM_OPF_Offroad",\
"LOP_AM_OPF_UAZ_DshKM","LOP_AM_OPF_UAZ_DshKM","LOP_AM_OPF_UAZ_DshKM","LOP_AM_OPF_UAZ_DshKM","LOP_AM_OPF_UAZ_DshKM",\
"C_Van_01_transport_F",\
"LOP_AFR_OPF_M113_W",\
"LOP_TKA_Mi24V_UPK23",\
"LOP_TKA_Mi8MTV3_UPK23",\
"LOP_AM_OPF_Offroad_M2","LOP_AM_OPF_Offroad_M2","LOP_AM_OPF_Offroad_M2","LOP_AM_OPF_Offroad_M2","LOP_AM_OPF_Offroad_M2",\
"LOP_TKA_BTR60","LOP_TKA_BTR60"\
"LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Nissan_PKM",\
"LOP_AM_OPF_Landrover_M2",\
"LOP_AM_OPF_Offroad_AT","LOP_AM_OPF_Offroad_AT","LOP_AM_OPF_Offroad_AT","LOP_AM_OPF_Offroad_AT","LOP_AM_OPF_Offroad_AT",\
"LOP_AM_OPF_Landrover_SPG9","LOP_AM_OPF_Landrover_SPG9",\
"LOP_AM_OPF_UAZ_AGS","LOP_AM_OPF_UAZ_AGS",\
"LOP_TKA_T34",\
"LOP_TKA_T55",\
"LOP_TKA_BMP1",\
"LOP_TKA_BMP2",\
"LOP_AM_OPF_UAZ_Open",\
"LOP_AM_OPF_UAZ_SPG",\
"C_Quadbike_01_F",\
"LOP_AM_OPF_Landrover",\
"LOP_TKA_BTR70",\
"rhsgref_ins_ural_work",\
"rhsgref_ins_zil131_flatbed_cover",\
"rhsgref_ins_zil131_flatbed",\
"rhsgref_ins_gaz66_repair",\
"rhsgref_ins_gaz66_ammo",\
"rhsgref_ins_ural_Zu23","rhsgref_ins_ural_Zu23"]

// "tanks" won't get passengers
#define tanks ["LOP_TKA_T34","LOP_TKA_T55"]
#define withPassenger ["rhsgref_ins_zil131_flatbed","rhsgref_ins_zil131_flatbed_cover","LOP_AM_OPF_Offroad","LOP_AM_OPF_Landrover","LOP_TKA_BMP1","LOP_TKA_BMP2","C_Quadbike_01_F","LOP_AM_OPF_Nissan_PKM","LOP_TKA_BTR60","LOP_TKA_Mi8MTV3_UPK23","LOP_TKA_Mi24V_UPK23","LOP_AFR_OPF_M113_W","rhsgref_BRDM2_ins","LOP_TKA_BTR70","C_Van_01_transport_F","LOP_AM_OPF_UAZ_Open","rhsgref_ins_ural_work"]
#define noGunVehicles ["rhsgref_ins_gaz66_ammo","rhsgref_ins_gaz66_repair","rhsgref_ins_zil131_flatbed","rhsgref_ins_zil131_flatbed_cover","LOP_AM_OPF_Landrover","C_Van_01_transport_F","LOP_AM_OPF_Offroad","LOP_AM_OPF_UAZ_Open","C_Quadbike_01_F","rhsgref_ins_ural_work"]
#define eastLightVehicles	["rhsgref_ins_ural_Zu23","rhsgref_ins_gaz66_ammo","rhsgref_ins_gaz66_repair","rhsgref_ins_zil131_flatbed","rhsgref_ins_zil131_flatbed_cover","LOP_AM_OPF_Landrover","LOP_AM_OPF_UAZ_SPG","LOP_AM_OPF_UAZ_AGS","LOP_AM_OPF_UAZ_DshKM","LOP_AM_OPF_Landrover_M2","LOP_AM_OPF_Offroad_M2","C_Van_01_transport_F","LOP_AM_OPF_Offroad","LOP_AM_OPF_Offroad_AT","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_UAZ_Open","C_Quadbike_01_F","rhsgref_ins_ural_work","LOP_AM_OPF_Landrover_SPG9"]
#define stationaryGunsHigh 	["rhs_KORD_high_MSV","RHS_ZU23_MSV","RHS_AGS30_TriPod_MSV","rhsgref_ins_DSHKM"]
#define stationaryGunsMed	["rhsgref_ins_DSHKM","RHS_AGS30_TriPod_MSV","rhs_KORD_high_MSV"]
#define stationaryGunsLow	["RHS_AGS30_TriPod_MSV","RHS_ZU23_MSV","rhsgref_ins_DSHKM","rhs_KORD_high_MSV"]
#define eastInfCount		(count(CENTERPOS nearObjects [eastInfClasses, AORADIUS]))
#define maxStaticGuns		40
//min distance between rooftop guns
#define staticWepDistances	1000
#define gunDistanceFromStartLocation	1000
//removed "Igla_AA_pod_TK_EP1", "LandRover_SPG9_TK_INS_EP1"