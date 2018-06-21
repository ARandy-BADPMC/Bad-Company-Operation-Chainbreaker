/*
	Set view distance for all sides players.

	You can optionally set minimum and maximum view distance (default is 1500 and 4000):
		#define VIEW_DISTANCE_MIN	1500
		#define VIEW_DISTANCE_MAX	4000

	Optionally, you can set default value:
		#define VIEW_DISTANCE_DEFAULT	2500

	Include this file to description.ext of your mission.

	Example:
	class Params
	{
		#include "Params\paramViewDistance.inc"
	};
*/

#ifndef VIEW_DISTANCE_MIN
	#define VIEW_DISTANCE_MIN	1500
#endif
#ifndef VIEW_DISTANCE_MAX
	#define VIEW_DISTANCE_MAX	4000
#endif
#ifndef VIEW_DISTANCE_DEFAULT
	#define VIEW_DISTANCE_DEFAULT	2500
#endif

__EXEC(_distanceStep = VIEW_DISTANCE_MAX * 0.2 - VIEW_DISTANCE_MIN * 0.2;)
__EXEC(_distance0 = VIEW_DISTANCE_MIN + 0 * _distanceStep;)
__EXEC(_distance1 = VIEW_DISTANCE_MIN + 1 * _distanceStep;)
__EXEC(_distance2 = VIEW_DISTANCE_MIN + 2 * _distanceStep;)
__EXEC(_distance3 = VIEW_DISTANCE_MIN + 3 * _distanceStep;)
__EXEC(_distance4 = VIEW_DISTANCE_MIN + 4 * _distanceStep;)
__EXEC(_distance5 = VIEW_DISTANCE_MIN + 5 * _distanceStep;)

class ViewDistance
{
	title = $STR_A3_paramViewDistance_title;
	isGlobal = 1;

	values[] = {
		__EVAL(_distance0),
		__EVAL(_distance1),
		__EVAL(_distance2),
		__EVAL(_distance3),
		__EVAL(_distance4),
		__EVAL(_distance5)
	};
	texts[] = {
		__EVAL(_distance0),
		__EVAL(_distance1),
		__EVAL(_distance2),
		__EVAL(_distance3),
		__EVAL(_distance4),
		__EVAL(_distance5)
	};
	default = VIEW_DISTANCE_DEFAULT;
	function = "BIS_fnc_paramViewDistance";
};