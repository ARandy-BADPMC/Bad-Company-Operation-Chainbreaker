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
			action = "[] call CHAB_fnc_spawn_tank_vehicle; closedialog 0;";

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
			action = " [] remoteExec ['OPCB_crateSpawner_fnc_spawnCrate',2]; closeDialog 0;";

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
	