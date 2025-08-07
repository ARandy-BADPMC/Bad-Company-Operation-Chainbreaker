[] spawn {
    private _wasInside = false; 

    while {true} do {
        private _inside = player inArea ShopRS;

        if (_inside) then {
            private _isZoneListed = player getVariable ["zonelisted", false];

            private _squadParams = squadParams player;
            private _clanUnit = "";
            if (!isNil "_squadParams" && {count _squadParams > 0 && {count (_squadParams select 0) > 0}}) then {
                _clanUnit = (_squadParams select 0) select 0;
            };

            private _unitWhitelist = ["Bad Co", "B.A.D. PMC"];
            private _isClanWL = _clanUnit in _unitWhitelist;

            if (!(_isZoneListed || _isClanWL)) then {
                hint "You are not authorized to enter. Apply via Discord.";
                sleep 3;
                player setPos (getMarkerPos "thrown_out");
            } else {
                if (!_wasInside) then { 
                    hint "Welcome whitelisted player to the store!";
                };
            };
        };

        _wasInside = _inside;
        sleep 2;
    };
};
