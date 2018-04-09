private ["_myDictionary", "_keys", "_values"];

_myDictionary = call Dictionary_fnc_new;

if (!(isNull ([_myDictionary, "foo"] call Dictionary_fnc_get))) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
[_myDictionary, "foo", "bar"] call Dictionary_fnc_set;
if (!([_myDictionary, "foo"] call Dictionary_fnc_get == "bar")) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!([_myDictionary, "foo"] call Dictionary_fnc_containsKey)) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!(!([_myDictionary, "bar"] call Dictionary_fnc_containsKey))) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!(!([_myDictionary, "foo"] call Dictionary_fnc_containsValue))) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!([_myDictionary, "bar"] call Dictionary_fnc_containsValue)) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!(!(_myDictionary call Dictionary_fnc_isEmpty))) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!(_myDictionary call Dictionary_fnc_size == 1)) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
_keys = _myDictionary call Dictionary_fnc_keys;
if (!(count _keys == 1 && _keys select 0 == "foo")) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
_values = _myDictionary call Dictionary_fnc_values;
if (!(count _values == 1 && _values select 0 == "bar")) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!(isNull ([_myDictionary, "bar"] call Dictionary_fnc_remove))) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!(_myDictionary call Dictionary_fnc_size == 1)) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!([_myDictionary, "foo"] call Dictionary_fnc_remove == "bar")) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };
if (!(_myDictionary call Dictionary_fnc_size == 0)) exitWith { hint format ["Test in line %1 failed.", __LINE__]; };

hint "Test completed without errors! : )";