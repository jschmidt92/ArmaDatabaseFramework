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

private _vehicles = createHashMap;

{
    private _vehicle = _x;
    private _id = _vehicle getVariable EGVAR(db,vehIDKey);
    private _data = createHashMap;

    _data set ["class", typeOf _vehicle];
    _data set ["cargo", [_vehicle] call DEFUNC(generate,cargoData)];
    _data set ["damages", getAllHitPointsDamage _vehicle];
    _data set ["fuel", fuel _vehicle];
    _data set ["generalDamage", damage _vehicle];
    _data set ["materials", getObjectMaterials _vehicle];
    _data set ["posDir", [_vehicle] call DEFUNC(generate,posDirData)];
    _data set ["textures", getObjectTextures _vehicle];
    _data set ["turrets", [_vehicle] call DEFUNC(generate,turretData)];

    _vehicles set [format ["vehicle.%1", _id], _data];
} forEach EGVAR(db,vehs);

["vehicles", _vehicles, _slot] call DEFUNC(core,saveData);

[EGVAR(db,debug), "adf_save_fnc_vehs", "Vehicles saved.", false] call DEFUNC(utils,debug);