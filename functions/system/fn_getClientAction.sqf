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
_holder = missionNamespace getVariable [STRVAR_DO(mission_actions),[]];
If(count _holder > 0)then
{
  _search_it = [2,_holder,_obj] call MFUNC(system,getInfoArray);
  If(count _search_it > 0)then
  {
    _end_it = false;
    _founded_arr = (_holder select (_search_it select 0));
    _script = (_founded_arr select 2);
    switch(typeName _script)do
    {
      case "STRING":{If(count (_founded_arr select 2) > 0)then
                     {
                       _handle = _this execVM _script;
                       waitUntil{scriptDone _handle};
                       _end_it = true;
                     };
                    };
      case "CODE":{_this call (_founded_arr select 2);_end_it = true;};
    };

    If(_end_it)then
    {
      REMOTE_NOREXESM(_obj,removeAllActions,0);
      If(_founded_arr select 3)then{_apos = (getPosATL _obj);
                                    hint str _apos;
                                    _obj setPosATL [(_apos select 0),(_apos select 1),((_apos select 2) - 15)];
                                    SET_POSATLM(_obj,_apos,15);
                                    deleteVehicle _obj;
                                   };
      _set_arr = ["MAINTARGETS",_obj,(_founded_arr select 1),(_founded_arr select 3)];
      REMOTE_TRIEXESM(_set_arr,system,doMissionCheck,0);
    };
  };
};
If(!isNull _obj)then{_obj setVariable [STRVAR_DO(in_use),false,true];};
};
