params ["_base","_current_tasknumber"];

_cities = missionNamespace getVariable["Cities",0];
_city = _cities select { type _x == "NameCity" || type _x == "NameCityCapital"}; //
_citypos = locationPosition (selectRandom _city);
_citymarker = missionNamespace getVariable ["citymarker",_citypos];
_citymarker setMarkerPos _citypos;

[_current_tasknumber ,west,["We have intel on the local arms-dealer who is supplying the resistance and is one of the main financers of the Armored Vehicle trades.He is guarded by Brutes and War veterans who aren't afraid to die for their Overlord. Take him out, but be careful; if enemy forces spot you, they will do everything in their power to stop you.","El Chapo",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"kill",true] call BIS_fnc_setTask;

_group = createGroup [resistance,true];
_guard = _group createUnit ["rhs_g_Soldier_TL_F", getMarkerPos _citymarker, [], 2, "NONE"];
_guardpos = getPos _guard;

_houses = nearestObjects [_guard, ["house"], 300] select { count ( _x buildingPos -1 ) > 10 };

_building = selectRandom _houses;
/*
_windowPositions = [];


_selectionNames = selectionNames _building;
_selectionPositions = [];
_windows = _selectionNames select {toUpper _x find "GLASS" >= 0 || toUpper _x find "DOOR" >= 0};
{
	_selectionPositions pushBack (_building modelToWorldVisual (_building selectionPosition [_x,"GEOMETRY"]));
} forEach _windows;

_windowPositions append _selectionPositions;

_closestArray =[];
_distance = 100; 
_i = 0;

{
	_thepos = _x;
	{
		if ( (_thepos distance _x) < _distance) then {
			_distance = (_thepos distance _x);
			_closestArray set [_i,[_thepos,_x,_distance]];
		};
	} forEach _windowPositions;
	_i=_i +1;
	_distance = 100;
} forEach (_building buildingPos -1);

_closest = _closestArray select 0;
{
	//[building,window,distance] = _x;
	if ((_x select 2) < (_closest select 2)) then {
		_closest = _x;
	};
} forEach _closestArray;*/
_number = count (_building buildingPos -1);
_buildpos = (_building buildingPos -1) select ( ceil _number/2);
_officer = _group createUnit ["rhs_g_Soldier_TL_F", _buildpos, [], 2, "NONE"]; 
_officer disableAI "MOVE";
_officer allowDamage false;
_guard setUnitLoadout [["rhs_weap_t5000","","","rhsusf_acc_LEUPOLDMK4",["rhs_5Rnd_338lapua_t5000",5],[],"bipod_02_F_blk"],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["U_I_C_Soldier_Para_3_F",[["ACRE_PRC343",1],["ACRE_PRC148",1],["ACE_fieldDressing",3],["ACE_elasticBandage",2],["ACE_quikclot",1],["ACE_microDAGR",1],["ACE_MapTools",1],["ACE_RangeCard",1]]],["TAC_Jvest_U2O",[["rhs_5Rnd_338lapua_t5000",10,5],["rhs_mag_9x18_8_57N181S",4,8],["rhs_mag_rgo",2,1],["rhs_mag_rgn",1,1],["rhs_mag_rgd5",1,1],["rhs_mag_rdg2_white",3,1],["rhs_mag_zarya2",2,1]]],[],"rhsgref_patrolcap_specter","G_Bandanna_khk",["rhs_pdu4","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]];
_officer setUnitLoadout [[],[],[],["TRYK_U_pad_j_blk",[["ACRE_PRC343",1],["ACRE_PRC148",1],["ACE_fieldDressing",3],["ACE_elasticBandage",2],["ACE_quikclot",1]]],["TAC_FS_FOL_B",[]],[],"rhs_beret_mp1","rhs_googles_black",[],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]];
_guard disableAI "MOVE";
_guard allowDamage false;
_guard setSkill 1;

_j = 0;
for "_i" from 0 to 4 do {
	_unit = _group createUnit ["rhs_g_Soldier_TL_F", (_building buildingPos _j), [], 2, "NONE"]; 
	_unit setUnitLoadout [["hlc_m249_pip3","muzzle_snds_H_MG_blk_F","","hlc_optic_HensoldtZO_Lo",["hlc_200rnd_556x45_T_SAW",200],[],""],[],["hgun_Pistol_heavy_01_F","hlc_muzzle_Octane45","hlc_acc_TLR1","",["11Rnd_45ACP_Mag",11],[],""],["TRYK_U_B_PCUHsW9",[["FirstAidKit",1],["rhs_VOG25",1,1]]],["V_PlateCarrierSpec_blk",[["rhs_VOG25",7,1],["rhs_mag_m67",5,1]]],["B_FieldPack_blk",[["rhs_mag_rgn",3,1],["hlc_200rnd_556x45_T_SAW",2,200]]],"TAC_K6C","G_Balaclava_blk",[],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]];
	_j = _j+2;
	_unit setSkill 1;
};

_guard setPos [(getPos _officer select 0),(getPos _officer select 1),(getPos _officer select 2)+30];
sleep 4;
_guard allowDamage true;
_officer allowDamage true;

_spawncomps = [_officer] call CHAB_fnc_roadblock_ins; //double fun
[_officer,7,1,2] call CHAB_fnc_spawn_ins;

_hmgs = [_officer] call CHAB_fnc_spawn_hmg;

with missionNamespace do
{
	{
		{
			_x addEventHandler ["FiredNear", {
				params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
				with missionNamespace do
				{
					Chapo_trigger = true;
				};
				_unit removeEventHandler ["FiredNear", _thisEventHandler];
			}];
		} forEach units _x;
	} forEach enemy_groups;
};

waitUntil {
	_trigger = missionNamespace getVariable "Chapo_trigger";
  !alive _officer || _trigger
};

if (alive _officer) then {
	"The enemies already know we are here. Prepare for the worst. HOLD TIGHT!" remoteExec ["hint"]; 
	[_officer] call CHAB_fnc_reinforcement;

	waitUntil {
	  !alive _officer
	};

};

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
[_base] call CHAB_fnc_endmission;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _hmgs;


//guard
//[["hlc_m249_pip3","muzzle_snds_H_MG_blk_F","","hlc_optic_HensoldtZO_Lo",["hlc_200rnd_556x45_T_SAW",200],[],""],[],["hgun_Pistol_heavy_01_F","hlc_muzzle_Octane45","hlc_acc_TLR1","",["11Rnd_45ACP_Mag",11],[],""],["TRYK_U_B_PCUHsW9",[["FirstAidKit",1],["rhs_VOG25",1,1]]],["V_PlateCarrierSpec_blk",[["rhs_VOG25",7,1],["rhs_mag_m67",5,1]]],["B_FieldPack_blk",[["rhs_mag_rgn",3,1],["hlc_200rnd_556x45_T_SAW",2,200]]],"TAC_K6C","G_Balaclava_blk",[],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]]

//sniper
//[["rhs_weap_t5000","","","rhsusf_acc_LEUPOLDMK4",["rhs_5Rnd_338lapua_t5000",5],[],"bipod_02_F_blk"],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["U_I_C_Soldier_Para_3_F",[["ACRE_PRC343",1],["ACRE_PRC148",1],["ACE_fieldDressing",3],["ACE_elasticBandage",2],["ACE_quikclot",1],["ACE_microDAGR",1],["ACE_MapTools",1],["ACE_RangeCard",1]]],["TAC_Jvest_U2O",[["rhs_5Rnd_338lapua_t5000",10,5],["rhs_mag_9x18_8_57N181S",4,8],["rhs_mag_rgo",2,1],["rhs_mag_rgn",1,1],["rhs_mag_rgd5",1,1],["rhs_mag_rdg2_white",3,1],["rhs_mag_zarya2",2,1]]],[],"rhsgref_patrolcap_specter","G_Bandanna_khk",["rhs_pdu4","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]]

//officer
//[[],[],[],["TRYK_U_pad_j_blk",[["ACRE_PRC343",1],["ACRE_PRC148",1],["ACE_fieldDressing",3],["ACE_elasticBandage",2],["ACE_quikclot",1]]],["TAC_FS_FOL_B",[]],[],"rhs_beret_mp1","rhs_googles_black",[],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]]