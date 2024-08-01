#include "script_component.hpp"

/*
 * Function: adf_load_fnc_groupData
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
 * Load player data from specified slot and setup player.
 *
 * Arguments:
 * 0: Unit object <OBJECT> (default: nil)
 * 1: Unit data <STRING|ARRAY> (default: [])
 * 2: Leader object <OBJECT> (default: nil)
 *
 * Return Value:
 * The return <OBJECT>
 *
 * Examples:
 * [_groupData, _leader] call adf_load_fnc_groupData
 *
 * Public: Yes
 */

params [["_groupData", [], [[], "", createHashMap]], ["_leader", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

if (isNil "_groupData" || (count _groupData) <= 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_groupData", "No group data to load.", false] call DEFUNC(utils,debug); };

private _class = "";
private _side = sideUnknown;

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case "class": { _class = _value; };
        case "side": { _side = _value; };
    };
    true
} count _groupData;

private _unit = (createGroup _side) createUnit [_class, [0, 0, 0], [], 0, "FORM"];

waitUntil { !(isNil "_unit") };

[EGVAR(db,debug), "adf_load_fnc_unitData", format ["Loading unit group data for '%1'.", _unit], false] call DEFUNC(utils,debug);

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case "assignedTeam": { _unit assignTeam _value; };
        case "damages": { [_unit, _value] call DEFUNC(utils,applyDamage); };
        case "face": { _unit setFace _value; };
        case "fatigue": { _unit setFatigue _value; };
        case "formDir": { _unit setFormDir _value; };
        case "generalDamage": { _unit setDamage _value; };
        case "groupOrders": { [_unit, _value] call DEFUNC(helpers,setGroupOrders); };
        case "loadout": { _unit setUnitLoadout _value; };
        case "name": { [_unit, _value] call DEFUNC(helpers,restoreName); };
        case "orders": { [_unit, _value] call DEFUNC(helpers,setOrders); };
        case "pitch": { _unit setPitch _value; };
        case "posDir": { [_unit, _value] call DEFUNC(utils,applyPosDir); };
        case "rating": { [_unit, _value] call DEFUNC(helpers,setRating); };
        case "skills": { [_unit, _value] call DEFUNC(helpers,setSkills); };
        case "speaker": { _unit setSpeaker _value; };
        case "stamina": { _unit setStamina _value; };
        case "variables": { [_unit, _value] call DEFUNC(helpers,setVariables); };
        case "vehicle": { [_unit, _value] spawn DEFUNC(utils,addUnitToVehicle); };
    };
    true
} count (_groupData);

[EGVAR(db,debug), "adf_load_fnc_unitData", "Unit group data loaded.", false] call DEFUNC(utils,debug);

_unit setVariable ["BIS_enableRandomization", false];

[_unit] joinSilent _leader;
_unit;