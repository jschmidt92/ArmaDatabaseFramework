#include "script_component.hpp"

/*
 * Function: adf_load_fnc_environment
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
 * Load environment data from specified slot and change weather.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_load_fnc_environment
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_load_fnc_environment", format ["Loading environment data from slot '%1'", _slot], false] call DEFUNC(utils,debug);

private _environment = ["environment", _slot] call DEFUNC(core,loadData);

if (isNil "_environment" || (count _environment) == 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_environment", format ["No environment data to load from slot '%1'", _slot], false] call DEFUNC(utils,debug); };

private _transitionTime = 15;

{
    private _key = _x;
    private _value = _y;

    switch (_key) do {
        case "date": { setDate _value };
        case "rain": { _transitionTime setRain _value };
        case "fog": { _transitionTime setFog _value };
        case "overcast": { _transitionTime setOvercast _value };
    };
} forEach _environment;

[EGVAR(db,debug), "adf_load_fnc_environment", "Environment data loaded.", false] call DEFUNC(utils,debug);