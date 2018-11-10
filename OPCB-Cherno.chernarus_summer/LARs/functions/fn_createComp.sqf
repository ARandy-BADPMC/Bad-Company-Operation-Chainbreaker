//Main function resposible for spawning compositions

//[ COMP_NAME, POS_ATL, OFFSET, DIR, ALIGN_TERRAIN ] call LARs_fnc_spawnComp;

//COMP_NAME - Classname given to composition in missionConfigFile CfgCompositions

//POS_ATL( optional ) - Position to spawn composition
//	If not given or empty array passed then original saved composition position is used
//	Also accepts OBJECT, MARKER, LOCATION

//OFFSET( optional ) - ARRAY [ x, y, z ] ammount to offset composition, as a compositions base pos can vary from what you want when its saved

//DIR( optional ) - Direction to face composition in, If POS_ATL is of type OBJECT, MARKER, LOCATION passing TRUE for direction will use objects direction

//ALIGN_TERRAIN( optional ) - BOOL, Whether composition objects should align themselves to their positions surface normal



//Are we running in debugMode 2
#define DEBUG_DEV getNumber( missionConfigFile >> "LARs_spawnComp_debug" ) isEqualTo 2
//Are we running in debugMode 1 OR 2
#define DEBUG getNumber( missionConfigFile >> "LARs_spawnComp_debug" ) isEqualTo 1 || DEBUG_DEV
//Show RPT message if condition is true
#define DEBUG_MSG( COND, MSG ) if ( COND ) then { diag_log MSG }

private [ "_groupCfgs", "_itemCfgs", "_deferedIDs", "_deferedItems", "_deferedGrps", "_deferedTrgs", "_crewLinks", "_objects", "_priority", "_ids", "_inits", "_nul" ];

params[
	"_compName",
	[ "_compPos", [] ],
	[ "_compOffset", [0,0,0] ],
	[ "_compRot", 0 ],
	[ "_compAlign", true ],
	[ "_compWater", true ]
];

//Show debug message for function parameters
_msg = format[ "COMP - Name: %1, Pos:%2, Offset: %3, Rot: %4, Align: %5", _compName, _compPos, _compOffset, _compRot, _compAlign ];
DEBUG_MSG( DEBUG, _msg );

//Init asPlaced as false - this flag represents whether we are spawning the composition at the place the composition was saved in Eden
_asPlaced = false;

//Retrieve position and rotation that the user has asked the composition to be spawned at
switch ( true ) do {

	//Get original composition position
	//If the passed position is an empty array
	case ( _compPos isEqualType [] && { count _compPos isEqualTo 0 } ) : {
		//Retrieve the saved position from the composition
		_compPos = getArray( missionConfigFile >> "CfgCompositions" >> _compName >> "center" );
		//Saved Eden positions are [ x, z, y ] so change it to [ x, y, z ]
		_compPos = [ _compPos select 0, _compPos select 2, _compPos select 1 ];
		//Flag as saved position
		_asPlaced = true;
	};

	//Get position of a specified OBJECT
	//If the passed position is an OBJECT
	case ( _compPos isEqualType objNull ) : {
		//If rotation asked for is BOOLEAN
		if ( _compRot isEqualType true ) then {
			//Then used the OBJECTS direction
			_compRot = getDirVisual _compPos;
		};
		//Set the position as the OBJECT visual ASL position
		_compPos = getPosASLVisual _compPos;
	};

	//Get position of a MARKER
	//If the passed position is a STRING and a marker of this name exists
	case ( _compPos isEqualType "" && { getMarkerPos _compPos != [0,0,0] } ) : {
		//If rotation asked for is BOOLEAN
		if ( _compRot isEqualType true ) then {
			//Then use the markers direction
			_compRot = markerDir _compPos;
		};
		//Set the position as the markers ASL position
		_compPos = ATLToASL getMarkerPos _compPos;
	};

	//Get position of a LOCATION
	//If the passed position is a LOCATION
	case ( _compPos isEqualType locationNull ) : {
		//If rotation asked for is BOOLEAN
		if ( _compRot isEqualType true ) then {
			//Then use the locations direction
			_compRot = direction _compPos;
		};
		//Set the position as the locations ASL position
		_compPos = ATLToASL locationPosition _compPos;
	};

	default {
		//Else default position to passed position as ASL
		_compPos = ATLToASL _compPos;
	};
};

//If debugMode 2
if ( DEBUG_DEV ) then {
	//spawn a large green arrow at choosen composition position
	createVehicle [ "Sign_Arrow_Large_Green_F", _compPos, [], 0, "CAN_COLLIDE" ];
	//spawn a green direction arrow 3m above choosen composition position pointing in composition direction
	_arrow = createVehicle [ "Sign_Arrow_Direction_Green_F", _compPos vectorAdd [ 0, 0, 3 ], [], 0, "CAN_COLLIDE" ];
	_arrow setDir _compRot;
};



//DEFERED - means items that have had their spawning push to the end because they rely on other items to have been spawned first
//Array to hold Eden IDs of composition items that have been defered
_deferedIDs = [];
//Array to hold cfg paths of composition items that have been defered
_deferedItems = [];
//Array to hold cfg paths of composition groups that have been defered
_deferedGrps = [];
//Array to hold cfg paths of composition triggers that have been defered
_deferedTrgs = [];

//Holds an ARRAY of ARRAYs of Eden IDs of objects that are linked to a crew position of a vehicle
_crewLinks = [];

//An ARRAY of references to items spawned from the composition - each object is placed in the index of its Eden ID
_objects = [];

//This is the order in which items from the composition will be spawned via their type
_priority = [ "Marker", "Object", "Group", "Waypoint", "Trigger", "Logic" ];

//These are arrays of everything to be spawned that has not been defered
//Array to hold cfg paths of any groups to be spawned
_groupCfgs = [];
//Array to hold cfg paths of all other items to be spawned
_itemCfgs = [];


//**********
//Function to recursively iterate the compositions cfg hierarchy and seperate each item into
//the previously defined arrays ready for spawning
//**********
private _fnc_sortCfgItems = {
	private[ "_dataType" ];

	//[ config path to check, Eden ID of parent GROUP, GROUP cfg path, flag as item needing to be defered ]
	//_groupID, _groupCfg and _toDefer are used in recursice calls by groups
	params[ "_cfg", [ "_groupID", -1 ], [ "_groupCfg", configNull ], [ "_toDefer", false ] ];

	//For each class in the composition
	{
		//retrieve its data type
		_dataType = getText( _x >> "dataType" );

		//Get its Eden ID
		_id = getNumber( _x >> "id" );
		//If our _objects array is not large enough to place this object at an index of its Eden ID
		if ( count _objects <= _id ) then {
			//Resize the array
			_objects resize _id;
		};

		//Store the object as [ Eden ID, composition cfg path, datatype, parent groups Eden ID, parent groups cfg path ]
		_nul = _objects set [ _id, [ _id, _x, _dataType, _groupID, _groupCfg ] ];

		//Select what to do via objects data type
		switch ( _dataType ) do {

			//If its a Layer then recurse the layers objects
			case "Layer" : {
				[ ( _x >> "Entities" ) ] call _fnc_sortCfgItems;
			};

			//If its a group
			case "Group" : {

				//If the group has NO links to vehicle positions
				if !( isClass( _x >> "crewLinks" ) ) then {
					//Then add its cfg path to our groups array
					_nul = _groupCfgs pushBack _x;
				}else{
					//Otherwise add the groups Eden ID to IDs that have been defered
					_nul = _deferedIDs pushBackUnique _id;
					//Add the groups cfg path to defered groups
					_nul = _deferedGrps pushBack _x;
					//Recurse the objects of this group
					//Passing [ cfg path to groups objects, Eden ID of parent group, cfg path of parent group, flag as defered ]
					[ ( _x >> "Entities" ), _id, _x, true ] call _fnc_sortCfgItems;
					//[ ( _x >> "CrewLinks" ) ] call _fnc_deferLinks;
				};
			};

			//If we get here then it must be an actual object that will need spawning
			default {
				//If not flagged as defered
				if !( _toDefer ) then {
					//Add to our item array for spawning
					_nul = _itemCfgs pushBack _x;
				}else{
					//Otherwise push its Eden ID into the defered IDs array
					_nul = _deferedIDs pushBackUnique _id;
					//_nul = _deferedItems pushBack _x;
				};
			};
		};
	}forEach ( "true" configClasses _cfg );

};

