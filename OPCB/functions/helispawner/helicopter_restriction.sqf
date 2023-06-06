params ["_vehicle", "_isAttack"];

if(_isAttack == 1) then {
	_vehicle addEventHandler ["GetIn",{
		params ["_vehicle","_seat","_player"];
		_playerid = getPlayerUID _player;

		#include "..\..\data\vehicleDriverUnitTypes.sqf";
		#include "..\..\data\soar.sqf";

		if (_vehicle isKindOf "Plane" && {_seat == "driver"}) then {
			if !(typeof _player in _jetPilotTypes) then {
				moveOut _player;
				_vehicle engineOn false;
			};
		} else {
			if(_seat == "driver") then {
				if !(typeof _player in _helicopterPilotTypes && {_playerid in _SOAR}) then {
					moveOut _player;
					_vehicle engineOn false;
				};
			};
		};

	}];
}
else {
	if (typeof _vehicle != "B_UAV_02_dynamicLoadout_f") then {
		_vehicle addEventHandler ["GetIn",{
			#include "..\..\data\vehicleDriverUnitTypes.sqf";
			params ["_vehicle", "_seat", "_player"];

			if(_seat == "driver") then {
				if !(typeof _player in _helicopterPilotTypes) then
				{
					moveOut _player;
				};
			};
		}];
		_vehicle addEventHandler ["Engine",{
			#include "..\..\data\vehicleDriverUnitTypes.sqf";
			params ["_vehicle"];
			_pilot = driver _vehicle;

			if (! ((typeOf _pilot) in _helicopterPilotTypes)  || {isNull _pilot}) then {
				_vehicle engineOn false; 
			};
		}];
	};
};
