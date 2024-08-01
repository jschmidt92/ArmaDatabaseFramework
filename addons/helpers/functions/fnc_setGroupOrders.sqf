#include "script_component.hpp"

/*
 * Function: adf_helpers_fnc_setGroupOrders
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

params ["_unit", "_groupOrdersArray"];

private _group = group _unit;

if (leader _group == _unit) then {
    {
        private _key = _x # 0;
        private _value = _x # 1;

        switch (_key) do {
            case "combatMode": { _group setCombatMode _value; };
            case "formation": { _group setFormation _value; };
            case "speedMode": { _group setSpeedMode _value; };
        };
        true
    } count (_groupOrdersArray);
};