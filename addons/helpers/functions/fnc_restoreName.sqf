#include "script_component.hpp"

/*
 * Function: adf_helpers_fnc_restoreName
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

params ["_unit", "_nameArray"];

private _firstName = "";
private _surname = "";
private _joinedNames = "";

if (count _nameArray == 1) then {
    _surname = _nameArray # 0;
    _joinedNames = _surname;
} else {
    _firstName = _nameArray # 0;
    _surname = _nameArray # 1;
    _joinedNames = format ["%1 %2", _firstName, _surname];
};

_unit setName [_joinedNames, _firstName, _surname];