#include "msot_components.hpp"
/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_getInfoArray

Description: Search specific Things in given Array.

Parameters: [INDEX,ARRAY,SEARCHEDOBJECT]

            INDEX: 1 - Search for Things in a normal ARRAY
                   2 - Search for first Thing in a multidimensional array  >> [[x,1,2,3],[x,A,B,C]]
                   3 - [[Position,[[Target,MarkerName,Succsess,Failed,Do Script],[Target,MarkerName,Succsess,Failed,Do Script]],DOSCRIPT]]
                       >> RETURN [0,1] means [(1st Element in Array),(3rd Element of 2nd Part in 1st Element of Array)]
            ARRAY: Name of Array

            SEARCHEDOBEJECT : All what u think to find

Returns: ARRAY filled with founded Arrayindex

Examples:
            _found = [1,["Hello",2,[2,3,4]],"Hello"] call MSOT_system_fnc_getInfoArray;
            _found = [2,[[1,3,4],[5,7,8]],5] call MSOT_system_fnc_getInfoArray;

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_output","_found","_idx1","_x","_i","_scan_inner_arr","_scanner_2nd_arr","_counter","_scanner_2nd_inner_arr"];
params["_idx","_scan_array","_searched_thing"];

_output = [];

switch(_idx)do
{
 case 1:{{If(_searched_thing isEqualTo _x)then{_output = [_forEachIndex];};}forEach _scan_array;};
 case 2:{{If(_searched_thing isEqualTo (_x select 0))then{_output = [_forEachIndex];};}forEach _scan_array;};
 case 3:{
          _found = false; _idx1 = -1;
          {
            If(!_found)then
            {
             _idx1 = _forEachIndex; _scan_inner_arr = _x; _scanner_2nd_arr = _scan_inner_arr select 1; _counter = ((count _scanner_2nd_arr) - 1);
             F_LOOP(_i,0,_counter)
             {
              _scanner_2nd_inner_arr = _scanner_2nd_arr select _i;
              If((_scanner_2nd_inner_arr select 0) isEqualTo _searched_thing)then
              {_output = [_idx1,_i];_found = true;_counter = _i;};
              sleep 0.04;
             };
           };
          }forEach _scan_array;
        };
};
_output
