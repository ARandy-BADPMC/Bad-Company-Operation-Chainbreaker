jey_spawn_heli =
{
		disableSerialization;
		createDialog "jey_helispawner";

		waitUntil {
		  !isNull (findDisplay 9900)
		};
		_helicopters = [];

		_ctrl = (findDisplay 9900) displayCtrl 1500;
		for "_j" from 0 to count Helicopter_loadouts -1 step 2 do {
			_item = Helicopter_loadouts select _j;
			_helicopters pushBack _item;
		};
		_i = 0;
		{
			_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			_ctrl lbAdd _text;
			_ctrl lbSetData [_i,_x];
			_i = _i +1;
		} forEach _helicopters;
		
};
jey_heli_loadouts =
{
	disableSerialization;
	_ctrl = (findDisplay 9900) displayCtrl 1500;
	_loadouts = (findDisplay 9900) displayCtrl 1561;

    lbClear _loadouts;
	_heli = lbCurSel _ctrl;
	private ["_heli_loadouts"];
	if(_heli != -1) then 
	{
		_name = _ctrl lbData _heli;
		_index = Helicopter_loadouts find _name; 
		_heli_loadouts = Helicopter_loadouts select (_index +1);
		for "_i" from 0 to count _heli_loadouts -1 step 2 do {
			_loadout_name = _heli_loadouts select _i;
			_loadouts lbAdd _loadout_name;
		};

	}
	else
	{
		hint "Select a vehicle first";
	};
};
jey_spawn_heli_vehicle =
{
	disableSerialization;
	_loadouts = (findDisplay 9900) displayCtrl 1561;
	_loadout = lbCurSel _loadouts;
	if(_loadout != -1) then  
	{	
		_vehiclelist = (findDisplay 9900) displayCtrl 1500;
		_heli = lbCurSel _vehiclelist;

		_vehicle = _vehiclelist lbData _heli;
		_loadout_type = _loadouts lbText _loadout;
		_index = Helicopter_loadouts find _vehicle;
		_loadoutska = Helicopter_loadouts select (_index +1); //array
		_pylons_number = _loadoutska find _loadout_type;

		_pylons = _loadoutska select (_pylons_number +1);

		_nObjects= nearestObjects [getPos heli_spawnpos, ["all"], 7];

		_maxAttackChoppers = missionNamespace getVariable ["MaxAttackHelis",0];
		_maxTransChoppers = missionNamespace getVariable ["MaxTransHelis",0];
		_attackType = ["RHS_UH60M_ESSS_d","RHS_MELB_AH6M","I_Heli_light_03_dynamicLoadout_F","RHS_UH1Y_d","B_Plane_Fighter_01_F","B_Plane_CAS_01_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","RHS_AH1Z","RHS_A10","RHS_AH64D","I_Plane_Fighter_04_F","O_Heli_Light_02_dynamicLoadout_F"];

		if (count _nObjects == 1) then {

			if (_vehicle in _attackType) then 
			{
			  if (_maxAttackChoppers != 2) then
			  {
			  	_maxAttackChoppers = _maxattackchoppers + 1;
			  	missionNamespace setVariable ["MaxAttackHelis",_maxattackchoppers];
			    [_vehicle,_pylons,1] remoteExec ["jey_spawn_helicopter_server",2];

			  } else {hint "There are already 2 attack helicopters in game";};

			} else 
			{
			  if (_maxTransChoppers != 3) then
			  {
			  	_maxTransChoppers = _maxTransChoppers + 1;
			  	missionNamespace setVariable ["MaxTransHelis",_maxTransChoppers];
			    [_vehicle,_pylons,0] remoteExec ["jey_spawn_helicopter_server",2];

			  } else{hint "3 Transport helicopters are already in game.";};
			};

		  	
		} else {hint "Spawn position is not empty";};
	}
	else
	{
		hint "Select a loadout first";
	};
};
jey_spawn_helicopter_server =
{
	params ["_vehicle","_pylons","_isAttack"];
	if (_isAttack == 1) then 
	{
	 	
		_helicopter = _vehicle createVehicle (getpos heli_spawnpos);
		[_helicopter] call skinapplier;
		_helicopter setdir (getdir heli_spawnpos);
		_pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _helicopter >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
		{ _helicopter removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _helicopter;
		{ _helicopter setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;

		_helicopter addMPEventHandler ["MPKilled",{ missionNamespace setVariable ["MaxAttackHelis",0]; }];

		[_helicopter] remoteExec ["jey_helicopter_restriction",0,true];
		
		
	} else 
	{
		_helicopter = _vehicle createVehicle (getpos heli_spawnpos);
		[_helicopter] call skinapplier;
		_helicopter setdir (getdir heli_spawnpos);
		_helicopter addMPEventHandler ["MPKilled",
		{
			_current_helis = missionNamespace getVariable ["MaxTransHelis",1];
			_current_helis = _current_helis -1;
			missionNamespace setVariable ["MaxTransHelis",_current_helis];
		}];

		if (typeOf _helicopter == "RHS_UH60M_MEV_d") then {
		  _helicopter setVariable ["ace_medical_medicClass",1,true];
		};
		[_helicopter] remoteExec ["jey_helicopter_restriction",0,true];
		
	};
		

};
jey_helicopter_restriction =
{
	_vehicle = _this select 0;
	_attackType = ["RHS_UH60M_ESSS_d","RHS_MELB_AH6M","I_Heli_light_03_dynamicLoadout_F","RHS_UH1Y_d","B_Plane_Fighter_01_F","B_Plane_CAS_01_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","RHS_AH1Z","RHS_A10","RHS_AH64D","I_Plane_Fighter_04_F","O_Heli_Light_02_dynamicLoadout_F"];

	if( typeOf _vehicle in _attackType)
		then {
		_vehicle addEventHandler ["GetIn",{_this call checkjetpilot}];
	}
	else
	{
		_vehicle addEventHandler ["GetIn",{_this call checkpilot}];
		_vehicle addEventHandler ["Engine",{_this call checkengine}];
	};
};

jey_remover_heli =
{
	disableSerialization;
	createDialog "jey_remover";

	waitUntil {
	  !isNull (findDisplay 9902)
	};
	_ctrl = (findDisplay 9902) displayCtrl 1500;
	_nearestVeh = [];
	_helipos = getPos heli_spawnpos;
	_i = 0;
  	_nearestVeh = nearestObjects [_helipos, ["Air"], 50];
  	{	
  		_asd = _x getVariable ["vehicleSerial","TIN"];
  		if (_asd == "TIN") then {
  		  _x setVariable ["vehicleSerial",str _x];
  		};
  	 	_text = getText (configFile >> "CfgVehicles" >> typeof _x >> "displayName");
		_ctrl lbAdd _text;
		_ctrl lbSetData [_i,str _x];
		_i = _i +1;
  	} forEach _nearestVeh;
		
};
jey_deletebutton_heli =
{
	disableSerialization;
	_ctrl = (findDisplay 9902) displayCtrl 1500;

	_veh = lbCurSel _ctrl;
	if(_veh != -1) then 
	{
		_vehicle = _ctrl lbData _veh;
		{
		  _asd = _x getVariable ["vehicleSerial","TIN"];
		  if (_asd == _vehicle) then {
		    	_x setPos [0,0,0];
				_x setDamage 1;
		  };
		} forEach vehicles;
		_ctrl lbDelete _veh;
	}
	else
	{
		hint "Select a vehicle first";
	};
};