//Sort composition items
[ ( missionConfigFile >> "CfgCompositions" >> _compName >> "items" ) ] call _fnc_sortCfgItems;


//**********
//Function to sort Eden LINKS
//These are SYNC connections like waypoint activations, trigger owners etc
//OR unit crew positions in vehicles
//**********
private _fnc_deferLinks = {
	private[ "_item0ID", "_item1ID", "_item0Info", "_item1Info", "_linkType" ];
	params[ "_cfg" ];

	//For each link in the composition cfg
	{

		//Connections
		//RandomStartPos = Man and Marker
		//WaypointActivation = Waypoint and Waypoint OR Waypoint and Trigger
		//Sync
		//[ "marker", "object", "group", "waypoint", "trigger", "logic" ]

		//Retrieve the two object that are linked - these are Eden IDs
		_item0ID = getNumber( _x >> "item0" );
		_item1ID = getNumber( _x >> "item1" );

		//Get the info we saved about each object when we sorted them in sortGfgItems
		//[ _id, _cfg, _dataType, _groupID, _groupCfg ]
		_item0Info = _objects select _item0ID;
		_item1Info = _objects select _item1ID;

		//Make sure the info for both items exist
		//When saving a composition in Eden a object may well be synced to an object that did not get saved in the compostion
		//If one of the objects is not in the composition then we want to ignore it as the connection has no meaning
		if ( !isNil "_item0Info" && !isNil "_item1Info" ) then {

			//Switch on the links configName as this relates to the type of connection its is
			switch ( toUpper ( configName _cfg ) ) do {

				//These are SYNC links like waypoint activations and trigger owners
				case ( "CONNECTIONS" ) : {

					//Get the actual link type
					_linkType = getText( _x >> "customData" >> "type" );
					switch ( _linkType ) do {

						//*****
						//WAYPOINTS
						//*****
						case "WaypointActivation" : {

							//Is atleast one of the linked items a trigger
							if ( { ( _x select 2 ) isEqualTo "Trigger" }count[ _item0Info, _item1Info ] > 0 ) then {

								//Find which one is the trigger
								{
									_x params[ "_id", "_cfg", "_type" ];

									if ( _type isEqualTo "Trigger" ) exitWith {

										//Remove it from our items to spawn
										_itemCfgs = _itemCfgs - [ _cfg ];

										//And derfer it
										_nul = _deferedIDs pushBackUnique _id;
										_nul = _deferedItems pushBackUnique _cfg;
									};
								}forEach [ _item0Info, _item1Info ];
							}else{
								//Else its two waypoints synced to each other, just defer the first one
								_nul = _deferedIDs pushBackUnique _item0ID;
								_nul = _deferedItems pushBackUnique ( _item0Info select 1 );
							};
						};

						//*****
						//RANDOM START
						//*****
						case "RandomStart" : {
							//For each linked items info
							{
								_x params[ "_id", "_cfg", "_type", "_groupID", "_groupCfg" ];

								if ( _type isEqualTo "Object" ) exitWith {
									//If it has a member of a group
									if !( isNull _groupCfg ) then {
										//Remove it from the groups to spawn
										_groupCfgs = _groupCfgs - [ _groupCfg ];
										//And add it to defered groups
										_nul = _deferedIDs pushBackUnique _groupID;
										_nul = _deferedGrps pushBackUnique _groupCfg;
									}else{
										//Otherwise remove from items to spawn
										_itemCfgs = _itemCfgs - [ _cfg ];
										//And add it to defered items
										_nul = _deferedIDs pushBackUnique _id;
										_nul = _deferedItems pushBackUnique _cfg;
									};
								};
							}forEach [ _item0Info, _item1Info ];
						};

						//*****
						//SYNCHRONISED
						//*****
						case "Sync" : {
							private[ "_item" ];
							_itemPriority = [ 0, 0 ];

							//Find the priority of each linked item
							{
								_x params[ "_id", "_cfg", "_type" ];
								_itemPriority set [ _forEachIndex, _priority find _type ];
							}forEach [ _item0Info, _item1Info ];

							//Find the one with the earliest priority( smaller index )
							_item = [ _item0Info, _item1Info ] select ( _itemPriority select 1 < ( _itemPriority select 0 ) );

							//Get its info
							_item params[ "_id", "_cfg", "_type", "_groupID", "_groupCfg" ];

							//If its a member of a group
							if ( _groupID > -1 ) then {
								//remove its group from groups to spawn
								_groupCfgs = _groupCfgs - [ _groupCfg ];
								//Add it to defered groups
								_nul = _deferedIDs pushBackUnique _groupID;
								_nul = _deferedGrps pushBackUnique _groupCfg;
							}else{
								//Remove it from items to spawn
								_itemCfgs = _itemCfgs - [ _cfg ];
								//Add it to defered items
								_nul = _deferedIDs pushBackUnique _id;
								_nul = _deferedItems pushBackUnique _cfg;
							};
						};

						//*****
						//TRIGGER OWNERS
						//*****
						case "TriggerOwner" : {
							private[ "_owner" ];
							//FIXME: triggerOwner is currently broken in stable branch
							//TODO: attached trigger types activationByOwner and its variants - EDIT: needs proper testing hopefully handled by connections

							//For each items info
							{
								_x params[ "_id", "_cfg", "_type", "_groupID", "_groupCfg" ];

								//If its a trigger
								if ( _type isEqualTo "Trigger" ) exitWith {
									//Get the other link info
									_owner = [ _item0Info, _item1Info ] - ( [ _item0Info, _item1Info ] select _forEachIndex );
									//Remove the trigger from items to spawn
									_itemCfgs = _itemCfgs - [ _cfg ];
									//Add trigger to defered
									_nul = _deferedIDs pushBackUnique _id;
									_nul = _deferedTrgs pushBackUnique _cfg;
								};
							}forEach [ _item0Info, _item1Info ];
						};

					};
				};

//				case ( "CREWLINKS" ) :{
//					//If a Group has crewLinks then it and its units are defered
					//so will not spawn until after vehicle is done see connections
//				};
			};
		};


	}forEach ( "true" configClasses ( _cfg >> "Links" ));

};

