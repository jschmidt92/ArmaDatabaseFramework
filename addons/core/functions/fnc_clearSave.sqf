#include "script_component.hpp"

/*
 * Function: adf_core_fnc_clearSave
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
 * Remove all saved data for given slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: nil)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_core_fnc_clearSave
 * [1] call adf_core_fnc_clearSave
 *
 * Public: Yes
 */

params [["_slot", nil, [0]]];

[EGVAR(db,debug), "adf_core_fnc_clearSave", "Clearing save...", true] call DEFUNC(utils,debug);

if (isNil "_slot") then {
        [EGVAR(db,debug), "adf_core_fnc_clearSave", "Clearing all saves.", true] call DEFUNC(utils,debug);
    } else {
        [EGVAR(db,debug), "adf_core_fnc_clearSave", format ["Clearing save for slot '%1'.", _slot], true] call DEFUNC(utils,debug);
    };

// {
//     if (isNil "_slot") then {
//         if (_x find (format ["%1.", EGVAR(db,prefix)]) == 0) then { profileNamespace setVariable [_x, nil]; };
//     } else {
//         if (_x find (format ["%1.%2.", EGVAR(db,prefix), _slot]) == 0) then { profileNamespace setVariable [_x, nil]; };
//     };
//     true
// } count (allVariables profileNamespace);

// saveProfileNamespace;