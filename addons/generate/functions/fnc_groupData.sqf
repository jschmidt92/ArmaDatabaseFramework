#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_groupData
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
 * Generate unit data for a group.
 *
 * Arguments:
 * 0: Entity object <OBJECT> (default: nil)
 *
 * Return Value:
 * The return <ARRAY>
 *
 * Examples:
 * [leaderUnit] call adf_generate_fnc_groupData
 *
 * Public: Yes
 */

params [["_leader", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

if (isNil "_leader" || isNull _leader) exitWith {[EGVAR(db,debug), "adf_generate_fnc_groupData", "No entity to generate group data for.", true] call DEFUNC(utils,debug); };

private _groupArray = units group _leader;
private _unitsData = [];

[EGVAR(db,debug), "adf_generate_fnc_groupData", format ["Generating group data for leader '%1'...", _leader], false] call DEFUNC(utils,debug);

{
    if (_x != _leader && alive _x) then {
        _unitsData pushBack ([_x, false] call DFUNC(unitData));
    };
    true
} count (_groupArray);

[EGVAR(db,debug), "adf_generate_fnc_groupData", format ["Group data for leader '%1' has been successfully generated.", _leader], false] call DEFUNC(utils,debug);

_unitsData;