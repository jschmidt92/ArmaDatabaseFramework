#include "script_component.hpp"

/*
 * Function: adf_db_fnc_updatePersistentList
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
 * Update list with save slots.
 *
 * Arguments:
 * 0: IDC of list box <SCALAR> (default: -1)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_updatePersistentList
 *
 * Public: Yes
 */

params [["_listID", -1, [0]]];

if !(_listID > -1) exitWith { [EGVAR(db,debug), "adf_db_fnc_updatePersistentList", format ["Invalid input for listID '%1'.", _listID], false] call DEFUNC(utils,debug); };

[EGVAR(db,debug), "adf_db_fnc_updatePersistentList", "Updating persistent slots...", true] call DEFUNC(utils,debug);

[EGVAR(db,debug), "adf_db_fnc_updatePersistentList", "Clearing slots...", false] call DEFUNC(utils,debug);
lbClear _listID;
[EGVAR(db,debug), "adf_db_fnc_updatePersistentList", "Cleared slots.", false] call DEFUNC(utils,debug);

[EGVAR(db,debug), "adf_db_fnc_updatePersistentList", "Loading slots from profileNamespace...", false] call DEFUNC(utils,debug);
private _slotArray = profileNameSpace getVariable EGVAR(db,pListKey);

if (isNil "_slotArray") then {
	[EGVAR(db,debug), "adf_db_fnc_updatePersistentList", "No saves found, using default slot instead.", false] call DEFUNC(utils,debug);
	EGVAR(db,slots) = EGVAR(db,defaultSlots);
} else {
	[EGVAR(db,debug), "adf_db_fnc_updatePersistentList", "Saves found. Now populating list with save slots.", false] call DEFUNC(utils,debug);
	EGVAR(db,slots) = _slotArray;
};

{
	lbAdd [_listID, _x];
	true
} count (EGVAR(db,slots));

[EGVAR(db,debug), "adf_db_fnc_updatePersistentList", "Persistent tab updated.", true] call DEFUNC(utils,debug);