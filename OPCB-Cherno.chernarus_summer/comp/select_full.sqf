private ["_taskIsrunning","_comp","_current_task","_tasknumber","_current_tasknumber","_markerarray","_base","_taskobjective"];
_taskIsrunning = missionNamespace getVariable ["running_task",1];

if(_taskIsrunning == 0) then {

_tasks = ["Eliminate","Technology","Destroy","Annihilate and Destroy","Secure","Capture","Exterminate","Neutralize","Neutralize2","Destroy Choppers","Attack","Retrieve","Clear out","Minefield","IDAP"];

_tasks call BIS_fnc_arrayShuffle;
_markerarray = ["Mark1","Mark1_2","Mark1_3","Mark1_4","Mark1_5","Mark1_6","Mark1_7","Mark1_8","Mark1_9","Mark1_10","Mark1_11","Mark1_12","Mark1_13","Mark1_14","Mark1_15","Mark1_16","Mark1_17","Mark1_18","Mark1_19","Mark1_20"];

_taskobjective = _tasks call BIS_fnc_selectRandom;

_current_task = selectRandom _markerarray;
missionNamespace setVariable ["current_task",_current_task];

_tasknumber = (missionNamespace getVariable ["TaskNumber",-1]) + 1;
missionNamespace setVariable ["TaskNumber",_tasknumber];
_current_tasknumber = format ["TaskNumberFinal_%1",_tasknumber];

//_taskobjective = "Minefield";
missionNamespace setVariable ["TaskObjective",_taskobjective];
switch (_taskobjective) do 
{ 
	
	case "Destroy Choppers" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = "destroy_chopper";
		[_current_tasknumber ,west,["Russian airsupport is grounded at the moment. Use this to your advantage and attack thier airsupport.","Destroy Choppers",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

		_guardgroup = createGroup east;
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};
		_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 2, "NONE"];

		_guardpos = getpos _guard;
		[_guard] spawn CHAB_fnc_roadblock_rus;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_guard,10,1,2] execVM "functions\spawn_rus.sqf";
		
		_destroytargets = nearestObjects [ _guardpos, ["RHS_Mi24Vt_vvs","rhs_mi28n_vvs"], 30];
		_thetarget = _destroytargets call BIS_fnc_selectRandom;

		waitUntil { 
			sleep 10; 
			!(alive _thetarget) || (damage _thetarget > 0.8)
		};

		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;
		[ _comp ] call LARs_fnc_deleteComp;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Neutralize2" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = "weap_factory";
		[_current_tasknumber ,west,["Insurgents have set up a weaponfactory in an abandoned, unmarked FOB. Locate the factory and destroy important equipment. Also, according to one of our agents, a commander is visiting the factory. Try to capture him.","Locate and Destroy Weapon Factory",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;

		_capturegroup = createGroup resistance;
		_guardgroup = createGroup resistance;
		
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};

		_guard = _guardgroup createUnit ["rhsgref_nat_warlord", _base, [], 2, "NONE"];

		_guardpos = getPos _guard;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		
		sleep 10;
		[_guard,10,1,2] execVM "functions\spawn_nat.sqf";
		sleep 5;
		
		_leader = _capturegroup createUnit ["rhsgref_nat_commander",  _guardpos, [], 2, "NONE"];
		removeAllWeapons _leader;
		_leader setunitpos "middle";

		_house = nearestObjects [ _guardpos, ["Land_i_Shed_Ind_F"], 30];
		_thehouse = _house call BIS_fnc_selectRandom;
		[_guard] spawn CHAB_fnc_roadblock_rus;

		_leader setpos (_thehouse buildingpos 0); 

		waitUntil 
		{
			sleep 10;
			!alive _thehouse
		};
		waitUntil {
		  sleep 10;			
		  (_leader distance (getPos dropoffpoint) < 10) || !alive _leader
		};

		if(alive _leader) then 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;					
			
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		}
		else 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			"The Weapon Factory is destroyed, but the commander is dead." remoteExec ["hint"];
			[_guardpos] call CHAB_fnc_endmission;					
			
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		};
	};
	case "Eliminate": 
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = selectRandom ["warhead1","warhead2","destroy1","destroy2","destroy_tower","destroy_tower2","destroy_radar"];
		[_current_tasknumber ,west,["We have intel on an OPFOR base located in the marked area. You need to eliminate them","Eliminate",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

		_guardgroup = createGroup east;
		
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		   !(_base isEqualTo [0,0,0])
		};
		_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 2, "NONE"];

		_guardpos = getPos _guard;
		[_guard] spawn CHAB_fnc_roadblock_rus;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_guard,10,1,2] execVM "functions\spawn_rus.sqf";
		
		sleep 10;
		_trg = createTrigger ["EmptyDetector", _guardpos,true];
		_trg setTriggerArea [600, 600, 0, false];
		_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];
		sleep 60;
		[] spawn CHAB_fnc_enemycount;
		waitUntil {sleep 10;triggerActivated _trg};
		
		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;

		[ _comp ] call LARs_fnc_deleteComp;
		deleteVehicle _trg;

		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Technology" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = "generator1";
		[_current_tasknumber ,west,["We have reports, that OPFOR is transporting new, to us unknown, technology, which could change the war to their favor. Destroy it under any circumstances!","Destroy Technology",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

		_guardgroup = createGroup east;
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};
		_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 2, "NONE"];

		_guardpos = getpos _guard;
		[_guard] spawn CHAB_fnc_roadblock_rus;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_guard,10,1,2] execVM "functions\spawn_rus.sqf";
		
		_destroytargets = nearestObjects [ _guardpos, ["Land_Device_assembled_F"], 30];
		_thetarget = _destroytargets call BIS_fnc_selectRandom;

		waitUntil { 
			sleep 10; 
			!(alive _thetarget) || (damage _thetarget > 0.8)
		};

		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;
		[ _comp ] call LARs_fnc_deleteComp;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Destroy" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = selectRandom ["warhead1","warhead2","destroy2"];
		[_current_tasknumber ,west,["Intel states, that the russian forces testing new systems for thier T-90 MBT. Destroy the vehicle testbed.","Destroy",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;
		
		_guardgroup = createGroup east;
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		   !(_base isEqualTo [0,0,0])
		};
		_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 2, "NONE"];

		_guardpos = getpos _guard;
		[_guard] spawn CHAB_fnc_roadblock_rus;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_guard,10,2,1] execVM "functions\spawn_rus.sqf";

		_thetarget = createVehicle ["rhs_t90a_tv", _guardpos, [], 1, "NONE"];
		_thetarget lock true;

		waitUntil { sleep 10; !(alive _thetarget) || (damage _thetarget > 0.8)};

		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;
		[ _comp ] call LARs_fnc_deleteComp;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Annihilate and Destroy" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = selectRandom ["destroy_chopper","destroy_radar","destroy_tower","destroy_tower2","weap_factory"];
		[_current_tasknumber ,west,["OPFOR set up a base and will hold it under any circumstances. Clear out the area and destroy any important equipment.","Annihilate and Destroy",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;
		
		_guardgroup = createGroup east;
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		   !(_base isEqualTo [0,0,0])
		};
		_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 2, "NONE"];

		_guardpos = getPos _guard;
		[_guard] spawn CHAB_fnc_roadblock_rus;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_guard,10,1,2] execVM "functions\spawn_rus.sqf";
		
		_destroytargets = nearestObjects [ _guardpos, ["Land_Device_assembled_F","RHS_Mi24Vt_vvs","rhs_mi28n_vvs","Land_TTowerBig_1_F","Land_TTowerBig_2_F","rhs_p37","Land_i_Shed_Ind_F"], 30];
		_thetarget = _destroytargets call BIS_fnc_selectRandom;

		sleep 5;
		_trg = createTrigger ["EmptyDetector", _guardpos,true];
		_trg setTriggerArea [600, 600, 0, false];
		_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];

		sleep 30;
		[] spawn CHAB_fnc_enemycount;
		waitUntil { 
			sleep 10; 
			(!(alive _thetarget) || (damage _thetarget > 0.8)) && (triggerActivated _trg)
		};

		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;
		[ _comp ] call LARs_fnc_deleteComp;
		deleteVehicle _trg;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Secure" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = selectRandom ["warhead1","warhead2"];
		[_current_tasknumber ,west,["The invaders brought a nuclear warhead to Isla Duala and are threatening, to launch it. Our task is to secure and recover it.","Secure nuclear Warhead",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

		_guardgroup = createGroup east;
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		   !(_base isEqualTo [0,0,0])
		};

		_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 1, "NONE"];

		_guardpos = getPos _guard;

		[_guard] spawn CHAB_fnc_roadblock_rus;

		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_guard,10,1,3] execVM "functions\spawn_rus.sqf";

		_thetarget = createVehicle ["O_Truck_03_device_F", _guardpos, [], 1, "NONE"];

		_thetarget setVehicleAmmo 0;
		sleep 5;
		_thetarget setDamage 0;

		waitUntil {
		 sleep 10; 
			!(alive _thetarget) || _thetarget distance (getPos dropoffpoint) < 15
		};

		if(!alive _thetarget) then 
		{
			[_current_tasknumber, "FAILED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		}
		else 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		};
	};
	case "Capture" :
	{
		_taskcomp = selectRandom ["insurgent1","insurgent2","insurgent3","insurgent4","insurgent_big","insurgent_hostage"];
		missionNamespace setVariable ["running_task",1];
		[_current_tasknumber ,west,["A high ranking officer has arrived at an Insurgent camp near the marked area. You have to Capture him","Capture the HRO",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"search",true] call BIS_fnc_setTask;
		_capturegroup = createGroup east;

		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};
		_target1 = _capturegroup createUnit ["rhs_g_Soldier_TL_F", _base, [], 2, "NONE"];

		_guardpos = getPos _target1;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

		[_target1,10,1,2] execVM "functions\spawn_ins.sqf";
		
		removeAllWeapons _target1;
		_target1 disableAI "AUTOCOMBAT";
		_target1 setunitpos "middle";
		[_target1] spawn CHAB_fnc_roadblock_ins;
		waitUntil 
		{
			sleep 10;
			_target1 distance (getPos dropoffpoint) < 10 || !alive _target1
		};

		if(alive _target1) then 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		}
		else
		{
			[_current_tasknumber, "FAILED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		};
	};
	case "Exterminate" :
	{
		_taskcomp = selectRandom ["insurgent1","insurgent2","insurgent3","insurgent4","insurgent_big","insurgent_hostage"];
		missionNamespace setVariable ["running_task",1];
		[_current_tasknumber ,west,["Insurgents terrorising the total population. We can not tolerate this.","Defend the defensless",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

		_guardgroup = createGroup east;
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};
		_guard = _guardgroup createUnit ["rhs_g_Soldier_TL_F", _base, [], 2, "NONE"];

		_guardpos = getPos _guard;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_guard,10,2,2] execVM "functions\spawn_ins.sqf";
		
		sleep 10;
		_trg = createTrigger ["EmptyDetector", _guardpos,true];
		_trg setTriggerArea [600, 600, 0, false];
		_trg setTriggerActivation ["GUER", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];
		[_guard] spawn CHAB_fnc_roadblock_ins;
		sleep 60;

		[] spawn CHAB_fnc_enemycount;

		waitUntil {sleep 10;triggerActivated _trg};
		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;
		
		[ _comp ] call LARs_fnc_deleteComp;
		deleteVehicle _trg;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "IDAP" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = "peacekeeper";
		[_current_tasknumber ,west,["IDAP Units have reported indirect and small arms fire on one of their locations, wounding several peacekeepers and civilians. You are tasked, to investigate, interrogate survivors, locate the enemy firing-positions and take them, including all the equipment, out. Be aware of counterattacks!","Locate Mortars",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;
		_resgroup = createGroup resistance;
		_guardgroup = createGroup civilian;
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0]) 
		};

		_guard = _guardgroup createUnit ["B_GEN_Commander_F", _base, [], 2, "NONE"];

		_guardpos = getPos _guard;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

		{
		  if (_x != _guard) then {
		    deleteVehicle _x;
		  };
		  
		} forEach (allUnits select { (_x distance _guardpos ) < 200 } );

		_markpos1 = [_guardpos, 100, random 359] call BIS_fnc_relPos;
		_defender1 = [_markpos1, civilian,["B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Commander_F"]] call BIS_fnc_spawnGroup;
		[_defender1,150] execVM "functions\shk_patrol.sqf";
		_defender1 deleteGroupWhenEmpty true;

		_nearestCity = nearestLocation [ _guardpos, "NameVillage"];
		_village = locationPosition _nearestCity;

		[_current_tasknumber,_guardpos] call BIS_fnc_taskSetDestination;

		[_village] call CHAB_fnc_idap;

		[_guard,["<t color='#FF0000'>Tell me which town is under attack.</t>",
		{
			_village = _this select 3 select 0;
			_townName = text _village;

			hint format ["%1 is currently under heavy artilerry fire. Please save the Village.",_townName];


		}, [_nearestCity], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
		missionNamespace setVariable ["artilerry_rem",4];
		[_village,_guard] spawn CHAB_fnc_artilerry;

		waitUntil {
		  _remain = missionNamespace getVariable ["artilerry_rem",4];
		
		  _remain <= 0
		};

		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;					
		
		[ _comp ] call LARs_fnc_deleteComp;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Neutralize" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = "ied_factory";
		[_current_tasknumber ,west,["Insurgents set up an IED Factory. To protect our own and the lifes of the innocent population, we need to take it out. If possible, capture the Leader, that is controlling the manufacturing process","Locate and Destroy IED Factory",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;

		_capturegroup = createGroup resistance;
		_guardgroup = createGroup resistance;
		
		waitUntil {
		  _base = [getMarkerPos _current_task, 400, 2000, 20, 0, 0.5, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};

		_guard = _guardgroup createUnit ["rhs_g_Soldier_TL_F", _base, [], 2, "NONE"];

		_guardpos = getPos _guard;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		
		sleep 10;
		[_guard,10,1,2] execVM "functions\spawn_ins.sqf";
		sleep 5;

		_leader = _capturegroup createUnit ["rhs_g_Soldier_TL_F",  _guardpos, [], 2, "NONE"];
		removeAllWeapons _leader;
		_leader setunitpos "middle";

		_house = nearestObjects [ _guardpos, ["Land_i_Shed_Ind_F"], 30];
		_thehouse = _house call BIS_fnc_selectRandom;
		[_guard] spawn CHAB_fnc_roadblock_ins;

		_leader setpos (_thehouse buildingpos 0); 

		waitUntil 
		{
			sleep 10;
			!alive _thehouse
		};
		waitUntil {
		  sleep 10;			
		  (_leader distance (getPos dropoffpoint) < 10) || !alive _leader
		};

		if(alive _leader) then 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;					
			
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		}
		else 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			"The IED factory is destroyed, but the leader is dead." remoteExec ["hint"];
			[_guardpos] call CHAB_fnc_endmission;					
			
			[ _comp ] call LARs_fnc_deleteComp;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		};
	};
	case "Resupply" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = selectRandom ["fob1","fob2","fob3","fob4","fob5"];
		[_current_tasknumber ,west,["Nearby friendly forces have requested our help. You have to bring supplies to them. You have abou 15 minutes left before the attack begins.","Resupply",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"rearm",true] call BIS_fnc_setTask;

		_officergroup = createGroup west;

		waitUntil {
			_base = [getMarkerPos _current_task, 200, 800, 30, 0, 0.4, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};

		_officer = _officergroup createUnit ["rhsusf_usmc_marpat_d_officer", _base, [], 2, "NONE"];

		_officer disableAI "MOVE";

		_container = "C_IDAP_supplyCrate_F" createVehicle (getMarkerPos "object_dropoff");
		[_container, 5] call ace_cargo_fnc_setSize;
		clearItemCargoGlobal _container;

		_guardpos = getPos _officer;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

		_markpos1 = [_guardpos, 50, random 359] call BIS_fnc_relPos;
		_markpos2 = [_guardpos, 50, random 359] call BIS_fnc_relPos;

		_defender1 = [_markpos1, west,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;
		_defender2 = [_markpos2, west,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;
		_defender1 deleteGroupWhenEmpty true;
		_defender2 deleteGroupWhenEmpty true;

		[_defender1, _guardpos, 100] call bis_fnc_taskPatrol;
		[_defender2, _guardpos, 100] call bis_fnc_taskPatrol;
		waitUntil {
		  sleep 5;
		
		  _container distance (getPos _officer) < 500
		};
		//sleep 300;

		_nearestplayer = [_officer] call CHAB_fnc_nearest;
		if(isnull _nearestplayer) then{ _nearestplayer == officer_jeff};

		_dir = [ _officer, _nearestplayer ] call BIS_fnc_dirTo;
		_opposite = _dir + 180;

		_attackpos1 = [_guardpos, 800, _opposite +20] call BIS_fnc_relPos;
		_attackpos2 = [_guardpos, 800, _opposite -20] call BIS_fnc_relPos;
		_attackpos3 = [_guardpos, 800, _opposite +40] call BIS_fnc_relPos;
		_attackpos4 = [_guardpos, 800, _opposite -40] call BIS_fnc_relPos;
		_attackpos5 = [_guardpos, 800, _opposite] call BIS_fnc_relPos;

		_attacker2= [_attackpos2, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad")] call BIS_fnc_spawnGroup;
		_attacker3= [_attackpos3, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_2mg")] call BIS_fnc_spawnGroup;
		_attacker4= [_attackpos4, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_mg_sniper")] call BIS_fnc_spawnGroup;
		_attacker2 deleteGroupWhenEmpty true;
		_attacker3 deleteGroupWhenEmpty true;
		_attacker4 deleteGroupWhenEmpty true;

		_wayp2 = _attacker2 addWaypoint [_guardpos, 100];
		_wayp2 setWaypointType "SAD";

		_wayp3 = _attacker3 addWaypoint [_guardpos, 100];
		_wayp3 setWaypointType "SAD";

		_wayp4 = _attacker4 addWaypoint [_guardpos, 100];
		_wayp4 setWaypointType "SAD";

		_listofroads1 = _attackpos1 nearRoads 1200;
		_roadhelp1 = _listofroads1 call BIS_fnc_selectRandom;
		_attackpos1 = getPos _roadhelp1;

		_listofroads2 = _attackpos5 nearRoads 1200;
		_roadhelp2 = _listofroads2 call BIS_fnc_selectRandom;
		_attackpos5 = getPos _roadhelp2;

		_attacker5= [_attackpos5, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_gaz66" >> "rhs_group_rus_vdv_gaz66_squad_2mg")] call BIS_fnc_spawnGroup;
		_attacker1= [_attackpos1, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad_mg_sniper")] call BIS_fnc_spawnGroup;
		_wayp1 = _attacker1 addWaypoint [_guardpos, 100];
		_wayp1 setWaypointType "SAD";
		_wayp5 = _attacker5 addWaypoint [_guardpos, 100];
		_wayp5 setWaypointType "SAD";
		_attacker5 deleteGroupWhenEmpty true;
		_attacker1 deleteGroupWhenEmpty true;

		_trg = createTrigger ["EmptyDetector", _guardpos,true];
		_trg setTriggerArea [1200, 1200, 0, false];
		_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];

		[_current_tasknumber,_base] call BIS_fnc_taskSetDestination;
		[] spawn CHAB_fnc_enemycount;
		waitUntil 
		{
			sleep 10;
			_container distance (getPos _officer) < 20 || !alive _officer || !alive _container
		};

		if(alive _officer && alive _container) then 
		{
			"You have delivered the supplies. Now try to defend the FOB" remoteExec ["hint"];
		}
		else
		{
			"The commander of the FOB is dead and now the supplies are worthless." remoteExec ["hint"];
		};

		waitUntil 
		{
		  sleep 10;
		  triggerActivated _trg || !alive _officer
		};

		if(alive _officer) then 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
			deleteVehicle _officer;
			deleteVehicle _container;
			{deleteVehicle _x} forEach units _defender1;
			{deleteVehicle _x} forEach units _defender2;
			[ _comp ] call LARs_fnc_deleteComp;
		}
		else
		{
			[_current_tasknumber, "FAILED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			{deleteVehicle _x} forEach units _defender1;
			{deleteVehicle _x} forEach units _defender2;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
			deleteVehicle _officer; 
			deleteVehicle _container;
			[ _comp ] call LARs_fnc_deleteComp;
		};
	};
	case "Escort" :
	{
		missionNamespace setVariable ["running_task",1];
		_taskcomp = selectRandom ["fob1","fob2","fob3","fob4","fob5"];
		[_current_tasknumber ,west,["An army officer is arriving soon to the airport. You have to escort him to a nearby FOB.","Escort",_current_task],getMarkerPos _current_task,"ASSIGNED",10,true,true,"defend",true] call BIS_fnc_setTask;

		_officergroup = createGroup west;
		_landergroup = createGroup west;

		waitUntil {
			_base = [getMarkerPos _current_task, 100, 800, 30, 0, 0.4, 0, ["base_marker"], [getMarkerPos _current_task,getMarkerPos _current_task]] call BIS_fnc_findSafePos;

		  !(_base isEqualTo [0,0,0])
		};
		_lander = _landergroup createUnit ["rhsusf_usmc_marpat_d_officer", [0,0,0], [], 2, "NONE"];
		_officer = _officergroup createUnit ["rhsusf_usmc_marpat_d_officer", _base, [], 2, "NONE"];

		_officer allowDamage false;

		_landinggroup = createGroup west;
		_plane= [[0,0,300], 90, "RHS_CH_47F_10", _landinggroup] call bis_fnc_spawnvehicle;
		_planeobj = _plane select 0;

		_lander moveInCargo _planeobj;

		_landingposhelp = getMarkerPos "getout1";
		_landingpos = [_landingposhelp select 0,_landingposhelp select 1, 0];

		_landing1 = _landinggroup addWaypoint [_landingpos,100];
		_landing1 setWaypointType "TR UNLOAD";

		_landing2 = _landinggroup addWaypoint [getPos _lander,10];
		_landing2 setWaypointType "UNLOAD";

		_officerpoint= _landergroup addWaypoint [getMarkerPos "move1",10];
		_officerpoint setWaypointType "MOVE";

		[_lander] remoteExec ["CHAB_fnc_lander_action", 0, true];

		_guardpos = getPos _officer;
		_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
		[_current_tasknumber,_guardpos] call BIS_fnc_taskSetDestination;

		_markpos1 = [_guardpos, 50, random 359] call BIS_fnc_relPos;
		_markpos2 = [_guardpos, 50, random 359] call BIS_fnc_relPos;

		_defender1 = [_markpos1, west,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;
		_defender2 = [_markpos2, west,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;

		_defender1 deleteGroupWhenEmpty true;
		_defender2 deleteGroupWhenEmpty true;

		[_defender1, _guardpos, 100] call bis_fnc_taskPatrol;
		[_defender2, _guardpos, 100] call bis_fnc_taskPatrol;
		sleep 500;

		_nearestplayer = [_officer] call CHAB_fnc_nearest;
		if(isnull _nearestplayer) then{ _nearestplayer == officer_jeff};

		_dir = [ _officer, _nearestplayer ] call BIS_fnc_dirTo;
		_opposite = _dir + 180;

		_attackpos1 = [getPos _officer, 800, _opposite +20] call BIS_fnc_relPos;
		_attackpos2 = [getPos _officer, 800, _opposite -20] call BIS_fnc_relPos;
		_attackpos3 = [getPos _officer, 800, _opposite +40] call BIS_fnc_relPos;
		_attackpos4 = [getPos _officer, 800, _opposite -40] call BIS_fnc_relPos;
		_attackpos5 = [getPos _officer, 800, _opposite] call BIS_fnc_relPos;

		_attacker2= [_attackpos2, independent, (configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "Infantry" >> "IRG_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
		_attacker3= [_attackpos3, resistance, (configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "Infantry" >> "IRG_InfTeam_AT")] call BIS_fnc_spawnGroup;
		_attacker4= [_attackpos4, resistance, (configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "Infantry" >> "IRG_InfTeam_MG")] call BIS_fnc_spawnGroup;

		_attacker2 deleteGroupWhenEmpty true;
		_attacker3 deleteGroupWhenEmpty true;
		_attacker4 deleteGroupWhenEmpty true;

		_wayp2 = _attacker2 addWaypoint [_guardpos, 100];
		_wayp2 setWaypointType "SAD";

		_wayp3 = _attacker3 addWaypoint [_guardpos, 100];
		_wayp3 setWaypointType "SAD";

		_wayp4 = _attacker4 addWaypoint [_guardpos, 100];
		_wayp4 setWaypointType "SAD";

		_listofroads1 = _attackpos1 nearRoads 800;
		_roadhelp1 = _listofroads1 call BIS_fnc_selectRandom;
		_attackpos1 = getPos _roadhelp1;

		_listofroads2 = _attackpos5 nearRoads 800;
		_roadhelp2 = _listofroads2 call BIS_fnc_selectRandom;
		_attackpos5 = getPos _roadhelp2;

		_attacker5= [_attackpos5, resistance, (configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "rhs_group_indp_ins_btr60" >> "rhs_group_chdkz_btr60_squad_aa")] call BIS_fnc_spawnGroup;
		_attacker1= [_attackpos1, resistance, (configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "rhs_group_indp_ins_ural" >> "rhs_group_chdkz_ural_squad_mg_sniper")] call BIS_fnc_spawnGroup;
		_attacker5 deleteGroupWhenEmpty true;
		_attacker1 deleteGroupWhenEmpty true;
		_wayp1 = _attacker1 addWaypoint [_guardpos, 100];
		_wayp1 setWaypointType "SAD";
		_wayp5 = _attacker5 addWaypoint [_guardpos, 100];
		_wayp5 setWaypointType "SAD";

		_trg = createTrigger ["EmptyDetector", _guardpos,true];
		_trg setTriggerArea [1200, 1200, 0, false];
		_trg setTriggerActivation ["GUER", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];

		waitUntil 
		{
			sleep 10;
			_lander distance (getPos _officer) < 20 || !alive _lander 
		};

		if(alive _lander) then 
		{
			"You have escorted the officer to safety. Make sure it remains safe" remoteExec ["hint"];
		}
		else
		{
			"The officer is dead" remoteExec ["hint"];
		};

		waitUntil 
		{
		  sleep 10;
		  triggerActivated _trg || !alive _lander
		};

		if(alive _lander) then 
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
			deleteVehicle _officer;
			deleteVehicle _lander;
			{deleteVehicle _x} forEach units _defender1;
			{deleteVehicle _x} forEach units _defender2;
			_planeobj setDamage 1;
			[ _comp ] call LARs_fnc_deleteComp;
			deleteVehicle _planeobj;
		}
		else
		{
			[_current_tasknumber, "FAILED",true] spawn BIS_fnc_taskSetState;
			"The officer is dead. " remoteExec ["hint"];
			[_guardpos] call CHAB_fnc_endmission;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
			deleteVehicle _officer;
			deleteVehicle _lander;
			{deleteVehicle _x} forEach units _defender1;
			{deleteVehicle _x} forEach units _defender2;
			_planeobj setDamage 1;
			[ _comp ] call LARs_fnc_deleteComp;
			deleteVehicle _planeobj;
		};
	};
	case "Retrieve" :
	{
		missionNamespace setVariable ["running_task",1];

		_cities = nearestLocations [getPosATL officer_jeff, ["NameCity"], 25000];
		_city = _cities call BIS_fnc_selectRandom;
		_citypos = locationPosition _city;

		_citymarker = missionNamespace getVariable ["citymarker",_citypos];
		_citymarker setMarkerPos _citypos;

		[_current_tasknumber ,west,["Insurgent forces have stolen an ammo crate from a nearby FOB. Retrieve the Ammo crate and find out who is the fugitive.","Retrieve",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"listen",true] call BIS_fnc_setTask;

		_guardgroup = createGroup civilian;
		_guard = _guardgroup createUnit ["rhs_g_Soldier_TL_F", getMarkerPos _citymarker, [], 2, "NONE"];
		_guardpos = getpos _guard;
		_taskItems = [_guard] call CHAB_fnc_retrieve;
		[_guard,5,0,0] execVM "functions\spawn_ins.sqf";
		
		sleep 20;
		_crate = _taskItems select 0;
		_fugitive = _taskItems select 1;

		_guard setDamage 1;

		waitUntil {
		  sleep 20;
		  (!alive _fugitive && _crate distance (getPos dropoffpoint) < 10) || !alive _crate
		};

		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call jey_endmission;
		deleteVehicle _crate;
		missionNamespace setVariable ["running_task",0];
	};
	case "Attack" : 
	{	
		missionNamespace setVariable ["running_task",1];
		_cities = nearestLocations [getPosATL officer_jeff, ["NameCity"], 25000];
		_city = _cities call BIS_fnc_selectRandom;
		_citypos = locationPosition _city;

		_citymarker = missionNamespace getVariable ["citymarker",_citypos];
		_citymarker setMarkerPos _citypos;

		[_current_tasknumber ,west,["The area has been overrun by OPFOR. Re-capture it.","Re-capture",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;
		
		_guardgroup = createGroup east;
		_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", getMarkerPos _citymarker, [], 2, "NONE"];

		_guardpos = getPos _guard;
		[_guard] call CHAB_fnc_spawn_city_rus;

		sleep 5;
		_trg = createTrigger ["EmptyDetector", _guardpos,true];
		_trg setTriggerArea [450, 450, 0, false];
		_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];

		[_guard,10,2,2] execVM "functions\spawn_rus.sqf";
		sleep 20;
		[] spawn CHAB_fnc_enemycount;

		waitUntil {
			sleep 10;
			triggerActivated _trg
		};
		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;
		deleteVehicle _trg;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Minefield" :
	{	
		missionNamespace setVariable ["running_task",1];
		_cities = nearestLocations [getPosATL officer_jeff, ["NameCity"], 25000];
		_city = selectRandom _cities;
		_citypos = locationPosition _city;

		_citymarker = missionNamespace getVariable ["citymarker",_citypos];
		_citymarker setMarkerPos _citypos;
		[_current_tasknumber ,west,["Enemy forces laid mines to stop our advance against them. These mines are not just a threat to us, but also for the local population. Clear the minefields, but be careful, the enemy might be watching them.","Minefield",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

		_guardgroup = createGroup resistance;
		_guard = _guardgroup createUnit ["rhs_g_Soldier_TL_F", getMarkerPos _citymarker, [], 2, "NONE"];
		_guardpos = getPos _guard;
		_mines = [_guard] call CHAB_fnc_minefield;

		[_guard,6,0,2] execVM "functions\spawn_ins.sqf";
		{
		  resistance revealMine _x;
		  civilian revealMine _x;
		} forEach _mines;

		//copyToClipboard str _mines;
		sleep 60;
		

		waitUntil {
			_van = 1;
		  	{
		  	 	if ( alive _x ) exitWith { _van = 1;};
		  	 	_van = 0;
		  	} forEach _mines;
		
		  _van == 0
		};

		[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
		[_guardpos] call CHAB_fnc_endmission;
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	};
	case "Clear out" : 
	{
		missionNamespace setVariable ["running_task",1];
		_cities = nearestLocations [getPosATL officer_jeff, ["NameCity"], 25000];
		_city = _cities call BIS_fnc_selectRandom;
		_citypos = locationPosition _city;

		_citymarker = missionNamespace getVariable ["citymarker",_citypos];
		_citymarker setMarkerPos _citypos;

		[_current_tasknumber ,west,["There is a riot going on. Clear out the area and capture the leader. We also have intel of two captured journalists, which need to be rescued.","Clear out and rescue",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

		_guardgroup = createGroup resistance;
		_guard = _guardgroup createUnit ["rhs_g_Soldier_TL_F", getMarkerPos _citymarker, [], 2, "NONE"];
		removeAllWeapons _guard;
		_guard disableAI "AUTOCOMBAT";
		_guard setunitpos "MIDDLE";
		_rescuegroup = createGroup civilian;

		_guardpos = getPos _guard;
		_houses = nearestObjects [_guardpos, ["house"], 200];
		_house1 = selectRandom _houses;
		_house2 = selectRandom _houses;

		_positions1 = [_house1] call BIS_fnc_buildingPositions;
		_positions2 = [_house2] call BIS_fnc_buildingPositions;

		while {count _positions1 == 0} do {
		  _house1 = selectRandom _houses;
		  _positions1 = [_house1] call BIS_fnc_buildingPositions;
		};
		while {count _positions2 == 0} do {
		  _house2 = selectRandom _houses;
		  _positions2 = [_house2] call BIS_fnc_buildingPositions;
		};

		_pos1max = count _positions1;
		_pos2max = count _positions2;

		_journal1 = _rescuegroup createUnit ["C_journalist_F", _guardpos, [], 2, "NONE"];
		_journal2 = _rescuegroup createUnit ["C_journalist_F", _guardpos, [], 2, "NONE"];

		_journal1 setPosATL (_house1 buildingpos (_pos1max -1)); 
		_journal2 setPosATL (_house2 buildingpos (_pos2max -1)); 

		[_journal1, true] call ACE_captives_fnc_setSurrendered;
		[_journal2, true] call ACE_captives_fnc_setSurrendered;

		[_guard] call CHAB_fnc_spawn_city_ins;

		_trg = createTrigger ["EmptyDetector", _guardpos,true];
		_trg setTriggerArea [600, 600, 0, false];
		_trg setTriggerActivation ["GUER", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];
		[_guard,10,1,1] execVM "functions\spawn_ins.sqf";
		sleep 30;
		[] spawn CHAB_fnc_enemycount;

		waitUntil 
		{
			sleep 10;
			triggerActivated _trg
		};
		waitUntil {
		  sleep 2;
		  _journal1 distance (getPos dropoffpoint) < 10 || !alive _journal1
		};
		waitUntil {
		  sleep 2;
		  _journal2 distance (getPos dropoffpoint) < 10 || !alive _journal2
		};

		waitUntil {
		  sleep 2;
		  _guard distance (getPos dropoffpoint) < 10 || !alive _guard
		};

		if(!alive _guard) then { "The task is completed but the leader is dead." remoteExec ["hint"];};
		if(alive _guard && alive _journal1 && alive _journal2)
		then
		{
			[_current_tasknumber, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			deleteVehicle _journal1;
			deleteVehicle _journal2;
			deleteVehicle _trg;
			deleteMarker _marker;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
		}
		else
		{
			[_current_tasknumber, "FAILED",true] spawn BIS_fnc_taskSetState;
			[_guardpos] call CHAB_fnc_endmission;
			missionNamespace setVariable ["running_task",0];
			missionNamespace setVariable ["TaskObjective","none"];
			deleteVehicle _journal1;
			deleteVehicle _journal2;
			deleteVehicle _trg;
		};
	};
	default 
	{ 
		"Failed to spawn a task, try again" remoteExec["hint",0];
		missionNamespace setVariable ["running_task",0];
		missionNamespace setVariable ["TaskObjective","none"];
	}; 
};

} 
else 
{
	_callerRE = remoteExecutedOwner;
  "There are still BLUFOR units in the AO" remoteExec ["hint",_callerRE];
};