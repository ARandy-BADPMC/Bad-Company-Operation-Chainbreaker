_vehicle = _this select 0;
_pilot = driver _vehicle;

if ((typeOf _pilot != "rhsusf_army_ocp_helipilot") || isNull _pilot)
then {
_vehicle engineOn false; 
};
