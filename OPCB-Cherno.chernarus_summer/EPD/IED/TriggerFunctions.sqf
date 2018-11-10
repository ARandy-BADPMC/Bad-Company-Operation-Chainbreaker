TRIGGER_STATUS_LOOP = {
	
	_iedPosition = _this select 0;
	_sectionDictionary = _this select 1;
	_sectionName = _this select 2;
	_iedName = _this select 3;
	_iedSize = _this select 4;
	
	_triggerActive = false;
	while{true} do {
		_nearEntitiesCount = count (_iedPosition nearEntities [["CAManBase","LandVehicle"], 250]);
		
		if(! _triggerActive && {_nearEntitiesCount > 0}) then {
			_triggerActive = true;
			if(EPD_IED_debug) then { hintSilent "Trigger Created" };
			
			_trigger = createTrigger["EmptyDetector", _iedPosition];
			_trigger setTriggerArea[11,11,0,true];
			_trigger setTriggerActivation ["any", "PRESENT", false];
			_trigger setTriggerStatements [
						'this && { ["' + _sectionName + '","' + _iedName +'", thisList] call TRIGGER_CHECK }',
						'["' + _sectionName + '","' + _iedName +'"] call EXPLOSIVESEQUENCE_' + _iedSize + ';',
						""];
			
			[_sectionDictionary, _iedName, _trigger] call ADD_TRIGGER_TO_IED;
		}
		else {
			if(_triggerActive && {_nearEntitiesCount == 0}) then {
				_triggerActive = false;
				if(EPD_IED_debug) then { hintSilent "Trigger deleted"; };
				[_sectionDictionary, _iedName] call REMOVE_TRIGGER_FROM_IED;
			};		
		};
	
	
	
		sleep 5;
	};
};

TRIGGER_CHECK = {
	_sectionName = _this select 0;
	_iedName = _this select 1;
	_thisList = _this select 2;

	_iedArray = [_sectionName, _iedName] call GET_IED_ARRAY; 

	_iedPos = getpos (_iedArray select 0);

	_minDistance = 10000;
	_minHeight = 10000;
	_maxSpeed = 0;
		
	_validItemsInTrigger = 0;
	{
		if((_x iskindof "man") or (_x iskindof "allvehicles")) then {
			if(format["%1", side _x] in(_iedArray select 2)) then {
				_validItemsInTrigger = _validItemsInTrigger + 1;
				_distance = (position _x distance _iedPos);
				if(_distance < _minDistance) then {
					_minDistance = _distance;
				};
				
				if((((velocity _x) distanceSqr [0,0,velocity _x select 2]) > _maxSpeed) and (stance _x != "PRONE")) then
				{
					_maxSpeed = (velocity _x) distanceSqr [0,0,velocity _x select 2]; //ignore the z component, because you get large speed increases steping over stone walls	
				};
				
				if((position _x) select 2 < _minheight) then {
					_minHeight = (position _x) select 2;
				};
			};
		};

	} foreach (_thisList);

	if(EPD_IED_debug && _validItemsInTrigger > 0) then {
		hintSilent format["Trigger\nPeople/Vehicles in trigger = %1\nMax Speed = %2\nMin Height = %3\nDistance = %4", _validItemsInTrigger,_maxSpeed, _minHeight,_minDistance];
	};	

	//fast walk forward without gear averages 44.6
	//fast crouch forward without gear averages 44.6
	//regular walk forward without gear averages 16.02
	//regular crouch forward without gear averages 12.76
	//slow walk forward without gear averages 2.95
	//slow crouch forward without gear averages 1.97
	//crawl forward averages without gear averages 0.30
	if((_maxSpeed > 2.8) and (_minHeight < 3)) then { true; } else {false;}; 
}