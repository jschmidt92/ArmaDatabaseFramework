#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_vehicleID
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
 * Generate unique ID for a vehicle and store it, or retrieve the unique ID of an existing vehicle.
 *
 * Arguments:
 * 0: Entity object <OBJECT> (default: nil)
 *
 * Return Value:
 * The return <SCALAR>
 *
 * Examples:
 * [veh1] call adf_generate_fnc_vehicleID
 *
 * Public: Yes
 */

params [["_vehicle", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

[EGVAR(db,debug), "adf_generate_fnc_vehicleID", text format ["Generating ID for vehicle '%1'...", _vehicle], false] call DEFUNC(utils,debug);

private _vehicleIndex = (EGVAR(db,vehs)) find _vehicle;

if (_vehicleIndex == -1) then {
    private _vehicleID = count (EGVAR(db,vehs));
    _vehicle setVariable [EGVAR(db,vehIDKey), _vehicleID];
    (EGVAR(db,vehs)) pushback _vehicle;

    [EGVAR(db,debug), "adf_generate_fnc_vehicleID", text format ["ID for vehicle '%1' has been successfully generated.", _vehicle], false] call DEFUNC(utils,debug);
} else {
    [EGVAR(db,debug), "adf_generate_fnc_vehicleID", text format ["Vehicle '%1' already had an existing ID.", _vehicle], false] call DEFUNC(utils,debug);
	private _vehicleID = ((EGVAR(db,vehs)) # _vehicleIndex) getVariable EGVAR(db,vehIDKey);
};

_vehicleID;