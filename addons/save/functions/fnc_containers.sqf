#include "script_component.hpp"

/*
 * Function: adf_save_fnc_containers
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
 * Save container data to specified slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_save_fnc_containers
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_save_fnc_containers", format ["Saving containers to slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _containers = [];

private _fnc_generateContainerData = {
    params ["_container"];
    private _containerId = _container getVariable EGVAR(db,contIDKey);
    private _containerData = [format ["container.%1", _containerId], [
        ["class", typeOf _container],
        ["cargo", [_container] call DEFUNC(generate,cargoData)],
        ["id", _containerId],
        ["posDir", [_container] call DEFUNC(generate,posDirData)]
    ]];
    _containerData;
};

{
    private _containerData = [_x] call _fnc_generateContainerData;
    _containers pushBack _containerData;
} forEach EGVAR(db,conts);

["containers", _containers, _slot] call DEFUNC(core,saveData);

[EGVAR(db,debug), "adf_save_fnc_containers", "Containers saved.", false] call DEFUNC(utils,debug);