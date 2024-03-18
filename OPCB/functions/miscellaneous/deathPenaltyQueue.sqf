private _sleepCounter = (count DP_Queue) + 1;
private _creditCounter = 0;
while {_sleepCounter > 0} do {
	if(count DP_Queue > 0) then {
		_sleepCounter = (count DP_Queue) + 1;
		_creditCounter = _creditCounter + 5;
		DP_Queue deleteAt 0;
	};
	_sleepCounter = _sleepCounter - 1;
	sleep 1;
};

OPCB_econ_credits = OPCB_econ_credits - _creditCounter;

publicVariable "OPCB_econ_credits";