#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_applyCargoData
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
 * Adds cargo to a container.
 *
 * Arguments:
 * 0: Container object <OBJECT> (default: nil)
 * 1: Types of cargo items to add to container <ARRAY> (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_unit, _vehicleData] call adf_utils_fnc_applyCargoData
 *
 * Public: Yes
 */

params [["_container", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_cargoArray", [], [[]]]];

private ["_cargo", "_class"];

clearItemCargo _container;
clearMagazineCargo _container;
clearWeaponCargo _container;
clearBackpackCargo _container;

private _fnc_isContainerEmpty = {
    params ["_container"];

    if (!(magazineCargo _container isEqualTo [])) exitWith { false };
    if (!(weaponCargo _container isEqualTo [])) exitWith { false };
    if (!(itemCargo _container isEqualTo [])) exitWith { false };
    if (!(backpackCargo _container isEqualTo [])) exitWith { false };

    true;
};

private _fnc_addAllToCargo = {
    params ["_container", "_cargoArray", "_fnc_addToCargo"];
    
    {
        private _name = _x;
        private _count = (_cargoArray # 1) # _forEachIndex;
        [_container, _name, _count] call _fnc_addToCargo;
        true
    } count (_cargoArray # 0);
};

private _fnc_addAllMagazinesToCargo = {
    params ["_container", "_cargoArray"];

    {
        private _name = _x # 0;
        private _ammo = _x # 1;

        _container addMagazineAmmoCargo [_name, 1, _ammo];
        true
    } count (_cargoArray);
};

private _fnc_addAllWeaponsToCargo = {
    params ["_container", "_cargoArray"];

    {
        _container addWeaponWithAttachmentsCargo [_x, 1];
        true
    } count (_cargoArray);
};

private _fnc_addAllContainersToCargo = {
    params ["_container", "_cargoArray"];

    {
        private _key = _x # 0;
        private _value = _x # 1;

        switch (_key) do {
            case "class": { _class = _value; };
            case "cargo": { _cargo = _value; };
        };
        
        {
            private _currentClass = _x # 0;
            private _currentInstance = _x # 1;

            if (_currentClass == _class && [_currentInstance] call _fnc_isContainerEmpty) exitWith {
                [_currentInstance, _cargo] call DFUNC(applyCargoData);
            };
            true
        } count (everyContainer _container);
        true
    } count (_cargoArray);
};

private _fnc_addAllBackpacksToCargo = {
    params ["_container", "_cargoArray"];

    {
        private _key = _x # 0;
        private _value = _x # 1;

        switch (_key) do {
            case "class": { _class = _value; };
            case "cargo": { _cargo = _value; };
        };

        _container addBackpackCargo [_class, 1];

        {
            if (typeOf _x == _class && [_x] call _fnc_isContainerEmpty) exitWith {
                [_x, _cargo] call DFUNC(applyCargoData);
            };
            true
        } count (everyBackpack _container);
        true
    } count (_cargoArray);
};

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case "containers": { [_container, _value] call _fnc_addAllContainersToCargo; };
        case "backpacks": { [_container, _value] call _fnc_addAllBackpacksToCargo; };
        case "items": { [_container, _value, { params ["_c", "_n", "_cnt"]; _c addItemCargo [_n, _cnt]; }] call _fnc_addAllToCargo; };
        case "magazines": { [_container, _value] call _fnc_addAllMagazinesToCargo; };
        case "weapons": { [_container, _value] call _fnc_addAllWeaponsToCargo; };
    };
    true
} count (_cargoArray);