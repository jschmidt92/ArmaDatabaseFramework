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

[EGVAR(db,debug), "adf_load_fnc_loadContainers", format ["Loading containers from slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _containers = ["containers", _slot] call DEFUNC(core,loadData);

if (isNil "_containers" || (count _containers) == 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_loadContainers", format ["No containers to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };

{ deleteVehicle _x } forEach EGVAR(db,conts);
[EGVAR(db,conts)] call DEFUNC(utils,clearArray);

{
    private _key = _x;
    private _value = _containers get _key;

    if (_key select [0, 10] == "container.") then {
        private _cargo = _value getOrDefault ["cargo", []];
        private _class = _value getOrDefault ["class", ""];
        private _id = _value getOrDefault ["id", 0];
        private _posDir = _value getOrDefault ["posDir", []];

        if (_class != "") then {
            private _container = createVehicle [_class, [0,0,0], [], 0, "NONE"];

            [_container, _cargo] call DEFUNC(utils,applyCargoData);
            _container setVariable [EGVAR(db,contIDKey), _id];
            EGVAR(db,conts) pushBack _container;
            [_container, _posDir] call DEFUNC(utils,applyPosDir);
        };
    };
} forEach keys _containers;

[EGVAR(db,debug), "adf_load_fnc_loadContainers", "All containers loaded.", false] call DEFUNC(utils,debug);