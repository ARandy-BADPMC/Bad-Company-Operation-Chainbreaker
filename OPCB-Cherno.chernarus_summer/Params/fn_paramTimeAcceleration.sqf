/*
	Author: Nelson Duarte

	Description:
	Set time acceleration ratio

	Parameter(s):
	NUMBER - Ratio

	Returns:
	NUMBER - Ratio
*/

private ["_ratio"];
_ratio = _this param [0,timeMultiplier,[0]];
setTimeMultiplier _ratio;
_ratio