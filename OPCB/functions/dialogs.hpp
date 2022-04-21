class jey_adminconsole_dialog 
{
	idd = 9999;
	movingEnabled = false;

	class controls 
	{
		class jey_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.549786 * safezoneH;
		};
		class jey_getgroups: RscButton
		{
			idc = 1600;
			text = "Groups"; //--- ToDo: Localize;
			x = 0.282292 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_getgroups";
		};
		class jey_close: RscButton
		{
			idc = 1601;
			text = "Close"; //--- ToDo: Localize;
			x = 0.666146 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0";
		};
		class jey_leave_spectator: RscButton
		{
			idc = 1622;
			text = "Leave Spectator"; //--- ToDo: Localize;
			x = 0.282292 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0632917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "['Terminate'] call BIS_fnc_EGSpectator;closeDialog 0";
		};
		class fix_task: RscButton
		{
			idc = 1632;
			text = "Order task spec."; //--- ToDo: Localize;
			x = 0.536146 * safezoneW + safezoneX; //check x
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0;[] call CHAB_fnc_adminTask;";
		};
		class jey_zeus: RscButton
		{
			idc = 1603;
			text = "Zeus"; //--- ToDo: Localize;
			x = 0.282292 * safezoneW + safezoneX;
			y = 0.42303 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_zeus";
		};
		class jey_kick: RscButton
		{
			idc = 1602;
			text = "Kick"; //--- ToDo: Localize;
			x = 0.4325 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_kick";
		};
		class jey_ban: RscButton
		{
			idc = 1604;
			text = "Ban"; //--- ToDo: Localize;
			x = 0.4325 * safezoneW + safezoneX;
			y = 0.327013 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_ban";
		};
		class jey_kicklist: RscListbox
		{
			idc = 1500;
			x = 0.491667 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.22042 * safezoneW;
			h = 0.175931 * safezoneH;
		};
		class jey_restart: RscButton
		{
			idc = 1605;
			text = "Restart Mission"; //--- ToDo: Localize;
			x = 0.282292 * safezoneW + safezoneX;
			y = 0.510996 * safezoneH + safezoneY;
			w = 0.0622917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "remoteExec ['CHAB_fnc_restart',2]";
		};
		class jey_spectator: RscButton
		{
			idc = 1626;
			text = "Spectate"; //--- ToDo: Localize;
			x = 0.282292 * safezoneW + safezoneX;
			y = 0.598962 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_spectate;closeDialog 0";
		};
		class jey_restart_server: RscButton
		{
			idc = 1625;
			text = "Restart Server"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.510996 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "remoteExec ['CHAB_fnc_restart_server',2]";
		};
		class jey_getpilots: RscButton
		{
			idc = 1606;
			text = "Pilots"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_getpilots";
		};
		class jey_gettankcrew: RscButton
		{
			idc = 1607;
			text = "Tank crew"; //--- ToDo: Localize;
			x = 0.282887 * safezoneW + safezoneX;
			y = 0.336016 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_gettankcrew";
		};
		
		class jey_day: RscButton
		{
			idc = 1609;
			text = "Skip time 12"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.336016 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_skip12";
		};
		class jey_night: RscButton
		{
			idc = 1610;
			text = "Skip time 6"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.42303 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_skip6";
		};
	};
};
class CHAB_adminTask 
{
	idd = 9904;
	movingEnabled = false;

	class controls 
	{
		class adminTask_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.549786 * safezoneH;
		};
		class adminTask_close: RscButton
		{
			idc = 1601;
			text = "Close"; //--- ToDo: Localize;
			x = 0.666146 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0";
		};
		
		class adminTask_spawn: RscButton
		{
			idc = 1602;
			text = "Spawn selected task"; //--- ToDo: Localize;
			x = 0.4325 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_admin_order_task";
		};
		
		class adminTask_list: RscListbox
		{
			idc = 1500;
			x = 0.491667 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.22042 * safezoneW;
			h = 0.175931 * safezoneH;
		};
	};
};

class jey_helispawner 
{
	idd = 9900;
	movingEnabled = false;

