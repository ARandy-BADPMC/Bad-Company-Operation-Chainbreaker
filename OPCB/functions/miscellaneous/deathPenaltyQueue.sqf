private _sleepCounter = 5;

while {_sleepCounter > 0} do {
	if(count DP_Queue > 0) then {
		_sleepCounter = 5;
		OPCB_econ_credits = OPCB_econ_credits - 3;
		publicVariable "OPCB_econ_credits";
		DP_Queue deleteAt 0;
	};
	_sleepCounter = _sleepCounter - 1;
	sleep 1;
};
