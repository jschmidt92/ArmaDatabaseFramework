#include "script_component.hpp"

/*
 * Function: adf_load_fnc_containers
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
 * Load container data from specified slot and create containers.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_load_fnc_containers
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

private _class = "";
private _cargo = [];
private _posDir = [];

[EGVAR(db,debug), "adf_load_fnc_loadContainers", format ["Loading containers from slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _containers = ["containers", _slot] call DEFUNC(core,loadData);

if (isNil "_containers" || (count _containers) == 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_loadContainers", format ["No containers to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };

{
    deleteVehicle _x;
    true
} count (EGVAR(db,conts));

[EGVAR(db,conts)] call DEFUNC(utils,clearArray);

{
    private _key = _x;
    private _value = _y;

    switch (_key) do {
        case "class": { _class = _value; };
        case "cargo": { _cargo = _value; };
        case "posDir": { _posDir = _value; };
    };

    private _container = _class createVehicle [0, 0, 0];

    [_container, _posDir] call DEFUNC(utils,applyPosDir);
    [_container, _cargo] call DEFUNC(utils,applyCargoData);
    [_container, EGVAR(db,conts)] call DEFUNC(db,makePersistent);
} forEach _containers;

[EGVAR(db,debug), "adf_load_fnc_loadContainers", "All containers loaded.", false] call DEFUNC(utils,debug);