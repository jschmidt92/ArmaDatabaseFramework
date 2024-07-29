#include "script_component.hpp"

/*
 * Function: adf_save_fnc_variables
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
 * Save variable data to specified slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_save_fnc_variables
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_save_fnc_variables", format ["Saving all variables to slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _allVariables = [];

{
	private _namespace = _x # 0;
	private _name = _x # 1;
	private _value = [_namespace, _name] call DEFUNC(load,fromNamespace);

	_allVariables pushBack [_namespace, _name, _value];
	true
} count (EGVAR(db,vars));

["variables", _allVariables, _slot] call DEFUNC(core,saveData);

[EGVAR(db,debug), "adf_save_fnc_variables", "All variables saved.", false] call DEFUNC(utils,debug);