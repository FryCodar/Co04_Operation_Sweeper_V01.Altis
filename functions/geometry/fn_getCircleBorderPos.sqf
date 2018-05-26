#include "msot_components.hpp"
/* ---------------------------------------------------------------------------------------------------------
Function: MSOT_geometry_fnc_getCircleBorderPos

Description: Find a random Position on Circle Border with Water,House,Walls,Vehicle and Area check
             (Test a new "Random" Option)

Parameters: [Position,Radius,(Optional:Radius for big Objects)]

            Optional: Radius to find Places for big Objects without Houses,Walls,Vehicles and StaticWeapons

Returns:  [Position,Direction(given Position -> BorderPos)]
Examples:
          _borderpos = [(getMarkerPos "Town"),200] call MSOT_geometry_fnc_getCircleBorderPos;

Author: Fry

------------------------------------------------------------------------------------------------------------- */
private ["_output","_number","_found_pos","_co","_angle","_mran","_point","_dir","_onmap","_statics","_slope"];
params ["_position","_radius",["_big_radius",5]];

_output = [];
_found_pos = [];
_co = 0;
_angle = 0;
//hint "Hallo";

while{count _found_pos == 0 && _co < 100}do
{
 _number = selectRandom [10,20,30,40,50,60];
 F_LOOP(_mran,0,(round(random _number)))
 {
   _angle = floor (random 360);
   sleep 0.04;
 };
 _point = _position getPos [_radius,_angle];
 If(count _point > 0)then
 {
   _onmap = [_point] call MFUNC(spawnhelp,isOnMap);
   _statics = [_point,["Static","House","Tank","Car","StaticWeapon"],_big_radius] call MFUNC(spawnhelp,checkObjects);
   _slope = [_point] call MFUNC(spawnhelp,getSlope);
   If(!(surfaceIsWater _point) && _onmap && _slope && _statics < 1)then
   {
     _found_pos = _point;
     _dir = [_position,_point] call BFUNC(dirTo);
     _output = [_point,_dir];
   }else{_co = _co + 1;};
 };
 sleep 0.02
};
_output
