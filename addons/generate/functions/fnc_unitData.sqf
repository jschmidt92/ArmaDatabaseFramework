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

params [["_unit", objNull, [objNull]], ["_isLeader", false, [false]]];

if (isNull _unit) exitWith {
    [EGVAR(db,debug), "adf_generate_fnc_unitData", "No unit to generate data for.", true] call DEFUNC(utils,debug);
    createHashMap
};

private _unitData = createHashMap;

[EGVAR(db,debug), "adf_generate_fnc_unitData", format ["Generating data for '%1' (isLeader = '%2')...", _unit, _isLeader], false] call DEFUNC(utils,debug);

_unitData set ["assignedTeam", assignedTeam _unit];
_unitData set ["class", typeOf _unit];
_unitData set ["damages", getAllHitPointsDamage _unit];
_unitData set ["face", face _unit];
_unitData set ["fatigue", getFatigue _unit];
_unitData set ["formDir", formationDirection _unit];
_unitData set ["generalDamage", damage _unit];
_unitData set ["loadout", getUnitLoadout _unit];
_unitData set ["name", (name _unit) splitString " "];
_unitData set ["orders", [_unit] call DFUNC(orders)];
_unitData set ["pitch", pitch _unit];
_unitData set ["posDir", [_unit] call DFUNC(posDirData)];
_unitData set ["rating", rating _unit];
_unitData set ["side", side _unit];
_unitData set ["skills", [_unit] call DFUNC(skills)];
_unitData set ["speaker", speaker _unit];
_unitData set ["stamina", getStamina _unit];
_unitData set ["variables", [_unit] call DFUNC(variables)];

if (vehicle _unit != _unit) then {
    private _vehicle = vehicle _unit;
    private _vehicleCrew = fullCrew vehicle _unit;
    private _vehicleData = createHashMap;

    {
        _x params ["_assignedUnit", "_role", "_cargoIndex", "_turretPath", "_personTurret"];

        if (_unit == _assignedUnit) exitWith {
            _vehicleData set ["role", [_role, _cargoIndex, _turretPath, _personTurret]];
            [EGVAR(db,debug), "adf_generate_fnc_unitData", format ["Vehicle role data for '%1' generated: '%2'", _unit, _vehicleData get "role"], false] call DEFUNC(utils,debug);
        };
    } forEach _vehicleCrew;

    _vehicleData set ["id", [_vehicle] call DFUNC(vehicleID)];
    _unitData set ["vehicle", _vehicleData];
};

if (_isLeader) then {
    _unitData set ["group", [_unit] call DFUNC(groupData)];
    _unitData set ["groupOrders", [_unit] call DFUNC(groupOrders)];
};

[EGVAR(db,debug), "adf_generate_fnc_unitData", format ["Data for '%1' (isLeader = '%2') has been successfully generated.", _unit, _isLeader], false] call DEFUNC(utils,debug);

_unitData