null = [] spawn {
    waitUntil {
        !isNil { player getVariable "InitDone" } &&
        { player getVariable ["InitDone", false] }
    };

    // Now safe to check zone access:
    private _isZoneListed = player getVariable ["zonelisted", false];
    private _squadParams = squadParams player;
    private _clanUnit = "";

    if (!isNil "_squadParams" && {count _squadParams > 0 && count (_squadParams select 0) > 0}) then {
        _clanUnit = (_squadParams select 0) select 0;
    };

    private _unitWhitelist = ["Bad Co", "B.A.D. PMC"];
    private _isClanWL = _clanUnit in _unitWhitelist;

    if (!(_isZoneListed || _isClanWL)) then {
        hint "You are not authorized to enter. Apply via Discord.";
        sleep 3;
        player setPos (getMarkerPos "thrown_out");
    } else {
        hint "Welcome whitelisted player to the store!";
    };
};
