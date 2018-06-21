CREATE_IED_SECTION = {
	_sectionName = "";
	_parameters = [];
	if(count _this == 1) then {
		_sectionName = call CREATE_RANDOM_IED_NAME;
		_parameters = _this select 0;
	};
	if(count _this == 2) then {
		_sectionName = _this select 0;
		_parameters = _this select 1;
	};
	
	_locationAndSize = (_parameters select 0) call GET_CENTER_LOCATION_AND_SIZE;
	_sectionDictionary = _sectionName call CREATE_IED_SECTION_DICTIONARY;
	if(_locationAndSize select 1 == 1) then {
		
		[_sectionDictionary, _sectionName, _locationAndSize select 0, _parameters ] call CREATE_SPECIFIC_IED;
	} else {
		if(_locationAndSize select 1 > 1) then {
			[_sectionDictionary, _sectionName, _locationAndSize select 0, _locationAndSize select 1, _parameters ] call CREATE_RANDOM_IEDS;
		};
	};
	
	_sectionName;
};

CREATE_FAKE = {
	_junkPosition = _this select 0;
	_junkType = _this select 1;
	_sectionDictionary = _this select 2;
	_fakesDictionary = [_sectionDictionary, "fake"] call Dictionary_fnc_get;
	
	_junk = _junkType createVehicle _junkPosition;
	_junk setdir(random 360);
	_junk setPos _junkPosition;
	_junk enableSimulation false;
	_junk allowDamage false;
	
	_fakeName = call CREATE_RANDOM_IED_NAME;
	_markerName = "fake"+_fakeName;
	[_fakesDictionary, _fakeName, [_junk, _markerName]] call Dictionary_fnc_set;
	
	if(EPD_IED_debug) then {			
		createmarker [_markerName, _junkPosition];
		_markerName setMarkerTypeLocal "hd_warning";
		_markerName setMarkerColorLocal "ColorBlue";
		_markerName setMarkerTextLocal "fake";
	};
};

CREATE_SPECIFIC_IED = {
	_dictionary = _this select 0;
	_sectionName = _this select 1;
	_origin = _this select 2;
	_parameters = _this select 3;
	_side = _parameters select ((count _parameters)-1);
	
	_sizeAndType = "" call GET_SIZE_AND_TYPE;
	_chance = 100;
	if(count _parameters == 3) then { 
		if(typename( _parameters select 1) == "ARRAY") then {
			_chances =  _parameters select 1;
			_chance = 100-(_chances select 0);
			_sizeAndType = [_chances select 1, _chances select 2, _chances select 3] call GET_SIZE_AND_TYPE;
		} else {
			_chance = _parameters select 1; 
		};
	};
	
	if(random 100 < _chance) then {
		[_origin, _sizeAndType select 0, _sizeAndType select 1, _side, _dictionary, _sectionName] call CREATE_IED;
	} else {
		[_origin, _sizeAndType select 1, _dictionary] call CREATE_FAKE;
	};
};

CREATE_RANDOM_IEDS = {
	_dictionary = _this select 0;
	_sectionName = _this select 1;
	_origin = _this select 2;
	_distance = _this select 3;
	_parameters = _this select 4;
	
	_side = [];
	_iedsToPlace = 0;
	_junkToPlace = 0;
	
	_chances = "";
	
	switch (count _parameters) do
	{
		case 2: {
					_iedsToPlace = ceil (_distance / 100.0);
					_junkToPlace = _iedsToPlace;
					_side = _parameters select 1;
				};
		case 3: {
					_iedsToPlace = _parameters select 1;
					_junkToPlace = _iedsToPlace;
					_side = _parameters select 2;
				};
		case 4: {
		
					if(typename( _parameters select 2) == "ARRAY") then {
						_max = _parameters select 1;
						_fakeChance = _parameters select 2 select 0;
						for "_i" from 0 to _max -1 do{
							if(random 100 < _fakeChance) then {
								_junkToPlace = _junkToPlace + 1;
							} else {
								_iedsToPlace = _iedsToPlace + 1;
							};
						};
						_chances = [_parameters select 2 select 1, _parameters select 2 select 2, _parameters select 2 select 3];
					} else {
						_iedsToPlace = _parameters select 1;
						_junkToPlace = _parameters select 2;
					};
					
					_side = _parameters select 3;
				};
	};
	
	
	_roads = (_origin nearRoads _distance) - iedSafeRoads;
	_roadCount = count _roads;
	if(_roadCount > 0) then {

		for "_i" from 0 to _iedsToPlace -1 do{
			_sizeAndType = _chances call GET_SIZE_AND_TYPE;
			_iedPos = [_roads, _roadCount] call FIND_LOCATION_BY_ROAD;
			[_iedPos, _sizeAndType select 0, _sizeAndType select 1, _side, _dictionary, _sectionName] call CREATE_IED;
		};
		
		for "_i" from 0 to _junkToPlace -1 do{
			_sizeAndType = _chances call GET_SIZE_AND_TYPE;
			_junkPosition = [_roads, _roadCount] call FIND_LOCATION_BY_ROAD;
			[_junkPosition, _sizeAndType select 1, _dictionary] call CREATE_FAKE;
		};
		
	};
};

