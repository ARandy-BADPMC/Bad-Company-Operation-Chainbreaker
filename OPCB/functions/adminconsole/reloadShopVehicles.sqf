if (!isServer || {!isRemoteExecuted}) exitWith {};

private _caller = remoteExecutedOwner;
private _callerIndex = allPlayers findIf {owner _x == _caller};
if (_callerIndex < 0) exitWith {};

#include "..\..\data\developers.sqf"
if !((getPlayerUID (allPlayers select _callerIndex)) in _developers) exitWith {};
if !(missionNamespace getVariable ["Hz_pers_serverInitialised", false]) exitWith {
	"The server is still loading saved vehicles. Please try again shortly." remoteExecCall ["hint", _caller];
};

private _restored = 0;
{
	if (alive _x && {_x isKindOf "LandVehicle"} && {!(_x isKindOf "StaticWeapon")}) then {
		private _slot = _x getVariable ["OPCB_shopSlot", ""];
		private _purchaseSlot = _x getVariable ["OPCB_shopPurchaseSlot", ""];
		if !(_purchaseSlot in ["Tank", "APC", "Vehicle"]) then {_purchaseSlot = _slot;};
		if (_purchaseSlot in ["Tank", "APC", "Vehicle"]) then {
			if (_slot != _purchaseSlot || {_x getVariable ["OPCB_shopSlotReleased", false]}) then {
				_restored = _restored + 1;
			};
			[_x, _purchaseSlot] call CHAB_fnc_shopSlotTrack;
		};
	};
} forEach vehicles;

call CHAB_fnc_shopGroundReconcile;
format ["Ground vehicle list reloaded. Restored: %1. Vehicles: %2/8, APCs: %3/3, tanks: %4/1.", _restored, ShopVehicleCount, MaxAPC, MaxTanks] remoteExecCall ["hint", _caller];
