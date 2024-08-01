#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_variables
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
 * N/A
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * N/A
 *
 * Public: Yes
 */

params ["_unit"];

private _varsArray = [];

{
    private _splittedKey = _x splitString '_';

    if (_splittedKey # 0 != 'cba' && _splittedKey # 0 != 'ace') then {
        _varsArray pushBack [_x, _unit getVariable _x];
    };
    true
} count (allVariables _unit);

_varsArray;