CREATE_IED = {
	_iedPos = _this select 0;
	_iedSize = _this select 1;
	_iedObject = _this select 2;
	_side = _this select 3;
	_sectionDictionary = _this select 4;
	_sectionName = _this select 5;

	_iedName = call CREATE_RANDOM_IED_NAME;
	_markerName = "ied"+_iedName+_iedSize;
	
	if(typename _side != "ARRAY") then { _side = [_side]; };
	for "_i" from 0 to (count _side) -1 do {
		_side set [_i, toUpper (_side select _i)];
	};
	
	_ied = _iedObject createVehicle _iedPos;
	_ied setDir random 360;
	_ied enableSimulation false;
	_ied allowDamage false;
	
	_scriptHandle = "";
	if(allowExplosiveToTriggerIEDs) then {
		_scriptHandle = [_ied, _sectionName, _iedName, _iedSize] spawn PROJECTILE_DETECTION;
	} else {
		_scriptHandle = 0 spawn {};
	};
	
	_triggerStatusHandle = [_iedPos, _sectionDictionary, _sectionName, _iedName, _iedSize] spawn TRIGGER_STATUS_LOOP;
	
	[_sectionDictionary, _iedName, [_ied, objNull, _side, _iedSize,_markerName, _scriptHandle, _triggerStatusHandle]] call ADD_IED_TO_SECTION;
	
	
	
	if(EPD_IED_debug) then {			
		createmarker [_markerName, _iedPos];
		_markerName setMarkerTypeLocal "hd_warning";
		_markerName setMarkerColorLocal "ColorRed";
		_markerName setMarkerTextLocal _iedSize;
	};
	
	if(iedsAdded) then { //initial ieds were added already and the game is in progress
		publicVariable "iedDictionary";
		[[_sectionName, _iedName],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
		if(allowExplosiveToTriggerIEDs) then {
			[[_sectionName, _iedName],"EXPLOSION_EVENT_HANDLER_ADDER", true, false] spawn BIS_fnc_MP;
		};
	};
};

CREATE_SECONDARY_IED = {
	_location = _this select 0;
	_side = _this select 1;
	_sectionName = _this select 2;
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	

	_theta = random 360;
	_offset = 4 + random 12;
	_iedPos = [(_location select 0) + _offset*cos(_theta), (_location select 1) + _offset*sin(_theta),0];
	_iedObject = iedSecondaryItems select(floor random(iedSecondaryItemsCount));
	
	_iedName = call CREATE_RANDOM_IED_NAME;
	_markerName = "secondary"+_iedName;
	
	if(typename _side != "ARRAY") then { _side = [_side]; };
	for "_i" from 0 to (count _side) -1 do {
		_side set [_i, toUpper (_side select _i)];
	};
	
	_ied = _iedObject createVehicle _iedPos;
	_ied setDir random 360;
	_ied enableSimulation false;
	_ied allowDamage false;
	
	_scriptHandle = "";
	if(allowExplosiveToTriggerIEDs) then {
		_scriptHandle = [_ied, _sectionName, _iedName, "SECONDARY"] spawn PROJECTILE_DETECTION;
	} else {
		_scriptHandle = 0 spawn {};
	};
	
	_triggerStatusHandle = [_iedPos, _sectionDictionary, _sectionName, _iedName, "SECONDARY"] spawn TRIGGER_STATUS_LOOP;
	[_sectionDictionary, _iedName, [_ied, objNull, _side, "SECONDARY",_markerName, _scriptHandle, _triggerStatusHandle]] call ADD_IED_TO_SECTION;
	
	
	if(EPD_IED_debug) then {			
		createmarker [_markerName, _iedPos];
		_markerName setMarkerTypeLocal "hd_warning";
		_markerName setMarkerColorLocal "ColorGreen";
		_markerName setMarkerTextLocal "SECONDARY";
	};
	
	publicVariable "iedDictionary";
	[[_sectionName, _iedName],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
	[[_sectionName, _iedName],"EXPLOSION_EVENT_HANDLER_ADDER", true, false] spawn BIS_fnc_MP;
};
