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
		class jey_counter_control: RscButton
		{
			idc = 1611;
			text = "Counter control";
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.379523 * safezoneH + safezoneY;
			w = 0.104167 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0; [] call CHAB_fnc_counterControl;";
		};
		class jey_execute_code: RscButton
		{
			idc = 1612;
			text = "Execute code";
			x = 0.5625 * safezoneW + safezoneX;
			y = 0.379523 * safezoneH + safezoneY;
			w = 0.104167 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0; [] call CHAB_fnc_executeCode;";
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

class CHAB_counterControl
{
	idd = 9910;
	movingEnabled = false;

	class controls
	{
		class counter_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.549786 * safezoneH;
		};
		class counter_title: RscText
		{
			idc = 1000;
			text = "Counter control";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class counter_close: RscButton
		{
			idc = 1601;
			text = "Close";
			x = 0.666146 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0";
		};
		class counter_back: RscButton
		{
			idc = 1602;
			text = "Back";
			x = 0.601042 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0; [] spawn CHAB_fnc_adminconsole;";
		};
		class counter_reset_shopvehicles: RscButton
		{
			idc = 1611;
			text = "Reset vehicles";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""ShopVehicleCount""] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_reset_crates: RscButton
		{
			idc = 1612;
			text = "Reset crates";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.379523 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""CrateCount""] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_reset_tanks: RscButton
		{
			idc = 1613;
			text = "Reset tanks";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.445973 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""MaxTanks""] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_reset_attackhelis: RscButton
		{
			idc = 1614;
			text = "Reset atk helis";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.512423 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""MaxAttackHelis""] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_reset_transhelis: RscButton
		{
			idc = 1615;
			text = "Reset trans helis";
			x = 0.40625 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""MaxTransHelis""] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_reset_apc: RscButton
		{
			idc = 1616;
			text = "Reset APC";
			x = 0.40625 * safezoneW + safezoneX;
			y = 0.379523 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""MaxAPC""] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_reset_boats: RscButton
		{
			idc = 1617;
			text = "Reset boats";
			x = 0.40625 * safezoneW + safezoneX;
			y = 0.445973 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""MaxBoats""] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_reset_all: RscButton
		{
			idc = 1618;
			text = "Reset all";
			x = 0.40625 * safezoneW + safezoneX;
			y = 0.512423 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[] remoteExec [""CHAB_fnc_resetCounters"", 2];";
		};
		class counter_show_counted: RscButton
		{
			idc = 1619;
			text = "Show counted";
			x = 0.346354 * safezoneW + safezoneX;
			y = 0.58989 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "closeDialog 0; [] call CHAB_fnc_countedVehicles;";
		};
		class counter_counts_background: RscText
		{
			idc = 1001;
			x = 0.536458 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.171875 * safezoneW;
			h = 0.351863 * safezoneH;
			colorBackground[] = {0,0,0,0.35};
		};
		class counter_counts_title: RscText
		{
			idc = 1002;
			text = "Live counts";
			x = 0.549479 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.09375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class counter_counts_info: RscStructuredText
		{
			idc = 1100;
			x = 0.549479 * safezoneW + safezoneX;
			y = 0.368527 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.274893 * safezoneH;
		};
	};
};

class CHAB_countedVehicles
{
	idd = 9911;
	movingEnabled = false;

	class controls
	{
		class counted_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.549786 * safezoneH;
		};
		class counted_title: RscText
		{
			idc = 1000;
			text = "Counted vehicles";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class counted_summary: RscStructuredText
		{
			idc = 1100;
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.291057 * safezoneH + safezoneY;
			w = 0.40625 * safezoneW;
			h = 0.0439829 * safezoneH;
		};
		class counted_list: RscListbox
		{
			idc = 1500;
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.346036 * safezoneH + safezoneY;
			w = 0.40625 * safezoneW;
			h = 0.30788 * safezoneH;
		};
		class counted_mark: RscButton
		{
			idc = 1600;
			text = "Mark location";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.09375 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_countedVehiclesMark;";
		};
		class counted_remove_mark: RscButton
		{
			idc = 1603;
			text = "Remove mark";
			x = 0.385417 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.09375 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "[] call CHAB_fnc_countedVehiclesUnmark;";
		};
		class counted_back: RscButton
		{
			idc = 1601;
			text = "Back";
			x = 0.536458 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0; [] call CHAB_fnc_counterControl;";
		};
		class counted_close: RscButton
		{
			idc = 1602;
			text = "Close";
			x = 0.666146 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0659743 * safezoneH;
			action = "closeDialog 0";
		};
	};
};

class CHAB_executeCode
{
	idd = 9912;
	movingEnabled = false;

	class controls
	{
		class execute_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.458333 * safezoneW;
			h = 0.549786 * safezoneH;
		};
		class execute_title: RscText
		{
			idc = 1000;
			text = "Execute code";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class execute_edit_background: RscText
		{
			idc = 1001;
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.291057 * safezoneH + safezoneY;
			w = 0.270833 * safezoneW;
			h = 0.285889 * safezoneH;
			colorBackground[] = {0,0,0,0.35};
		};
		class execute_code_edit: RscEdit
		{
			idc = 1400;
			x = 0.291667 * safezoneW + safezoneX;
			y = 0.302053 * safezoneH + safezoneY;
			w = 0.260417 * safezoneW;
			h = 0.263898 * safezoneH;
			style = ST_MULTI;
			lineSpacing = 1;
		};
		class execute_presets_title: RscText
		{
			idc = 1002;
			text = "Preset scripts";
			x = 0.5625 * safezoneW + safezoneX;
			y = 0.291057 * safezoneH + safezoneY;
			w = 0.130208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class execute_presets_list: RscListbox
		{
			idc = 1501;
			x = 0.5625 * safezoneW + safezoneX;
			y = 0.324044 * safezoneH + safezoneY;
			w = 0.130208 * safezoneW;
			h = 0.252903 * safezoneH;
			onLBSelChanged = "_this call CHAB_fnc_executeCodePresetSelect;";
		};
		class execute_info: RscStructuredText
		{
			idc = 1100;
			text = "<t size='0.95'>Paste SQF code here and choose where to run it. Selecting a preset auto-fills the editor.</t>";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.58789 * safezoneH + safezoneY;
			w = 0.40625 * safezoneW;
			h = 0.0549786 * safezoneH;
		};
		class execute_local: RscButton
		{
			idc = 1600;
			text = "Local";
			x = 0.286458 * safezoneW + safezoneX;
			y = 0.653865 * safezoneH + safezoneY;
			w = 0.0729167 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""local""] call CHAB_fnc_executeCodeRun;";
		};
		class execute_server: RscButton
		{
			idc = 1601;
			text = "Server";
			x = 0.364583 * safezoneW + safezoneX;
			y = 0.653865 * safezoneH + safezoneY;
			w = 0.0729167 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""server""] call CHAB_fnc_executeCodeRun;";
		};
		class execute_global: RscButton
		{
			idc = 1602;
			text = "Global";
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.653865 * safezoneH + safezoneY;
			w = 0.0729167 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""global""] call CHAB_fnc_executeCodeRun;";
		};
		class execute_global_jip: RscButton
		{
			idc = 1603;
			text = "Global + JIP";
			x = 0.520833 * safezoneW + safezoneX;
			y = 0.653865 * safezoneH + safezoneY;
			w = 0.09375 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "[""globalJip""] call CHAB_fnc_executeCodeRun;";
		};
		class execute_back: RscButton
		{
			idc = 1604;
			text = "Back";
			x = 0.619792 * safezoneW + safezoneX;
			y = 0.653865 * safezoneH + safezoneY;
			w = 0.0729167 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "closeDialog 0; [] spawn CHAB_fnc_adminconsole;";
		};
		class execute_close: RscButton
		{
			idc = 1605;
			text = "Close";
			x = 0.619792 * safezoneW + safezoneX;
			y = 0.719839 * safezoneH + safezoneY;
			w = 0.0729167 * safezoneW;
			h = 0.0549786 * safezoneH;
			action = "closeDialog 0";
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
				x = -0.5 * GUI_GRID_W + GUI_GRID_X;
				y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
				w = 44.5 * GUI_GRID_W;
				h = 31 * GUI_GRID_H;
			};
			class heli_list: RscListBox
			{
				idc = 1500;
				onLBSelChanged = "[] call CHAB_fnc_heli_loadouts;";

				x = 0.5 * GUI_GRID_W + GUI_GRID_X;
				y = 1 * GUI_GRID_H + GUI_GRID_Y;
				w = 12.2636 * GUI_GRID_W;
				h = 24.6904 * GUI_GRID_H;
			};
			class loadout_list: RscListBox
			{
				idc = 1561;

				x = 16 * GUI_GRID_W + GUI_GRID_X;
				y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
				w = 12.6005 * GUI_GRID_W;
				h = 9.69623 * GUI_GRID_H;
			};
			class heli_exit: RscButton
			{
				idc = 1600;
				action = "closeDialog 0";

				text = "Exit"; //--- ToDo: Localize;
				x = 37 * GUI_GRID_W + GUI_GRID_X;
				y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
				w = 4 * GUI_GRID_W;
				h = 2.49903 * GUI_GRID_H;
			};
			class heli_pylon_text: RscText
			{
				idc = 1000;

				text = "Vehicle loadout list : "; //--- ToDo: Localize;
				x = 18.5 * GUI_GRID_W + GUI_GRID_X;
				y = 0 * GUI_GRID_H + GUI_GRID_Y;
				w = 8 * GUI_GRID_W;
				h = 1.49941 * GUI_GRID_H;
			};
			class heli_spawn: RscButton
			{
				idc = 1602;
				action = "[] call CHAB_fnc_spawn_heli_vehicle; closeDialog 0;";

				text = "Buy"; //--- ToDo: Localize;
				x = 35 * GUI_GRID_W + GUI_GRID_X;
				y = 5 * GUI_GRID_H + GUI_GRID_Y;
				w = 4 * GUI_GRID_W;
				h = 2.69895 * GUI_GRID_H;
			};
			class heli_picture: RscPicture
			{
				idc = 1618;

				text = "#(argb,8,8,3)color(1,1,1,1)";
				x = 14 * GUI_GRID_W + GUI_GRID_X;
				y = 12 * GUI_GRID_H + GUI_GRID_Y;
				w = 20 * GUI_GRID_W;
				h = 11 * GUI_GRID_H;
			};
			class money_display: RscStructuredText
			{
				idc = 1001;

				x = 14 * GUI_GRID_W + GUI_GRID_X;
				y = 24 * GUI_GRID_H + GUI_GRID_Y;
				w = 30 * GUI_GRID_W;
				h = 3.5 * GUI_GRID_H;
				colorText[] = {0.3,1,1,1};
			};
			
	}; 
	
};

