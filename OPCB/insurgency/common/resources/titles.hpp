class RscTitles {
	//#include "IEDdetect_screens.hpp"

	class Rtags { 
		idd=64431; 
		movingEnable = true; 
		fadein       =  0; 
		fadeout      =  0; 
		duration     =  0.2; 
		name				 = "TAGS_HUD"; 
		controls[]	 = { "camtag", "nametag", "interact"}; 
		onLoad			 = "uiNamespace setVariable ['TAGS_HUD', _this select 0]"; 
		class camtag { 
			type 							= CT_STRUCTURED_TEXT; 
			idc 							= 64434; 
			style 						= 0x00; 
			x 								= safeZoneX; 
			y 								= safeZoneY+safeZoneH/2+0.3; 
			w 								= safeZoneW; 
			h 								= safeZoneH; 
			font 							= "Zeppelin33"; 
			size 							= 0.03; 
			colorText[] 			= { 0, 0.4, 0.8, 0.8}; 
			colorBackground[]	={ 0,0,0,0.0}; 
			text 							= ""; 		
			class Attributes { 
				font 				= "Zeppelin33"; 
				color 			= "#347C17"; 
				align 			= "center"; 
				valign 			= "middle"; 
				shadow 			= "1"; 
				shadowColor = "#000000"; 
				size 				= "1"; 
			}; 	
		};
		class nametag { 
			type 							= CT_STRUCTURED_TEXT; 
			idc 							= 64435; 
			style 						= 0x00; 
			x 								= safeZoneX+ 0.1; 
			y 								= safeZoneY+safeZoneH/2+0.05; 
			w 								= safeZoneW; 
			h 								= safeZoneH; 
			font 							= "Zeppelin33"; 
			size 							= 0.03; 
			colorText[] 			= { 0, 0.4, 0.8, 0.8}; 
			colorBackground[]	={ 0,0,0,0.0}; 
			text 							= ""; 		
			class Attributes { 
				font 				= "Zeppelin33"; 
				color 			= "#2B60DE"; 
				align 			= "center"; 
				valign 			= "middle"; 
				shadow 			= "1"; 
				shadowColor = "#000000"; 
				size 				= "1"; 
			}; 	
		}; 
		class interact { 
			type 							= CT_STRUCTURED_TEXT; 
			idc 							= 64436; 
			style							= 0x00; 			
			x 								= safeZoneX; 
			y 								= safeZoneY+safeZoneH/2+0.2; 
			w 								= safeZoneW; 
			h 								= safeZoneH; 
			font 							= "Zeppelin33"; 
			size 							= 0.03; 
			colorText[] 			= { 1, 1, 0, 0.8}; 
			colorBackground[]	={ 0,0,0,0.0}; 
			text 							= ""; 
			class Attributes { 
				font 				= "Zeppelin33"; 
				color 			= "#2B60DE"; 
				align 			= "center"; 
				valign 			= "middle"; 
				shadow 			= "1"; 
				shadowColor = "#000000"; 
				size 				= "1"; 
			}; 
		}; 
	};
}; 