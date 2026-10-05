params ["_currentTasknumber", "_reward"];

private _buildRoadRoute = {
	params ["_startRoad", "_endRoad"];
	private _roadQueue = [_startRoad];
	private _roadParents = [-1];
	private _visitedRoads = createHashMap;
	_visitedRoads set [str (getPosATL _startRoad), true];
	private _roadHead = 0;
	private _endIndex = -1;

	while {_roadHead < count _roadQueue && {_roadHead < 8000} && {_endIndex < 0}} do {
		private _road = _roadQueue select _roadHead;
		if (_road isEqualTo _endRoad) then {
			_endIndex = _roadHead;
		} else {
			{
				if (!isNull _x) then {
					private _roadKey = str (getPosATL _x);
					if (isNil {_visitedRoads get _roadKey}) then {
						_visitedRoads set [_roadKey, true];
						_roadQueue pushBack _x;
						_roadParents pushBack _roadHead;
					};
				};
			} forEach roadsConnectedTo _road;
		};
		_roadHead = _roadHead + 1;
	};

	if (_endIndex < 0) exitWith { [] };
	private _reverseRoute = [];
	private _routeIndex = _endIndex;
	while {_routeIndex >= 0} do {
		_reverseRoute pushBack (_roadQueue select _routeIndex);
		_routeIndex = _roadParents select _routeIndex;
	};

	private _routeRoads = [];
	_routeIndex = (count _reverseRoute) - 1;
	while {_routeIndex >= 0} do {
		_routeRoads pushBack (_reverseRoute select _routeIndex);
		_routeIndex = _routeIndex - 1;
	};
	_routeRoads
};

private _startRoad = objNull;
private _endRoad = objNull;
private _routeRoads = [];
private _attempts = 0;
private _routeCenter = [worldSize / 2, worldSize / 2, 0];
private _routeAreaRadius = worldSize * 0.4;

while {_routeRoads isEqualTo []} do {
	private _batchAttempts = 0;
	while {_batchAttempts < 160 && {_routeRoads isEqualTo []}} do {
		_attempts = _attempts + 1;
		_batchAttempts = _batchAttempts + 1;
		private _sampleDistance = sqrt (random 1) * _routeAreaRadius;
		private _samplePos = _routeCenter getPos [_sampleDistance, random 360];
		private _startCandidates = _samplePos nearRoads 250;
		_startCandidates = _startCandidates select {_x distance2D _routeCenter <= _routeAreaRadius};
		if (_startCandidates isEqualTo []) then { continue; };
		private _candidateStart = selectRandom _startCandidates;
		private _searchPos = (getPosATL _candidateStart) getPos [random [7000, 8500, 10000], random 360];
		private _endCandidates = _searchPos nearRoads 400;
		_endCandidates = _endCandidates select {
			_x distance2D _candidateStart >= 6000
			&& {_x distance2D _routeCenter <= _routeAreaRadius}
		};
		if (_endCandidates isEqualTo []) then { continue; };

		private _candidateEnd = selectRandom _endCandidates;
		private _candidateRoute = [_candidateStart, _candidateEnd] call _buildRoadRoute;
		if (count _candidateRoute < 2) then { continue; };

		private _routeDistance = 0;
		private _previousRoadPos = getPosATL (_candidateRoute select 0);
		for "_routeIndex" from 1 to ((count _candidateRoute) - 1) do {
			private _currentRoadPos = getPosATL (_candidateRoute select _routeIndex);
			_routeDistance = _routeDistance + (_previousRoadPos distance2D _currentRoadPos);
			_previousRoadPos = _currentRoadPos;
		};

		if (_routeDistance >= 8000 && {_routeDistance <= 12000}) then {
			_startRoad = _candidateStart;
			_endRoad = _candidateEnd;
			_routeRoads = _candidateRoute;
		};
	};
	if (_routeRoads isEqualTo []) then {
		diag_log format ["[PMC_ConvoyIntercept] No suitable 8-12 km road route found after %1 attempts; continuing search.", _attempts];
		sleep 5;
	};
};

