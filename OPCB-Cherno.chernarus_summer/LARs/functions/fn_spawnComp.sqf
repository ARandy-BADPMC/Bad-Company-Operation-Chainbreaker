//Entry function - calls function to spawn composition and handles composition references

//Composition spawning is designed to be used via the server
//If we are not the server exit with error
if !( isServer ) exitWith {
	"LARs_fnc_spawnComp must be called on the server" call BIS_fnc_error;
	objNull
};

private[ "_objects", "_index", "_compReference" ];
params[ "_compName" ];

//If the data structure for spawned compositions is Nil then we are spawning a comp for the first time
if ( isNil "LARs_spawnedCompositions" ) then {
	//Initialise data structure array
	LARs_spawnedCompositions = [];
};

//Call function to spawn composition
_objects = _this call LARs_fnc_createComp;

//For each of the objects returned that the composition spawned
{
	//Some index will be blank as objects are placed in the array according to their Eden ID
	//If it is not blank
	if !( isNil "_x" ) then {
		//Set the index as [ Eden ID, OBJECT ]
		_objects set [ _forEachIndex, [ _forEachIndex, _x ] ];
	}else{
		//Otherwise fill it with null
		_objects set [ _forEachIndex, objNull ];
	};
}forEach _objects;

//Remove all null elements from the objects array
_objects = _objects - [ objNull ];

//Find a blank index in the data structure to store a reference to the spawned composition
_index = {
	if ( isNil "_x" ) exitWith { _forEachIndex };
}forEach LARs_spawnedCompositions;

//If we dont have a blank index
if ( isNil "_index" ) then {

	//Format a reference STRING for this composition using its name and index in the data structure
	_compReference = format[ "%1_%2", _compName, count LARs_spawnedCompositions ];

	//Add it to the end of the data structure as an array of [ reference name, objects spawned ]
	_nul = LARs_spawnedCompositions pushBack [ _compReference, _objects ];

}else{

	//Format a reference STRING for this composition using its name and index in the data structure
	_compReference = format[ "%1_%2", _compName, _index ];

	//Insert it into the blank position as an array of [ reference name, objects spawned ]
	LARs_spawnedCompositions set [ _index, [ _compReference, _objects ] ];
};

//Return reference to user
_compReference