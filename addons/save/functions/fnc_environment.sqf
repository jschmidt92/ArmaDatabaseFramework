#include "script_component.hpp"

/*
 * Function: adf_save_fnc_environment
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
 * Save environment data to specified slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_save_fnc_environment
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_save_fnc_environment", format ["Saving environment info to slot '%1'.", _slot], false] call DEFUNC(utils,debug);

private _environment = createHashMap;

_environment set ["date", date];
_environment set ["rain", rain];
_environment set ["fog", fog];
_environment set ["overcast", overcast];

["environment", _environment, _slot] call DEFUNC(core,saveData);