private _startPos = getPosATL _startRoad;
private _endPos = getPosATL _endRoad;
private _nextRoadPos = getPosATL (_routeRoads select 1);
private _heading = _startPos getDir _nextRoadPos;
private _routePositions = [getPosASL _startRoad];
private _lastRoadPos = _startPos;
private _distanceSinceWaypoint = 0;

for "_i" from 1 to ((count _routeRoads) - 1) do {
	private _roadPos = getPosATL (_routeRoads select _i);
	_distanceSinceWaypoint = _distanceSinceWaypoint + (_lastRoadPos distance2D _roadPos);
	_lastRoadPos = _roadPos;
	if (_distanceSinceWaypoint >= 100) then {
		_routePositions pushBack (getPosASL (_routeRoads select _i));
		_distanceSinceWaypoint = 0;
	};
};
if ((_routePositions select ((count _routePositions) - 1)) distance2D _endPos > 30) then {
	_routePositions pushBack (getPosASL _endRoad);
};

private _vehicleTypes = [
	"UK3CB_LDF_I_M1025_M2",
	"UK3CB_LDF_I_Offroad_M2",
	"UK3CB_LDF_I_M1025_M2",
	"UK3CB_LDF_I_Offroad_M2"
];
private _usedSpawnRoads = [_startRoad];
private _primaryData = [_startPos, _heading, "UK3CB_LDF_I_RM70_MG", resistance] call BIS_fnc_spawnVehicle;
_primaryData params ["_primaryAsset", "_primaryCrew", "_convoyGroup"];

if (isNull _primaryAsset) exitWith {
	"Convoy mission failed to spawn its RM70 asset." remoteExec ["hint", 0];
};

private _vehicles = [_primaryAsset];
private _convoyGroups = [_convoyGroup];
{
	private _spawnTarget = _startPos getPos [18 * (_forEachIndex + 1), _heading + 180];
	private _spawnRoads = _spawnTarget nearRoads 40;
	_spawnRoads = _spawnRoads select {
		private _candidateRoad = _x;
		(_usedSpawnRoads findIf {_x distance2D _candidateRoad < 12}) == -1
	};
	if (_spawnRoads isEqualTo []) then {
		diag_log format ["[PMC_ConvoyIntercept] No clear road found for escort vehicle %1; skipping it.", _x];
		continue;
	};
	private _spawnRoadChoices = _spawnRoads apply {[_x distance2D _spawnTarget, _x]};
	_spawnRoadChoices sort true;
	private _spawnRoad = (_spawnRoadChoices select 0) select 1;
	_usedSpawnRoads pushBack _spawnRoad;
	private _spawnPos = getPosATL _spawnRoad;
	private _spawnData = [_spawnPos, _heading, _x, resistance] call BIS_fnc_spawnVehicle;
	_spawnData params ["_vehicle", "_crew", "_group"];
	if (isNull _vehicle) then { continue; };

	_vehicles pushBack _vehicle;
	_convoyGroups pushBack _group;
} forEach _vehicleTypes;

