params ["_compReference", "_replaceWithVehicle"];

private _pots = ([ _compReference ] call LARs_fnc_getCompObjects) select { typeOf _x == "Land_FlowerPot_01_F"};

if(count _pots == 0) exitWith {
    objNull;
};

{
    _x enableSimulation false;
} forEach _pots;

private _selectedPotPos = getPos (selectRandom _pots);
_vehicle = _selectedPotPos;

if(!isNil "_replaceWithVehicle") then {
    _vehicle = _replaceWithVehicle createVehicle _selectedPotPos;
};

{
    deleteVehicle _x;
} forEach _pots;

_vehicle