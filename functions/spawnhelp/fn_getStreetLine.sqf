#include "msot_components.hpp"
/* ---------------------------------------------------------------------------------------------------------
Function: MSOT_spawnhelp_fnc_getStreetLine

Description: Return Number of Streetblocks in Line to specific Position and Direction

Parameters: [Position,Direction/Position,Number of Streetblocks]


Returns:  [Position,Direction]
Examples:
          _streetblocks = [(getMarkerPos "ConvoyStart"),240,7] call MSOT_spawnhelp_fnc_getStreetLine;

Author: Fry

------------------------------------------------------------------------------------------------------------- */
private ["_output","_direction_pos","_is_pos","_street_arr","_street_block","_connected_streets","_last_streetblock","_holder_arr","_ctrl",
         "_dir","_is_allowed","_chk","_chk_arr","_is_in_sector"];
params ["_center","_pos_dir","_num"];

_output = [];
_direction_pos = [];
_is_pos = If((typeName _pos_dir) isEqualTo "ARRAY")then{true}else{false};


_street_block = [_center,100] call MFUNC(spawnhelp,nearestStreet);

If(!((typeName _street_block) isEqualTo "STRING"))then
{
  If(_is_pos)then{_direction_pos = _pos_dir;}else{_direction_pos = (position _street_block) getPos [100,_pos_dir];};
  _holder_arr = [];
  _ctrl = 0;
  _dir = 0;
  _is_allowed = true;
  _last_streetblock = _street_block;

  While{count _holder_arr < _num && _ctrl < _num}do
  {
    If(_is_allowed)then
    {
     _chk = true;
     _chk_arr = [];
     _connected_streets = roadsConnectedTo _last_streetblock;
     {
       If(_chk)then
       {
        _dir = GET_DIRPOS(_x,_last_streetblock);
        _is_in_sector = [(position _x),_dir,180,_direction_pos] call MFUNC(geometry,inAngleSector);
        If(_is_in_sector)then{_chk_arr = [(position _x),_dir]; _chk = false;_last_streetblock = _x;};
       };
     }forEach _connected_streets;
     If(count _chk_arr > 0)then{ARR_ADDVAR(_holder_arr,_chk_arr);}else{_is_allowed = false;};
    };
    _ctrl = _ctrl + 1;
  sleep 0.04;
  };
  If(_is_allowed)then{_output = _holder_arr;};
};
_output
