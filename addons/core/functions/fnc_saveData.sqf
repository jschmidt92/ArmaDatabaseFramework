#include "script_component.hpp"

/*
 * Function: adf_core_fnc_saveData
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
 * Save data in missionProfileNamespace using specified key, value, and slot.
 *
 * Arguments:
 * 0: Name of key <STRING> (default: "")
 * 1: Value to save in key <ARRAY|STRING|SCALAR|BOOL|HASHMAP> (default: "")
 * 2: Slot number to save value to <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["name", name player, 1] call adf_core_fnc_saveData
 * ["rating", rating player, 2] call adf_core_fnc_saveData
 *
 * Public: Yes
 */

diag_log _this;

params [["_key", "", [""]], ["_value", "", [[], 0, "", false, createHashMap]], ["_slot", 0, [0]]];

private _hashKey = format ["%1.%2.%3", EGVAR(db,prefix), _slot, _key];
private _hashMap = createHashMapFromArray _value;

_hashMap set ["hashKey", _hashKey];

missionProfileNamespace setVariable [_hashKey, _hashMap];
[EGVAR(db,debug), "adf_core_fnc_saveData", format ["Saved data to '%1'.", _hashKey], true] call DEFUNC(utils,debug);