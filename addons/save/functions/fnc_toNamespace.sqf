#include "script_component.hpp"

/*
 * Function: adf_save_fnc_toNamespace
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
 * This function is used for saving variables to a namespace.
 *
 * Arguments:
 * 0: Name of Namespace <STRING> (default: "")
 * 1: Key to save to namespace <STRING> (default: "")
 * 2: Value to save to key <ARRAY> (default: "")
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_save_fnc_toNamespace
 *
 * Public: Yes
 */

params [["_namespace", "", [""]], ["_key", "", [""]], ["_value", "", [[], 0, "", false, createhashMap]]];

switch (_namespace) do {
	case "local": {
		localNamespace setVariable [_key, _value];
	};
	case "mission": {
		missionProfileNamespace setVariable [_key, _value];
	};
	case "parsing": {
		parsingNamespace setVariable [_key, _value];
	};
	case "profile": {
		missionProfileNamespace setVariable [_key, _value];
	};
	case "ui": {
		uiNamespace setVariable [_key, _value];
	};
};