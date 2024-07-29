#include "script_component.hpp"

/*
 * Function: adf_db_fnc_saveToSlot
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
 * Save or update data for specified slot.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_saveToSlot
 *
 * Public: Yes
 */

EGVAR(db,selectedList) = [EGVAR(db,listBox)] call DFUNC(getSelectedList);

[EGVAR(db,debug), "adf_db_fnc_saveToSlot", "Generating save...", false] call DEFUNC(utils,debug);

private _saveDate = [] call DEFUNC(generate,dateData);
private _saveName = format ["'%1' saved on, '%2'", Scenario_Name, _saveDate];
private _saveSlot = 0;

if (EGVAR(db,selectedList) == 0) then {
    [EGVAR(db,debug), "adf_db_fnc_saveToSlot", "Creating a new save slot...", false] call DEFUNC(utils,debug);
    EGVAR(db,slots) pushBack _saveName;
    _saveSlot = (count EGVAR(db,slots)) -1;
} else {
    [EGVAR(db,debug), "adf_db_fnc_saveToSlot", format ["Saving to slot '%1'", EGVAR(db,selectedList)], false] call DEFUNC(utils,debug);
    EGVAR(db,slots) set [EGVAR(db,selectedList), _saveName];
    _saveSlot = EGVAR(db,selectedList);
};

[EGVAR(db,debug), "adf_db_fnc_saveToSlot", "Now saving...", false] call DEFUNC(utils,debug);
[_saveSlot] call DEFUNC(save,game);

profileNamespace setVariable [QEGVAR(db,pListKey), EGVAR(db,slots)];

[EGVAR(db,debug), "adf_db_fnc_saveToSlot", "Progress saved.", false] call DEFUNC(utils,debug);
[EGVAR(db,listBox)] call DFUNC(updatePersistentList);