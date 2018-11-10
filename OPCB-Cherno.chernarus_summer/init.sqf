if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};
enableSaving [false, false];
enableSentences true;
enableTeamswitch false;

Resistance setFriend [EAST, 1]; Resistance setFriend [WEST, 0]; Resistance setFriend [Civilian, 1];

EAST setFriend [Resistance, 1]; EAST setFriend [WEST, 0]; EAST setFriend [Civilian, 1];	

WEST setFriend [EAST, 0]; WEST setFriend [Resistance, 0]; WEST setFriend [Civilian, 1]; 	

Civilian setFriend [EAST, 1]; Civilian setFriend [WEST, 1]; Civilian setFriend [Resistance, 1];

[] execVM "VCOMAI\init.sqf";

//EOS SYSTEM
//[]execVM "eos\OpenMe.sqf";

RHSDecalsOff = true;

//try to safely resolve 'stuck in loading screen bug' of Arma 3... thank you again BIS
	WaitUntil{ !(isNull player) && !isNil "mps_init"};
	_counter = 0;
	WaitUntil { 
		
		sleep 1;
		_counter = _counter + 1;
		
		(Receiving_finish || ((_counter > 20) && (diag_fps > 20)))
	
	};
	
	{if (!Receiving_finish) then {endLoadingScreen};
}else{
	Receiving_finish = true;
	WaitUntil{!isNil "mps_init"};
};
