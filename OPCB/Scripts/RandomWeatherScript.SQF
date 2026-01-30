
_activated = true;
_On = true;
_allowFog = false;

//To Add?...   [object, interval, brightness, newspapers] call BIS_fnc_sandstorm;
_overcast 				= [0.25,0.5,0.7,0.8,1];
_fogDensity				= [0,0.25,0.5,0.75,1];
_fogDecay				= [0.125,0.25,0.5,0.75,1];
_fogBase				= [0,1,2,3,4,5,6,8,10,15,20,33];
_windDirection			= 0;
_windForce				= 0;
_windStrength			= 0;

sleep 1;
if(_activated && _On)then{
	_code = compile preprocessFileLineNumbers "Scripts\RandomWindDirection.sqf";
	[] spawn _code;

};
systemChat "Random Weather Running";

while {_activated && _On} do {


	if (_allowFog) then {
			_sunriseSunsetTime 		= date call BIS_fnc_sunriseSunsetTime;
		if ( ((daytime > ((_sunriseSunsetTime select 0)-1)) && (daytime <= ((_sunriseSunsetTime select 0)+2))) or ((daytime > (_sunriseSunsetTime select 1)-1) && (daytime <= ((_sunriseSunsetTime select 1)+2))) ) then {
		//if ( ((daytime > 5) && (daytime <= 8)) or ((daytime > 16) && (daytime <= 22)) ) then {
			_fogChange = (random [600, 1350, 2700]);
		//hint "Fog";
			_fogChange setFog [_fogDensity selectRandomWeighted [0,4,3,2,1],_fogDecay selectRandomWeighted [1,0,0,0,0],_fogBase selectRandomWeighted [1,2,3,4,3,2,1,1,1,1,1,1] ]; //[fogValue, fogDecay, fogBase] 
			sleep (_fogChange / timeMultiplier);
			sleep ((random [600,900,1800]) / timeMultiplier);
			_fogChange = (random [600, 1350, 2700]);
		//hint "Fog Change";
			_fogChange setFog [_fogDensity selectRandomWeighted [0,4,3,2,1],_fogDecay selectRandomWeighted [1,0,0,0,0],_fogBase selectRandomWeighted [1,2,3,4,3,2,1,1,1,1,1,1] ]; //[fogValue, fogDecay, fogBase] 
			sleep (_fogChange / timeMultiplier);
			sleep ((random [600,900,1800]) / timeMultiplier);
			_fogChange = (random [1200, 2700, 5400]);
			_fogChange setFog [0.001,0.001,0];
			sleep (_fogChange / timeMultiplier);
		};
	};
	_overcastChange = random [3000,3300,3600];

	private _currentHour = daytime * 24; // Current server hour
	if (_currentHour > 20 || _currentHour < 6) then ((_overcastChange / timeMultiplier) setOvercast 0.1) else {// Check if its night to disable night overcast
	_overcastChangeTo = (_overcast selectRandomWeighted [1,4,3,2,1]); //Randomise overcast
	(_overcastChange / timeMultiplier) setOvercast _overcastChangeTo;
	(_overcastChange / timeMultiplier) setGusts _overcastChangeTo;
	(_overcastChange / timeMultiplier) setWindStr _overcastChangeTo;
	(_overcastChange / timeMultiplier) setWindForce (1 /( _overcastChangeTo + 0.01));

	};


	//hint "Weather Change";
	sleep (_overcastChange / timeMultiplier);
};
 
systemChat "Random Weather Not Running";