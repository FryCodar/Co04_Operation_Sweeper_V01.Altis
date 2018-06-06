If(isMultiplayer)then{If(!hasInterface)exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_getClientAction

Description: Get AddAction Information

Parameters: [OBJECT,CALLER,ID,ARGUMENTS]


Returns: Nothing

Examples:
          _this spawn MSOT_system_fnc_getClientAction

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_holder","_search_it","_founded_arr","_handle","_script","_end_it","_set_arr","_apos"];
params ["_obj","_caller","_id","_arguments"];

If(!(_obj getVariable [STRVAR_DO(in_use),false]))then{
_obj setVariable [STRVAR_DO(in_use),true,true];

_holder = _obj getVariable [STRVAR_DO(mission_actions),[]];
If(count _holder > 0)then
{

  switch(typeName (_holder select 1))do
  {
    case "STRING":{
                    If(count (_holder select 1) > 0)then
                    {
                      _handle = _this execVM _script;
                      waitUntil{scriptDone _handle};
                    };
                  };
     case "CODE":{
                   _this call (_holder select 1);
                 };
  };
  If(_this call (compile (_holder select 2)))then
  {
    ["MAINTARGETS",_obj,(_holder select 0)] spawn MFUNC(system,eventHandling);
    If(_holder select 3)then
    {
      deleteVehicle _obj;
    }else{_set_arr = [_obj,_id];REMOTE_NOREXESM(_set_arr,removeAction,-2)};
  };
};
If(!isNull _obj)then{_obj setVariable [STRVAR_DO(in_use),false,true];};
};
