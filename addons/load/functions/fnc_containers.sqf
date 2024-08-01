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

[EGVAR(db,debug), "adf_load_fnc_loadContainers", format ["Loading containers from slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _containers = ["containers", _slot] call DEFUNC(core,loadData);

if (isNil "_containers" || (count _containers) == 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_loadContainers", format ["No containers to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };

if (count EGVAR(db,conts) > 0) then {
    {
        deleteVehicle _x;
        true
    } count (EGVAR(db,conts));

    [EGVAR(db,conts)] call DEFUNC(utils,clearArray);
    EGVAR(db,conts) = [];
};

{
    private _key = _x;
    private _value = _y;

    if (_key find "container." == 0) then {
        {
            private _contKey = _x # 0;
            private _contValue = _x # 1;

            switch (_contKey) do {
                case "class": { _class = _contValue; break; };
            };
            true
        } count (_value);
    };
} forEach _containers;

private _container = _class createVehicle [0, 0, 0];

waitUntil { !(isNil "_container") };

{
    private _key = _x;
    private _value = _y;

    if (_key find "container." == 0) then {
        {
            private _contKey = _x # 0;
            private _contValue = _x # 1;

            switch (_contKey) do {
                case "cargo": { [_container, _contValue] call DEFUNC(utils,applyCargoData); };
                case "id": { _container setVariable [EGVAR(db,contIDKey), _contValue]; EGVAR(db,conts) set [_contValue, _container]; };
                case "posDir": { [_container, _contValue] call DEFUNC(utils,applyPosDir); };
            };
            true
        } count (_value);
    };
} forEach _containers;

[EGVAR(db,debug), "adf_load_fnc_loadContainers", "All containers loaded.", false] call DEFUNC(utils,debug);