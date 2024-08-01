#include "script_component.hpp"

/*
 * Function: adf_save_fnc_vehs
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
 * Save vehicle data to specified slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_save_fnc_vehs
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_save_fnc_vehs", format ["Saving vehicles to slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _vehicles = [];


private _fnc_generateTurretArray = {
    params ["_vehicle"];

    private _turretsArray = [];

    {
        _turretsArray pushBack _x;
        true
    } count (magazinesAllTurrets _vehicle);

    _turretsArray;
};

private _fnc_generateVehicleData = {
    params ["_vehicle"];
    private _vehicleId = _vehicle getVariable EGVAR(db,vehIDKey);
    private _vehicleData = [format ["vehicle.%1", _vehicleId], [
        ["class", typeOf _vehicle],
        ["damages", getAllHitPointsDamage _vehicle],
        ["fuel", fuel _vehicle],
        ["generalDamage", damage _vehicle],
        ["id", _vehicleId],
        ["materials", getObjectMaterials _vehicle],
        ["posDir", [_vehicle] call DEFUNC(generate,posDirData)],
        ["textures", getObjectTextures _vehicle],
        ["turrets", [_vehicle] call _fnc_generateTurretArray]
    ]];
    _vehicleData;
};

{
    private _vehicleData = [_x] call _fnc_generateVehicleData;
    _vehicles pushBack _vehicleData;
} forEach EGVAR(db,vehs);

["vehicles", _vehicles, _slot] call DEFUNC(core,saveData);

[EGVAR(db,debug), "adf_save_fnc_vehs", "Vehicles saved.", false] call DEFUNC(utils,debug);