#include "script_component.hpp"

/*
 * Function: adf_load_fnc_vehs
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
 * Load vehicle data from specified slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_load_fnc_vehs
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_load_fnc_vehs", format ["Loading persistent vehicles from slot '%1'", _slot], false] call DEFUNC(utils,debug);

private _vehicles = ["vehicles", _slot] call DEFUNC(core,loadData);

if (isNil "_vehicles" || (count _vehicles) <= 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_vehs", format ["No vehicles to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };

{ deleteVehicle _x } forEach EGVAR(db,vehs);
[EGVAR(db,vehs)] call DEFUNC(utils,clearArray);

{
    private _value = _y;
    if (_x select [0, 8] == "vehicle.") then {
        private _vehicle = _value getOrDefault ["class", ""] createVehicle [0,0,0];

        [_vehicle, _value getOrDefault ["cargo", []]] call DEFUNC(utils,applyCargoData);
        [_vehicle, _value getOrDefault ["damages", []]] call DEFUNC(utils,applyDamage);
        _vehicle setFuel (_value getOrDefault ["fuel", 1]);
        _vehicle setDamage (_value getOrDefault ["generalDamage", 0]);
        _vehicle setVariable [EGVAR(db,vehIDKey), _forEachIndex];
        [_vehicle, _value getOrDefault ["posDir", []]] call DEFUNC(utils,applyPosDir);

        {
            private _turretPath = _x;
            {
                _vehicle removeMagazinesTurret [_x, _turretPath];
            } forEach (_vehicle magazinesTurret _turretPath);
        } forEach (allTurrets _vehicle);

        {
            _vehicle addMagazineTurret [_x # 0, _x # 1, _x # 2];
        } forEach (_value getOrDefault ["turrets", []]);

        {
            _vehicle setObjectMaterial [_forEachIndex, _x];
        } forEach (_value getOrDefault ["materials", []]);

        {
            _vehicle setObjectTexture [_forEachIndex, _x];
        } forEach (_value getOrDefault ["textures", []]);

        EGVAR(db,vehs) pushBack _vehicle;
    };
} forEach _vehicles;

[EGVAR(db,debug), "adf_load_fnc_vehs", "Persistent vehicles loaded.", false] call DEFUNC(utils,debug);