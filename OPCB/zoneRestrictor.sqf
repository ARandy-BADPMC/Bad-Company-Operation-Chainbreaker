if (!hasInterface) exitWith {};

waitUntil {
    sleep 1;
    !isNull player && {player getVariable ["InitDone", false]}
};

{
    _x spawn {
        params ["_trigger", "_isShop"];
        private _wasInside = false;
        private _lastUnit = objNull;

        while {true} do {
            private _unit = player;
            if (_unit != _lastUnit) then {
                _wasInside = false;
                _lastUnit = _unit;
            };

            private _inside = alive _unit && {_unit inArea _trigger};
            if (_inside && {!_wasInside}) then {
                private _clanUnit = "";
                private _squadParams = squadParams _unit;
                if (count _squadParams > 0 && {count (_squadParams select 0) > 0}) then {
                    _clanUnit = (_squadParams select 0) select 0;
                };

                private _isClanMember = _clanUnit in ["Bad Co", "B.A.D. PMC"];
                private _authorized = _isClanMember || {_isShop && {_unit getVariable ["zonelisted", false]}};

                if (_authorized) then {
                    if (_isShop) then {
                        hint "Welcome whitelisted player to the store!";
                    } else {
                        if (_clanUnit == "B.A.D. PMC") then {
                            hint "Welcome B.A.D. PMC member to the BadCo base!";
                        } else {
                            hint "Welcome B.A.D. Co member to the BadCo base!";
                        };
                    };
                } else {
                    hint (if (_isShop) then {
                        "You are not authorized to enter. Apply via Discord."
                    } else {
                        "Warning! You're entering a restricted area and will be teleported!"
                    });
                    [_unit, _trigger] spawn {
                        params ["_unit", "_trigger"];
                        sleep 3;
                        if (player == _unit && {alive _unit} && {_unit inArea _trigger}) then {
                            _unit setPos (getMarkerPos "thrown_out");
                        };
                    };
                };
            };

            _wasInside = _inside;
            sleep 0.5;
        };
    };
} forEach [[BadCoRestrictedZone1, false], [BadCoRestrictedZone2, false], [ShopRS, true]];
