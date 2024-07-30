#include "script_component.hpp"

/*
 * Function: adf_load_fnc_unitData
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
 * [_unit, _unitData, _leader] call adf_load_fnc_unitData
 *
 * Public: Yes
 */

params [["_unit", nil, [objNull, 0, [], sideUnknown, grpNull, ""]], ["_unitData", [], [[], "", createHashMap]], ["_leader", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

if (isNil "_unit") exitWith {[EGVAR(db,debug), "adf_load_fnc_unitData", "No unit to load data for.", true] call DEFUNC(utils,debug); };

private _tmpArgs = [_unit];

private _fnc_createUnit = {
    params ["_unit", "_class", "_side"];
    
    if (isNil { _unit }) then {
        _unit = (createGroup _side) createUnit [_class, [0, 0, 0], [], 0, "FORM"];
    };
    
    _unit;
};

private _fnc_removeGroupUnits = {
    params ["_unit"];
    
    {
        if (_unit != _x) then {
            deleteVehicle _x;
        };
        true
    } count (units _unit);
};

private _fnc_joinGroupLeader = {
    params ["_unit", "_leader"];
    
    if (!isNil "_leader") then {
        [_unit] joinSilent _leader;
    };
};

private _fnc_loadGroupUnits = {
    params ["_leader", "_group"];
    
    {
       [_x, _leader] spawn DFUNC(groupData);
       true
    } count (_group);
};

private _fnc_loadOrders = {
    params ["_unit", "_ordersArray"];

    {
        private _key = _x # 0;
        private _value = _x # 1;

        switch (_key) do {
            case "behaviour": { _unit setBehaviour _value; };
            case "unitPos": { _unit setUnitPos _value; };
        };

        true
    } count (_ordersArray);
};

private _fnc_loadGroupOrders = {
    params ["_unit", "_groupOrdersArray"];

    private _group = group _unit;

    if (leader _group == _unit) then {
        {
            private _key = _x # 0;
            private _value = _x # 1;

            switch (_key) do {
                case "combatMode": { _group setCombatMode _value; };
                case "formation": { _group setFormation _value; };
                case "speedMode": { _group setSpeedMode _value; };
            };
            true
        } count (_groupOrdersArray);
    };
};

private _fnc_loadVariables = {
    params ["_unit", "_varsArray"];

    {
        _unit setVariable [_x, nil];
        true
    } count (allVariables _unit);

    {
        private _key = _x # 0;
        private _value = _x # 1;

        if (isNil "_value") then {
            _unit setVariable [_key, nil];
        } else {
            _unit setVariable [_key, _value];
        };
        true
    } count (_varsArray);
};

private _fnc_loadSkills = {
    params ["_unit", "_skillsArray"];

    {
        _unit setSkill [_x # 0, _x # 1];
        true
    } count (_skillsArray);
};

private _fnc_restoreName = {
    params ["_unit", "_nameArray"];
    
    private _firstName = "";
    private _surname = "";
    private _joinedNames = "";
    
    if (count _nameArray == 1) then {
        _surname = _nameArray # 0;
        _joinedNames = _surname;
    } else {
        _firstName = _nameArray # 0;
        _surname = _nameArray # 1;
        _joinedNames = format ["%1 %2", _firstName, _surname];
    };
    
    _unit setName [_joinedNames, _firstName, _surname];
};

private _fnc_setRating = {
    params ["_unit", "_rating"];

    if (rating _unit > _rating) then {
        _unit addRating -(rating _unit - _rating);
    } else {
        _unit addRating (_rating - rating _unit);
    };
};

[EGVAR(db,debug), "adf_load_fnc_unitData", format ["Loading unit data for '%1'.", _unit], false] call DEFUNC(utils,debug);

{
    private _key = _x;
    private _value = _y;

    switch (_key) do {
        case "assignedTeam": { _unit assignTeam _value; };
        case "class": { _tmpArgs pushBack _value; };
        case "damages": { [_unit, _value] call DEFUNC(utils,applyDamage); };
        case "face": { _unit setFace _value; };
        case "fatigue": { _unit setFatigue _value; };
        case "formDir": { _unit setFormDir _value; };
        case "generalDamage": { _unit setDamage _value; };
        case "group": { [_unit, _value] call _fnc_loadGroupUnits; };
        case "groupOrders": { [_unit, _value] call _fnc_loadGroupOrders; };
        case "loadout": { _unit setUnitLoadout _value; };
        case "name": { [_unit, _value] call _fnc_restoreName; };
        case "orders": { [_unit, _value] call _fnc_loadOrders; };
        case "pitch": { _unit setPitch _value; };
        case "posDir": { [_unit, _value] call DEFUNC(utils,applyPosDir); };
        case "rating": { [_unit, _value] call _fnc_setRating; };
        case "side": { _tmpArgs pushBack _value; };
        case "skills": { [_unit, _value] call _fnc_loadSkills; };
        case "speaker": { _unit setSpeaker _value; };
        case "stamina": { _unit setStamina _value; };
        case "variables": { [_unit, _value] call _fnc_loadVariables; };
        case "vehicle": { [_unit, _value] call DEFUNC(utils,addUnitToVehicle); };
    };
} forEach _unitData;

_unit = _tmpArgs call _fnc_createUnit;
_unit setVariable ["BIS_enableRandomization", false];

[_unit] call _fnc_removeGroupUnits;
[_unit, _leader] call _fnc_joinGroupLeader;
_unit;

[EGVAR(db,debug), "adf_load_fnc_unitData", "Unit data loaded.", false] call DEFUNC(utils,debug);