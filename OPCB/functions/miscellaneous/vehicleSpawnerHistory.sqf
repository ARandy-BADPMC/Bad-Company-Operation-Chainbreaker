disableSerialization;
createDialog "vehicleSpawnerHistory";

waitUntil {
  !isNull (findDisplay 74818) && { !(isNil "OPCB_econ_initDone") && {OPCB_econ_initDone}}
};

private _display = findDisplay 74818;

_header = _display displayCtrl 20000;
_header ctSetRowTemplate ( missionConfigFile >> "FalseHeaderRow" );
ctAddRow _header params [ "_rowIndex", "_rowCtrls" ];

_rowCtrls params [ "_backGround", "_playerH", "_vehicleH", "_creditH"];

_backGround ctrlSetBackgroundColor [ 0.1, 0.1, 0.1, 1 ];

{
	_x params [ "_header", "_text" ];

	_header ctrlSetText _text;
}forEach [
	[ _playerH, "Player" ],
	[ _vehicleH, "Vehicle" ],
	[ _creditH, "Cost" ]
];

_table = _display displayCtrl 30000;
_table ctSetRowTemplate( missionConfigFile >> "DataRow" );

{
	_x params [ "_playerName", "_vehicleName", "_credit" ];

	ctAddRow _table params [ "_rowIndex", "_rowCtrls" ];
	_rowCtrls params [ "", "_playerNameCtrl", "_vehicleCtrl", "_creditCtrl" ];

	_vehicleCtrl ctrlSetBackgroundColor [ 0.16, 0.16, 0.16, 1 ];

	_playerNameCtrl ctrlSetText _playerName;
	_vehicleCtrl ctrlSetText str _vehicleName;
	_creditCtrl ctrlSetText str _credit;
}forEach VehicleSpawnerHistory;