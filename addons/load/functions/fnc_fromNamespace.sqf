#include "script_component.hpp"

/*
 * Function: adf_load_fnc_fromNamespace
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
 * This function is used for loading variables from a namespace.
 *
 * Arguments:
 * 0: Name of Namespace <STRING> (default: "")
 * 1: Key to retrieve from namespace <STRING> (default: "")
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["profile", "playerName"] call adf_load_fnc_fromNamespace
 *
 * Public: Yes
 */

params [["_namespace", "", [""]], ["_key", "", [""]]];

private _value = [];

switch (_namespace) do {
	case "local": {
		_value = localNamespace getVariable _key;
	};
	case "mission": {
		_value = missionProfileNamespace getVariable _key;
	};
	case "parsing": {
		_value = parsingNamespace getVariable _key;
	};
	case "profile": {
		_value = missionProfileNamespace getVariable _key;
	};
	case "ui": {
		_value = uiNamespace getVariable _key;
	};
};

_value;