//add connections to deferedIDs
if ( isClass( missionConfigFile >> "CfgCompositions" >> _compName >> "connections" ) ) then {
	[ ( missionConfigFile >> "CfgCompositions" >> _compName >> "connections" ) ] call _fnc_deferLinks;
};

//**********
//Function to work out objects actual spawning position taking into account composition position and rotation
//Plus any position rotation offsets for the object
//**********
private _fnc_setPositionAndRotation = {
	private[ "_pos", "_newPosX", "_newPosY", "_newPosASL", "_newPosZ", "_rotation", "_mkrPos" ];
	params[
		[ "_obj", objNull ],			//The spawned object
		[ "_cfgOffset", [0,0,0] ],		//Its offset within the composition
		[ "_cfgRot", [0,0,0] ],			//Its rotation from the composition
		[ "_ATLOffset", 0 ],			//Its height offset from the composition
		[ "_randomStartPos", [] ],		//RandomStart positions from ther composition
		[ "_needsSurfaceUp", false ],	//Does it need surface up
		[ "_placementRadius", 0 ]		//PlacementRadius from composition
	];

	//TESTING
//	if ( DEBUG_DEV ) then {
//		if !( canSuspend ) exitWith {
//			_this spawn _fnc_setPositionAndRotation;
//		};
//	};

	//Change cfg offset from [ x, z, y ] into [ x, y, z ]
	_cfgOffset = [ _cfgOffset select 0, _cfgOffset select 2 , _cfgOffset select 1 ];
	//Rotate the objects offset in the composition relative to the compositions spawn direction
	_cfgOffset = [ _cfgOffset, 360 - _compRot ] call BIS_fnc_rotateVector2D;
	//Add any composition offset rotated around the compositions spawning rotation
	_cfgOffset = _cfgOffset vectorAdd ( [ _compOffset, 360 - _compRot ] call BIS_fnc_rotateVector2D );

	//If the user has asked for objects to be aligned to the terrain and we are not spawning the composition as placed
	if ( _compAlign && !_asPlaced ) then {
		_newPosX = ( _compPos select 0 ) + ( _cfgOffset select 0 );
		_newPosY = ( _compPos select 1 ) + ( _cfgOffset select 1 );
		_newPosASL = getTerrainHeightASL [ _newPosX, _newPosY ];
		_newPosZ = _newPosASL + ( _cfgOffset select 2 );
//		if ( _asPlaced ) then {
//			_pos = [ _newPosX, _newPosY, _newPosZ + _ATLOffset ];
//		}else{
			_pos = [ _newPosX, _newPosY, _newPosZ ];
//		};
	}else{
		//Otherwise just add the objects offset to the position the composition is spawning at plus any height offset
		_pos = ( _compPos vectorAdd _cfgOffset ) vectorAdd [ 0, 0, _ATLOffset ];
	};

	//If the object has random spawn positions
	if ( count _randomStartPos > 0 ) then {
		//Get each marker position and add the object center offset
		_randomStartPos = _randomStartPos  apply {
			_mkrPos = ATLToASL getMarkerPos _x;
			_mkrPos = _mkrPos vectorAdd [ 0, 0, abs( boundingBoxReal _obj select 0 select 2 ) ];
			_mkrPos
		};
		//Choose a random position
		_pos = selectRandom ( [ _pos ] + _randomStartPos );
	};

	//If the object has a placement radius
	if ( _placementRadius > 0 ) then {
		//Get a random position in a random direction in _placementRadius distance
		_pos = AGLToASL ( _pos getPos [ random _placementRadius, random 360 ] );
		//Add objects center offset
		_pos = _pos vectorAdd [ 0, 0, abs( boundingBoxReal _obj select 0 select 2 ) ];
	};

	//If the position is water and the user has asked to align to water and the composition is not being placed as saved
	if ( surfaceIsWater _pos && _compWater && !_asPlaced ) then {
		//Place at sea level plus any objects offset and any composition offset
		_pos = [ _pos select 0, _pos select 1, 0 + ( _cfgOffset select 2 ) + ( _compOffset select 2 ) ];
	};

	//DEBUG ARROWS for spawn locations and calculated position
	if ( DEBUG_DEV ) then {
		//OBJECT composition pos + offset + atl offset
		createVehicle [ "Sign_Arrow_Yellow_F", ASLToATL ( ( _compPos vectorAdd _cfgOffset ) vectorAdd [ 0, 0, _ATLOffset ] ), [], 0, "CAN_COLLIDE" ];
		//OBJECT calculated final position
		createVehicle [ "Sign_Arrow_Green_F", ASLToATL _pos, [], 0, "CAN_COLLIDE" ];
	};


	if !( isNull _obj ) then {

		//Move object to its world position
		_obj setPosWorld _pos;

		//Turn composition angles to degrees
		_CfgRot params[ "_P", "_Y", "_R" ];

		_Y = ( deg _Y ) + _compRot;
		_P = deg _P;
		_R = 360 - deg _R;

		//If Aliging composition or its a vehicle that needs surface up
		_pb = if ( ( _compAlign || _needsSurfaceUP ) && !( surfaceIsWater _pos && _compWater ) && !_asPlaced ) then {
			//Face it in the right direction
			_obj setDir _Y;
			//Get positions surface up
			_up = surfaceNormal _pos;

			//Get bound corner surface ups
			_bounds = boundingBoxReal _obj;
			_bounds params[ "_mins", "_maxs" ];
			_mins params[ "_minX", "_minY", "_minZ" ];
			_maxs params[ "_maxX", "_maxY" ];

			//Calculate up based on corner surface normals
			_newUp = _up;
			{
				_cornerPos = _obj modelToWorldVisual _x;
				_cornerUp = surfaceNormal _cornerPos;
				_weight = _pos distance _cornerPos;
				_diff = ( _up vectorDiff _cornerUp ) vectorMultiply _weight;
				_newUp = _newUp vectorAdd _diff;
			}forEach [
				[ _minX, _minY, _minZ ],
				[ _minX, _maxY, _minZ ],
				[ _maxX, _maxY, _minZ ],
				[ _maxX, _minY, _minZ ]
			];

			_obj setVectorUp vectorNormalized _up;

			_obj call BIS_fnc_getPitchBank
		}else{
			[ 0, 0 ]
		};

		//Add any surface offset to composition rotations
		_pb params[ "_pbP", "_pbR" ];

		_P = _P + _pbP;
		_R = _R + _pbR;

		//Make sure rotations are in 0 - 360 range
		{
			_deg = call compile format [ "%1 mod 360", _x ];
			if ( _deg < 0 ) then {
				_deg = linearConversion[ -0, -360, _deg, 360, 0 ];
			};
			call compile format[ "%1 = _deg", _x ];
		}forEach [ "_P", "_R", "_Y" ];

		//Calculate Dir and Up
		_dir = [ sin _Y * cos _P, cos _Y * cos _P, sin _P];
		_up = [ [ sin _R, -sin _P, cos _R * cos _P ], -_Y ] call BIS_fnc_rotateVector2D;

		//Set Object rotation
		_obj setVectorDirAndUp [ _dir, _up ];

		//enable simulation
		if !( simulationEnabled _obj ) then {
			_obj enableSimulationGlobal true;
		};

	};

	_pos
};

