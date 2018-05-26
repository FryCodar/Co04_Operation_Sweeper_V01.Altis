#include "msot_components.hpp"
/* ---------------------------------------------------------------------------------------------------------
Function: MSOT_spawnhelp_fnc_getStreetInDistance

Description: Return a Position of a Streetblock in a defined Radius

Parameters: [Position,Radius]


Returns:  Positionarray
Examples:
          _streetblocks = [(getMarkerPos "Town"),800] call MSOT_spawnhelp_fnc_getStreetInDistance;

Author: Fry

------------------------------------------------------------------------------------------------------------- */
private ["_output","_streets_arr","_so_pos","_dir","_x_dir"];
params ["_pos","_radius"];


_output = [];
_so_pos = _pos getPos [_radius,(random 360)];
_streets_arr = [_so_pos,50,true] call MFUNC(spawnhelp,getStreets);
_dir = _pos getDir _so_pos;_x_dir = _dir + 1;
while{count _streets_arr == 0 && !(_x_dir isEqualTo _dir)}do
{
  _so_pos = _pos getPos [_radius,_x_dir];
  _streets_arr = [_so_pos,50,true] call MFUNC(spawnhelp,getStreets);
  _x_dir = If((_x_dir + 1) > 360)then{1}else{_x_dir + 1};
  sleep 0.04;
};
If(count _streets_arr > 0)then
{
  _street_arr = [_so_pos,50] call MFUNC(spawnhelp,nearestStreet);
  If(!(_street_arr isEqualTo ""))then{_output = (getPos _street_arr);};
};
_output
