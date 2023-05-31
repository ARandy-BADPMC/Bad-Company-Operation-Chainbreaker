//Original by Xeno
params ["_vehicle","_caller", "_id" ]

if (_caller == driver _vehicle) then {
	_vehicle removeAction _id;
	Vehicle_Attached = true;	
};