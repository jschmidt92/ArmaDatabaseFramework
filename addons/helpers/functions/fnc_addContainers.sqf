#include "script_component.hpp"

/*
 * Function: adf_helpers_fnc_addContainers
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
 * Adds containers to a container.
 *
 * Arguments:
 * 0: Container object <OBJECT> (default: nil)
 * 1: Types of cantainers to add to container <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_container, _containers] call adf_helpers_fnc_addContainers
 *
 * Public: Yes
 */

params ["_container", "_containersArray"];

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case "class": { private _class = _value; };
        case "cargo": { private _cargo = _value; };
    };
    
    {
        private _currentClass = _x # 0;
        private _currentInstance = _x # 1;

        if (_currentClass == _class && [_currentInstance] call DFUNC(isContainerEmpty)) exitWith {
            [_currentInstance, _cargo] call DEFUNC(utils,applyCargoData);
        };
        true
    } count (everyContainer _container);
    true
} count (_containersArray);