#include "msot_components.hpp"
/* -----------------------------------------------------------------------------------------------
Function: MSOT_spawnhelp_fnc_getMapLocations

Description: Find Locations on Map

Parameters: [Number,position,min radius, max radius]

            Number (Optinal): minimum count of Houses - 6 Houses is default Value
            Position (Optional): Center for Searching Locations
            MIN RADIUS (Optional): Minimum Distance to find Locations in metres
            MAX RADIUS (Optional): Maximum Distance to find Locations in metres


Returns: Array with Arrays of available Locations
         [["CityName",position, size]]

Examples:
          _location_list = [] call MSOT_spawnhelp_fnc_getMapLocations;
          _location_list = [20,(position player),0,1500] call MSOT_spawnhelp_fnc_getMapLocations;

Author: Fry

-------------------------------------------------------------------------------------------------- */
private ["_not_allowed","_output","_dist","_location_arr","_config","_angle","_name","_pos","_xsize","_ysize","_type","_text","_size",
         "_house_num","_town_arr"];
params ["_center","_min_radius","_max_radius",["_min_houses",6]];

If(_min_radius >= _max_radius)then{If(true) exitWith {LOG_ERR("GRAD_spawnhelp_fnc_getMapLocations: CHECK MIN/MAX RADIUS");};};
_not_allowed = ["Hill","NameMarine","Mount"];
_output = [];

_location_arr = (configfile >> "CfgWorlds" >> worldName >> "Names") call BFUNC(getCfgSubClasses);
If(count _location_arr > 0)then
{
  _config = configfile >> "CfgWorlds" >> worldName >> "Names";
  {
    _angle = getNumber(_config >> _x >> "angle");
    _name = getText(_config >> _x >> "name");
    _pos = getArray(_config >> _x >> "position");
    _xsize = getNumber(_config >> _x >> "radiusA");
    _ysize = getNumber(_config >> _x >> "radiusB");
    _type = getText(_config >> _x >> "type");
    _text = format["%1__%2",_name,_type];

    _size = round((_xsize + _ysize) * 0.5);
    _house_num = [[_pos select 0,_pos select 1,0],_size,false] call MFUNC(spawnhelp,checkHouses);
    If(!(_name isEqualTo "") && {!(_type In _not_allowed)} && {_house_num >= _min_houses})then
    {
      _dist = _center distance [_pos select 0,_pos select 1,0];
      If(_dist >= _min_radius && _dist <= _max_radius)then
      {
        _town_arr = [_name,_pos,_size];
        ARR_ADDVAR(_output,_town_arr);
      };      
    };
  }forEach _location_arr;
};
_output
