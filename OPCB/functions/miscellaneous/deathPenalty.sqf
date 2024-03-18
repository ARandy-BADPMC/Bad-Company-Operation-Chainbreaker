params ["_unit"];

if(count DP_Queue == 0) then {
	[] spawn CHAB_fnc_deathPenaltyQueue;
};

DP_Queue pushBack _unit;	