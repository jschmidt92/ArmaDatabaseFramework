#include "script_component.hpp"

/*
 * Function: adf_core_fnc_loadData
 * Author: NikolaiF90, J.Schmidt
 * Edit: 07.27.2024
 * Copyright © 2024 NikolaiF90, J.Schmidt, All rights reserved
 *
 * Do not edit without permission!
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivative 4.0 International License.
 * To view a copy of this license, vist https://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons,
 * PO Box 1866, Mountain View, CA 94042
 *
 * [Description]
 * Save data in profileNamespace using specified key, value, and slot.
 *
 * Arguments:
 * 0: Name of key <STRING|ARRAY> (default: "")
 * - 0: Name of key <STRING>
 * - 1: Default Value if isNil key <ARRAY|STRING|SCALAR|BOOL>
 * 2: Slot number to save value to <SCALAR> (default: 0)
 *
 * Return Value:
 * The return value <ARRAY|STRING|SCALAR|BOOL|HASHMAP>
 *
 * Examples:
 * ["name", 1] call adf_core_fnc_loadData
 * [["name", name player], 1] call adf_core_fnc_loadData
 *
 * Public: Yes
 */

params [["_key", "", [""]], ["_slot", 0, [0]]];

private ["_result", "_return", "_value"];

if (_key isEqualType "") then {
    _result = format ["%1.%2.%3", EGVAR(db,prefix), _slot, _key];
    _return = missionProfileNamespace getVariable _result;
};

if (_key isEqualType []) then {
    _result = format ["%1.%2.%3", EGVAR(db,prefix), _slot, _key # 0];
    _return = missionProfileNamespace getVariable [_result, _key # 1];
};

[EGVAR(db,debug), "adf_core_fnc_loadData", text format ["Key loaded '%1'.", _key], true] call DEFUNC(utils,debug);

_return;