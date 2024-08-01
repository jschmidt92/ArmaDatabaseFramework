#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_unitData
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
 * Generate unit data and return it.
 *
 * Arguments:
 * 0: Unit object <OBJECT> (default: nil)
 * 1: Leader <BOOL> (default: false)
 *
 * Return Value:
 * The return <OBJECT>
 *
 * Examples:
 * [_unit, false] call adf_generate_fnc_unitData
 *
 * Public: Yes
 */

params [["_unit", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_isLeader", false, [false]]];

if (isNil "_unit" || isNull _unit) exitWith {[EGVAR(db,debug), "adf_generate_fnc_unitData", "No unit to generate data for.", true] call DEFUNC(utils,debug); };

private _unitData = [];

[EGVAR(db,debug), "adf_generate_fnc_unitData", format ["Generating data for '%1' (isLeader = '%2')...", _unit, _isLeader], false] call DEFUNC(utils,debug);

_unitData pushBack ["assignedTeam", assignedTeam _unit];
_unitData pushBack ["class", typeOf _unit];
_unitData pushBack ["damages", getAllHitPointsDamage _unit];
_unitData pushBack ["face", face _unit];
_unitData pushBack ["fatigue", getFatigue _unit];
_unitData pushBack ["formDir", formationDirection _unit];
_unitData pushBack ["generalDamage", damage _unit];
_unitData pushBack ["loadout", getUnitLoadout _unit];
_unitData pushBack ["name", (name _unit) splitString " "];
_unitData pushBack ["orders", [_unit] call DFUNC(orders)];
_unitData pushBack ["pitch", pitch _unit];
_unitData pushBack ["posDir", [_unit] call DFUNC(posDirData)];
_unitData pushBack ["rating", rating _unit];
_unitData pushBack ["side", side _unit];
_unitData pushBack ["skills", [_unit] call DFUNC(skills)];
_unitData pushBack ["speaker", speaker _unit];
_unitData pushBack ["stamina", getStamina _unit];
_unitData pushBack ["variables", [_unit] call DFUNC(variables)];

if (vehicle _unit != _unit) then {
    private _roleData = [];
    private _vehicle = vehicle _unit;
    private _vehicleCrew = fullCrew vehicle _unit;
    private _vehicleData = [];

    {
        private _selectedUnit = _x # 0;
        if (_unit == _selectedUnit) exitWith {
            private _role = _x # 1;
            private _cargoIndex = _x # 2;
            private _turretPath = _x # 3;
            private _personTurret = _x # 4;
            _roleData = [_role, _cargoIndex, _turretPath, _personTurret];
            [EGVAR(db,debug), "adf_generate_fnc_unitData", format ["Role data for '%1' generated: '%2'", _unit, _roleData], false] call DEFUNC(utils,debug);
        };
        true
    } count (_vehicleCrew);

    _vehicleData pushBack ["id", [_vehicle] call DFUNC(vehicleID)];
    _vehicleData pushBack ["role", _roleData];

    _unitData pushBack ["vehicle", _vehicleData];
};

if (_isLeader) then {
    _unitData pushBack ["group", [_unit] call DFUNC(groupData)];
    _unitData pushBack ["groupOrders", [_unit] call DFUNC(groupOrders)];
};

[EGVAR(db,debug), "adf_generate_fnc_unitData", format ["Data for '%1' (isLeader = '%2') has been successfully generated.", _unit, _isLeader], false] call DEFUNC(utils,debug);

_unitData;