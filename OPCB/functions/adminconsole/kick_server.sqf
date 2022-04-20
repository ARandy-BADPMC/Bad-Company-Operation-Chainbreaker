
 	_id = _this select 0;
 	_array = _id splitString "'";
 	_newid = _array select 0;
 	_array2 = _newid splitString " ";
 	_newid = _array2 select 0;

 	_command = format ["#exec kick %1",str _newid];
	" " serverCommand _command;
