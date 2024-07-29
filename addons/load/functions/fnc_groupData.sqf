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
private _damages = [];
private _face = "";
private _fatigue = 0;
private _firstName = "";
private _formDir = 0;
private _generalDamage = 0;
private _group = [];
private _groupOrders = [];
private _joinedNames = "";
private _loadout = [];
private _orders = [];
private _name = [];
private _pitch = 0;
private _posDir = [];
private _rating = 0;
private _side = sideUnknown;
private _skills = [];
private _speaker = "";
private _stamina = 0;
private _surname = "";
private _team = "";
private _tmpArgs = [];
private _unit = objNull;
private _variables = [];
private _vehicle = [];

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

private _fnc_setRating = {
    params ["_unit", "_rating"];

    if (rating _unit > _rating) then {
        _unit addRating -(rating _unit - _rating);
    } else {
        _unit addRating (_rating - rating _unit);
    };
};

{
    private _key = _x;
    private _value = _y;

    switch (_key) do {
        case "assignedTeam": { _team = _value; };
        case "class": { _class = _value; };
        case "damages": { _damages = _value; };
        case "face": { _face = _value; };
        case "fatigue": { _fatigue = _value; };
        case "formDir": { _formDir = _value; };
        case "generalDamage": { _generalDamage = _value; };
        case "group": { _group = _value; };
        case "groupOrders": { _groupOrders = _value; };
        case "loadout": { _loadout = _value; };
        case "orders": { _orders = _value; };
        case "name": { _name = _value; };
        case "pitch": { _pitch = _value; };
        case "posDir": { _posDir = _value; };
        case "rating": { _rating = _value; };
        case "side": { _side = _value; };
        case "skills": { _skills = _value; };
        case "speaker": { _speaker = _value; };
        case "stamina": { _stamina = _value; };
        case "variables": { _variables = _value; };
        case "vehicle": { _vehicle = _value; };
    };
} forEach _groupData;

private _unit = (createGroup _side) createUnit [_class, [0,0,0], [], 0, "FORM"];

[EGVAR(db,debug), "adf_load_fnc_unitData", format ["Loading unit group data for '%1'.", _unit], false] call DEFUNC(utils,debug);

_unit setVariable ["BIS_enableRandomization", false];

[_unit] joinSilent _leader;

[_unit, _groupOrders] call _fnc_loadGroupOrders;
[_unit, _orders] call _fnc_loadOrders;
[_unit, _rating] call _fnc_setRating;
[_unit, _skills] call _fnc_loadSkills;
[_unit, _variables] call _fnc_loadVariables;


[_unit, _damages] call DEFUNC(utils,applyDamage);
[_unit, _posDir] call DEFUNC(utils,applyPosDir);
[_unit, _vehicle] call DEFUNC(utils,addUnitToVehicle);

_unit assignTeam _team;
_unit setDamage _generalDamage;
_unit setFatigue _fatigue;
_unit setFormDir _formDir;
_unit setStamina _stamina;

private _unitData = [_face, _loadout, _name, _pitch, _speaker];

[_unit, _unitData] spawn {
    params ["_unit", "_unitData"];

    private _face = _unitData # 0;
    private _loadout = _unitData # 1;
    private _name = _unitData # 2;
    private _pitch = _unitData # 3;
    private _speaker = _unitData # 4;

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

    [_unit, _name] call  _fnc_restoreUnitsName;
    
    _unit setFace _face;
    _unit setPitch _pitch;
    _unit setSpeaker _speaker;
    _unit setUnitLoadout _loadout;
};

_unit;

[EGVAR(db,debug), "adf_load_fnc_unitData", "Unit group data loaded.", false] call DEFUNC(utils,debug);