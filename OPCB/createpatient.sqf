{if ((typeOf _x == 'b_survivor_F') && (!isPlayer _x)) then {deleteVehicle _x}} forEach allUnits;
[MedicalData,3] call BIS_fnc_dataTerminalAnimate;
sleep 5;
_group1=createGroup west;
'b_survivor_F' createUnit [getmarkerPos 'PatientSpawn', _group1,'pat1=this; dostop pat1'];
[pat1, selectRandom[0.3,0.5,0.7,0.9], "leg_r", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "leg_l", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5], "body", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5], "head", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "hand_r", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "hand_l", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[MedicalData,0] call BIS_fnc_dataTerminalAnimate;
hint 'Your patient is ready';


//Flipflops- The first selctrandom chooses a randomish damage from a small one to a large one, the second selectrandom chooses the type of damage. Please do not touch any of the variables without talking with me or testing it yourself as it may result in the AI dying on spawn