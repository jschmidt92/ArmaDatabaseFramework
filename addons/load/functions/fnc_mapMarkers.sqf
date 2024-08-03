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

[EGVAR(db,debug), "adf_load_fnc_mapMarkers", format ["Loading map markers from slot '%1'...", _slot], false] call DEFUNC(utils,debug);

private _allMarkers = allMapMarkers;

{ deleteVehicle _x } forEach _allMarkers;
[_allMarkers] call DEFUNC(utils,clearArray);

private _markers = ["markers", _slot] call DEFUNC(core,loadData);

if (isNil "_markers" || (count _markers) == 1) exitWith { [EGVAR(db,debug), "adf_load_fnc_mapMarkers", format ["No markers to load from slot '%1'.", _slot], true] call DEFUNC(utils,debug); };

{
    private _namespace = _x;
    private _nameValuePairs = _y;

    if (_namespace select [0, 7] == "marker.") then {
        private _marker = createMarker [_nameValuePairs getOrDefault ["name", ""], _nameValuePairs getOrDefault ["position", []]];

        {
            private _key = _x;
            private _value = _y;

            switch (_key) do {
                case "alpha": { _marker setMarkerAlpha _value };
                case "brush": { _marker setMarkerBrush _value };
                case "color": { _marker setMarkerColor _value };
                case "dir": { _marker setMarkerDir _value };
                case "position": { _marker setMarkerPos _value };
                case "shape": { _marker setMarkerShape _value };
                case "size": { _marker setMarkerSize _value };
                case "text": { _marker setMarkerText _value };
                case "type": { _marker setMarkerType _value };
            };
        } forEach _nameValuePairs;
    };
} forEach _markers;

[EGVAR(db,debug), "adf_load_fnc_mapMarkers", "Map markers loaded.", false] call DEFUNC(utils,debug);