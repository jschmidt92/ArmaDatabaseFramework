#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_applyPosDir
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
 * Set position and direction of an entity.
 *
 * Arguments:
 * 0: Entity object <OBJECT> (default: nil)
 * 1: Position ATL and direction <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_unit, _hitpointsArray] call adf_utils_fnc_applyPosDir
 *
 * Public: Yes
 */

params [["_entity", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_array", [], [[]]]];

private _posATL = _array # 0;
private _dir = _array # 1;

_entity setPosATL _posATL;
_entity setDir _dir;