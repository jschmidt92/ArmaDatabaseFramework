#include "script_component.hpp"

/*
 * Function: adf_db_fnc_loadFromSlot
 * Author: NikolaiF90, PrinceF90, J.Schmidt
 * Edit: 07.27.2024
 * Copyright © 2024 NikolaiF90, PrinceF90, J.Schmidt, All rights reserved
 *
 * Do not edit without permission!
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivative 4.0 International License.
 * To view a copy of this license, vist https://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons,
 * PO Box 1866, Mountain View, CA 94042
 *
 * [Description]
 * Load save from slot.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_loadFromSlot
 *
 * Public: Yes
 */

EGVAR(db,selectedList) = [EGVAR(db,listBox)] call DFUNC(getSelectedList);

[EGVAR(db,debug), "adf_db_fnc_loadFromSlot", "Loading progress...", false] call DEFUNC(utils,debug);

if (EGVAR(db,selectedList) != 0) then {
    [EGVAR(db,selectedList)] call DEFUNC(load,game);
} else {
    [EGVAR(db,debug), "adf_db_fnc_loadFromSlot", "Empty slot selected. Nothing to load from here.", false] call DEFUNC(utils,debug);
};