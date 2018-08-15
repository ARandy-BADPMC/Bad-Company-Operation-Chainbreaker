
disableSerialization;
createDialog "jey_tankspawner";

waitUntil {
  !isNull (findDisplay 9901)
};
_tanks = [


"B_APC_Wheeled_01_cannon_F",
"B_APC_Tracked_01_AA_F",
"rhs_bmp2d_msv",
"rhsusf_CGRCAT1A2_usmc_d",
"rhsusf_CGRCAT1A2_Mk19_usmc_d",
"rhsusf_CGRCAT1A2_M2_usmc_d",
"Burnes_FV4034_02",
"Burnes_FV4034_01",
"I_MRAP_03_hmg_F",
"I_MRAP_03_gmg_F",
"I_APC_tracked_03_cannon_F",
"rhs_tigr_vdv",
"rhs_tigr_sts_vdv",
"rhs_tigr_m_vdv",
"O_MRAP_02_F",
"O_MRAP_02_gmg_F",
"O_MRAP_02_hmg_F",
"I_MBT_03_cannon_F",
"B_MRAP_01_F",
"B_MRAP_01_gmg_F",
"B_MRAP_01_hmg_F",
"rhsusf_m1045_d",
"rhsusf_M1078A1R_SOV_M2_D_fmtv_socom",
"rhsusf_M1084A1R_SOV_M2_D_fmtv_socom",
"rhsusf_m113d_usarmy_supply",
"rhsusf_m113d_usarmy",
"rhsusf_m113d_usarmy_M240",
"rhsusf_m113d_usarmy_medical",
"rhsusf_m113d_usarmy_MK19",
"rhsusf_m113d_usarmy_unarmed",
"rhsusf_m109d_usarmy",
"rhsusf_M1220_usarmy_d",
"rhsusf_M1220_M153_M2_usarmy_d",
"rhsusf_M1220_M2_usarmy_d",
"rhsusf_M1220_MK19_usarmy_d",
"rhsusf_M1230_M2_usarmy_d",
"rhsusf_M1230_MK19_usarmy_d",
"rhsusf_M1232_usarmy_d",
"rhsusf_M1232_M2_usarmy_d",
"rhsusf_M1232_MK19_usarmy_d",
"rhsusf_M1237_M2_usarmy_d",
"rhsusf_M1237_MK19_usarmy_d",
"rhsusf_M1117_D",
"rhsusf_M142_usarmy_D",
"Burnes_M1A1_MEU_01_Public",
"Burnes_M1A1_MEU_02_Public",
"rhsusf_m1a1aimd_usarmy",
"rhsusf_m1a1aim_tuski_d",
"rhsusf_m1a2sep1d_usarmy",
"rhsusf_m1a2sep1tuskid_usarmy",
"rhsusf_m1a2sep1tuskiid_usarmy",
"RHS_M2A2",
"RHS_M2A2_BUSKI",
"RHS_M2A3",
"RHS_M2A3_BUSKI",
"RHS_M2A3_BUSKIII",
"RHS_M6",
"I_C_Offroad_02_LMG_F",
"I_C_Offroad_02_AT_F",
"B_MBT_01_TUSK_F",
"B_MBT_01_cannon_F",
"B_APC_Tracked_01_rcws_F",
"B_APC_Tracked_01_CRV_F",
"B_G_Offroad_01_AT_F",
"O_APC_Wheeled_02_rcws_F",
"I_APC_Wheeled_03_cannon_F",
"rhsusf_rg33_usmc_d",
"rhsusf_rg33_m2_usmc_d",
"B_AFV_Wheeled_01_up_cannon_F",
"B_AFV_Wheeled_01_cannon_F",
"B_MBT_01_arty_F",
"rhs_t72bb_tv",
"I_LT_01_AT_F",
"I_LT_01_AA_F",
"I_LT_01_cannon_F",
"I_LT_01_scout_F",
"",
"",
"",
"rhs_Metis_9k115_2_vmf",
"rhs_Kornet_9M133_2_vmf",
"RHS_Stinger_AA_pod_D",
"RHS_M2StaticMG_D",
"RHS_M2StaticMG_MiniTripod_D",
"RHS_TOW_TriPod_D",
"RHS_MK19_TriPod_D",
"B_Mortar_01_F",
"B_Static_Designator_01_F"


];

_ctrl = (findDisplay 9901) displayCtrl 1500;

_i = 0;
{
	_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_ctrl lbAdd _text;
	_ctrl lbSetData [_i,_x];
	_i = _i +1;
} forEach _tanks;

