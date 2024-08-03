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

[EGVAR(db,debug), "adf_save_fnc_mapMarkers", format ["Saving map markers to slot '%1'.", _slot], false] call DEFUNC(utils,debug);

private _markers = createHashMap;
private _count = 1;
private _allMarkers = allMapMarkers;
//  private _allMarkers = allMapMarkers - markersToExclude;

{
    private _data = createHashMap;
    private _name = _x;

    if ((_name splitString ' ') # 0 == "_USER_DEFINED") then {
        _name = format ["_USER_DEFINED %1_STORED", _count];
        _count = _count + 1;
    };

    _data set ["name", _name];    
    _data set ["alpha", markerAlpha _x];
    _data set ["brush", markerBrush _x];
    _data set ["color", markerColor _x];
    _data set ["dir", markerDir _x];
    _data set ["id", _forEachIndex];
    _data set ["position", markerPos _x];
    _data set ["shape", markerShape _x];
    _data set ["size", markerSize _x];
    _data set ["text", markerText _x];
    _data set ["type", markerType _x];
    
    _markers set [format ["marker.%1", _forEachIndex], _data];
} forEach _allMarkers;

["markers", _markers, _slot] call DEFUNC(core,saveData);