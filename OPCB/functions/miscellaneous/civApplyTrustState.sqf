params ["_civilian"];
if (!isServer || {isNull _civilian} || {!alive _civilian}) exitWith {};

private _relation = missionNamespace getVariable ["OPCB_civRelation", 50];
private _wantPistol = _relation < 40;
private _wantRifle = _relation < 30;
private _pistol = "rhsusf_weap_m1911a1";
private _rifle = "rhs_weap_m38";

private _setWeapon = {
    params ["_unit", "_weapon", "_give"];
    private _has = _weapon in (weapons _unit);
    if (_give && !_has) then {
        private _mag = (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) param [0, ""];
        if (_mag != "") then {
            for "_i" from 1 to 4 do { _unit addMagazine _mag; };
            _unit addWeapon _weapon;
        };
    };
    if (!_give && _has) then {
        _unit removeWeapon _weapon;
        private _mags = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
        { _unit removeMagazines _x; } forEach _mags;
    };
};

[_civilian, _pistol, _wantPistol] call _setWeapon;
[_civilian, _rifle, _wantRifle] call _setWeapon;

private _homeGroup = _civilian getVariable ["OPCB_civHomeGroup", grpNull];
private _hostile = _civilian getVariable ["OPCB_civHostile", false];

if (_wantPistol && !_hostile) then {
    private _hostileGroup = createGroup [east, true];
    [_civilian] joinSilent _hostileGroup;
    _hostileGroup setBehaviour "COMBAT";
    _hostileGroup setCombatMode "RED";
    _civilian selectWeapon (if (_wantRifle) then { _rifle } else { _pistol });
    _civilian setVariable ["OPCB_civHostile", true];
    {
        _civilian setSkill [_x, 0.3];
    } forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "reloadSpeed", "courage"];
    [_civilian] spawn {
        params ["_civilian"];
        while {alive _civilian && {_civilian getVariable ["OPCB_civHostile", false]}} do {
            private _targets = (allPlayers select {side group _x == west && {alive _x} && {_x distance2D _civilian < 600}}) apply {[_x distance2D _civilian, _x]};
            _targets sort true;
            if (_targets isNotEqualTo []) then {
                private _target = (_targets select 0) select 1;
                (group _civilian) reveal [_target, 4];
                _civilian doTarget _target;
                _civilian doMove (getPosATL _target);
            };
            sleep 10;
        };
    };
};

if (!_wantPistol && _hostile) then {
    private _oldGroup = group _civilian;
    if (!isNull _homeGroup) then {
        [_civilian] joinSilent _homeGroup;
        _homeGroup setBehaviour "SAFE";
    };
    if (count units _oldGroup == 0) then { deleteGroup _oldGroup; };
    _civilian setVariable ["OPCB_civHostile", false];
};
