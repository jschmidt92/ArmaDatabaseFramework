#include "script_component.hpp"

/*
 * Function: adf_db_fnc_config
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
 * Configuration for ADF_ARMADBCORE.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call adf_db_fnc_config
 *
 * Public: Yes
 */

EGVAR(db,debug) = true;
[EGVAR(db,debug), "adf_db_fnc_config", format ["Configuring '%1'...", Scenario_Name], true] call DEFUNC(utils,debug);

EGVAR(db,host) = player;
EGVAR(db,prefix) = "ADF_ARMADBCORE";
EGVAR(db,saveInterval) = 600;
EGVAR(db,conts) = [];
EGVAR(db,slots) = [];
EGVAR(db,vars) = [];
EGVAR(db,vehs) = [];

[EGVAR(db,debug), "adf_db_fnc_config", format ["Setting global variables '%1'... Host: '%2', Prefix: '%3', Save Interval: '%4', Vehicles: '%5', Containers: '%6' and Variables: '%7'", Scenario_Name, EGVAR(db,host), EGVAR(db,prefix), EGVAR(db,saveInterval), EGVAR(db,vehs), EGVAR(db,conts), EGVAR(db,vars)], true] call DEFUNC(utils,debug);

EGVAR(db,configDone) = true;
[EGVAR(db,debug), "adf_db_fnc_config", format ["Finished configuring '%1'.", Scenario_Name], true] call DEFUNC(utils,debug);