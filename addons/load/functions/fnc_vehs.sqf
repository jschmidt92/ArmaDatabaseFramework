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

private _class = "";
private _materialData = [];
private _textureData = [];
private _turretData = [];

[EGVAR(db,debug), "adf_load_fnc_vehs", format ["Loading persistent vehicles from slot '%1'", _slot], false] call DEFUNC(utils,debug);

private _vehicles = ["vehicles", _slot] call DEFUNC(core,loadData);

if (isNil "_vehicles" || (count _vehicles) == 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_vehs", format ["No vehicles to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };
if (count EGVAR(db,vehs) > 0) then {
    {
        deleteVehicle _x;
        true
    } count (EGVAR(db,vehs));

    [EGVAR(db,vehs)] call DEFUNC(utils,clearArray);
    EGVAR(db,vehs) = [];
};

{
    private _key = _x;
    private _value = _y;

    if (_key isEqualTo "vehicles") then {
        {
            private _vehKey = _x # 0;
            private _vehValue = _x # 1;

            switch (_vehKey) do {
                case "class": { _class = _vehValue; break; };
            };
            true
        } count (_value);
    };
} forEach _vehicles;

private _vehicle = _class createVehicle [0, 0, 0];

waitUntil { !(isNil "_vehicle") };

{
    private _key = _x;
    private _value = _y;
    private _materialData = [];
    private _textureData = [];
    private _turretData = [];

    if (_key isEqualTo "vehicles") then {
        {
            private _vehKey = _x # 0;
            private _vehValue = _x # 1;

            switch (_vehKey) do {
                case "cargo": { [_vehicle, _vehValue] call DEFUNC(utils,applyCargoData); };
                case "damages": { [_vehicle, _vehValue] call DEFUNC(utils,applyDamage); };
                case "fuel": { _vehicle setFuel _vehValue; };
                case "generalDamage": { _vehicle setDamage _vehValue; };
                case "id": { _vehicle setVariable [EGVAR(db,vehIDKey), _vehValue]; EGVAR(db,vehs) set [_vehValue, _vehicle]; };
                case "materials": { _materialData = _vehValue; };
                case "posDir": { [_vehicle, _vehValue] call DEFUNC(utils,applyPosDir); };
                case "textures": { _textureData = _vehValue; };
                case "turrets": { _turretData = _vehValue; };
            };
            true
        } count (_value);
    };

    {
        private _turretPath = _x;
        {
            _vehicle removeMagazinesTurret [_x, _turretPath];
        } forEach (_vehicle magazinesTurret _turretPath);
    } forEach (allTurrets _vehicle);

    {
        _vehicle addMagazineTurret [_x select 0, _x select 1, _x select 2];
    } forEach _turretData;

    {
        _vehicle setObjectMaterial [_forEachIndex, _x];
    } forEach _materialData;

    {
        _vehicle setObjectTexture [_forEachIndex, _x];
    } forEach _textureData;
} forEach _vehicles;

[EGVAR(db,debug), "adf_load_fnc_vehs", "Persistent vehicles loaded.", false] call DEFUNC(utils,debug);