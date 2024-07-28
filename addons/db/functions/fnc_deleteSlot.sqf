#include "script_component.hpp"

/*
 * Function: adf_db_fnc_deleteSlot
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
 * Delete selected item from a persistent list and update profileNamespace.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_deleteSlot
 *
 * Public: Yes
 */

EGVAR(db,selectedList) = [EGVAR(db,listBox)] call DFUNC(getSelectedList);

if (EGVAR(db,selectedList) != 0) then {
    private _deletedItem = EGVAR(db,slots) deleteAt EGVAR(db,selectedList);
    [EGVAR(db,debug), "adf_db_fnc_deleteSlot", text format ["Deleted '%1' from persistent list.", _deletedItem], false] call DEFUNC(utils,debug);

    profileNamespace setVariable [QEGVAR(db,pListKey), EGVAR(db,slots)];
    [EGVAR(db,listBox)] call DFUNC(updatePersistentList);
} else {
    [EGVAR(db,debug), "adf_db_fnc_deleteSlot", "Can not delete empty slot.", false] call DEFUNC(utils,debug);
};