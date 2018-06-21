_player = _this select 0;
_id= _this select 1;
_pcstring = _this select 2;
_pcstr = toArray _pcstring;
_number = (_pcstr select 7)-48;
copyToClipboard str _number;

_pc = pc1;
_dual = 0;
switch (_number) do { 
	case 1 : {  _pc = pc1;}; 
	case 2 : {  _pc = pc2;}; 
	case 3 : {  _pc = pc3;}; 
	case 4 : {  _dual = 1;}; 
	case 5 : {  _pc = pc4;}; 
	case 6 : {  _pc = pc5;}; 
	default {  _pc = pc1;}; 
};
_cams = _player getVariable ["cams",[]];

for "_i" from 0 to count _cams -1 do { 
		_item = _cams select _i;
		_unitID = _item select 0;
		_target = _item select 2;
		if (_unitID == _id) then { 
			_texture = "#(argb,256,256,1)r2t(" + _target + ",1)"; 
			if (_dual == 1) then {
				pc3 setObjectTexture [1, _texture];
			}
			else 
			{
				_pc setObjectTexture [0, _texture]; 
			};
		};
	};