//private _fnc_getRotation = {
//	params[ "_CfgRot", "_obj" ];
//
//
//	_CfgRot params[ "_P", "_Y", "_R" ];
//	_Y = ( ( deg _Y ) + _compRot );
//	_P = ( deg _P );
//	_R = ( deg _R );
//
//	_cfgDir = [ sin _Y * cos _P, cos _Y * cos _P, sin _P];
//	_cfgUp = [ [ sin _R, -sin _P, cos _R * cos _P ], -_Y ] call BIS_fnc_rotateVector2D;
//
//	_obj setVectorDirAndUp [ _cfgDir, _cfgUp ];
//
//};

//**********
//Process any custom Eden attributes saved with the object
//See Eden custom attributes on the wiki
//These are a STRING of code that have a value and property name inserted in them and run on the server
//**********
private _fnc_CustomAttributes = {
	private[ "_property", "_expression", "_split", "_valueType", "_value", "_header" ];
	params[ "_obj", "_cfg" ];

	//For each of the objects custom atributes
	{
		//Get the property
		_property = getText( _x >> 'property' );
		//Get the STRING of code
		_expression = getText( _x >> 'expression' );
		//Insert property in code at %s <- there can only be one, as described in Eden attribute modding
		if ( _expression find "%s" > -1 ) then {
			_index = _expression find "%s";
			_splitLeft = _expression select [ 0, _index ];
			_splitRight = _expression select [ _index + 2, count _expression ];
			_expression = format[ "%1%2%3", _splitLeft, _property, _splitRight ]; //TODO: does property need passing as STRING? dont think so
		};


		//Get the attributes data type and retrieve the value via the currect command getText getNumber etc
		_valueType = getArray( _x >> 'Value' >> 'data' >> 'type' >> 'type' );
		switch ( _valueType select 0 ) do {
			case 'STRING' : {
				_value = getText( _x >> 'Value' >> 'data' >> 'value' );
			};
			case 'SCALAR' : {
				_value = getNumber( _x >> 'Value' >> 'data' >> 'value' );
			};
			case 'BOOL' : {
				_value = [ false, true ] select getNumber( _x >> 'Value' >> 'data' >> 'value' );
			};
			case 'ARRAY' : {
				_value = getArray( _x >> 'Value' >> 'data' >> 'value' );
			};
		};
		//Add a header to the code to decompose the passed values into the variables expected by the code
		_header = "params[ '_this', '_value' ];";
		//Call the code
		[ _obj, _value ] call compile format[ "%1%2", _header, _expression ];
	}forEach ( "true" configClasses ( _cfg >> 'CustomAttributes' ) );
};

_ids = [];
_inits = [];

//**********
//A function to return cfg values or return a default value( if supplied ) when a cfg value is not present
//**********
private _fnc_getCfgValue = {
	private[ "_value" ];
	params[ "_cfg", "_type", "_default" ];

	switch ( toUpper _type ) do {
		case "NUM" : {
			//Does a cfg value exist
			_value = if ( isNumber( _cfg ) ) then {
				//Return config value
				getNumber( _cfg )
			}else{
				//If weve passed a default value to use then return it
				if !( isNil "_default" ) then {
					_default
				}else{
					//Else use this a a default
					0
				};
			};
		};
		case "BOOL" : {
			_value = if ( isNumber( _cfg ) ) then {
				[ false, true ] select ( getNumber( _cfg ) )
			}else{
				if !( isNil "_default" ) then {
					_default
				}else{
					true
				};
			};
		};
		case "TXT" : {
			_value = if ( isText( _cfg ) ) then {
				getText ( _cfg )
			}else{
				if !( isNil "_default" ) then {
					_default
				}else{
					""
				};
			};
		};
		case "ARRAY" : {
			_value = if ( isArray( _cfg ) ) then {
				getArray ( _cfg )
			}else{
				if !( isNil "_default" ) then {
					_default
				}else{
					[]
				};
			};
		};
	};

	_value
};

//**********
//Function to pass a units inventory saved from Eden - vehicles behave different and are handle via custom attrbutes
//**********
private _fnc_getUnitInventory = {
	private[ "_invCfg", "_loadout" ];
	params[ "_invCfg", "_unit" ];

	_loadout = [];

	//Weapons
	private _fnc_getWeaponDetails = {
		private[ "_weaponCfg" ];
		params[ "_weapon" ];

		_weaponCfg = _invCfg >> _weapon;

		if !( isClass _weaponCfg ) then {
			[]
		}else{
			[
				getText( _weaponCfg >> "name" ),
				getText( _weaponCfg >> "muzzle" ),
				getText( _weaponCfg >> "flashlight" ),
				getText( _weaponCfg >> "optics" ),
				[ [], [
					getText( _weaponCfg >> "primaryMuzzleMag" >> "name" ),
					getNumber( _weaponCfg >> "primaryMuzzleMag" >> "ammoLeft" )
				] ] select ( isClass( _weaponCfg >> "primaryMuzzleMag" )),
				[ [], [
					getText( _weaponCfg >> "secondaryMuzzleMag" >> "muzzle" ),
					getNumber( _weaponCfg >> "secondaryMuzzleMag" >> "ammoLeft" )
				] ] select ( isClass( _weaponCfg >> "secondaryMuzzleMag" )) ,
				getText( _weaponCfg >> "underBarrel" )
			]
		};

	};

	{
		_nul = _loadout pushBack ( _x call _fnc_getWeaponDetails );
	}forEach [ "primaryWeapon", "secondaryWeapon", "handgun" ];


	//Containers
	private _fnc_getContainerDetails = {
		params[ "_container" ];

		_containerCfg = _invCfg >> _container;

		if !( isClass( _containerCfg ) ) then {
			[]
		}else{
			_containerType = getText( _containerCfg >> "typeName" );
			_items = [];
			{
				_cargoType = _x;
				{
					if ( _cargoType isEqualTo "MagazineCargo" ) then {
						_nul = _items pushBack [ getText( _x >> "name" ), getNumber( _x >> "count" ), getNumber( _x >> "ammoLeft" ) ];
					}else{
						_nul = _items pushBack [ getText( _x >> "name" ), getNumber( _x >> "count" ) ];
					};
				}forEach ( "true" configClasses ( _containerCfg >> _cargoType ));
			}forEach [ "MagazineCargo", "ItemCargo" ];

			[ _containerType, _items ]
		};
	};

	{
		_nul = _loadout pushBack ( _x call _fnc_getContainerDetails );
	}forEach [ "uniform", "vest", "backpack" ];

	_nul = _loadout pushBack getText( _invCfg >> "headgear" );
	_nul = _loadout pushBack getText( _invCfg >> "goggles" );
	_nul = _loadout pushBack ( "binocular" call _fnc_getWeaponDetails );

	//linked Items
	_nul = _loadout pushBack [
		getText( _invCfg >> "map" ),
		getText( _invCfg >> "gps" ),
		getText( _invCfg >> "radio" ),
		getText( _invCfg >> "compass" ),
		getText( _invCfg >> "watch" ),
		getText( _invCfg >> "hmd" )
	];

	_unit setUnitLoadout _loadout;
};



