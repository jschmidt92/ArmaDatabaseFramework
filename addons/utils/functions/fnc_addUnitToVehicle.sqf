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

params [["_unit", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_vehicleData", nil, [createHashMap]]];

private _vehAssgnID = 0;
private _vehRoleArr = [];

if (isNil "_unit") exitWith { [EGVAR(db,debug), "adf_utils_fnc_addUnitToVehicle", "No unit to assign role in vehicle", false] call DFUNC(debug); };

[EGVAR(db,debug), "adf_utils_fnc_addUnitToVehicle", format ["Adding '%1' to vehicle...", _unit], false] call DFUNC(debug);

if ((count _vehicleData) <= 1) exitWith { [EGVAR(db,debug), "adf_utils_fnc_addUnitToVehicle", format ["'%1' has no vehicle", _unit], false] call DFUNC(debug); };

{
    private _key = _x;
    private _value = _vehicleData get _key;

    switch (_key) do {
        case "id": { _vehAssgnID = _value };
        case "role": { _vehRoleArr = _value };
    };
} forEach keys _vehicleData;

waitUntil { (count EGVAR(db,vehs)) > 0 };

private _vehInst = [_vehAssgnID] call DEFUNC(helpers,findAssignedVeh);
		
if (!(isNil "_vehInst") && !(isNil "_vehRoleArr")) then {
	private _role = _vehRoleArr # 0;

	switch (_role) do {
		case "driver": {
			_unit moveInDriver _vehInst;
		};
		case "gunner": {
			_unit moveInGunner _vehInst;
		};
		case "cargo": {
			private _cargoIndex = _vehRoleArr # 1;
			_unit moveInCargo [_vehInst, _cargoIndex];
		};
		case "commander": {
			_unit moveInCommander _vehInst;
		};
		case "turret": {
			private _turretPath = _vehRoleArr # 2;
			_unit moveInTurret [_vehInst, _turretPath];
		};
	};
};

[EGVAR(db,debug), "adf_utils_fnc_addUnitToVehicle", "Added unit to vehicle.", false] call DFUNC(debug);