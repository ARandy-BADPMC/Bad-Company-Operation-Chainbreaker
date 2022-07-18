/* Controls Definitions. */

#ifdef VANILLA
	/* Green */
	#define subcolor1 {0.7,1,0.7,1}
	#define subcolor1hex "#b3ffb3"
	#define WFBE_SoundClick "ui\ui_ok"
	#define WFBE_SoundEnter "ui\ui_over"
	#define WFBE_SoundEscape "ui\ui_cc"
#else
	/* Yellow */
	#define subcolor1 {1,1,0.7,1}
	#define subcolor1hex "#ffffb3"
	#define WFBE_SoundClick "\ca\ui\data\sound\onclick"
	#define WFBE_SoundEnter "\ca\ui\data\sound\onover"
	#define WFBE_SoundEscape "\ca\ui\data\sound\onescape"
#endif

class RscPicture {
	type = 0;
	idc = -1;
	style = 48;
	colorText[] = {0.75, 0.75, 0.75, 1};
	colorBackground[] = {0, 0, 0, 0};
	font = "Bitstream";
	sizeEx = 0.025;
	soundClick[] = {WFBE_SoundClick, 0.2, 1};
	soundEnter[] = {WFBE_SoundEnter, 0.2, 1};
	soundEscape[] = {WFBE_SoundEscape, 0.2, 1};
	soundPush[] = {"", 0.2, 1};
	w = 0.275;
	h = 0.04;
	text = "";
};
class RscShortcutButton {
	type = 16;
	idc = -1;
	style = 0;
	default = 0;
	w = 0.183825;
	h = 0.104575;
	color[] = {0.543, 0.5742, 0.4102, 1.0};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.4};
	colorDisabled[] = {1, 1, 1, 0.25};
	periodFocus = 1.2;
	periodOver = 0.8;
	
	class HitZone {
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	
	class ShortcutPos {
		left = 0.004;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos {
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	textureNoShortcut = "";
	period = 0.4;
	font = "Zeppelin32";
	size = 0.03521;
	sizeEx = 0.03521;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	action = "";
	
	class Attributes {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	
	class AttributesImage {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
	};
};
class RscIGUIShortcutButton : RscShortcutButton {
	w = 0.183825;
	h = 0.0522876;
	style = 2;
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 0.85};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.85};
	colorDisabled[] = {1, 1, 1, 0.4};
	
	class HitZone {
		left = 0.002;
		top = 0.003;
		right = 0.002;
		bottom = 0.016;
	};
	
	class ShortcutPos {
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos {
		left = 0.02;
		top = 0.0;
		right = 0.002;
		bottom = 0.016;
	};
	animTextureNormal = "\ca\ui\data\igui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\igui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\igui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\igui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\igui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\igui_button_normal_ca.paa";
	
	class Attributes {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
	};
};
class RscShortcutButtonMain: RscShortcutButton {
	w = 0.313726;
	h = 0.104575;
	color[] = {0.543, 0.5742, 0.4102, 1.0};
	colorDisabled[] = {1, 1, 1, 0.25};
	
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	
	class ShortcutPos {
		left = 0.0204;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos {
		left = 0.08;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	animTextureNormal = "\ca\ui\data\ui_button_main_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_main_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_main_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_main_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_main_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_main_normal_ca.paa";
	period = 0.5;
	font = "Zeppelin32";
	size = 0.03921;
	sizeEx = 0.03921;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	action = "";
	
	class Attributes {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	
	class AttributesImage {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "false";
	};
};
class RscListBox {
	idc = -1;
	type = 5;
	style = 0 + 0x10;
	font = "Zeppelin32";
	sizeEx = 0.04221;
	color[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 0.75};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.6, 0.8392, 0.4706, 1.0};
	colorSelectBackground2[] = {0.6, 0.8392, 0.4706, 1.0};
	columns[] = {0.1, 0.7, 0.1, 0.1};
	period = 0;
	colorBackground[] = {0, 0, 0, 1};
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	soundSelect[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\igui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\igui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\igui_arrow_top_ca.paa";
		border = "\ca\ui\data\igui_border_scroll_ca.paa";
	};
};
class RscListBoxA : RscListBox {
	type = 102;
	lineSpacing = 1;
	sizeEx = 0.029;
	rowHeight = 0.03;
	style = 16;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
};
class RscText {
	idc = -1;
	type = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 256;
	font = "Zeppelin32";
	text = "";
	SizeEx = 0.03921;
	colorText[] = {0.543, 0.5742, 0.4102, 1.0};
	colorBackground[] = {0, 0, 0, 0};
};
class RscStructuredText {
	type = 13;
	idc = -1;
	style = 0;
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = 0.03421;
	colorText[] = subcolor1;
	
	class Attributes {
		font = "Zeppelin32";
		color = subcolor1hex;
		align = "left";
		shadow = true;
	};
};
class RscXSliderH {
	idc = -1;
	type = 43;
	style = 0x400  + 0x10;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	color[] = {1, 1, 1, 0.4};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.2};
	arrowEmpty = "\ca\ui\data\ui_arrow_left_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_left_active_ca.paa";
	border = "\ca\ui\data\ui_border_frame_ca.paa";
	thumb = "\ca\ui\data\ui_slider_bar_ca.paa";
};
class RscCombo {
	idc = -1;
	type = 4;
	style = 1;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.035;
	colorSelect[] = {0.023529, 0, 0.0313725, 1};
	colorText[] = {0.023529, 0, 0.0313725, 1};
	colorBackground[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.543, 0.5742, 0.4102, 1.0};
	colorScrollbar[] = {0.023529, 0, 0.0313725, 1};
	arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {0, 0, 0, 0.6};
	colorActive[] = {0, 0, 0, 1};
	colorDisabled[] = {0, 0, 0, 0.3};
	font = "Zeppelin32";
	sizeEx = 0.031;
	soundSelect[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundExpand[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundCollapse[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	maxHistoryDelay = 1.0;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};
class RscClickableText {
	idc = -1;
	type = 11;
	style = 48 + 0x800;
	color[] = {0.75,0.75,0.75,1};
	colorActive[] = {1,1,1,1};
	colorBackground[] = {0.6, 0.8392, 0.4706, 1.0};
	colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 1.0};
	colorFocused[] = {0.0, 0.0, 0.0, 0};
	font = "Zeppelin32";
	sizeEx = 0.03921;
	soundClick[] = {WFBE_SoundClick,0.2,1};
	soundDoubleClick[] = {"", 0.1, 1};
	soundEnter[] = {WFBE_SoundEnter,0.2,1};
	soundEscape[] = {WFBE_SoundEscape,0.2,1};
	soundPush[] = {, 0.2, 1};
	w = 0.275;
	h = 0.04;
	text = "";
};
class RscMapControl {
	type = 101;
	moveOnEdges = 1;
	sizeEx = 0.025;
	style = 48;
	x = 0.2;
	y = 0.2;
	w = 0.2;
	h = 0.2;
	ptsPerSquareSea = 8;
	ptsPerSquareTxt = 10;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = "6.0f";
	ptsPerSquareForEdge = "15.0f";
	ptsPerSquareRoad = "3f";
	ptsPerSquareObj = 15;
	showCountourInterval = "false";
	maxSatelliteAlpha = 0.75;
	alphaFadeStartScale = 0.15;
	alphaFadeEndScale = 0.29;
	colorLevels[] = {0.65, 0.6, 0.45, 1};
	colorSea[] = {0.46, 0.65, 0.74, 0.5};
	colorForest[] = {0.45, 0.64, 0.33, 0.5};
	colorRocks[] = {0, 0, 0, 0.3};
	colorCountlines[] = {0.85, 0.8, 0.65, 1};
	colorMainCountlines[] = {0.45, 0.4, 0.25, 1};
	colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
	colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
	colorPowerLines[] = {0.1, 0.1, 0.1, 1};
	colorRailWay[] = {0.8, 0.2, 0, 1};
	colorForestBorder[] = {0, 0, 0, 0};
	colorRocksBorder[] = {0, 0, 0, 0};
	colorNames[] = {0.1, 0.1, 0.1, 0.9};
	colorInactive[] = {1, 1, 1, 0.5};
	colorText[] = {0, 0, 0, 1};
	colorBackground[] = {0.8, 0.8, 0.8, 1};
	font = "EtelkaNarrowMediumPro";
	colorOutside[] = {0, 0, 0, 1};
	fontLabel = "Zeppelin32";
	sizeExLabel = 0.034;
	fontGrid = "Zeppelin32";
	sizeExGrid = 0.03;
	fontUnits = "Zeppelin32";
	sizeExUnits = 0.034;
	fontNames = "Zeppelin32";
	sizeExNames = 0.056;
	fontInfo = "Zeppelin32";
	sizeExInfo = 0.034;
	fontLevel = "Zeppelin32";
	sizeExLevel = 0.024;
	text = "\ca\ui\data\map_background2_co.paa";
	
	class Task {
		icon = "\ca\ui\data\ui_taskstate_current_CA.paa";
		iconCreated = "\ca\ui\data\ui_taskstate_new_CA.paa";
		iconCanceled = "#(argb,8,8,3)color(0,0,0,0)";
		iconDone = "\ca\ui\data\ui_taskstate_done_CA.paa";
		iconFailed = "\ca\ui\data\ui_taskstate_failed_CA.paa";
		color[] = {0.863, 0.584, 0.0, 1};
		colorCreated[] = {0.95, 0.95, 0.95, 1};
		colorCanceled[] = {0.606, 0.606, 0.606, 1};
		colorDone[] = {0.424, 0.651, 0.247, 1};
		colorFailed[] = {0.706, 0.0745, 0.0196, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class CustomMark {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0.6471, 0.6706, 0.6235, 1.0};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class Legend {
		x = "SafeZoneX";
		y = "SafeZoneY";
		w = 0.34;
		h = 0.152;
		font = "Zeppelin32";
		sizeEx = 0.03921;
		colorBackground[] = {0.906, 0.901, 0.88, 0};
		color[] = {0, 0, 0, 1};
	};
	
	class Bunker {
		icon = "\ca\ui\data\map_bunker_ca.paa";
		size = 14;
		color[] = {0, 0, 1, 1};
		importance = 1.5 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Bush {
		icon = "\ca\ui\data\map_bush_ca.paa";
		color[] = {0.55, 0.64, 0.43, 1};
		size = 14;
		importance = 0.2 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class BusStop {
		icon = "\ca\ui\data\map_busstop_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 12;
		importance = 1 * 10 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Command {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class Cross {
		icon = "\ca\ui\data\map_cross_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 0.7 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fortress {
		icon = "\ca\ui\data\map_bunker_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fuelstation {
		icon = "\ca\ui\data\map_fuelstation_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.75;
		coefMax = 4;
	};
	
	class Fountain {
		icon = "\ca\ui\data\map_fountain_ca.paa";
		color[] = {0.2, 0.45, 0.7, 1};
		size = 11;
		importance = 1 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Hospital {
		icon = "\ca\ui\data\map_hospital_ca.paa";
		color[] = {0.78, 0, 0.05, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Chapel {
		icon = "\ca\ui\data\map_chapel_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Church {
		icon = "\ca\ui\data\map_church_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Lighthouse {
		icon = "\ca\ui\data\map_lighthouse_ca.paa";
		size = 14;
		color[] = {0, 0.9, 0, 1};
		importance = 3 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Quay {
		icon = "\ca\ui\data\map_quay_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Rock {
		icon = "\ca\ui\data\map_rock_ca.paa";
		color[] = {0.1, 0.1, 0.1, 0.8};
		size = 12;
		importance = 0.5 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Ruin {
		icon = "\ca\ui\data\map_ruin_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 1.2 * 16 * 0.05;
		coefMin = 1;
		coefMax = 4;
	};
	
	class SmallTree {
		icon = "\ca\ui\data\map_smalltree_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.6 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Stack {
		icon = "\ca\ui\data\map_stack_ca.paa";
		size = 20;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Tree {
		icon = "\ca\ui\data\map_tree_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.9 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Tourism {
		icon = "\ca\ui\data\map_tourism_ca.paa";
		size = 16;
		color[] = {0.78, 0, 0.05, 1};
		importance = 1 * 16 * 0.05;
		coefMin = 0.7;
		coefMax = 4;
	};
	
	class Transmitter {
		icon = "\ca\ui\data\map_transmitter_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class ViewTower {
		icon = "\ca\ui\data\map_viewtower_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 16;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Watertower {
		icon = "\ca\ui\data\map_watertower_ca.paa";
		color[] = {0.2, 0.45, 0.7, 1};
		size = 20;
		importance = 1.2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Waypoint {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class WaypointCompleted {
		icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class ActiveMarker {
		icon = "";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
};