//**********
// OBJECT TYPES - functions to handle spawning of each item via their type
//**********

//*****
//GROUPS
//*****
private _fnc_spawnGroup = {
	private[ "_side", "_group", "_combatMode", "_behaviour", "_speedMode", "_formation" ];
	params[ "_cfg" ];

	_side = getText( _cfg >> "Side" );
	_group = call compile format[ "createGroup %1", _side ];

	_combatMode = getText( _cfg >> "Attributes" >> "combatMode" );
	_behaviour = getText( _cfg >> "Attributes" >> "behaviour" );
	_speedMode = getText( _cfg >> "Attributes" >> "speedMode" );
	_formation = getText( _cfg >> "Attributes" >> "formation" );
	_group setCombatMode _combatMode;
	_group setBehaviour _behaviour;
	_group setSpeedMode _speedMode;
	_group setFormation _formation;

	_garbageCollect = getNumber( _cfg >> "Attributes" >> "garbageCollect" );
	if ( _garbageCollect > 0 ) then {
		_group deleteGroupWhenEmpty true;
	};
	_dynamicSimulation = getNumber( _cfg >> "Attributes" >> "dynamicSimulation" );
	if ( _dynamicSimulation > 0 ) then {
		_group enableDynamicSimulation true;
	};

	{
		[ _x, _group ] call _fnc_spawnItems;
	}forEach ( "true" configClasses ( _cfg >> "Entities" ) );

	//DO we want to fix placement spawning of whole groups ????
//	{
//		_x setPosATL formationPosition _x;
//	}forEach units _group;

	//Save crewLinks until everything is spawned
	if ( isClass( _cfg >> "crewLinks" ) ) then {
		private[ "_unitID", "_vehID", "_role", "_turret", "_cargoIndex" ];
		{

			_unitID = getNumber( _x >> 'item0' );
			_vehID = getNumber( _x >> 'item1' );
			_role = getNumber( _x >> 'customData' >> 'role' );
			_turret = getArray( _x >> 'customData' >> 'turretPath' );
			_cargoIndex = [ ( _x >> 'customData' >> 'cargoIndex' ), 'NUM', -1 ] call _fnc_getCfgValue;

			_nul = _crewLinks pushBack [ _unitID, _vehID, _role, _turret, _cargoIndex ];

		}forEach ( "true" configClasses ( _cfg >> "crewLinks" >> "Links" ));
	};

	_group
};

//*****
//OBJECT
//*****
private _fnc_spawnObject = {
	private [ "_veh", "_isFlying", "_presence", "_preCondition", "_needsSurfaceUP" ];
	params[ "_cfg", "_group" ];

	_veh = objNull;
	_isFlying = false;
	_needsSurfaceUP = false;

	_presence = [ ( _cfg >> "Attributes" >> "presence" ), "NUM", 1 ] call _fnc_getCfgValue;
	_preCondition = [ ( _cfg >> "Attributes" >> "presenceCondition" ), "TXT", "true" ] call _fnc_getCfgValue; //TODO: does this need defering

	if ( random 1 <= _presence && { call compile _preCondition } ) then {
		private[ "_type", "_ATLOffset" ];

		_type = getText( _cfg >> "type" );

		_ATLOffset = getNumber( _cfg >> "atlOffset" );

		switch ( true ) do {

			case ( _type isKindOf "Man" ) : {
				private[ "_skill", "_rank" ];

				_veh = _group createUnit [ _type, [0,0,500], [], 0, "FORM" ];
				_veh enableSimulationGlobal false;

				_skill = [ ( _cfg >> "Attributes" >> "skill" ), "NUM", -1 ] call _fnc_getCfgValue;
				if ( _skill > -1 ) then {
					_veh setSkill _skill;
				};

				_rank = getText( _cfg >> "Attributes" >> "rank" );
				if !( _rank isEqualTo "" ) then {
					_veh setRank _rank;
				};

				if ( isClass( _cfg >> "Attributes" >> "Inventory" ) ) then {
					[ _cfg >> "Attributes" >> "Inventory", _veh ] call _fnc_getUnitInventory;

				};

			};

			case ( _type isKindOf "LandVehicle" ) : {
				private[ "_lock", "_fuel" ];

				_veh = createVehicle [ _type, [0,0,500], [], 0, "CAN_COLLIDE" ];
				_veh enableSimulationGlobal false;

				_lock = getText( _cfg >> "Attributes" >> "lock" );
				if !( _lock isEqualTo "" ) then {
					_veh setVehicleLock _lock
				};

				_fuel = [ ( _cfg >> "Attributes" >> "fuel" ), "NUM", 1 ] call _fnc_getCfgValue;
				_veh setFuel _fuel;

				_needsSurfaceUP = true;
			};

			case ( _type isKindOf "Air" ) : {
				private[ "_lock", "_fuel" ];

				_isFlying = _ATLOffset > 18;

				_veh = createVehicle [ _type, [0,0,500], [], 0, [ "NONE", "FLY" ] select _isFlying ];
				_veh enableSimulationGlobal false;

				_lock = getText( _cfg >> "Attributes" >> "lock" );
				if !( _lock isEqualTo "" ) then {
					_veh setVehicleLock _lock
				};

				_fuel = [ ( _cfg >> "Attributes" >> "fuel" ), "NUM", 1 ] call _fnc_getCfgValue;
				_veh setFuel _fuel;

				if ( _isFlying ) then {
					_veh engineOn true;
				}else{
					_needsSurfaceUP = true;
				};

			};

			default {
				_simpleObject = [ ( _cfg >> "Attributes" >> "createAsSimpleObject" ), "NUM", 0 ] call _fnc_getCfgValue;
				if ( _simpleObject > 0 ) then {
					_veh = createSimpleObject [ _type, [0,0,500] ];
				}else{
					_veh = createVehicle [ _type, [0,0,500], [], 0, "CAN_COLLIDE" ];
					_veh enableSimulationGlobal false;
				};
			};
		};

		if ( DEBUG_DEV ) then {
			[ _veh, [ 1, 0, 0, 1 ] ] call LARs_fnc_drawBounds;
		};

		private[ "_health", "_ammo", "_name", "_texture" ];

		_health = [ ( _cfg >> "Attributes" >> "health" ), "NUM", 1 ] call _fnc_getCfgValue;
		_veh setDamage ( 1 - _health );

		_ammo = [ ( _cfg >> "Attributes" >> "ammo" ), "NUM", 1 ] call _fnc_getCfgValue;
		_veh setVehicleAmmo _ammo;

		_name = getText( _cfg >> "Attributes" >> "name" );
		if !( _name isEqualTo "" ) then {
			_veh setVehicleVarName _name;
			missionNamespace setVariable [ _name, _veh ];
		};


		_texture = getText( _cfg >> "Attributes" >> "textures" );
		if !( _texture isEqualTo "" ) then {
			_veh setObjectTextureGlobal [ 0, _texture ];
		};

		private[ "_randomStartPos", "_position", "_rotation", "_placementRadius", "_init" ];

		_position = getArray( _cfg >> "PositionInfo" >> "position" );
		_rotation = [ ( _cfg >> "PositionInfo" >> "angles" ), "ARRAY", [0,0,0] ] call _fnc_getCfgValue;
		_randomStartPos = getArray( _cfg >> "randomStartPositions" );
		_placementRadius = getNumber( _cfg >> "Attributes" >> "placementRadius" );

		_position = [ _veh, _position, _rotation, _ATLOffset, _randomStartPos, _needsSurfaceUP, _placementRadius ] call _fnc_setPositionAndRotation;

		_ignoreTrigDynSym = [ ( _cfg >> "Attributes" >> "ignoreByDynSimulGrid" ), "NUM", 0 ] call _fnc_getCfgValue;
		if ( _ignoreTrigDynSym isEqualTo 0 ) then {
			_veh triggerDynamicSimulation true;
		};

		if ( typeOf _veh isKindOf "Man" ) then {
			( waypoints ( group _veh )) select 0 setWaypointPosition [ getPos _veh, 0 ];
		};

		_init = getText( _cfg >> "Attributes" >> "init" );
		if !( _init isEqualTo "" ) then {
			_nul = _inits pushBack [ _veh, format[ "this = _this; %1", _init ] ];
		};

		//enable simulation if not marked as disabled
		_disableSimulation = [ ( _cfg >> "Attributes" >> "disableSimulation" ), "NUM", 0 ] call _fnc_getCfgValue;
		if ( _disableSimulation isEqualTo 0 ) then {
			_veh enableSimulationGlobal true;
		};

	};

	_veh

};

