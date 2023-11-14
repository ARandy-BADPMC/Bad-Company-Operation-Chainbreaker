params ["_compReference", "_replaceWithVehicle"];

private _pots = ([ _compReference ] call LARs_fnc_getCompObjects) select { typeOf _x == "Land_FlowerPot_01_F"};

if(count _pots == 0) exitWith {
    objNull;
};

{
    _x enableSimulation false;
} forEach _pots;

private _selectedPot = selectRandom _pots;
private _selectedPotPos = getPos (_selectedPot);
_vehicle = _selectedPotPos;

if(!isNil "_replaceWithVehicle") then {
    _vehicle = createVehicle [_replaceWithVehicle, _selectedPotPos, [], 0, "NONE"];
    _vehicle allowDamage false;
    _vehicle setDirection (direction _selectedPot);
    _vehicle allowDamage true;
};

{
    deleteVehicle _x;
} forEach _pots;

_vehicle