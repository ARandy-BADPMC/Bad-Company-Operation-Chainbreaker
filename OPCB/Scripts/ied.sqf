iedMkr = ["ied","ied1"];	//List of markers to spawn IEDs in
iedNum = 10;								//Number of IEDs per marker, defined in iedMkr	[Default: 5]
iedDmg = false;							//Can the IED be killed with weapons?			[Default: false] TRUE = Yes | FALSE = Can only be disarmed
Dbug = false;								//Show IED markers on map?						[Default: false]

//!!DO NOT EDIT BELOW!!
iedBlast=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","HelicopterExploSmall"];
iedList=["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];
iedAmmo=["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo"];
iedJunk=["Land_Garbage_square3_F","Land_Garbage_square5_F","Land_Garbage_line_F"];
if(!Dbug) then {
	{
		_x setMarkerAlpha 0;
	}
	forEach iedMkr;
};

iedAct = {
	params ["_iedObj"];
	if(mineActive _iedObj) then {
		_iedBlast= selectRandom iedBlast;
		createVehicle[_iedBlast,(getPosATL _iedObj),[],0,""];
		createVehicle["Crater",(getPosATL _iedObj),[],0,""];

		{
			deleteVehicle _x;
		} forEach nearestObjects[getPosATL _iedObj,iedJunk,4];

		deleteVehicle _iedObj;
	};
};

{
	private["_trig"];
	_iedArea = getMarkerSize _x select 0;
	_iedRoad = ((getMarkerPos _x)nearRoads _iedArea);

	for "_i" from 1 to iedNum do {

		_iedR = selectRandom _iedRoad;
		_roadInfo = getRoadInfo _iedR;
		_roadWidth = _roadInfo select 1; 
		_roadBegPos = _roadInfo select 6;
		_roadEndPos = _roadInfo select 7;
		_roadDir = _roadBegPos getDir _roadEndPos;
		_roadHalf = _roadBegPos getPos [(_roadBegPos distance2D _roadEndPos) / 2, _roadDir];
		_roadSide = _roadHalf getPos [ (_roadWidth/2) + 3, _roadDir + 90];

		_ied = selectRandom iedList;
		_junk = selectRandom iedJunk;
		_ied = createMine[_ied, _roadSide,[],0];
		_ied setPosATL(getPosATL _ied select 2+1);
		_ied setDir(random 359);
		_ied allowDamage iedDmg;

		if(round(random 2)==1)then {
			_iedJunk= createVehicle[_junk,getPosATL _ied,[],0,""];
			_iedJunk setPosATL(getPosATL _iedJunk select 2+1);
			_iedJunk enableSimulationGlobal false;
		};
		_jnkR=selectRandom _iedRoad;
		_junk=createVehicle[_junk,getPosATL _jnkR,[],8,""];
		_junk setPosATL(getPosATL _junk select 2+1);
		_junk enableSimulationGlobal false;
		_trig=createTrigger["EmptyDetector",getPosATL _ied];
		_trig setTriggerArea[10,10,0,FALSE,10];
		_trig setTriggerActivation["ANY","PRESENT",false];
		_trig setTriggerTimeout[1,1,1,true];
		if(isMultiplayer)then {
			_trig setTriggerStatements[
				"{vehicle _x in thisList && speed vehicle _x>4}count playableUnits>0",
				"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
				"deleteVehicle thisTrigger"];
		}else {
			_trig setTriggerStatements[
				"{vehicle _x in thisList && isPlayer vehicle _x && speed vehicle _x>4}count allUnits>0",
				"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
				"deleteVehicle thisTrigger"];
		};

		if(Dbug)then {
			_iedPos = getPosWorld _ied;
			_mkrID = format["m %1",_iedPos];
			_mkr = createMarker[_mkrID,getPosWorld _ied];
			_mkr setMarkerShape "ICON";
			_mkr setMarkerType "mil_dot";
			_mkr setMarkerBrush "Solid";
			_mkr setMarkerAlpha 1;
			_mkr setMarkerColor "ColorEast";
		};
	};
}forEach iedMkr;

sleep 5;
{
	CIVILIAN revealMine _x;
	EAST revealMine _x;
	resistance revealMine _x;
} forEach allMines;