#include "script_component.hpp"

/*
 * Function: adf_load_fnc_variables
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
 * Load unit variable data from specified slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_load_fnc_variables
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_load_fnc_variables", format ["Loading all variables from slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _allVariables = ["variables", _slot] call DEFUNC(core,loadData);

if (isNil "_allVariables" || (count _allVariables) == 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_variables", format ["No variables to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };

[EGVAR(db,vars)] call DEFUNC(utils,clearArray);

{
	private _namespace = _x;
	private _nameValuePairs = _y;

	{
		private _key = _x;
		private _value = _y;

		[_namespace, _key, _value] call DEFUNC(save,toNamespace);
		EGVAR(db,vars) pushBack [_key, _value];
	} forEach _nameValuePairs;
} forEach _allVariables;

[EGVAR(db,debug), "adf_load_fnc_variables", "All variables loaded.", false] call DEFUNC(utils,debug);