skinapplier = {
params ["_helicopter"];
//aircraft
if (typeOf _helicopter == "I_Plane_Fighter_04_F") then { _helicopter setObjectTextureGlobal [0,"\Gripen_textures\Gripen_Skin1.paa"]; _helicopter setObjectTextureGlobal [1,"\Gripen_textures\Grippen_Skin2.paa"];};
if (typeOf _helicopter == "I_Heli_light_03_dynamicLoadout_F") then { _helicopter setObjectTextureGlobal [0,"\a3\Air_F_EPB\Heli_Light_03\data\Heli_Light_03_base_CO.paa"];};
if (typeOf _helicopter == "O_Heli_Light_02_dynamicLoadout_F") then { _helicopter setObjectTextureGlobal [0,"a3\air_f\heli_light_02\data\heli_light_02_ext_co.paa"];};
if (typeOf _helicopter == "O_Heli_Transport_04_F") then {_helicopter setObjectTextureGlobal [0,"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_01_black_co.paa"]; _helicopter setObjectTextureGlobal [1,"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_02_black_co.paa"];};




//land vehs
if (typeOf _helicopter == "I_MRAP_03_gmg_F" || typeOf _helicopter == "I_MRAP_03_hmg_F")then { _helicopter setObjectTextureGlobal [0,"\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa"]; _helicopter setObjectTextureGlobal [1,"\A3\data_f\vehicles\turret_co.paa"];};
if (typeOf _helicopter == "I_MBT_03_cannon_F") then { _helicopter setObjectTextureGlobal [0,"\Leopard_textures\Leopard_0.paa"]; _helicopter setObjectTextureGlobal [1,"\Leopard_textures\Leopard_1.paa"]; _helicopter setObjectTextureGlobal [2,"\Leopard_textures\Leopard_0.paa"];};
if (typeOf _helicopter == "I_APC_Wheeled_03_cannon_F") then {_helicopter setObjectTextureGlobal [0,"\Pandur_textures\pandur_0"];_helicopter setObjectTextureGlobal [1,"\Pandur_textures\pandur_1"];_helicopter setObjectTextureGlobal [2,"\Pandur_textures\pandur_2"];_helicopter setObjectTextureGlobal [3,"\Pandur_textures\pandur_3"];};
if (typeOf _helicopter == "O_APC_Wheeled_02_rcws_F") then {_helicopter setObjectTextureGlobal [0,"\ARMA_textures\ARMA_0"];_helicopter setObjectTextureGlobal [1,"\ARMA_textures\ARMA_1"];_helicopter setObjectTextureGlobal [2,"\ARMA_textures\ARMA_2"];};
if (typeOf _helicopter == "O_MRAP_02_gmg_F" || typeOf _helicopter == "O_MRAP_02_hmg_F") then {_helicopter setObjectTextureGlobal [0,"\IFRIT_textures\IFRIT_0"];_helicopter setObjectTextureGlobal [1,"\IFRIT_textures\IFRIT_1"];_helicopter setObjectTextureGlobal [2,"\IFRIT_textures\IFRIT_2"];};
if (typeOf _helicopter == "O_MRAP_02_F") then {_helicopter setObjectTextureGlobal [0,"\IFRIT_textures\IFRIT_0"];_helicopter setObjectTextureGlobal [1,"\IFRIT_textures\IFRIT_1"];};




//special
if (typeOf _helicopter == "rhs_bmp2d_msv") then {[ 
_helicopter, ["standard",1], ["konkurs_hide_source",1,"crate_l1_unhide",1,"crate_l2_unhide",1,"crate_l3_unhide",1,"crate_r1_unhide",1,"crate_r2_unhide",1,"crate_r3_unhide",1,"wood_1_unhide",1] ] call BIS_fnc_initVehicle; 
_helicopter setObjectTextureGlobal [0,"\BMP_2_textures\BMP2_0"];
_helicopter setObjectTextureGlobal [1,"\BMP_2_textures\BMP2_1"];
_helicopter setObjectTextureGlobal [2,"\BMP_2_textures\BMP2_2"];
_helicopter setObjectTextureGlobal [3,"\BMP_2_textures\BMP2_3"];
};

};
