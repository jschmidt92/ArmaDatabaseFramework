#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_addUnitToVehicle
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
 * Assigns a unit to a specific role in a vehicle.
 *
 * Arguments:
 * 0: Unit object <OBJECT> (default: nil)
 * 1: Data of vehicle and role to assign <ARRAY> (default: nil)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [_unit, _vehicleData] call adf_utils_fnc_addUnitToVehicle
 *
 * Public: Yes
 */

params [["_unit", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_vehicleData", nil, [[]]]];

private _vehicleAssignmentId = "";
private _roleArray = [];


if (isNil "_unit") exitWith { [EGVAR(db,debug), "adf_utils_fnc_addUnitToVehicle", "No unit to assign role in vehicle", false] call DFUNC(debug); };

[EGVAR(db,debug), "adf_utils_fnc_addUnitToVehicle", format ["Adding '%1' to vehicle...", _unit], false] call DFUNC(debug);

if (isNil "_vehicleData" || !(_vehicleData isEqualType [])) exitWith { [EGVAR(db,debug), "adf_utils_fnc_addUnitToVehicle", format ["'%1' has no vehicle", _unit], false] call DFUNC(debug); };

diag_log format ["Adding '%1' with vehicle data '%2'", _unit, _vehicleData];

private _fnc_findAssignedVehicleInArray = {
	params ["_id"];
	private _instance = objNull;

	waitUntil { (count EGVAR(db,vehs)) > 0 };


	{
		private _tmpVar = _x getVariable QEGVAR(db,vehIDKey);
		diag_log text format ["Checking vehicle '%1' with ID '%2'", _x, _tmpVar];
	
		if (_x getVariable QEGVAR(db,vehIDKey) == _id) exitWith { _instance = _x; };
	} forEach EGVAR(db,vehs);

	_instance;
};

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case "key": { _vehicleAssignmentId = _value };
        case "role": { _roleArray = _value };
    };
    true
} count (_vehicleData);

private _vehicleInstance = [_vehicleAssignmentId] call _fnc_findAssignedVehicleInArray;

diag_log format ["Assigning '%1' to '%2' with role '%3'", _unit, _vehicleInstance, _roleArray];
		
if (!(isNil "_vehicleInstance") && !(isNil "_roleArray")) then {
	private _role = _roleArray # 0;

	switch (_role) do {
		case "driver": {
			_unit moveInDriver _vehicleInstance;
		};
		case "gunner": {
			_unit moveInGunner _vehicleInstance;
		};
		case "cargo": {
			private _cargoIndex = _roleArray # 1;
			_unit moveInCargo [_vehicleInstance, _cargoIndex];
		};
		case "commander": {
			_unit moveInCommander _vehicleInstance;
		};
		case "turret": {
			private _turretPath = _roleArray # 2;
			_unit moveInTurret [_vehicleInstance, _turretPath];
		};
	};
};