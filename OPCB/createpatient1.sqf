{if ((typeOf _x == 'b_g_survivor_F') && (!isPlayer _x)) then {deleteVehicle _x}} forEach allUnits;
[MedicalData1,3] call BIS_fnc_dataTerminalAnimate;
sleep 5;
_group2=createGroup west;
'b_g_survivor_F' createUnit [getmarkerPos 'PatientSpawn2', _group2,'pat=this; dostop pat'];
[pat, selectRandom[2.5], "leg_r", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat, selectRandom[2.5], "leg_l", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat, selectRandom[0.5], "body", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat, selectRandom[0.5], "head", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat, selectRandom[2.5], "hand_r", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat, selectRandom[2.5], "hand_l", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[MedicalData,0] call BIS_fnc_dataTerminalAnimate;
hint 'Your Critical patient is ready and needs you!';


