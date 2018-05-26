if(isMultiplayer)then{If(!isServer)exitWith{};};
#include "msot_components.hpp"
/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_creating_fnc_setBase

Description: Sets Objects defined in init_bases.sqf in the Main Folder

Parameters: [INDEX,POSITION,DIRECTION]

            INDEX         -     defined NUMBERS
            POSITION      -     ARRAY with COORDINATES
            DIRECTION     -     Direction in which you want to build the base

Returns: Arrays with Objectnames - [[Names of Objects],[Names of Special Objects]]

Examples:
            _isStored = [2,(getMarkerPos "BASE"),(random 360)] call MSOT_creating_fnc_setBase

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_output","_spec_obj","_objects","_all_obj"];
params ["_obj_idx","_pos","_dir"];

_output = [];
_spec_obj = [];
_all_obj = [];

handle = [_obj_idx] execVM "init_bases.sqf";
waitUntil{scriptdone handle};
If(!isNil "BASES_STORE" && {count BASES_STORE > 0})then
{
  _objects = [_pos,_dir,(BASES_STORE select 0)] call BFUNC(ObjectsMapper);
  If(count (BASES_STORE select 1) > 0 && {count _objects > 0})then
  {
    {If((typeOf _x) isEqualTo ((BASES_STORE select 1) select 0))then{ARR_ADDVAR(_spec_obj,_x);};}forEach _objects;
  };
};
_output = [_objects,_spec_obj];
_output
