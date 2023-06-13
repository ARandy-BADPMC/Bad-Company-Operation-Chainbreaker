class FRED_VehicleRespawn
{
	tag = "FRED";
	class VehicleRespawn {
		file = "VehicleRespawn";
		class vehicleLoadout {};
		class vehicleMonitor {};
		class vehicleRespawn {};
	};
};
class chainbreaker
{
	tag = "CHAB";
	class missions
	{
		class Minefield
		{
			file = "functions\missions\Minefield.sqf";
		};
		class GDrunken
		{
			file = "functions\missions\GDrunken.sqf";
		};
		class El_Chapo
		{
			file = "functions\missions\El_Chapo.sqf";
		};
		class Neutralize
		{
			file = "functions\missions\Neutralize.sqf";
		};
		class Eliminate
		{
			file = "functions\missions\Eliminate.sqf";
		};
		class Technology
		{
			file = "functions\missions\Technology.sqf";
		};
		class Destroy
		{
			file = "functions\missions\Destroy.sqf";
		};
		class Annihilate_and_Destroy
		{
			file = "functions\missions\Annihilate_and_Destroy.sqf";
		};
		class Secure
		{
			file = "functions\missions\Secure.sqf";
		};
		class Capture
		{
			file = "functions\missions\Capture.sqf";
		};
		class Exterminate
		{
			file = "functions\missions\Exterminate.sqf";
		};
		class IDAP
		{
			file = "functions\missions\IDAP.sqf";
		};
		class Resupply
		{
			file = "functions\missions\Resupply.sqf";
		};
		class Retrieve
		{
			file = "functions\missions\Retrieve.sqf";
		};
		class Attack
		{
			file = "functions\missions\Attack.sqf";
		};
		class Clear_out
		{
			file = "functions\missions\Clear_out.sqf";
		};
		
	};
	class mission_related
	{
		class gdrunken_spawn
		{
			file = "functions\missions\gdrunken_spawn.sqf";
		};
		class reinforcement
		{
			file = "functions\missions\reinforcement.sqf";
		};
		class retrieve_create
		{
			file = "functions\retrieve_create.sqf";
		};
		class mission_selector   //from here on, this script is called CHAB_fnc_mission_selector
		{
			file = "comp\select.sqf";
		};
		class endmission
		{
			file = "functions\endmission.sqf";
		};
		class spawn_hmg
		{
			file = "functions\spawn_hmg.sqf";
		};
		class roadblock_rus
		{
			file = "functions\missions\roadblock.sqf";
		};
		class roadblock_ins
		{
			file = "functions\missions\roadblock_ins.sqf";
		};
		class spawn_city_rus
		{
			file = "functions\missions\spawn_city_rus.sqf";
		};
		class enemySpawner
		{
			file = "functions\enemySpawner.sqf";
		};
		class spawn_city_ins 
		{
			file = "functions\missions\spawn_city_ins.sqf";
		};
		class enemycount  
		{
			file = "functions\enemycount.sqf";
		};
		class minefield_spawn  
		{
			file = "functions\missions\minefield_spawn.sqf";
		};
		class idap_fn  
		{
			file = "functions\missions\idap_fn.sqf";
		};
		class fire_artillery  
		{
			file = "functions\missions\fire_artillery.sqf";
		};
		class artillery  
		{
			file = "functions\missions\artillery.sqf";
		};
	};
	class miscellaneous
	{
		class nearest
		{
			file = "functions\miscellaneous\nearest.sqf";
		}; 
		class setVehicleLock
		{
			file = "functions\miscellaneous\setVehicleLock.sqf";
		}; 
		class findSpot
		{
			file = "functions\findSpot.sqf";
		};
		class vehicleDeleteCheck
		{
			file = "functions\vehicleDeleteCheck.sqf";
		};
		class commanderActions
		{
			file = "functions\commanderActions.sqf";
		};
		class shk_patrol
		{
			file = "functions\shk_patrol.sqf";
		};
		class playerScale
		{
			file = "functions\miscellaneous\playerScale.sqf";
		};
		class serverGroups
		{
			file = "functions\miscellaneous\serverGroups.sqf";
		};
	};
	class admin_menu
	{
		class adminconsole
		{
			file = "functions\adminconsole\adminconsole.sqf";
		};
		class adminTask
		{
			file = "functions\adminconsole\adminTask.sqf";
		};
		class admin_order_task
		{
			file = "functions\adminconsole\admin_order_task.sqf";
		};
		class zeus
		{
			file = "functions\adminconsole\zeus.sqf";
		};
		class zeus_server
		{
			file = "functions\adminconsole\zeus_server.sqf";
		};
		class skip12
		{
			file = "functions\adminconsole\skip12.sqf";
		};
		class skip6
		{
			file = "functions\adminconsole\skip6.sqf";
		};
	};
	class tankspawner
	{
		class deletebutton_tank
		{
			file = "functions\tankspawner\deletebutton_tank.sqf";
		};
		class remover_tank
		{
			file = "functions\tankspawner\remover_tank.sqf";
		};
		class spawn_tank
		{
			file = "functions\tankspawner\spawn_tank.sqf";
		};
		class spawn_tank_server
		{
			file = "functions\tankspawner\spawn_tank_server.sqf";
		};
		class spawn_tank_vehicle
		{
			file = "functions\tankspawner\spawn_tank_vehicle.sqf";
		};
		class tank_restriction
		{
			file = "functions\tankspawner\tank_restriction.sqf";
		};
	};
	class helispawner
	{
		class deletebutton_heli
		{
			file = "functions\helispawner\deletebutton_heli.sqf";
		};
		class heli_loadouts
		{
			file = "functions\helispawner\heli_loadouts.sqf";
		};
		class helicopter_restriction
		{
			file = "functions\helispawner\helicopter_restriction.sqf";
		};
		class remover_heli
		{
			file = "functions\helispawner\remover_heli.sqf";
		};
		class spawn_heli
		{
			file = "functions\helispawner\spawn_heli.sqf";
		}; 
		class spawn_heli_vehicle
		{
			file = "functions\helispawner\spawn_heli_vehicle.sqf";
		};
		class spawn_helicopter_server
		{
			file = "functions\helispawner\spawn_helicopter_server.sqf";
		};
	};
};
class badco
{
	tag = "BADCO";
	class miscellaneous
	{
		class classCheck
		{
			file = "functions\BADCO_class_check.sqf";
		};
		class skinApplier
		{
			file = "functions\BADCO_skin_applier.sqf";
		};
	}
}
