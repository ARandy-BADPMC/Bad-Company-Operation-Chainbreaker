private _sleepCounter = 5;
private _creditCounter = 0;
while {_sleepCounter > 0} do {
	if(count DP_Queue > 0) then {
		_sleepCounter = 5;
		_creditCounter = _creditCounter + 3;
		DP_Queue deleteAt 0;
	};
	_sleepCounter = _sleepCounter - 1;
	sleep 1;
};

OPCB_econ_credits = OPCB_econ_credits - _creditCounter;
publicVariable "OPCB_econ_credits";
