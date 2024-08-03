#include "script_component.hpp"

/*
 * Function: adf_generate_fnc_dateData
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
 * Generate a string Date and Time using format [hh:mm dd/mm/yy].
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * The return <STRING>
 *
 * Examples:
 * [] call adf_generate_fnc_dateData
 *
 * Public: Yes
 */

[EGVAR(db,debug), "adf_generate_fnc_dateData", "Generating date and time string...", false] call DEFUNC(utils,debug);

private _return = "";
private _time = systemTime;
private _hour = _time # 3;
private _minute = _time # 4;
private _month = _time # 1;
private _day = _time # 2;
private _year = _time # 0;

private _string = format ["%1:%2 %3/%4/%5", _hour, _minute, _month, _day, _year];

EGVAR(db,saveTime) = _string;
_return = _string;

[EGVAR(db,debug), "adf_generate_fnc_dateData", "Date and time string generated.", false] call DEFUNC(utils,debug);
_return;