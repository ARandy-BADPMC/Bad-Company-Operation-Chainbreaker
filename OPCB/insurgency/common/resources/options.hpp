// Settings Dialog
class INSURGENCY_OPTIONS {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['INSURGENCY_OPTIONS', _this select 0]; _this call fillOptionsDialog";
	class controlsBackground {
		class INS_BackGround : RscText {
			idc = -1;
			type = 0;
			style = 48;
			x = 0;
			y = 0;
			w = 0.8;
			h = 0.43;
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;
		};
	};	
	class controls {
		class INS_GraslayerCaption : RscText {
			idc = -1;
			x = 0.12;
			y = 0.063;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			text = "Gras Layer:";
		};
		class INS_GraslayerCombo:RscCombo {
			idc = 1001;
			x = 0.125;
			y = 0.163;
			w = 0.17;
			h = 0.03;
			onLBSelChanged = "[_this] execVM 'common\client\UI\setgrass.sqf'"; 
		};
		class INS_CloseButton: RscShortcutButtonMain {
			idc = -1;
			text = "X"; 
			action = "closeDialog 0";
			default = true;
			x = 0.25;
			y = 0.31;
			h = 0.04;
			w = 0.1;
			sizeEx = 0.029;
			size = 0.029;
			class TextPos {
				left = 0.05;
				top = 0.002;
				right = 0;
				bottom = 0;
			};			
		};
		class INS_MainCaption : RscText {
			x = 0.12;
			y = -0.025;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			text = "Settings";
		};
	};
};