#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_cargoData
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
 * Generate cargo data for a container.
 *
 * Arguments:
 * 0: Container object <OBJECT> (default: nil)
 *
 * Return Value:
 * The return <ARRAY>
 *
 * Examples:
 * [] call adf_generate_fnc_cargoData
 *
 * Public: Yes
 */

params [["_container", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

if (isNil "_container" || isNull _container) exitWith {[EGVAR(db,debug), "adf_generate_fnc_cargoData", "No entity to generate cargo data for.", true] call DEFUNC(utils,debug); };

[EGVAR(db,debug), "adf_generate_fnc_cargoData", format ["Generating cargo data for container '%1'.", _container], false] call DEFUNC(utils,debug);

private _itemsArray = ["items", getItemCargo _container];
private _magazinesArray = ["magazines", magazinesAmmoCargo _container];
private _weaponsArray = ["weapons", weaponsItemsCargo _container];
private _containersArray = ["containers", [_container] call DEFUNC(helpers,getContainers)];
private _backpacksArray = ["backpacks", [_container] call DEFUNC(helpers,getBackpacks)];

private _cargo = [
    _itemsArray,
    _magazinesArray,
    _weaponsArray,
    _containersArray,
    _backpacksArray
];

[EGVAR(db,debug), "adf_generate_fnc_cargoData", format ["Cargo data for container %1 successfully generated.", _container], false] call DEFUNC(utils,debug);

_cargo;