If(!isServer)exitWith{};
#include "msot_components.hpp"

/* -----------------------------------------------------------------------------------------------
Function: MSOT_usage_fnc_setMapMarker

Description: Create Marker on Map.

             SERVER

Parameters: [Position,MarkerName,MarkerShape,[MarkerSize],MarkerColor,MarkerType,MarkerBrush,MarkerDirection,MarkerText]

            Position     : Array with Coordinates
            MarkerName   : Name of Marker you want to give STRING
            MarkerShape  : "ELLIPSE","ELLIPSE_BORDER","RECTANGLE","ICON"
            MarkerSize   : Array [a-axis, b-axis]
            MarkerColor  :(Optional) Color of Marker
            MarkerType   :(Optional) Type of Marker
            MarkerBrush  :(Optional) fill texture for the marker
            MarkerDirection :(Optional) Direction of Marker
            MarkerText   :(Optional) Text at Marker - only for ICON

Returns: Name of Marker

Examples:
          _marker_name = [(position player),"TARGETMARKER","ELLIPSE",[200,200]] call MSOT_usage_fnc_setMapMarker;

Author: Fry

-------------------------------------------------------------------------------------------------- */
private ["_output","_do_your_job","_main_pos","_marker","_chk_to_store"];
params ["_marker_pos","_marker_name","_marker_shape","_marker_size",["_marker_color","ColorRed"],["_marker_type","Empty"],["_marker_brush","SolidBorder"],["_marker_dir",0],["_marker_txt",""]];

_output = "";
_do_your_job = true;


switch(toUpper _marker_shape)do
{
  case "ELLIPSE":{_marker_type = "Empty";_marker_txt = "";};
  case "ELLIPSE_BORDER":{_marker_shape = "ELLIPSE";_marker_type = "Empty";_marker_brush = "Border";_marker_txt = "";};
  case "RECTANGLE":{_marker_type = "Empty";_marker_txt = "";};
  case "ICON":{If(_marker_type == "Empty")exitWith{LOG_ERR("Control MarkerType for a ICON Marker!");};};
};


_marker = createMarker [_marker_name,[(_marker_pos select 0),(_marker_pos select 1)]];
_marker_name setMarkerShape _marker_shape;
_marker_name setMarkerType _marker_type;
_marker_name setMarkerColor _marker_color;
_marker_name setMarkerDir _marker_dir;
If((toUpper _marker_shape) != "ICON")then
{
 _marker_name setMarkerSize _marker_size;
 _marker_name setMarkerBrush _marker_brush;
 _marker_name setMarkerAlpha 0.8;
};
If(_marker_txt != "")then{_marker_name setMarkerText _marker_txt;};
_output = _marker_name;


_output
