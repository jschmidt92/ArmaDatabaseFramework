#include "script_component.hpp"

/*
 * Function: adf_load_fnc_mapMarkers
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
 * Load map marker data from specified slot and create map markers.
 *
 * Arguments:
 * 0: ID of Slot <SCALAR> (default: 0)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [1] call adf_load_fnc_mapMarkers
 *
 * Public: Yes
 */

params [["_slot", 0, [0]]];

[EGVAR(db,debug), "adf_load_fnc_mapMarkers", text format ["Loading map markers from slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _allMarkers = allMapMarkers;

{
    deleteMarker _x;
    true
} count (_allMarkers);

private _markers = ["markers", _slot] call DEFUNC(core,loadData);

{
    private _key =  _x # 0;
    private _value = _x # 1;
    
    switch (_key) do {
        case "alpha": { _alpha = _value; };
        case "brush": { _brush = _value; };
        case "color": { _color = _value; };
        case "dir": { _dir = _value; };
        case "name": { _name = _value; };
        case "position": { _position = _value; };
        case "shape": { _shape = _value; };
        case "size": { _size = _value; };
        case "text": { _text = _value; };
        case "type": { _type = _value; };
    };

    private _marker = createMarker [_name, _position];
    
    _marker setMarkerAlpha _alpha;
    _marker setMarkerBrush _brush;
    _marker setMarkerColor _color;
    _marker setMarkerDir _dir;
    _marker setMarkerShape _shape;
    _marker setMarkerSize _size;
    _marker setMarkerText _text;
    _marker setMarkerType _type;
    true
} count (_markers);

[EGVAR(db,debug), "adf_load_fnc_mapMarkers", "Map markers loaded.", false] call DEFUNC(utils,debug);