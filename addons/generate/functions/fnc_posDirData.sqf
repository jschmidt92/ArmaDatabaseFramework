#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_posDirData
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
 * Generate position and direction for  an entity.
 *
 * Arguments:
 * 0: Entity object <OBJECT> (default: nil)
 *
 * Return Value:
 * The return <ARRAY>
 *
 * Examples:
 * [leaderUnit] call adf_generate_fnc_posDirData
 *
 * Public: Yes
 */

params [["_entity", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

if (isNil "_entity" || isNull _entity) exitWith {[EGVAR(db,debug), "adf_generate_fnc_posDirData", "No entity to generate position and direction array for.", true] call DEFUNC(utils,debug); };

[EGVAR(db,debug), "adf_generate_fnc_posDir", format ["Generating position and direction array for entity '%1'...", _entity], false] call DEFUNC(utils,debug);

private _pos = getPosATL _entity;
private _dir = getDir _entity;
private _returnData = [_pos, _dir];

[EGVAR(db,debug), "adf_generate_fnc_posDir", format ["Position and direction array for entity '%1' has been successfully generated.", _entity], false] call DEFUNC(utils,debug);

_returnData;