//*****
//TRIGGERS
//*****
private _fnc_spawnTrigger = {
	private[ "_type", "_position", "_ATLOffset", "_rotation", "_varName", "_description", "_condition",
	"_onActivation", "_onDeactivation", "_sizeA", "_sizeB", "_sizeC", "_timeout", "_interuptable", "_repeatable" ];
	params[ "_cfg", [ "_defered", false ] ];

	//FIX for default grpNull passed from spawnItems
	if ( _defered isEqualType grpNull ) then { _defered = false };

	_type = getText( _cfg >> "type" );
	_position = getArray( _cfg >> "position" );
	_rotation = getNumber( _cfg >> "angle" );
	_ATLOffset = getNumber( _cfg >> "atlOffset" );

	_varName = getText( _cfg >> "Attributes" >> "name" );
	_description = getText( _cfg >> "Attributes" >> "text" );
	_condition = if !( _defered ) then {
		[ ( _cfg >> "Attributes" >> "condition" ), "TXT", "this" ] call _fnc_getCfgValue
	}else{
		//If trigger is defered due to connections TriggerOwner
		//set its condition to false until after connections are made
		"false"
	};
	_onActivation = getText( _cfg >> "Attributes" >> "onActivation" );
	_onDeactivation = getText( _cfg >> "Attributes" >> "onDeactivation" );
	_sizeA = getNumber( _cfg >> "Attributes" >> "sizeA" );
	_sizeB = getNumber( _cfg >> "Attributes" >> "sizeB" );
	_sizeC = getNumber( _cfg >> "Attributes" >> "sizeC" );
	_timeout = [ ( _cfg >> "Attributes" >> "timeout" ), "ARRAY", [ 0, 0, 0 ] ] call _fnc_getCfgValue;
	_interuptable = [false, true] select getNumber( _cfg >> "Attributes" >> "interuptable" );
	_repeatable = [false, true] select getNumber( _cfg >> "Attributes" >> "repeatable" );

	private[ "_activationBy", "_trig_type", "_isRectangle", "_effectCondition", "_effectSound", "_effectVoice", "_effectSoundEnvironment", "_effectSoundTrigger", "_effectMusic", "_effectTitle", "_trg" ];

//TODO: Hopefully done see connections TriggerOwner
	//Default to NONE if not defined it could possibly be waiting on a connection TriggerOwner
	_activationBy = [ ( _cfg >> "Attributes" >> "activationBy" ), "TXT", "NONE" ] call _fnc_getCfgValue;

	_trig_type = [ ( _cfg >> "Attributes" >> "type" ), "TXT", "PRESENT" ] call _fnc_getCfgValue;
	_isRectangle = [false, true] select getNumber( _cfg >> "Attributes" >> "isRectangle" );

	_effectCondition = getText( _cfg >> "Attributes" >> "effectCondition" );
	_effectSound = getText( _cfg >> "Attributes" >> "effectSound" );
	_effectVoice = getText( _cfg >> "Attributes" >> "effectVoice" );
	_effectSoundEnvironment = getText( _cfg >> "Attributes" >> "effectSoundEnvironment" );
	_effectSoundTrigger = getText( _cfg >> "Attributes" >> "effectSoundTrigger" );
	_effectMusic = getText( _cfg >> "Attributes" >> "effectMusic" );
	_effectTitle = getText( _cfg >> "Attributes" >> "effectTitle" );


	_trg = createTrigger[ _type, [0,0,0], true ];
	//_trg setPosWorld _position;
	//_position = [ _position, _ATLOffset ] call _fnc_getPosition;
	_position = [ _trg, _position, [0,0,0], _ATLOffset ] call _fnc_setPositionandRotation;
	_trg setTriggerArea [ _sizeA, _sizeB, _rotation, _isRectangle, _sizeC ];
	if !( _varName isEqualTo "" ) then {
		_trg setVehicleVarName _varname;
		missionNamespace setVariable [ _varName, _trg, true ];
	};
	_trg setTriggerText _description;
	_trg setTriggerStatements [ _condition, _onActivation, _onDeactivation ];
	_trg setTriggerActivation [ _activationBy, _trig_type, _repeatable ];
	_trg setTriggerTimeout ( _timeout + [ _interuptable ] );

	//TODO: Needs testing
	_trg setEffectCondition _effectCondition;
	_trg setSoundEffect [ _effectSound, _effectVoice, _effectSoundEnvironment, _effectSoundTrigger ];
	_trg setMusicEffect _effectMusic;
	switch ( true ) do {
		case ( isClass( missionConfigFile >> "RscTitles" >> _effectTitle ) ) : {
			_trg setTitleEffect [ "RES", "", _effectTitle ];
		};
		case ( isClass( configFile >> "CfgTitles" >> _effectTitle ) ) : {
			_trg setTitleEffect [ "OBJECT", "", _effectTitle ];
		};
		default {
			if ( _effectTitle != "" ) then {
				_trg setTitleEffect [ "TEXT", "PLAIN", _effectTitle ];
			};
		};
	};

	_trg
};

