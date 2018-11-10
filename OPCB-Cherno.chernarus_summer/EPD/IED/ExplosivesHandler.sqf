//Since explosions don't trigger any hit events for these items, we have to detect them a funky way
PROJECTILE_DETECTION = {
	//http://forums.bistudio.com/showthread.php?170903-How-do-you-find-out-what-type-of-explosive-hit-an-object
	//Detects projectiles that go near this object

	if(allowExplosiveToTriggerIEDs) then {
		_range = 35;
		_ied = _this select 0;
		_sectionName = _this select 1;
		_iedName = _this select 2;
		_iedSize = _this select 3;
		
		_fired = [];
		while {alive _ied} do 
		{
			_nearProjectiles = (position _ied) nearObjects ["Default",_range]; //Default = superclass of ammo
			if (count _nearProjectiles >=1) then 
			{
				_ammo = _nearProjectiles select 0;
				if (!(_ammo in _fired)) then
				{
					[_ammo, _ied, _iedSize, typeof _ammo, getpos _ammo, _sectionName, _iedName] spawn EXPLOSIVE_WATCHER;
					_fired = _fired + [_ammo];
				};
				
			};
			sleep 0.1;
			_fired = _fired - [objNull]; //remove dead projectiles
		};
	};
};

//Since explosions don't trigger any hit events for planted explosives and a few others for these items, we have to detect them a funky way
EXPLOSIVE_WATCHER = {
	_isExplosive = false;
	_ammoToWatch = _this select 0;
	_ied = _this select 1;
	_iedSize = _this select 2;
	_class = _this select 3;
	_position = _this select 4;
	_sectionName = _this select 5;
	_iedName = _this select 6;
	_trigger = _this select 7;
	
	{
		if(_class iskindof _x) then {
			_isExplosive = true;
		};
	} foreach explosiveSuperClasses;
	
	{//smoke grenades.. chem lights.. ir strobes.. rocks..
		if(_class iskindof _x) then{
			_isExplosive = false;
		}
	} foreach projectilesToIgnore;
	
	if(_isExplosive) then {
		_updateInterval = .1;
		_radiusSqr = 49;
		
		while{(alive _ammoToWatch) && !(isnull _ied)} do {
			_position = getpos _ammoToWatch;
			sleep _updateInterval;
		};
		
		_origin = getpos _ied;
		if(EPD_IED_debug) then {player sidechat format["distance = %1", (_origin distance _position)]; };
		if((_origin distancesqr _position < _radiusSqr) and !(isnull _ied)) then {
			_chance = 100; //since this handles mostly giant explosions. Bombs, planted satchels...
			if(_class iskindof "Grenade") then { _chance = 35; }; 
			
			_r = random 100;
			if(EPD_IED_debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_class];};
			if(_r < _chance) then {
				if(EPD_IED_debug) then { player sidechat format ["%1 triggered IED",_class]; };
				if(!(isnull _ied)) then {
					_ied removeAllEventHandlers "HitPart";
					call compile format['["%2", "%3" ] call EXPLOSIVESEQUENCE_%1', _iedSize, _sectionName,_iedName ];
				};
			};
		};		
	};
};

//Event that happens when a projectile explosive or bullet hits the IED object
EXPLOSION_EVENT_HANDLER = {

	if(allowExplosiveToTriggerIEDs) then {	
		_hitEvent = _this select 0;
		_ied = _hitEvent select 0;
		_sectionName = _ied getVariable ["_sectionName", ""];
		_iedName = _ied getVariable ["_iedName", ""];
		_iedSize= _ied getVariable ["_iedSize", ""];
		
		//hint format["%1", _hitEvent select 6];
		_projectile =  _hitEvent select 6 select 4;
		
		_isExplosive = false;
		_isExplosiveBullet = false;
		
		{
			if(_projectile iskindof _x) then {
				_isExplosive = true;
			};
		} foreach ehExplosiveSuperClasses;
		
		if(! _isExplosive) then
		{
			_explosiveValue = getNumber(configfile >> "CfgAmmo" >> format["%1", _projectile] >> "explosive");
			if(_explosiveValue > 0) then {
				_isExplosiveBullet = true;
			};
		};
		
		{//smoke grenades.. chem lights.. ir strobes.. rocks..
			if(_projectile iskindof _x) then{
				_isExplosive = false;
				_isExplosiveBullet = false;
			}
		} foreach projectilesToIgnore;
		
		
		//hint format["projectile = %3\nexplosive = %1\nexbullet = %2", _isExplosive, _isExplosiveBullet,_projectile];
		if(_isExplosive || _isExplosiveBullet) then {
			_chance = 100;
				
			if(_projectile iskindof "GrenadeCore") then { _chance = 50; }; //grenade launcher
			
			if(_isExplosiveBullet) then {_chance = 40; };
			_r = 0;//random 100;
			if(EPD_IED_debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_projectile];};
			if(_r < _chance) then {
				//if(!(isnull _ied) and !(isnull _trigger)) then {
					if(EPD_IED_debug) then { player sidechat format ["%1 triggered IED",_projectile]; };
					//call compile format["terminate pd_%2; [_iedPosition, _ied, _iedNumber] call EXPLOSIVESEQUENCE_%1", _iedSize, _iedNumber ];	
					_ied removeAllEventHandlers "HitPart";
					call compile format['["%2", "%3" ] call EXPLOSIVESEQUENCE_%1', _iedSize, _sectionName,_iedName ];
				//};
			};
		};		
	};
};

EXPLOSION_EVENT_HANDLER_ADDER = {	
	_sectionName = _this select 0;
	_iedName = _this select 1;
	
	_arr = [_sectionName, _iedName] call GET_IED_ARRAY;
	_ied = _arr select 0;
	_iedSize = _arr select 3;
	
	_ied setVariable ["_sectionName", _sectionName];
	_ied setVariable ["_iedName", _iedName];
	_ied setVariable ["_iedSize", _iedSize];
	
	_ied addEventHandler ["HitPart", {_this call EXPLOSION_EVENT_HANDLER;}];
	
};

SECONDARY_EVENT_ADDER = {
	_code = _this select 0;
	call compile _code;
};