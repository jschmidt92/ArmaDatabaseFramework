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

private ["_cargo", "_class", "_damages", "_fuel", "_generalDamage", "_id", "_materialData", "_posDir", "_textureData", "_turretData"];

[EGVAR(db,debug), "adf_load_fnc_vehs", text format ["Loading persistent vehicles from slot '%1'", _slot], false] call DEFUNC(utils,debug);

private _vehicles = ["vehicles", _slot] call DEFUNC(core,loadData);

if (isNil "_vehicles") exitWith { [EGVAR(db,debug), "adf_load_fnc_vehs", text format ["No vehicles to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };
if (count EGVAR(db,vehs) > 0) then {
    {
        deleteVehicle _x;
        true
    } count (EGVAR(db,vehs));

    [EGVAR(db,vehs)] call DEFUNC(utils,clearArray);
    EGVAR(db,vehs) = [];
};

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case "cargo": { _cargo = _value; };
        case "class": { _class = _value; };
        case "damages": { _damages = _value; };
        case "fuel": { _fuel = _value; };
        case "generalDamage": { _generalDamage = _value; };
        case "id": { _id = _value; };
        case "materials": { _materialData = _value; };
        case "posDir": { _posDir = _value; };
        case "textures": { _textureData = _value; };
        case "turrets": { _turretData = _value; };
    };

    private _vehicle = _class createVehicle [0, 0, 0];

    _vehicle setFuel _fuel;
    _vehicle setDamage _generalDamage;
    [_vehicle, _damages] call DEFUNC(utils,applyDamage);
    [_vehicle, _cargo] call DEFUNC(utils,applyCargoData);
    [_vehicle, _posDir] call DEFUNC(utils,applyPosDir);

    {
        private _turretPath = _x;

        {
            _vehicle removeMagazinesTurret [_x, _turretPath];
            true
        } count (_vehicle magazinesTurret  _turretPath);
        true
    } count (allTurrets _vehicle);

    {
        private _class = _x # 0;
        private _turretPath = _x # 1;
        private _ammo = _x # 2;

        _vehicle addMagazineTurret [_class, _turretPath, _ammo];
        true
    } count (_turretData);

    {
        _vehicle setObjectMaterial [_forEachIndex, _x];
        true
    } count (_materialData);

    {
        _vehicle setObjectTexture [_forEachIndex, _x];
        true
    } count (_textureData);

    _vehicle setVariable [EGVAR(db,vehIDKey), _id];
    
    EGVAR(db,vehs) set [_id, _vehicle];
    true
} count (_vehicles);