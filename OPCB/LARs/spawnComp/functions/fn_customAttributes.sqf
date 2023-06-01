//Handle Eden custom attributes

private[ "_property", "_expression", "_split", "_valueType", "_value", "_header" ];
params[ "_obj", "_cfg" ];

{
	_property = getText( _x >> 'property' );
	_expression = getText( _x >> 'expression' );
	if ( _expression find "%s" > -1 ) then {
		_index = _expression find "%s";
		_splitLeft = _expression select [ 0, _index ];
		_splitRight = _expression select [ _index + 2, count _expression ];
		_expression = format[ "%1%2%3", _splitLeft, _property, _splitRight ]; //TODO: does property need passing as STRING? dont think so
	};

	//Get the attributes data type and retrieve the value via the currect command getText getNumber etc
	_valueType = if ( isClass( _x >> 'Value' >> 'data' >> 'type' ) ) then {
		getArray( _x >> 'Value' >> 'data' >> 'type' >> 'type' ) select 0;
	}else{
		getText( _x >> 'Value' >> 'data' >> 'singleType' );
	};

	switch ( _valueType ) do {
		case 'STRING' : {
			_value = getText( _x >> 'Value' >> 'data' >> 'value' );
		};
		case 'SCALAR' : {
			_value = getNumber( _x >> 'Value' >> 'data' >> 'value' );
		};
		case 'BOOL' : {
			_value = [ false, true ] select getNumber( _x >> 'Value' >> 'data' >> 'value' );
		};
		case 'ARRAY' : {
			_value = getArray( _x >> 'Value' >> 'data' >> 'value' );
		};
	};
	_header = "params[ '_this', '_value' ];";
	[ _obj, _value ] call compile format[ "%1%2", _header, _expression ];
}forEach ( "true" configClasses ( _cfg >> 'CustomAttributes' ) );