class jey_dronespawner 
{
	idd = 9909;
	movingEnabled = false;

	class controls 
	{
		
		class drone_background: RscPicture
		{
			idc = 1200;

			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = -0.5 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 44.5 * GUI_GRID_W;
			h = 31 * GUI_GRID_H;
		};
		class drone_list: RscListBox
		{
			idc = 1500;
			onLBSelChanged = "";

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.2636 * GUI_GRID_W;
			h = 24.6904 * GUI_GRID_H;
		};
		class drone_exit: RscButton
		{
			idc = 1600;
			action = "closeDialog 0";

			text = "Exit"; //--- ToDo: Localize;
			x = 37 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.49903 * GUI_GRID_H;
		};
		class drone_spawn: RscButton
		{
			idc = 1602;
			 action = "[] call CHAB_fnc_spawn_drone_vehicle;";

			text = "Buy"; //--- ToDo: Localize;
			x = 35 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.69895 * GUI_GRID_H;
		};
		class drone_picture: RscPicture
		{
			idc = 1618;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
		};
		class money_display: RscStructuredText
		{
			idc = 1001;

			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
			colorText[] = {0.3,1,1,1};
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
		class tank_list: RscListBox
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
			action = "closeDialog 0";

			text = "Exit"; //--- ToDo: Localize;
			x = 35.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.95 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.49903 * GUI_GRID_H;
		};
		class heli_spawn: RscButton
		{
			idc = 1602;
			action = "[] call CHAB_fnc_spawn_tank_vehicle;";