{
	_x setBehaviour "AWARE";
	_x setCombatMode "YELLOW";
	_x setSpeedMode "LIMITED";
	for "_i" from 1 to ((count _routePositions) - 1) do {
		private _waypoint = _x addWaypoint [_routePositions select _i, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 15;
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointBehaviour "AWARE";
	};
} forEach _convoyGroups;

private _zoneRadius = 500;
private _deliveryRadius = 75;
private _zoneMarker = format ["PMC_ConvoyEndZone_%1", _currentTasknumber];
createMarker [_zoneMarker, _endPos];
_zoneMarker setMarkerShape "ELLIPSE";
_zoneMarker setMarkerSize [_zoneRadius, _zoneRadius];
_zoneMarker setMarkerBrush "SolidBorder";
_zoneMarker setMarkerColor "ColorRed";
_zoneMarker setMarkerAlpha 0.3;
_zoneMarker setMarkerText "Convoy End Zone";

private _deliveryMarker = format ["PMC_ConvoyDeliveryPoint_%1", _currentTasknumber];
private _deliveryMarkerPos = [_endPos select 0, (_endPos select 1) + _zoneRadius, _endPos select 2];
createMarker [_deliveryMarker, _deliveryMarkerPos];
_deliveryMarker setMarkerType "hd_flag";
_deliveryMarker setMarkerColor "ColorRed";
_deliveryMarker setMarkerText "Suspected Destination";

private _destinationVehicles = [];
private _destinationVehicleTypes = [
	"UK3CB_LDF_I_Offroad_M2",
	"UK3CB_LDF_I_M1025_M2",
	"UK3CB_LDF_I_Pickup_M2"
];
{
	private _angle = _heading + 90 + (120 * _forEachIndex);
	private _vehiclePos = _endPos getPos [35, _angle];
	private _vehicle = createVehicle [_x, _vehiclePos, [], 0, "NONE"];
	_vehicle setDir (_vehiclePos getDir _endPos);
	_vehicle lock 2;
	_destinationVehicles pushBack _vehicle;
} forEach _destinationVehicleTypes;

private _destinationGroup = [_endPos, resistance, selectRandom OPCB_InfantryGroups_Insurgents] call BIS_fnc_spawnGroup;
[_destinationGroup, _endPos] call BIS_fnc_taskDefend;

private _taskId = format ["PMC_ConvoyIntercept_%1", _currentTasknumber];
private _sightingMarker = format ["PMC_ConvoySighting_%1", _currentTasknumber];
private _sightingMarkerCreated = false;
[_taskId, west, [
	"A hostile convoy is transporting an RM-70 rocket launcher across Mehland. The red circle marks its suspected delivery area stop it before it reaches the delivery point inside. Intelligence marks its latest sighting on the map every three minutes. Destroy the RM-70 to complete the mission.",
	"Operation Iron Road",
	"Iron Road"
], getPosATL _primaryAsset, "ASSIGNED", 10, true, true, "Destroy", true] call BIS_fnc_setTask;

private _nextUpdate = time + 180;
while {alive _primaryAsset && {_primaryAsset distance2D _endPos > _deliveryRadius}} do {
	sleep 5;
	if (time >= _nextUpdate && {alive _primaryAsset}) then {
		private _currentPos = getPosATL _primaryAsset;
		[_taskId, _currentPos] call BIS_fnc_taskSetDestination;
		if (!_sightingMarkerCreated) then {
			createMarker [_sightingMarker, _currentPos];
			_sightingMarker setMarkerType "mil_dot";
			_sightingMarker setMarkerColor "ColorOrange";
			_sightingMarker setMarkerText "Last Convoy Sighting";
			_sightingMarkerCreated = true;
		} else {
			_sightingMarker setMarkerPos _currentPos;
		};
		_nextUpdate = time + 180;
	};
};

if (!alive _primaryAsset) then {
	[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
	publicVariable "OPCB_econ_credits";
	[format ["Convoy intercepted. You earned %1 C.", _reward]] remoteExec ["hint", 0];
} else {
	[_taskId, "FAILED", true] call BIS_fnc_taskSetState;
	"The convoy reached the delivery point with the RM70 intact. Mission failed." remoteExec ["hint", 0];
};

{
	if (!isNull _x) then {
		{ deleteVehicle _x; } forEach crew _x;
		deleteVehicle _x;
	};
} forEach _vehicles;
{
	if (!isNull _x) then { deleteGroup _x; };
} forEach _convoyGroups;
{
	if (!isNull _x) then { deleteVehicle _x; };
} forEach _destinationVehicles;
if (!isNull _destinationGroup) then {
	{ deleteVehicle _x; } forEach units _destinationGroup;
	deleteGroup _destinationGroup;
};
deleteMarker _zoneMarker;
deleteMarker _deliveryMarker;
if (_sightingMarkerCreated) then { deleteMarker _sightingMarker; };