	class controls 
	{
		class heli_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.273055 * safezoneW + safezoneX;
			y = 0.229503 * safezoneH + safezoneY;
			w = 0.4538 * safezoneW;
			h = 0.543159 * safezoneH;
		};
		class heli_list: RscListbox
		{
			idc = 1500;
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.229506 * safezoneH + safezoneY;
			w = 0.1405209 * safezoneW;
			h = 0.543189 * safezoneH;
			onLBSelChanged  = "[] call CHAB_fnc_heli_loadouts;";
		};
		class loadout_list: RscListbox
		{
			idc = 1561;
			x = 0.456457 * safezoneW + safezoneX;
			y = 0.29548 * safezoneH + safezoneY;
			w = 0.144381 * safezoneW;
			h = 0.213317 * safezoneH;
		};
		class heli_exit: RscButton
		{
			idc = 1600;
			text = "Exit"; //--- ToDo: Localize;
			x = 0.677604 * safezoneW + safezoneX;
			y = 0.619914 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "closeDialog 0";
		};
		class heli_pylon_text: RscText
		{
			idc = 1000;
			text = "Vehicle loadout list : "; //--- ToDo: Localize;
			x = 0.482812 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class heli_spawn: RscButton
		{
			idc = 1602;
			text = "GIMME !"; //--- ToDo: Localize;
			x = 0.626042 * safezoneW + safezoneX;
			y = 0.361456 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0593768 * safezoneH;
			action = "[] call CHAB_fnc_spawn_heli_vehicle;";
		};
		class heli_picture: RscPicture
		{
			idc = 1618;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
		};
	};
};

class jey_tankspawner 
{
	idd = 9901;
	movingEnabled = false;

	class controls 
	{
		class tank_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = -11.5 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 58.5 * GUI_GRID_W;
			h = 26 * GUI_GRID_H;
		};
		class tank_list: RscListbox
		{
			idc = 1500;
			x = -9.88 * GUI_GRID_W + GUI_GRID_X;
			y = 0.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.6263 * GUI_GRID_W;
			h = 24.6904 * GUI_GRID_H;
		};
		class tank_exit: RscButton
		{
			idc = 1600;
			text = "Exit"; //--- ToDo: Localize;
			x = 0.677604 * safezoneW + safezoneX;
			y = 0.619914 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "closeDialog 0";
		};
		class heli_spawn: RscButton
		{
			idc = 1602;
			text = "GIMME !"; //--- ToDo: Localize;
			x = 0.626042 * safezoneW + safezoneX;
			y = 0.361456 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0593768 * safezoneH;
			action = "[] call CHAB_fnc_spawn_tank_vehicle;";
		};
		class tank_image: RscPicture
		{
			idc = 1608;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 16.5 * GUI_GRID_H;
		};

	}; 
};

class jey_remover
{
	idd = 9902;
	movingEnabled = false;

	class controls 
	{
		class remove_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.549786 * safezoneH;
		};
		class remove_cancel: RscButton
		{
			idc = 1600;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.671875 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "closeDialog 0";
		};
		class remove_delete: RscButton
		{
			idc = 1601;
			text = "Delete selected"; //--- ToDo: Localize;
			x = 0.402604 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[] call CHAB_fnc_deletebutton_heli";
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.280729 * safezoneW;
			h = 0.175931 * safezoneH;
		};
	};
};
class jey_remover_tank
{
	idd = 9903;
	movingEnabled = false;

	class controls 
	{
		class remove_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.549786 * safezoneH;
		};
		class remove_cancel: RscButton
		{
			idc = 1600;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.671875 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "closeDialog 0";
		};
		class remove_delete: RscButton
		{
			idc = 1601;
			text = "Delete selected"; //--- ToDo: Localize;
			x = 0.402604 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[] call CHAB_fnc_deletebutton_tank";
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.280729 * safezoneW;
			h = 0.175931 * safezoneH;
		};
	};
};
class jey_spectator 
{
	idd = 9998;
	movingEnabled = false;
	class controls
	{
		class jey_leave_spectate: RscButton
		{
			idc = 1600;
			text = "Leave"; //--- ToDo: Localize;
			x = 17 * GUI_GRID_W + GUI_GRID_X;
			y = -7 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			action = "['Terminate'] call BIS_fnc_EGSpectator;closeDialog 0";
		};
	};
};