			text = "Buy"; //--- ToDo: Localize;
			x = 31 * GUI_GRID_W + GUI_GRID_X;
			y = 6.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.69895 * GUI_GRID_H;
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
		class money_display: RscStructuredText
		{
			idc = 1001;
			colorText[] = {0.3,1,1,1};
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};

	}; 
};

class jey_boatspawner 
{
	idd = 74810;
	movingEnabled = false;

	class controls 
	{
		class boat_background: RscPicture
		{
			idc = 1200;

			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = -11.5 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 58.5 * GUI_GRID_W;
			h = 26 * GUI_GRID_H;
		};
		class boat_list: RscListBox
		{
			idc = 1500;

			x = -9.88 * GUI_GRID_W + GUI_GRID_X;
			y = 0.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.6263 * GUI_GRID_W;
			h = 24.6904 * GUI_GRID_H;
		};
		class boat_exit: RscButton
		{
			idc = 1600;
			action = "closeDialog 0";

			text = "Exit"; //--- ToDo: Localize;
			x = 35.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.95 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.49903 * GUI_GRID_H;
		};
		class boat_spawn: RscButton
		{
			idc = 1602;
			action = "[] call CHAB_fnc_spawn_boat_vehicle; closedialog 0;";

			text = "Buy"; //--- ToDo: Localize;
			x = 31 * GUI_GRID_W + GUI_GRID_X;
			y = 6.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.69895 * GUI_GRID_H;
		};
		class boat_image: RscPicture
		{
			idc = 1608;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 16.5 * GUI_GRID_H;
		};
		class money_display: RscStructuredText
		{
			idc = 1001;
			colorText[] = {0.3,1,1,1};
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
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

class crateSpawner {
	
