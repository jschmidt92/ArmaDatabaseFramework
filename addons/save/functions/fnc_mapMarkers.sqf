#include "script_component.hpp"

/*
 * Function: adf_save_fnc_mapMarkers
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
 * Save map marker data to specified slot.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_save_fnc_mapMarkers
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_save_fnc_mapMarkers", text format ["Saving map markers to slot '%1'.", _slot], false] call DEFUNC(utils,debug);

private _markersArray = [];
private _userMarkersCounter = 1;
private _allMarkers = allMapMarkers;
//  private _allMarkers = allMapMarkers - markersToExclude;

{
    private _marker = [];
    private _name = _x;

    if ((_name splitString ' ') # 0 == "_USER_DEFINED") then {
        _name = format ["_USER_DEFINED %1_STORED", _userMarkersCounter];
        _userMarkersCounter = _userMarkersCounter + 1;
    };

    _marker pushBack ["name", _name];    
    _marker pushBack ["alpha", markerAlpha _x];
    _marker pushBack ["brush", markerBrush _x];
    _marker pushBack ["color", markerColor _x];
    _marker pushBack ["dir", markerDir _x];
    _marker pushBack ["position", markerPos _x];
    _marker pushBack ["shape", markerShape _x];
    _marker pushBack ["size", markerSize _x];
    _marker pushBack ["text", markerText _x];
    _marker pushBack ["type", markerType _x];
    
    _markersArray pushBack _marker;
    true
} count (_allMarkers);

["markers", _markersArray, _slot] call DEFUNC(core,saveData);