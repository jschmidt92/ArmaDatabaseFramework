#include "script_component.hpp"

/*
 * Function: adf_db_fnc_openPersistentTab
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
 * Opens and setup the persistent tab.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_openPersistentTab
 *
 * Public: Yes
 */

[EGVAR(db,debug), "openPersistentTab", format ["'%1' opened Persistent Tab.", EGVAR(db,host)], false] call adf_utils_fnc_debug;

createDialog "persistentMenu";

//  Tab ID
EGVAR(db,listBox) = 1102;
EGVAR(db,saveButton) = 1103;
EGVAR(db,loadButton) = 1104;
EGVAR(db,deleteButton) = 1105;
EGVAR(db,scenarioNameText) = 1106;
EGVAR(db,saveVehicleButton) = 1107;

//  Update Scenario Name 
ctrlSetText [EGVAR(db,scenarioNameText), Scenario_Name];

//  Update List Box
[EGVAR(db,listBox)] call DFUNC(updatePersistentList);

//  Tab Variables
EGVAR(db,selectedList) = [EGVAR(db,listBox)] call DFUNC(getSelectedList);