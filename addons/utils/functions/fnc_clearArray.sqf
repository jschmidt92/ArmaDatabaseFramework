#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_clearArray
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
 * Deletes all elements in an array.
 *
 * Arguments:
 * 0: Array elements will be deleted <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_myArray] call adf_utils_fnc_clearArray
 *
 * Public: Yes
 */

params [["_array", [], [[]]]];

private _size = count _array;

for "_i" from (_size -1) to 0 do {
	_array deleteAt _i;
};