//*****
//LOGICS
//*****
private _fnc_spawnLogic = {
	private[ "_presence", "_preCondition" ];
	private _logic = objNull;
	params[ "_cfg" ];

	_presence = [ ( _cfg >> "presence" ), "NUM", 1 ] call _fnc_getCfgValue;
	_preCondition = [ ( _cfg >> "presenceCondition" ), "TXT", "true" ] call _fnc_getCfgValue; //TODO: does this need defering

	if ( random 1 <= _presence && { call compile _preCondition } ) then {
		private [ "_type", "_position", "_ATLOffset", "_rotation", "_varName", "_group", "_init" ];

		_type = getText( _cfg >> "type" );
		_position = [ ( _cfg >> "PositionInfo" >> "position" ), "ARRAY", [0,0,0] ] call _fnc_getCfgValue;
		_ATLOffset = getNumber( _cfg >> "atlOffset" );
		_rotation = [ ( _cfg >> "PositionInfo" >> "angles" ), "ARRAY", [0,0,0] ] call _fnc_getCfgValue;
		_varName = getText( _cfg >> "name" );

		//FIX: Seems to not to be saved in the composition ??
		//_placementRadius = getNumber( _cfg >> "Attributes" >> "placementRadius" );

		//TODO: Split logics into proper module grps
		_group = group bis_functions_mainscope;
		_logic = _group createUnit [ _type, [0,0,0], [], 0, "CAN_COLLIDE" ]; //No randomStart for logics

		_position = [ _logic, _position, _rotation, _ATLOffset ] call _fnc_setPositionandRotation;

		if !( _varName isEqualTo "" ) then {
			_logic setVehicleVarName _varName;
			missionNamespace setVariable [ _varName, _logic, true ];
		};

		_init = getText( _cfg >> "init" );
		_nul = _inits pushBack [ _logic, format[ "this = _this; %1", _init ] ];

	};

	_logic
};

//*****
//MARKERS
//*****
private _fnc_spawnMarker = {
	private [ "_position", "_name", "_text", "_markerType", "_type", "_colorName", "_alpha", "_fill", "_sizeA", "_sizeB", "_angle", "_id", "_mrk" ];
	params[ "_cfg" ];

	_position = getArray( _cfg >> "position" );
	//_position = [ _position ] call _fnc_getPosition;
	_position = [ objNull, _position ] call _fnc_setPositionandRotation;
	_name = getText( _cfg >> "name" );
	_text = getText( _cfg >> "text" );
	_markerType = getText( _cfg >> "markerType" );
	_type = getText( _cfg >> "type" );
	_colorName = getText( _cfg >> "colorName" );
	_alpha = [ ( _cfg >> "alpha" ), "NUM", 1 ] call _fnc_getCfgValue;

	_fill = getText( _cfg >> "fillName" );
	_sizeA = getNumber( _cfg >> "a" );
	_sizeB = getNumber( _cfg >> "b" );
	_angle = getNumber( _cfg >> "angle" );
	_id = getNumber( _cfg >> "id" );


	_mrk = createMarker[ _name, _position ];
	_mrk setMarkerDir _angle;
	_mrk setMarkerText _text;
	_mrk setMarkerSize [ _sizeA, _sizeB ];
	if !( _markerType isEqualTo "" ) then {
		_mrk setMarkerShape _markerType;
		if !( _fill isEqualTo "" ) then {
			_mrk setMarkerBrush _fill;
		};
	}else{
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType _type;
	};
	if !( _colorName isEqualTo "" ) then {
		_mrk setMarkerColor _colorName;
	};
	_mrk setMarkerAlpha _alpha;

	_mrk
};

//*****
//WAYPOINTS
//*****
private _fnc_spawnWaypoint = {
	private [ "_position", "_ATLOffset", "_placement", "_compRadius", "_mode", "_formation", "_speed", "_behaviour", "_description", "_condition" ];
	params[ "_cfg", "_group" ];

	_position = getArray( _cfg >> "position" );
	_ATLOffset = getNumber( _cfg >> "atlOffset" );
	//_position = [ _position, _ATLOffset ] call _fnc_getPosition;
	_position = [ objNull, _position, [0,0,0], _ATLOffset ] call _fnc_setPositionandRotation;
	_placement = getNumber( _cfg >> "placement" );
	_compRadius = getNumber( _cfg >> "completitionRadius" );
	_mode = getText( _cfg >> "combatMode" );
	_formation = getText( _cfg >> "formation" );
	_speed = getText( _cfg >> "speed" );
	_behaviour = getText( _cfg >> "combat" );
	_description = getText( _cfg >> "description" );
	_condition = [ ( _cfg >> "expCond" ), "TXT", "true" ] call _fnc_getCfgValue; //TODO: does this need defering

	private [ "_onAct", "_name", "_script", "_timeout", "_show", "_type" ];

	_onAct = getText( _cfg >> "expActiv" );
	_name = getText( _cfg >> "name" );
	_script = getText( _cfg >> "script" );
	_timeout = [ getNumber( _cfg >> "timeoutMin" ), getNumber( _cfg >> "timeoutMid" ), getNumber( _cfg >> "timeoutMax" ) ];
	_show = getText( _cfg >> "showWP" );
	_type = getText( _cfg >> "type" );

	private [ "_effectCondition", "_effectSound", "_effectVoice", "_effectSoundEnvironment", "_effectMusic", "_effectTitle", "_wp" ];

	_effectCondition = getText( _cfg >> "Effects" >> "condition" ); //TODO: does this need defering
	_effectSound = getText( _cfg >> "Effects" >> "sound" );
	_effectVoice = getText( _cfg >> "Effects" >> "voice" );
	_effectSoundEnvironment = getText( _cfg >> "Effects" >> "soundEnv" );
	_effectMusic = getText( _cfg >> "Effects" >> "track" );
	_effectTitle = getText( _cfg >> "Effects" >> "title" );

	_wp = _group addWaypoint[ ASLToATL _position, _placement, count waypoints _group, _name];
	_wp setWaypointType _type;
	_wp setWaypointCompletionRadius _compRadius;
	_wp setWaypointCombatMode _mode;
	_wp setWaypointFormation _formation;
	_wp setWaypointSpeed _speed;
	_wp setWaypointBehaviour _behaviour;
	_wp setWaypointDescription _description;
	_wp setWaypointStatements[ _condition, _onAct ];
	_wp setWaypointTimeout _timeout;
	_wp showWaypoint _show;
	_wp setWaypointScript _script;

	//TODO: Effects need testing
	_wp setEffectCondition _effectCondition;
	_wp setSoundEffect [ _effectSound, _effectVoice, _effectSoundEnvironment, "" ];
	_wp setMusicEffect _effectMusic;
	switch ( true ) do {
		case ( isClass( missionConfigFile >> "RscTitles" >> _effectTitle ) ) : {
			_wp setTitleEffect [ "RES", "", _effectTitle ];
		};
		case ( isClass( configFile >> "CfgTitles" >> _effectTitle ) ) : {
			_wp setTitleEffect [ "OBJECT", "", _effectTitle ];
		};
		default {
			if ( _effectTitle != "" ) then {
				_wp setTitleEffect [ "TEXT", "PLAIN", _effectTitle ];
			};
		};
	};

	_wp
};



//**********
//Main
//**********

