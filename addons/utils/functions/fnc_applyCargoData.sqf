#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_applyCargoData
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
 * Adds cargo to a container.
 *
 * Arguments:
 * 0: Container object <OBJECT> (default: nil)
 * 1: Types of cargo items to add to container <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_unit, _vehicleData] call adf_utils_fnc_applyCargoData
 *
 * Public: Yes
 */

params [["_container", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_cargoArray", [], [[]]]];

if (isNil "_container" || _cargoArray isEqualTo []) exitWith { [EGVAR(db,debug), "adf_utils_fnc_applyCargoData", "No container to add cargo to.", true] call DEFUNC(utils,debug); };

clearItemCargo _container;
clearMagazineCargo _container;
clearWeaponCargo _container;
clearBackpackCargo _container;

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case "containers": { [_container, _value] call DEFUNC(helpers,addContainers); };
        case "backpacks": { [_container, _value] call DEFUNC(helpers,addBackpacks); };
        case "items": { [_container, _value, { params ["_c", "_n", "_cnt"]; _c addItemCargo [_n, _cnt]; }] call DEFUNC(helpers,addAllCargo); };
        case "magazines": { [_container, _value] call DEFUNC(helpers,addMagazines); };
        case "weapons": { [_container, _value] call DEFUNC(helpers,addWeapons); };
    };
    true
} count (_cargoArray);