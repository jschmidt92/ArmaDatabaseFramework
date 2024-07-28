#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_applyDamage
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
 * Set specific hitpoint damages on an entity.
 *
 * Arguments:
 * 0: Entity object <OBJECT> (default: nil)
 * 1: Hitpoint keys and corresponding damage values <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_unit, _hitpointsArray] call adf_utils_fnc_applyDamage
 *
 * Public: Yes
 */

params [["_entity", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_hitpointsArray", [], [[], createHashMap]]];

{
    private _key = _x;
    private _value = (_hitpointsArray # 2) # _forEachIndex;
    _entity setHitPointDamage [_key, _value];
} forEach (_hitpointsArray # 0);