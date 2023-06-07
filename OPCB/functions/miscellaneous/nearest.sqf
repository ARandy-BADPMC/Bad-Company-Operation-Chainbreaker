params ["_p"];

_d = objNull;
_r = 80000;
{
       _n = _x distance _p;
       if(_n < _r) then
       {
           _d = _x;
           _r = _n;
       };
} forEach playableUnits;
_d

//Return the nearest friendly player as an object
