#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_turretData
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
 * Generate turret data for a vehicle.
 *
 * Arguments:
 * 0: Entity object <OBJECT> (default: nil)
 *
 * Return Value:
 * The return <ARRAY>
 *
 * Examples:
 * [veh1] call adf_generate_fnc_turretData
 *
 * Public: Yes
 */

params ["_vehicle"];

private _turretsArray = [];

{
    _turretsArray pushBack _x;
} forEach (magazinesAllTurrets _vehicle);

_turretsArray;