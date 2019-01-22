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
		class Neutralize2
		{
			file = "functions\missions\Neutralize2.sqf";
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
		class spawn_ins
		{
			file = "functions\spawn_ins.sqf";
		};
		class spawn_rus
		{
			file = "functions\spawn_rus.sqf";
		};
		class spawn_nat
		{
			file = "functions\spawn_nat.sqf";
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
		class fire_artilerry  
		{
			file = "functions\missions\fire_artilerry.sqf";
		};
		class artilerry  
		{
			file = "functions\missions\artilerry.sqf";
		};
	};
	class miscellaneous
	{
		class nearest
		{
			file = "functions\miscellaneous\nearest.sqf";
		}; 
		class lander_action
		{
			file = "functions\miscellaneous\lander_action.sqf";
		};
		class lander
		{
			file = "functions\miscellaneous\lander.sqf";
		};
		class findSpot
		{
			file = "functions\findSpot.sqf";
		};
		class shk_patrol
		{
			file = "functions\shk_patrol.sqf";
		};
		class serverGroups
		{
			file = "functions\miscellaneous\serverGroups.sqf";
		};
	};
	class choppers
	{
		class checkpilot 
		{
			file = "functions\miscellaneous\checkpilot.sqf";
		};
		class checkdriver 
		{
			file = "functions\miscellaneous\checkdriver.sqf";
		};
		class checkjetpilot
		{
			file = "functions\miscellaneous\checkjetpilot.sqf";
		};
		class checkengine
		{
			file = "functions\miscellaneous\checkengine.sqf";
		};
		class checktankengine
		{
			file = "functions\miscellaneous\checktankengine.sqf";
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
		class kick
		{
			file = "functions\adminconsole\kick.sqf";
		};
		class hint
		{
			file = "functions\adminconsole\hint.sqf";
		};
		class restart_server
		{
			file = "functions\adminconsole\restart_server.sqf";
		};
		class ban
		{
			file = "functions\adminconsole\ban.sqf";
		};
		class ban_server
		{
			file = "functions\adminconsole\ban_server.sqf";
		};
		class kick_server
		{
			file = "functions\adminconsole\kick_server.sqf";
		};
		class getgroups
		{
			file = "functions\adminconsole\getgroups.sqf";
		};
		class restart
		{
			file = "functions\adminconsole\restart.sqf";
		};
		class zeus
		{
			file = "functions\adminconsole\zeus.sqf";
		};
		class zeus_server
		{
			file = "functions\adminconsole\zeus_server.sqf";
		};
		class getpilots
		{
			file = "functions\adminconsole\getpilots.sqf";
		};
		class gettankcrew
		{
			file = "functions\adminconsole\gettankcrew.sqf";
		};
		class spectate
		{
			file = "functions\adminconsole\spectate.sqf";
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
	class player_required
	{
		class whitelist
		{
			file = "functions\playerreq\whitelist.sqf";
		};
	};
};
