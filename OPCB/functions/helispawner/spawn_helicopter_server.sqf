params ["_vehicle","_pylons","_isAttack"];
private "_helicopter";
if (_isAttack == 1) then 
{	
	if (_vehicle == "B_UAV_02_dynamicLoadout_f") then 
	
	{
	_helicopter = _vehicle createVehicle (getpos heli_spawnpos);
	createVehicleCrew _helicopter;
	} 
	
	else 
	
	{
	_helicopter = _vehicle createVehicle (getpos heli_spawnpos);
	};
	
	[_helicopter] call skinapplier;
	_helicopter setdir (getdir heli_spawnpos);
	_pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _helicopter >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
	{ _helicopter removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _helicopter;
	{ _helicopter setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;

	_helicopter addMPEventHandler ["MPKilled",{ 
		_maxtanks = missionNamespace getVariable ["MaxAttackHelis",0];
		missionNamespace setVariable ["MaxAttackHelis",_maxtanks -1,true];
	}];

	[_helicopter,_isAttack] remoteExec ["CHAB_fnc_helicopter_restriction",0,true];
	
	
} else 
{
	_helicopter = _vehicle createVehicle (getpos heli_spawnpos);
	[_helicopter] call skinapplier;
	_helicopter setdir (getdir heli_spawnpos);
	_helicopter addMPEventHandler ["MPKilled",
	{
		_current_helis = missionNamespace getVariable ["MaxTransHelis",1];
		_current_helis = _current_helis -1;
		missionNamespace setVariable ["MaxTransHelis",_current_helis,true];
	}];

	if (typeOf _helicopter == "RHS_UH60M_MEV_d") then {
	  _helicopter setVariable ["ace_medical_medicClass",1];
	};
	[_helicopter, _isAttack] remoteExec ["CHAB_fnc_helicopter_restriction",0,true];
	
};