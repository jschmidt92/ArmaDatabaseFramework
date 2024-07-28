#include "script_component.hpp"

/*
 * Function: adf_db_fnc_getSelectedList
 * Author: NikolaiF90, PrinceF90, J.Schmidt
 * Edit: 07.27.2024
 * Copyright © 2024 NikolaiF90, PrinceF90, J.Schmidt, All rights reserved
 *
 * Do not edit without permission!
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivative 4.0 International License.
 * To view a copy of this license, vist https://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons,
 * PO Box 1866, Mountain View, CA 94042
 *
 * [Description]
 * Return the index of the currently selected item of the listbox with the idc.
 *
 * Arguments:
 * 0: The idc of the listbox <SCALAR> (default: 0)
 *
 * Return Value:
 * The return <SCALAR>
 *
 * Examples:
 * [1106] call adf_db_fnc_getSelectedList
 *
 * Public: Yes
 */

 params [["_idc", 0, [0]]];

 _selected = lbCurSel _idc;

 if (_selected == -1) then { _selected = 0 };

 _selected;