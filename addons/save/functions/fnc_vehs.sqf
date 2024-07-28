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

{
    private _vehicle = _x;
    private _vehicleArray = [];

    _vehicleArray pushBack ["cargo", [_vehicle] call DEFUNC(generate,CargoData)];
    _vehicleArray pushBack ["class", typeOf _vehicle];
    _vehicleArray pushBack ["damages", getAllHitPointsDamage _vehicle];
    _vehicleArray pushBack ["fuel", fuel _vehicle];
    _vehicleArray pushBack ["generalDamage", damage _vehicle];
    _vehicleArray pushBack ["id", _vehicle getVariable EGVAR(db,vehIDKey)];
    _vehicleArray pushBack ["materials", getObjectMaterials _vehicle];
    _vehicleArray pushBack ["posDir", [_vehicle] call DEFUNC(utils,applyPosDir)];
    _vehicleArray pushBack ["textures", getObjectTextures _vehicle];
    _vehicleArray pushBack ["turrets", [_vehicle] call _fnc_generateTurretArray];

    _vehicles pushBack _vehicleArray;
    true
} count (EGVAR(db,vehs));

["vehicles", _vehicles, _slot] call DEFUNC(core,saveData);

[EGVAR(db,debug), "adf_save_fnc_vehs", text format ["Vehicles saved to slot '%1'.", _slot], false] call DEFUNC(utils,debug);