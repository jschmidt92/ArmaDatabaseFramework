#include "script_component.hpp"

/*
 * Function: adf_db_fnc_makePersistent
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
 * Manage the persistence of an object.
 *
 * Arguments:
 * 0: Object to persist <OBJECT> (default: 0)
 * 1: Array to store object <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_container, EGVAR(db,db_containers)] call adf_db_fnc_makePersistent
 *
 * Public: Yes
 */

params [["_object", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_array", [], [[]]]];

if (isNil "_object" || isNull _object) exitWith { [EGVAR(db,debug), "adf_db_fnc_makePersistent", "No object to make persistent.", true] call DEFUNC(utils,debug); };

[EGVAR(db,debug), "adf_db_fnc_makePersistent", format ["Processing '%1' persistence...", _object], true] call DEFUNC(utils,debug);

private _objectID = _array find _object;

if (_objectID == -1) then {
    _array pushback _object;
    [EGVAR(db,debug), "adf_db_fnc_makePersistent", format ["'%1' is now persistent.", _object], true] call DEFUNC(utils,debug);
} else {
    [EGVAR(db,debug), "adf_db_fnc_makePersistent", format ["'%1' is already persistent.", _object], true] call DEFUNC(utils,debug);
};