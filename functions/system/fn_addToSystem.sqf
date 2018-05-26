If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_addToSystem

Description: Stores GROUPS/Vehicles etc in System.

Parameters: [StoreName,Position,Array with Names,(Optional: Number)]

            StoreName     -    "GROUPS","VEHICLES","MORTARS","ARTILLERY"
            Position      -     position Array
            Array with Names  - Array with Names of GROUPS/Vehicles

Returns: Bool

Examples:
            _isStored = ["GROUPS",(getMarkerPos "TargetTown"),[GRP1...GRP2]] call MSOT_system_fnc_addToSystem;

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_work_arr","_run","_selector","_new_add_arr","_fill_arr","_fill_seqment"];
params ["_store_name","_chk_pos","_add_it_arr"];


_work_arr = [];
_run = true;
_selector = 0;
_new_add_arr = [];

If(missionNamespace getVariable [STRVAR_DO(delete_from_system),false])then
{waitUntil{!(missionNamespace getVariable [STRVAR_DO(delete_from_system),false])};};

missionNamespace setVariable[STRVAR_DO(write_to_system),true,false];

switch(_store_name)do
{
  case "GROUPS":{_work_arr = missionNamespace getVariable[STRVAR_DO(group_store),[]];_selector = 1;};
  case "VEHICLES":{_work_arr = missionNamespace getVariable[STRVAR_DO(vehicle_store),[]];_selector = 1;};
  case "MORTARS":{_work_arr = missionNamespace getVariable[STRVAR_DO(mortar_store),[]];_selector = 2;};
  case "ARTILLERY":{_work_arr = missionNamespace getVariable[STRVAR_DO(artillery_store),[]];_selector = 2;};
  default {_run = false;};
};
If(_run)then
{
  If(count _work_arr > 0)then
  {
    switch(_selector)do
    {
      case 1:{
               _searched_idx = [2,_work_arr,_chk_pos] call MFUNC(system,getInfoArray);
               If(count _searched_idx > 0)then
               {
                 _fill_arr = _work_arr select (_searched_idx select 0);
                 _fill_seqment = _fill_arr select 1; ARR_ADDARR(_fill_seqment,_add_it_arr);
                 _fill_arr set [1,_fill_seqment]; _work_arr set [(_searched_idx select 0),_fill_arr];
                 _new_add_arr = _work_arr;
               }else{
                      _fill_arr = [_chk_pos,_add_it_arr]; ARR_ADDVAR(_work_arr,_fill_arr);
                      _new_add_arr = _work_arr;
                    };
             };
      case 2:{
                ARR_ADDARR(_work_arr,_add_it_arr);_new_add_arr = _work_arr;
             };
    };
  }else{
         switch(_selector)do
         {
           case 1:{_new_add_arr = [[_chk_pos,_add_it_arr]];};
           case 2:{_new_add_arr = _add_it_arr;};
         };
       };

switch(_store_name)do
{
  case "GROUPS":{missionNamespace setVariable[STRVAR_DO(group_store),_new_add_arr,false];};
  case "VEHICLES":{missionNamespace setVariable[STRVAR_DO(vehicle_store),_new_add_arr,false];};
  case "MORTARS":{missionNamespace setVariable[STRVAR_DO(mortar_store),_new_add_arr,false];};
  case "ARTILLERY":{missionNamespace setVariable[STRVAR_DO(artillery_store),_new_add_arr,false];};
};
};
missionNamespace setVariable[STRVAR_DO(write_to_system),false,false];
_run
