#include "script_component.hpp"

/*
 * Function: adf_load_fnc_player
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
 * Load player data from specified slot and setup player.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_load_fnc_player
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_load_fnc_player", format ["Loading player data from slot '%1'.", _slot], false] call DEFUNC(utils,debug);

private _unitData = ["player", _slot] call DEFUNC(core,loadData);
[player, _unitData, objNull] call DFUNC(unitData);