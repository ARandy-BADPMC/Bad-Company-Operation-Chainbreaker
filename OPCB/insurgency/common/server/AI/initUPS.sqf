KRON_UPS_Debug = DEBUG;

// find a random position within a radius
KRON_randomPos = { 
	private["_cx","_cy","_rx","_ry","_cd","_sd","_ad","_tx","_ty","_xout","_yout"]; 
	_cx=_this select 0; 
	_cy=_this select 1; 
	_rx=_this select 2; 
	_ry=_this select 3; 
	_cd=_this select 4; 
	_sd=_this select 5; 
	_ad=_this select 6; 
	_tx=random (_rx*2)-_rx; 
	_ty=random (_ry*2)-_ry; 
	_xout=if (_ad!=0) then { _cx+ (_cd*_tx - _sd*_ty)} else { _cx+_tx};
	_yout=if (_ad!=0) then { _cy+ (_sd*_tx + _cd*_ty)} else { _cy+_ty}; 
	[_xout,_yout,0]
}; 
// find any building (and its possible building positions) near a position
KRON_PosInfo = { private["_pos","_lst","_bld","_bldpos"]; _pos=_this select 0; _lst= nearestObjects [_pos,["House","vbs2_house"],20]; if (count _lst==0) then { _bld=0; _bldpos=0} else { _bld=_lst select 0; _bldpos=[_bld] call KRON_BldPos}; [_bld,_bldpos]}; 
/// find the highest building position	
KRON_BldPos = { private ["_bld","_bi","_bldpos","_maxZ","_bp","_bz","_higher"]; _bld=_this select 0; _maxZ=0; _bi=0; _bldpos=0; while { _bi>=0} do { _bp = _bld BuildingPos _bi; if ((_bp select 0)==0) then { _bi=-99} else { _bz=_bp select 2; _higher = ((_bz>_maxZ) || ((abs(_bz-_maxZ)<.5) && (random 1>.5))); if ((_bz>4) && _higher) then { _maxZ=_bz; _bldpos=_bi}}; _bi=_bi+1}; _bldpos}; 
KRON_OnRoad = { private["_pos","_car","_tries","_lst"]; _pos=_this select 0; _car=_this select 1; _tries=_this select 2; _lst=_pos nearRoads 4; if ((count _lst!=0) && (_car || !(surfaceIsWater _pos))) then { _tries=99}; (_tries+1)}; 
KRON_getDirPos = { private["_a","_b","_from","_to","_return"]; _from = _this select 0; _to = _this select 1; _return = 0; _a = ((_to select 0) - (_from select 0)); _b = ((_to select 1) - (_from select 1)); if (_a != 0 || _b != 0) then { _return = _a atan2 _b}; if ( _return < 0 ) then { _return = _return + 360}; _return}; 
KRON_distancePosSqr = { (((_this select 0) select 0)-((_this select 1) select 0))^2 + (((_this select 0) select 1)-((_this select 1) select 1))^2}; 
KRON_relPos = { private["_p","_d","_a","_x","_y","_xout","_yout"]; _p=_this select 0; _x=_p select 0; _y=_p select 1; _d=_this select 1; _a=_this select 2; _xout=_x + sin(_a)*_d; _yout=_y + cos(_a)*_d; [_xout,_yout,0]}; 
KRON_rotpoint = { private["_cp","_a","_tx","_ty","_cd","_sd","_cx","_cy","_xout","_yout"]; _cp=_this select 0; _cx=_cp select 0; _cy=_cp select 1; _a=_this select 1; _cd=cos(_a*-1); _sd=sin(_a*-1); _tx=_this select 2; _ty=_this select 3; _xout=if (_a!=0) then { _cx+ (_cd*_tx - _sd*_ty)} else { _cx+_tx}; _yout=if (_a!=0) then { _cy+ (_sd*_tx + _cd*_ty)} else { _cy+_ty}; [_xout,_yout,0]}; 
KRON_stayInside = { 
		private["_np","_nx","_ny","_cp","_cx","_cy","_rx","_ry","_d","_tp","_tx","_ty","_fx","_fy"]; 
		_np=_this select 0; 	_nx=_np select 0; 	_ny=_np select 1; 
		_cp=_this select 1; 	_cx=_cp select 0; 	_cy=_cp select 1; 
		_rx=_this select 2; 	_ry=_this select 3; 	_d=_this select 4; 
		_tp = [_cp,_d,(_nx-_cx),(_ny-_cy)] call KRON_rotpoint; 
		_tx = _tp select 0; _fx=_tx; 
		_ty = _tp select 1; _fy=_ty; 
		if (_tx<(_cx-_rx)) then { _fx=_cx-_rx}; 
		if (_tx>(_cx+_rx)) then { _fx=_cx+_rx}; 
		if (_ty<(_cy-_ry)) then { _fy=_cy-_ry}; 
		if (_ty>(_cy+_ry)) then { _fy=_cy+_ry}; 
		if ((_fx!=_tx) || (_fy!=_ty)) then { _np = [_cp,_d*-1,(_fx-_cx),(_fy-_cy)] call KRON_rotpoint}; 
		_np; 
	}; 

KRON_getArg = { 
	private["_cmd","_arg","_list","_a","_v"]; 
	_cmd=_this select 0; 
	_arg=_this select 1; 
	_list=_this select 2; 
	_a=-1; 
	{ 
		_a=_a+1; 
		_v=format["%1",_list select _a]; 
		if (_v==_cmd) then { _arg=(_list select _a+1)}; 
	} foreach _list; 
	_arg
}; 

KRON_deleteDead = 
{ 
	private["_u","_s"]; 
	_u=_this select 0; 
	_s= _this select 1; 
	_u removeAllEventHandlers "killed"; 
	sleep _s; 
	hideBody _u; 
	sleep 5; 
	deletevehicle _u; 
}; 
	
KRON_AllWest=[]; 
KRON_AllEast=[]; 
KRON_AllRes=[]; 
KRON_KnownEnemy=[objNull,objNull]; 
	
{ 
	_s = side _x; 
	switch (_s) do { 
		case west: 
			{ KRON_AllWest=KRON_AllWest+[_x]; }; 
		case east: 
			{ KRON_AllEast=KRON_AllEast+[_x]; }; 
		case resistance: 
			{ KRON_AllRes=KRON_AllRes+[_x]; }; 
	}; 
}forEach allUnits; 

if (isNil("KRON_UPS_Debug")) then { KRON_UPS_Debug=false}; 
KRON_HQ="Logic" createUnit [[0,0], grpNull]; 
KRON_UPS_Instances=0; 
KRON_UPS_Total=0; 
KRON_UPS_Exited=0; 