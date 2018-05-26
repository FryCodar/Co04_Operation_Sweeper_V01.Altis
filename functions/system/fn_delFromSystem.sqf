If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_delFromSystem

Description: Delete stored Units/Vehicles from System!

Parameters: [Position]

Returns: Bool

Examples:
            _isStored = [(getMarkerPos "TargetTown")] call MSOT_system_fnc_delFromSystem;

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_output","_vec_store","_grp_store","_mortar_store","_artillery_store","_x","_holder","_get_idx","_found_arr","_del_arr",
         "_del_it","_i","_del_obj","_changed_mortar","_changed_artillery"];
params ["_del_pos"];


If(missionNamespace getVariable[STRVAR_DO(write_to_system),false])then
{waitUntil{!(missionNamespace getVariable[STRVAR_DO(write_to_system),false])};};

missionNamespace setVariable[STRVAR_DO(delete_from_system),true,false];

_output = false;
_holder = [];
_changed_mortar = false;
_changed_artillery = false;
_grp_store = missionNamespace getVariable[STRVAR_DO(group_store),[]];
ARR_ADDVAR(_holder,_grp_store);
_vec_store = missionNamespace getVariable[STRVAR_DO(vehicle_store),[]];
ARR_ADDVAR(_holder,_vec_store);
_mortar_store = missionNamespace getVariable[STRVAR_DO(mortar_store),[]];
_artillery_store = missionNamespace getVariable[STRVAR_DO(artillery_store),[]];


{
 switch(_forEachIndex)do
 {
   case 0:{
            If(count _x > 0)then{
            _get_idx = [2,_x,_del_pos] call MFUNC(system,getInfoArray);
            if(count _get_idx > 0)then
            {
              _found_arr = _x select (_get_idx select 0);
              _del_arr = _found_arr select 1; _counter = ((count _del_arr) - 1);
              F_LOOP(_i,0,_counter)
              {
                _del_obj = (_del_arr select _i);
                If(!isNull _del_obj)then{{deleteVehicle _x;}forEach units _del_obj;};
              };
              _x deleteAt (_get_idx select 0);
              missionNamespace setVariable[STRVAR_DO(group_store),_x,false];
              _del_it = [];
            };
           };
          };
   case 1:{
           If(count _x > 0)then{
            _get_idx = [2,_x,_del_pos] call MFUNC(system,getInfoArray);
            if(count _get_idx > 0)then
            {
              _found_arr = _x select (_get_idx select 0);
              _del_arr = _found_arr select 1;_counter = ((count _del_arr) - 1);
              F_LOOP(_i,0,_counter)
              {
                _del_obj = (_del_arr select _i);
                switch(true)do
                {
                  case (count _mortar_store > 0 && _del_obj In _mortar_store):{_mortar_store = _mortar_store - [_del_obj];_changed_mortar = true;};
                  case (count _artillery_store > 0 && _del_obj In _artillery_store):{_artillery_store = _artillery_store - [_del_obj];_changed_artillery = true;};
                };
                If(!isNull _del_obj && {local _del_obj})then{deleteVehicle _del_obj;};
              };
              _x deleteAt (_get_idx select 0);
              missionNamespace setVariable[STRVAR_DO(vehicle_store),_x,false];
              If(_changed_mortar)then{missionNamespace setVariable [STRVAR_DO(mortar_store),_mortar_store,false];};
              If(_changed_artillery)then{missionNamespace setVariable [STRVAR_DO(artillery_store),_artillery_store,false];};
            };
           };
          };
    };
  _output = true;

}forEach _holder;

missionNamespace setVariable[STRVAR_DO(delete_from_system),false,false];
_output
