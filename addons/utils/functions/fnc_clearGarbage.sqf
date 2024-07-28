#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_clearGarbage
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
 * Clear garbage such as dead bodies, wrecked vehicles, objects, etc.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_utils_fnc_clearGarbage
 *
 * Public: Yes
 */

[EGVAR(db,debug), "adf_utils_fnc_clearGarbage", "Clearing garbage...", false] call DFUNC(debug);
{
	deleteVehicle _x;
    true
} count (allDead);

[EGVAR(db,debug), "adf_utils_fnc_clearGarbage", "Garbage cleared.", false] call DFUNC(debug);