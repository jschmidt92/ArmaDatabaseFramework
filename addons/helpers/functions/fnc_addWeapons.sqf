#include "script_component.hpp"

/*
 * Function: adf_helpers_fnc_addWeapons
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
 * Adds weapons to a container.
 *
 * Arguments:
 * 0: Container object <OBJECT> (default: nil)
 * 1: Types of weapons to add to container <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_container, _weapons] call adf_helpers_fnc_addWeapons
 *
 * Public: Yes
 */

params ["_container", "_weaponsArray"];

{
    _container addWeaponWithAttachmentsCargo [_x, 1];
    true
} count (_weaponsArray);