	idd = 74815;
	movingEnabled = false;
	
	class controls {
		
		class tank_background: RscPicture
		{
			idc = 1200;

			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = -11.5 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 58.5 * GUI_GRID_W;
			h = 26 * GUI_GRID_H;
		};
		class tank_list: RscListBox
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
			action = "closeDialog 0";

			text = "Exit"; //--- ToDo: Localize;
			x = 35.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.95 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.49903 * GUI_GRID_H;
		};
		class heli_spawn: RscButton
		{
			idc = 1602;
			 action = "[] call OPCB_crateSpawner_fnc_spawnCrate;";

			text = "GIMME !"; //--- ToDo: Localize;
			x = 31 * GUI_GRID_W + GUI_GRID_X;
			y = 6.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.69895 * GUI_GRID_H;
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
		class info_display: RscStructuredText
		{
			idc = 1001;
			colorText[] = {0.3,1,1,1};
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};

	}; 
	
};

class bombDefusalPanel {
	idd = 74816;
	movingEnabled = false;

	class controls {
		class RscPicture_1800: RscPicture
		{
			text = "#(argb,8,8,3)color(0,0,0,1)";
			idc = 1800;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.350625 * safezoneW;
			h = 0.462 * safezoneH;
		};
		class digitText1: RscText
		{
			idc = 1000;
			text = ""; //--- ToDo: Localize;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.09 * safezoneH;
			sizeEx = 5 * GUI_GRID_H;
			colorBackground[] = {0.376,0.376,0.376,1};
			colorText[] = {0.216,0.863,0.239,1};
			colorShadow[] = {0,0,0,0};
			style = ST_CENTER + ST_MULTI;
		};
		class digitText2: RscText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.09 * safezoneH;
			sizeEx = 5 * GUI_GRID_H;
			colorBackground[] = {0.376,0.376,0.376,1};
			colorText[] = {0.157,0.741,0.176,1};
			colorShadow[] = {0,0,0,0};
			style = ST_CENTER + ST_MULTI;
		};
		class digitText3: RscText
		{
			idc = 1002;
			text = ""; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.09 * safezoneH;
			sizeEx = 5 * GUI_GRID_H;
			colorBackground[] = {0.376,0.376,0.376,1};
			colorText[] = {0.157,0.741,0.176,1};
			colorShadow[] = {0,0,0,0};
			style = ST_CENTER + ST_MULTI;
		};
		class digitText4: RscText
		{
			idc = 1003;
			text = ""; //--- ToDo: Localize;
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.09 * safezoneH;
			sizeEx = 5 * GUI_GRID_H;
			colorBackground[] = {0.376,0.376,0.376,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0.157,0.741,0.176,1};
			style = ST_CENTER + ST_MULTI;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "1"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[1] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "2"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[2] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "3"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[3] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "4"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[4] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			text = "5"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[5] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			text = "6"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[6] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1606: RscButton
		{
			idc = 1606;
			text = "7"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[7] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1607: RscButton
		{
			idc = 1607;
			text = "8"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[8] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1608: RscButton
		{
			idc = 1608;
			text = "9"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[9] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class RscButton_1609: RscButton
		{
			idc = 1609;
			text = "0"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[0] call CHAB_fnc_bombDefusalButtonPress;";
		};
		class defuseButton: RscButton
		{
			idc = 1610;
			text = "Defuse"; //--- ToDo: Localize;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 3 * GUI_GRID_H;
			colorShadow[] = {0,0,0,0};
			colorBackground[] = {0.251,0.251,0.251,1};
			action = "[] call CHAB_fnc_bombDefusalDefuse;";
		};
	}
}

class staticspawner 
{
	idd = 74817;
	movingEnabled = false;

	class controls 
	{
		class background: RscPicture
		{
			idc = 1200;

			text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = -11.5 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 58.5 * GUI_GRID_W;
			h = 26 * GUI_GRID_H;
		};
		class list: RscListBox
		{
			idc = 1500;

			x = -9.88 * GUI_GRID_W + GUI_GRID_X;
			y = 0.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.6263 * GUI_GRID_W;
			h = 24.6904 * GUI_GRID_H;
		};
		class exit: RscButton
		{
			idc = 1600;
			action = "closeDialog 0";

			text = "Exit"; //--- ToDo: Localize;
			x = 35.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.95 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.49903 * GUI_GRID_H;
		};
		class spawn_static: RscButton
		{
			idc = 1602;
			 action = "[] call CHAB_fnc_spawn_static_vehicle;";

			text = "Buy"; //--- ToDo: Localize;
			x = 31 * GUI_GRID_W + GUI_GRID_X;
			y = 6.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.69895 * GUI_GRID_H;
		};
		class image: RscPicture
		{
			idc = 1608;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 16.5 * GUI_GRID_H;
		};
		class money: RscStructuredText
		{
			idc = 1001;
			colorText[] = {0.3,1,1,1};
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};

	}; 
};	

class vehicleSpawnerHistory {

	idd = 74818;
	class controls {

		class PlayerTableHeader : RscControlsTable
		{
			idc = 20000;

			x = safeZoneX + ( safeZoneW / 2 ) - GRID_X( pixelGridNoUIScale, 8, ( 15 / 2 ));
			y = safeZoneY + GRID_Y( pixelGridNoUIScale, 8, 10 );
			w = GRID_X( pixelGridNoUIScale, 8, 15 );
			h = GRID_Y( pixelGridNoUIScale, 8, 1 );

			//False header - only ever going to need 7 controls
			firstIDC = ( 20000 + 1 );
			lastIDC = ( 20000 + 8 );

			headerHeight = GRID_Y( pixelGridNoUIScale, 8, 1 );
			rowHeight = GRID_Y( pixelGridNoUIScale, 8, 1 );

			lineSpacing = 0;
			selectedRowAnimLength = 0;
			selectedRowColorFrom[] = {0,0,0,0};
			selectedRowColorTo[] = {0,0,0,0};

			class HeaderTemplate {};
			class HScrollbar : ScrollBar
			{
				height = GRID_Y( pixelGridNoUIScale, 4, 1 );
			};
			class RowTemplate {};
			class VScrollbar : ScrollBar
			{
				width = GRID_X( pixelGridNoUIScale, 4, 1 );
			};
		};

		class PlayerTableData : PlayerTableHeader
		{
			idc = 30000;

			y = safeZoneY + GRID_Y( pixelGridNoUIScale, 8, 10 + 1 );
			//enough for 10 rows to start, can change through script depending on ammount of players data
			h = GRID_Y( pixelGridNoUIScale, 8, 1 * 10 );

			//False header - only ever going to need 7 controls
			firstIDC = ( 30000 + 1 );
			lastIDC = ( 30000 + 10001 ) ; //1 thousand idcs, 1 row has 4 controls so is enough for 2500 players data
		};
	};
};


class fobStore {
	
	idd = 74819;
	movingEnabled = false;
	
	class controls {
		class fob_list: RscListBox
		{
			idc = 2000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 24 * GUI_GRID_H;
		};
		class fob_buy: RscButton
		{
			idc = 2002;
			action = "[] call CHAB_fnc_buyFob;";

			text = "Buy Fob"; //--- ToDo: Localize;
			x = 15.2 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class fob_exit: RscButton
		{
			idc = 2001;
			action = "closeDialog 0";

			text = "Exit"; //--- ToDo: Localize;
			x = 15.2 * GUI_GRID_W + GUI_GRID_X;
			y = 21.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class info_display: RscStructuredText
		{
			idc = 2003;
			colorText[] = {0.3,1,1,1};
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 25 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};

	}; 
	
};

		class flips_uavrental
{
    idd = 9915;
    movingEnable = 0;
    enableSimulation = 1;
    onUnload = "";

    class ControlsBackground
    {
        class BG: RscText
        {
            x = 0.30 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.40 * safezoneW;
            h = 0.42 * safezoneH;
            colorBackground[] = {0,0,0,0.7};
        };
        class Title: RscText
        {
            text = "UAV Rental";
            x = 0.30 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.40 * safezoneW;
            h = 0.04 * safezoneH;
            sizeEx = 0.04;
            colorBackground[] = {0,0,0,0.9};
        };
    };

    class Controls
    {
        
        class Credits: RscStructuredText
        {
            idc = 1001;
            x = 0.62 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.035 * safezoneH;
            size = 0.035;
        };

        
        class List: RscListbox
        {
            idc = 1500;
            x = 0.32 * safezoneW + safezoneX;
            y = 0.30 * safezoneH + safezoneY;
            w = 0.36 * safezoneW;
            h = 0.26 * safezoneH;
            sizeEx = 0.038;
        };

        class RentBtn: RscButton
        {
            idc = 1600;
            text = "Rent";
            x = 0.40 * safezoneW + safezoneX;
            y = 0.58 * safezoneH + safezoneY;
            w = 0.12 * safezoneW;
            h = 0.05 * safezoneH;
            action = "[] execVM 'functions\helispawner\uavRental_doRent.sqf';";
        };

        class CloseBtn: RscButton
        {
            idc = 1601;
            text = "Close";
            x = 0.54 * safezoneW + safezoneX;
            y = 0.58 * safezoneH + safezoneY;
            w = 0.12 * safezoneW;
            h = 0.05 * safezoneH;
            action = "closeDialog 0;";
        };
    };
};

class shopSpawnLocation
{
	idd = 74820;
	movingEnabled = false;
	onUnload = "[] call CHAB_fnc_shopSpawnLocationClosed;";

	class controls
	{
		class Background: RscText
		{
			idc = -1;
			colorBackground[] = {0, 0, 0, 0.88};
			x = 0.34 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.32 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class Title: RscText
		{
			idc = -1;
			text = "Choose vehicle spawn location";
			colorText[] = {1, 1, 1, 1};
			x = 0.36 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.28 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class Locations: RscListBox
		{
			idc = 74821;
			x = 0.36 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.28 * safezoneW;
			h = 0.27 * safezoneH;
		};
		class SpawnHere: RscButton
		{
			idc = 74822;
			text = "Spawn Here";
			action = "[] call CHAB_fnc_shopSpawnLocationConfirm;";
			x = 0.36 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class Cancel: RscButton
		{
			idc = 74823;
			text = "Cancel";
			action = "closeDialog 0;";
			x = 0.51 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.05 * safezoneH;
		};
	};
};
