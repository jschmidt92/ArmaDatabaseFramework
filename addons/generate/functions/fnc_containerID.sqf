#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_containerID
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
 * Generate unique ID for a container and store it, or retrieve the unique ID of an existing container.
 *
 * Arguments:
 * 0: Entity object <OBJECT> (default: nil)
 *
 * Return Value:
 * The return <SCALAR>
 *
 * Examples:
 * [cont1] call adf_generate_fnc_containerID
 *
 * Public: Yes
 */

params [["_container", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

private _containerID = 0;

if (isNil "_container" || isNull _container) exitWith {[EGVAR(db,debug), "adf_generate_fnc_containerID", "No container to generate ID for.", true] call DEFUNC(utils,debug); };

[EGVAR(db,debug), "adf_generate_fnc_containerID", format ["Generating ID for container '%1'...", _container], false] call DEFUNC(utils,debug);

private _containerIndex = (EGVAR(db,conts)) find _container;

if (_containerIndex == -1) then {
    _containerID = count (EGVAR(db,conts));
    _container setVariable [EGVAR(db,contIDKey), _containerID];
    (EGVAR(db,conts)) pushback _container;

    [EGVAR(db,debug), "adf_generate_fnc_containerID", format ["ID for container '%1' has been successfully generated.", _container], false] call DEFUNC(utils,debug);
} else {
    [EGVAR(db,debug), "adf_generate_fnc_containerID", format ["Vehicle '%1' already had an existing ID.", _container], false] call DEFUNC(utils,debug);
	_containerID = ((EGVAR(db,conts)) # _containerIndex) getVariable EGVAR(db,contIDKey);
};

_containerID;