private _fnc_spawnItems = {
	private[ "_id", "_dataType", "_msg", "_obj" ];
	params[ "_cfg", [ "_info", grpNull ] ]; //INFO is usually a group but is also used by triggers as a defered boolean flag

	_id = getNumber( _cfg >> 'id' );

	if ( count _ids <= _id ) then {
		_ids resize _id;
	};

	_dataType = getText( _cfg >> "dataType" );

	_msg = format[ "spawning - %1 %2 - ID: %3", _dataType, getText( _cfg >> "type" ), _id ];

	switch ( _dataType ) do {

		case "Group" : {
			_obj = [ _cfg ] call _fnc_spawnGroup;
			_msg = format[ "%1, GroupID %2", _msg, groupID _obj ];
		};

		case "Object" : {
			_obj = [ _cfg, _info ] call _fnc_spawnObject;
			if !( vehicleVarName _obj isEqualTo "" ) then {
				_msg = format[ "%1, VarName %2", _msg, vehicleVarName _obj ];
			};
		};

		case "Trigger" : {
			_obj = [ _cfg, _info ] call _fnc_spawnTrigger;
			if !( vehicleVarName _obj isEqualTo "" ) then {
				_msg = format[ "%1, VarName %2", _msg, vehicleVarName _obj ];
			};
		};

		case "Logic" : {
			_obj = [ _cfg ] call _fnc_spawnLogic;
			if !( vehicleVarName _obj isEqualTo "" ) then {
				_msg = format[ "%1, VarName %2", _msg, vehicleVarName _obj ];
			};
		};

		case "Marker" : {
			_obj = [ _cfg ] call _fnc_spawnMarker;
			_msg = format[ "%1, Name %2", _msg, str _obj ];
		};

		case "Waypoint" : {
			_obj = [ _cfg, _group ] call _fnc_spawnWaypoint;
			if !( waypointName _obj isEqualTo "" ) then {
				_msg = format[ "%1, WaypointID %2", _msg, waypointName _obj ];
			};
		};

		case "Layer" : {
			[ ( _cfg >> "Entities" ) ] call _fnc_spawnItems;
		};
	};

	if !( isNil	"_obj" ) then {
		_ids set [ _id, _obj ];
		if ( ( _obj isEqualType objNull ) && { !isNull _obj } ) then {
			[ _obj, _cfg ] call _fnc_CustomAttributes;
		};
	};

	DEBUG_MSG( DEBUG, _msg );

};

//**********
//For each of the items to spawn, spawn them in priority order
//**********
DEBUG_MSG( DEBUG, "ITEMS" );
private [ "_pType", "_dataType" ];
{
	_pType = _x;
	{
		_dataType = getText( _x >> "dataType" );
		if ( _dataType == _pType ) then {
			[ _x ] call _fnc_spawnItems;
		};
	}forEach _itemCfgs;
}forEach _priority;

//**********
//Spawn each of our groups to spawn
//**********
DEBUG_MSG( DEBUG, "GROUPS" );
{
	[ _x ] call _fnc_spawnItems;
}forEach _groupCfgs;


//**********
//For each of the defered items to spawn, spawn them in priority order
//**********
//Items are defered if their id is in a connection or they belong to a defered group
DEBUG_MSG( DEBUG, "DEFERED ITEMS" );
{
	_pType = _x;
	{
		_dataType = getText( _x >> "dataType" );
		if ( _dataType == _pType ) then {
			[ _x ] call _fnc_spawnItems;
		};
	}forEach _deferedItems;
}forEach _priority;


//**********
//Spawn each of the defered groups to spawn
//**********
//Groups are defered if they have crewLinks or a unit of the group has a random start pos
DEBUG_MSG( DEBUG, "DEFERED GROUPS" );
{
	[ _x ] call _fnc_spawnItems;
}forEach _deferedGrps;

//**********
//Spawn each of the defered triggers to spawn
//**********
//Triggers are defered if they are in connections of type TriggerOwner
DEBUG_MSG( DEBUG, "DEFERED TRIGGERS" );
{
	[ _x, true ] call _fnc_spawnItems;
}forEach _deferedTrgs;


//**********
//Do crew positions
//**********
DEBUG_MSG( DEBUG, "CREW LINKS" );
private [ "_unit", "_veh" ];
{
	_x params[ "_unitID", "_vehID", "_role", "_turret", "_cargoIndex" ];

	_unit = _ids select _unitID;
	_veh = _ids select _vehID;

	switch ( true ) do {
		case ( count _turret > 0 ) : {
			_unit moveInTurret [ _veh, _turret ];
		};
		case ( _cargoIndex > -1 ) : {
			_unit moveInCargo [ _veh, _cargoIndex ];
		};
		default {
			_unit moveInDriver _veh;
		};
	};
}forEach _crewLinks;


//**********
//Synchronise all of the connections
//**********
DEBUG_MSG( DEBUG, "CONNECTIONS" );
if ( isClass( missionConfigFile >> "CfgCompositions" >> _compName >> "connections" ) ) then {
	private [ "_connectionType", "_fromID", "_toID", "_from", "_to" ];

	{
		_connectionType = getText ( _x >> "CustomData" >> "type" );
		_fromID = getNumber( _x >> "item0" );
		_toID = getNumber( _x >> "item1" );
		_from = _ids select _fromID;
		_to = _ids select _toID;

		if ( !isNil "_from" && !isNil "_to" ) then {

			switch ( _connectionType ) do {

				case 'WaypointActivation' : {
					private [ "_trg", "_wp" ];

					if ( { !( _x isEqualType [] ) }count[ _from, _to ] > 0 ) then {
						_trg = {
							if !( _x isEqualType [] ) exitWith { _x };
						}forEach [ _from, _to ];
						_wp = ( [ _from, _to ] - [ _trg ] ) select 0;
						_trg synchronizeTrigger [ _wp ];
					}else{
						_from synchronizeWaypoint [ _to ];
					};
				};

				case 'Sync' : {
					_from synchronizeObjectsAdd [ _to ];
				};

				case "RandomStart" : {

				};

				case "TriggerOwner" : {
					private [ "_info", "_trg", "_owner", "_type", "_act", "_condition", "_cond" ];

					_info = {
						if ( typeOf _x isEqualTo "EmptyDetector" ) exitWith { [ _x, _forEachIndex ] };
					}forEach [ _from, _to ];
					_trg = _info select 0;
					_owner = ( [ _from, _to ] - [ _trg ] ) select 0;
					( _objects select ( [ _toID, _fromID ] select ( _info select 1 )))params[ "_id", "_cfg" ];
					_type = [ ( _cfg >> "Attributes" >> "activationByOwner" ), "TXT", "VEHICLE" ] call _fnc_getCfgValue;
					_act = triggerActivation _trg;
					_act set [ 0, _type ];
					_condition = [ ( _cfg >> "Attributes" >> "condition" ), "TXT", "this" ] call _fnc_getCfgValue;
					_cond = triggerStatements _trg;
					_cond set [ 0, _condition ];
					if ( _type isEqualTo "STATIC" ) then {
						_trg triggerAttachObject [ _owner ];
					}else{
						_trg triggerAttachVehicle [ _owner ];
					};
					_trg setTriggerActivation _act;
					_trg setTriggerStatements _cond;
				};
			};
		}else{
			//Should never happen as we drop missing links whilst sorting
			//diag_log format[ "connection object missing - Fid: %1, F: %2, Tid: %3, T: %4", _fromID, _from, _toID, _to ];
		};
	}forEach ( "true" configClasses ( missionConfigFile >> "CfgCompositions" >> _compName >> "connections" >> "Links" ) );
};

//**********
//Run all OBJECTs init codes
//**********
DEBUG_MSG( DEBUG, "INITS" );
{
	_x params [ "_obj", "_code" ];
	_obj call compile _code;
}forEach _inits;

_msg = format[ "Composition %1 Done!!", str _compName ];
DEBUG_MSG( DEBUG, _msg );

_ids