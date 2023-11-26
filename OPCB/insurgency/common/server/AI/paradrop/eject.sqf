/* 
	Filename: Simple ParaDrop Script v0.96 eject.sqf
	Author: Beerkan
	
	Description:
     A Simple Paradrop Script
   
	Parameter(s):
	0: VEHICLE  - vehicle that will be doing the paradrop (object)
	1: ALTITUDE - (optional) the altitude where the group will open their parachute (number)
   
   Example:
   0 = [vehicle, altitude] execVM "eject.sqf"
*/  

private ["_paras","_vehicle","_chuteHeight","_dir", "_paragrp", "_side"];
_vehicle = _this select 0; 
_chuteheight = if ( count _this > 1 ) then { _this select 1 } else { 100 };
//_vehicle allowDamage false;
_paras = if ( count _this > 2 ) then { _this select 2 } else { assignedcargo _vehicle };
_dir = direction _vehicle;
_side = side _vehicle;

{
	_inv = name _x;// Get Unique name for Unit's loadout.
	[_x, [missionNamespace, format["%1%2", "Inventory",_inv]]] call BIS_fnc_saveInventory;// Save Loadout
	removeBackpack _x;
	_x disableCollisionWith _vehicle;// Sometimes units take damage when being ejected.
	_vehicle disableCollisionWith _x;
	//_x allowdamage false;// Trying to prevent damage.
	_x addBackPack "B_parachute";
	unassignvehicle _x;
	moveout _x;
	_x setDir (_dir + 90);// Exit the chopper at right angles.
	sleep 3;
	[_x,_chuteheight] spawn paraLandSafe;
} forEach _paras;

//_vehicle allowDamage true;

_paragrp = createGroup _side;
_paras joinSilent _paragrp;
_paragrp deleteGroupWhenEmpty true;
