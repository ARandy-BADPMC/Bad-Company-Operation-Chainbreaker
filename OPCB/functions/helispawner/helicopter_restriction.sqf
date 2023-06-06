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

		_vehicle addEventHandler ["SeatSwitched", {
			params ["_vehicle", "_unit1", "_unit2"];

			#include "..\..\data\vehicleDriverUnitTypes.sqf";

			{
				_role = assignedVehicleRole _x;
				
				if(_role isEqualTo ["driver"]) then {
					if !(typeOf _x in _helicopterPilotTypes) then {
						moveOut _x; 
					};
				};
			} forEach [_unit1, _unit2];
		}];
	};
};
