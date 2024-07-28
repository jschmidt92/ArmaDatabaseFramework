#include "script_component.hpp"

/*
 * Function: adf_db_fnc_init
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
 * Initialize the framework.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_init
 *
 * Public: Yes
 */

[true, "adf_db_fnc_init", text format ["Starting '%1'...", Scenario_Name], false] call DEFUNC(utils,debug);

EGVAR(db,configDone) = false;
[] call DFUNC(config);
waitUntil { EGVAR(db,configDone) };

EGVAR(db,defaultSlots) = ["Empty Slot"];

// Keys
EGVAR(db,pListKey) = Scenario_Name + "_pList"; 
EGVAR(db,vehIDKey) = "Save_QueueID";

EGVAR(db,host) addAction ["<t color='#0089f2'>Persistent</t>", { [] call DFUNC(openPersistentTab); }];