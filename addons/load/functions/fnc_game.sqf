#include "script_component.hpp"

/*
 * Function: adf_load_fnc_game
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
 * Load game data from specified slot and initialize game.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_load_fnc_game
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_load_fnc_game", format ["Loading progress from slot '%1'...", _slot], true] call DEFUNC(utils,debug);

[_slot] call DEFUNC(utils,clearGarbage);

[_slot] call DFUNC(containers);
[_slot] call DFUNC(player);
[_slot] call DFUNC(environment);
[_slot] call DFUNC(mapMarkers);
[_slot] call DFUNC(variables);
[_slot] spawn DFUNC(vehs);

[EGVAR(db,debug), "adf_load_fnc_game", "Progress has been successfully loaded.", true] call DEFUNC(utils,debug);