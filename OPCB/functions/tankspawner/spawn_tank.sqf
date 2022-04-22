
disableSerialization;
createDialog "jey_tankspawner";

waitUntil {
  !isNull (findDisplay 9901)
};
_tanks = [
	"rhsusf_m1025_d_m2",
	"rhsusf_m1025_d_Mk19",
	"rhsusf_m1025_d",
	"rhsusf_m998_d_2dr_fulltop",
	"rhsusf_m998_d_2dr_halftop",
	"rhsusf_m998_d_2dr",
	"rhsusf_m998_d_4dr_fulltop",
	"rhsusf_m998_d_4dr_halftop",
	"rhsusf_m998_d_4dr",
	"rhsusf_m1151_usarmy_d",
	"rhsusf_m1151_m2crows_usarmy_d",
	"rhsusf_m1151_mk19crows_usarmy_d",
	"rhsusf_m1151_m2_v1_usarmy_d",
	"rhsusf_m1151_m2_lras3_v1_usarmy_d",
	"rhsusf_m1151_m240_v1_usarmy_d",
	"rhsusf_m1151_mk19_v1_usarmy_d",
	"rhsusf_m1151_m2_v2_usarmy_d",
	"rhsusf_m1151_m240_v2_usarmy_d",
	"rhsusf_m1151_mk19_v2_usarmy_d",
	"rhsusf_m1152_usarmy_d",
	"rhsusf_m1152_rsv_usarmy_d",
	"rhsusf_m1152_sicps_usarmy_d",
	"rhsusf_m1165_usarmy_d",
	"rhsusf_m1165a1_gmv_m134d_m240_socom_d",
	"rhsusf_m1165a1_gmv_m2_m240_socom_d",
	"rhsusf_m1165a1_gmv_mk19_m240_socom_d",
	"rhsusf_CGRCAT1A2_usmc_d",
	"rhsusf_CGRCAT1A2_Mk19_usmc_d",
	"rhsusf_CGRCAT1A2_M2_usmc_d",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"rhsusf_M1078A1R_SOV_M2_D_fmtv_socom",
	"rhsusf_M1084A1R_SOV_M2_D_fmtv_socom",
	"rhsusf_m113d_usarmy_supply",
	"rhsusf_m113d_usarmy",
	"rhsusf_m113d_usarmy_M240",
	"rhsusf_m113d_usarmy_medical",
	"rhsusf_m113d_usarmy_MK19",
	"rhsusf_m113d_usarmy_unarmed",
	"rhsusf_stryker_m1126_m2_wd",
	"rhsusf_M1117_D",
	"rhsusf_M1220_usarmy_d",
	"rhsusf_M1220_M153_M2_usarmy_d",
	"rhsusf_M1220_M2_usarmy_d",
	"rhsusf_M1220_MK19_usarmy_d",
	"rhsusf_M1220_M153_MK19_usarmy_d",
	"rhsusf_M1230a1_usarmy_d",
	"rhsusf_M1230_M2_usarmy_d",
	"rhsusf_M1230_MK19_usarmy_d",
	"rhsusf_M1232_usarmy_d",
	"rhsusf_M1232_M2_usarmy_d",
	"rhsusf_M1232_MK19_usarmy_d",
	"rhsusf_M1237_M2_usarmy_d",
	"rhsusf_M1237_MK19_usarmy_d",
	"rhsusf_M1238A1_socom_d",
	"rhsusf_M1238A1_M2_socom_d",
	"rhsusf_M1238A1_Mk19_socom_d",
	"rhsusf_M1239_socom_d",
	"rhsusf_M1239_M2_socom_d",
	"rhsusf_M1239_M2_Deploy_socom_d",
	"rhsusf_M1239_MK19_socom_d",
	"rhsusf_M1239_MK19_Deploy_socom_d",
	"rhsusf_m1240a1_usarmy_d",
	"rhsusf_m1240a1_m2_usarmy_d",
	"rhsusf_m1240a1_m240_usarmy_d",
	"rhsusf_m1240a1_mk19_usarmy_d",
	"rhsusf_m1240a1_m2_uik_usarmy_d",
	"rhsusf_m1240a1_m240_uik_usarmy_d",
	"rhsusf_m1240a1_mk19_uik_usarmy_d",
	"rhsusf_m1240a1_m2crows_usarmy_d",
	"rhsusf_m1240a1_mk19crows_usarmy_d",
	"rhsusf_m1245_m2crows_socom_d",
	"rhsusf_m1245_mk19crows_socom_d",
	"I_C_Offroad_02_LMG_F",
	"I_C_Offroad_02_AT_F",
	"B_APC_Tracked_01_rcws_F",
	"B_APC_Tracked_01_CRV_F",
	"B_G_Offroad_01_AT_F",
	"rhsusf_rg33_usmc_d",
	"rhsusf_rg33_m2_usmc_d",
	"I_LT_01_scout_F"
];

_ctrl = (findDisplay 9901) displayCtrl 1500;
_imageCtrl = (findDisplay 9901) displayCtrl 1608;
 

_i = 0;
{
	_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_ctrl lbAdd _text;
	_ctrl lbSetData [_i,_x]; 
	_i = _i +1;
} forEach _tanks;
_ctrl lbSetSelected [0, true];

_classname = _ctrl lbData 0;
_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
_imageCtrl ctrlSetText _picture;


_ctrl ctrlAddEventHandler ["LBSelChanged",{
	params ["_control", "_selectedIndex"];
	
	_classname = _control lbData _selectedIndex;
	_picture = getText (configFile >> "CfgVehicles" >> _classname >> "editorPreview"); 
	_imageCtrl = (findDisplay 9901) displayCtrl 1608;
	_imageCtrl ctrlSetText _picture;
}];
