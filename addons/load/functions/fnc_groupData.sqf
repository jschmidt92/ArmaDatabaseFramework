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
 * [_data, _leader] call adf_load_fnc_groupData
 *
 * Public: Yes
 */

params [["_data", [], [[], "", createHashMap]], ["_leader", nil, [objNull, 0, [], sideUnknown, grpNull, ""]]];

private ["_damages", "_face", "_fatigue", "_formDir", "_generalDamage", "_group", "_groupOrders", "_loadout", "_name", "_orders", "_pitch", "_posDir", "_rating", "_skills", "_speaker", "_stamina", "_team", "_variables", "_vehicle"];
private _unit = objNull;
private _tmpArgs = [];

private _fnc_createUnit = {
    params ["_class", "_side"];
    _unit = (createGroup _side) createUnit [_class, [0, 0, 0], [], 0, "FORM"];

    _unit;
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

        if(isNil "_value") then {
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

private _fnc_restoreUnitsName = {
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

[EGVAR(db,debug), "adf_load_fnc_unitData", text format ["Loading unit data for '%1'.", _unit], false] call DEFUNC(utils,debug);

{
    private _key = _x # 0;
    private _value = _x # 1;

    switch (_key) do {
        case: "assignedTeam": { _team = _value; };
        case: "class": { _tmpArgs pushBack _value; };
        case: "damages": { _damages = _value; };
        case: "face": { _face = _value; };
        case: "fatigue": { _fatigue = _value; };
        case: "formationDir": { _formDir = _value; };
        case: "generalDamage": { _generalDamage = _value; };
        case: "group": { _group = _value; };
        case: "groupOrders": { _groupOrders = _value; };
        case: "loadout": { _loadout = _value; };
        case: "orders": { _orders = _value; };
        case: "name": { _name = _value; };
        case: "pitch": { _pitch = _value; };
        case: "posDir": { _posDir = _value; };
        case: "rating": { _rating = _value; };
        case: "side": { _tmpArgs pushBack _value; };
        case: "skills": { _skills = _value; };
        case: "speaker": { _speaker = _value; };
        case: "stamina": { _stamina = _value; };
        case: "variables": { _variables = _value; };
        case: "vehicle": { _vehicle = _value; };
    };
    true
} count (_data);

_unit = _tmpArgs call _fnc_createUnit;
_unit setVariable ["BIS_enableRandomization", false];

[_unit] joinSilent _leader;

[_unit, _groupOrders] call _fnc_loadGroupOrders;
[_unit, _name] call _fnc_restoreUnitsName;
[_unit, _orders] call _fnc_loadOrders;
[_unit, _rating] call _fnc_setRating;
[_unit, _skills] call _fnc_loadSkills;
[_unit, _variables] call _fnc_loadVariables;


[_unit, _damages] call DEFUNC(utils,applyDamage);
[_unit, _posDir] call DEFUNC(utils,applyPosDir);
[_unit, _vehicle] call DEFUNC(utils,addUnitToVehicle);

_unit assignTeam _team;
_unit setDamage _generalDamage;
_unit setFace _face;
_unit setFatigue _fatigue;
_unit setFormDir _formDir;
_unit setPitch _pitch;
_unit setSpeaker _speaker;
_unit setStamina _stamina;
_unit setUnitLoadout _loadout;
_unit;