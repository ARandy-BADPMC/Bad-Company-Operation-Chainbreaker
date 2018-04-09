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
	class mission_related
	{
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
			file = "functions\roadblock.sqf";
		};
		class roadblock_ins
		{
			file = "functions\roadblock_ins.sqf";
		};
		class spawn_city_rus
		{
			file = "functions\spawn_city_rus.sqf";
		};
		class spawn_city_ins 
		{
			file = "functions\spawn_city_ins.sqf";
		};
		class enemycount  
		{
			file = "functions\enemycount.sqf";
		};
		class minefield  
		{
			file = "functions\minefield.sqf";
		};
		class idap  
		{
			file = "functions\idap.sqf";
		};
		class fire_artilerry  
		{
			file = "functions\fire_artilerry.sqf";
		};
		class artilerry  
		{
			file = "functions\artilerry.sqf";
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
		class zeus_out
		{
			file = "functions\adminconsole\zeus_out.sqf";
		};
		class zeus_out_server
		{
			file = "functions\adminconsole\zeus_out_server.sqf";
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
		class adminrespawn
		{
			file = "functions\playerreq\adminrespawn.sqf";
		};
	};
};