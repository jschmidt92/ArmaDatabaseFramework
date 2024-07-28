#include "script_component.hpp"

/*
 * Function: adf_db_fnc_saveTarget
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
 * Check if the cursorTarget is a vehicle or container and add it to the save queue.
 *
 * Arguments:
 * 0: Type of target <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_saveTarget
 * [1] call adf_db_fnc_saveTarget
 *
 * Public: Yes
 */

params [["_typeOfTarget", 0, [0]]];

private _cursorTarget = cursorTarget;
private _objectToSave = objNull;

switch { _typeOfTarget } do {
    case 0: {
        if (_cursorTarget isKindOf "Air" || _cursorTarget isKindOf "LandVehicle" || _cursorTarget isKindOf "Ship") then {
            _objectToSave = _cursorTarget;
            [_objectToSave] call DEFUNC(generate,vehicleID);
            [EGVAR(db,debug), "adf_db_fnc_saveTarget", text format ["Added '%1' to save queue", _cursorTarget], true] call DEFUNC(utils,debug);
        } else {
            [EGVAR(db,debug), "adf_db_fnc_saveTarget", text format ["Target '%1' is not a vehicle", _cursorTarget], true] call DEFUNC(utils,debug);
        };
    };
    case 1: {
        _objectToSave = _cursorTarget;
        [_objectToSave, EGVAR(db,conts)] call DFUNC(makePersistent);
        [EGVAR(db,debug), "adf_db_fnc_saveTarget", text format ["Container '%1' is now persistent", _cursorTarget], true] call DEFUNC(utils,debug);
    };
    default: {
        if (_cursorTarget isKindOf "Air" || _cursorTarget isKindOf "LandVehicle" || _cursorTarget isKindOf "Ship") then {
            _objectToSave = _cursorTarget;
            [_objectToSave] call DEFUNC(generate,vehicleID);
            [EGVAR(db,debug), "adf_db_fnc_saveTarget", text format ["Added '%1' to save queue", _cursorTarget], true] call DEFUNC(utils,debug);
        } else {
            [EGVAR(db,debug), "adf_db_fnc_saveTarget", text format ["Target '%1' is not a vehicle", _cursorTarget], true] call DEFUNC(utils,debug);
        };
    };
};