#include "script_component.hpp"

/*
 * Function: adf_utils_fnc_debug
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
 * This function is used for debugging. It will output a debug message in the debug log and systemChat.
 *
 * Arguments:
 * 0: Debug <BOOL> (default: false)
 * 1: Name of Function <STRING> (default: "")
 * 2: Text <STRING> (default: "")
 * 3: Visible <BOOL> (default: false)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_utils_fnc_debug
 *
 * Public: Yes
 */

params [["_debug", false, [false]], ["_function", "", [""]], ["_text", "", [""]], ["_visible", false, [false]]];

if (typeName _debug != "BOOL") exitWith { diag_log "ADF_Debug: (ERROR) adf_utils_fnc_log only accept boolean as the first parameters." };
if (isNil "_function") exitWith { diag_log "ADF_Debug: (ERROR) adf_utils_fnc_log does not accept empty parameters!" };
if (_function == "") then { _function = "DEBUG" };
if (isNil "_visible") then { _visible = false };

if (_debug) then {
	diag_log text format ["[ArmaDatabaseFramework: '%1'] %2", _function, _text];
	if (_visible) then {
		systemChat format ["[ArmaDatabaseFramework: %1] %2", _function, _text];
	};
};