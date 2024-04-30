fnc_buzzInOut = 
{
	params ["_gate_obj"];
	_gate=_gate_obj select 0;
	["buzzer",0] remoteExec ["playMusic"] ;
	sleep 0.5;
	systemChat str _gate;
	_gate animate ["door_1_rot", 1];
	sleep 2;
	_gate animate ["door_1_rot", 0];
};