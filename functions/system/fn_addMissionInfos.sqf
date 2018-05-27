If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"
/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_addMissionInfos

Description: Stores Units/Vehicles etc in System.

Parameters: [StoreName,Position,Array with Names,(Optional: Number)]

            StoreName     -    "MAINMARKER","MAINTARGETS","MAINACTIONS","ACTIONSTORAGE","RESPAWNPOSES"
            Position      -     position Array or or any Values u think to find
            Array         -     Array with Informations

Returns: Nothing

Examples:
            _isStored = ["GROUPS",(getMarkerPos "TargetTown"),[S1,....,S10]] spawn MSOT_system_fnc_addMissionInfos

Author: Fry

----------------------------------------------------------------------------------------------------------------- */

private ["_output","_holder","_add_arr","_search_it","_found_arr","_found_inside"];
params ["_index","_value","_add_at_choice"];
_output = false;
If(missionNamespace getVariable [STRVAR_DO(delete_from_missinfo),false])then
{waitUntil{!(missionNamespace getVariable [STRVAR_DO(delete_from_missinfo),false])};};

missionNamespace setVariable [STRVAR_DO(write_to_missinfo),true,true];

switch(toUpper _index)do
{
  case "MAINMARKER":{
                      If((typeName _value) isEqualTo "ARRAY" && {(typeName _add_at_choice) isEqualTo "ARRAY"})then
                      {
                        _holder = missionNamespace getVariable [STRVAR_DO(mission_main_marker),[]];
                        If(count _holder > 0)then
                        {
                          _search_it = [2,_holder,_value] call MFUNC(system,getInfoArray);
                          If(count _search_it == 0)then
                          {
                            _add_arr = [_value,_add_at_choice];
                            ARR_ADDVAR(_holder,_add_arr); missionNamespace setVariable [STRVAR_DO(mission_main_marker),_holder,false];
                          }else{LOG_ERR("MAINMARKER : SAME VALUES IN INFO STORAGE DETECTED");};
                        }else{_holder = [[_value,_add_at_choice]];missionNamespace setVariable [STRVAR_DO(mission_main_marker),_holder,false];};
                        _output = true;
                      }else{LOG_ERR("MAINMARKER : WRONG DATATYPES IN FUNCTION PARAMETERS DETECTED!");};
                    };
  case "MAINTARGETS":{
                       If((typeName _value) isEqualTo "ARRAY" && {(typeName _add_at_choice) isEqualTo "ARRAY"})then
                       {
                         _holder = missionNamespace getVariable [STRVAR_DO(mission_main_targets),[]];
                         If(count _holder > 0)then
                         {
                            _search_it = [2,_holder,_value] call MFUNC(system,getInfoArray);
                            If(count _search_it > 0)then
                            {
                              _found_arr = _holder select (_search_it select 0); _found_inside = _found_arr select 1;
                              switch(typeName (_add_at_choice select 0))do
                              {
                                case "OBJECT":{ARR_ADDVAR(_found_inside,_add_at_choice);_output = true;};
                                case "ARRAY":{ARR_ADDARR(_found_inside,_add_at_choice);_output = true;};
                              };
                              ARR_SET(_found_arr,1,_found_inside); ARR_SET(_holder,(_search_it select 0),_found_arr);
                              //_found_arr set [1,_found_inside];_holder set [(_search_it select 0),_found_arr];
                              missionNamespace setVariable [STRVAR_DO(mission_main_targets),_holder,false];
                            }else{
                                   _add_arr = [];
                                   switch(typeName (_add_at_choice select 0))do
                                   {
                                     case "OBJECT":{_add_arr = [_value,[_add_at_choice]];_output = true;};
                                     case "ARRAY":{_add_arr = [_value,_add_at_choice];_output = true;};
                                   };
                                   If(count _add_arr > 0)then
                                   {ARR_ADDVAR(_holder,_add_arr); missionNamespace setVariable [STRVAR_DO(mission_main_targets),_holder,false];};
                                 };
                         }else{
                                _add_arr = [];
                                switch(typeName (_add_at_choice select 0))do
                                {
                                  case "OBJECT":{_add_arr = [[_value,[_add_at_choice]]];_output = true;};
                                  case "ARRAY":{_add_arr = [[_value,_add_at_choice]];_output = true;};
                                };
                                If(count _add_arr > 0)then{missionNamespace setVariable [STRVAR_DO(mission_main_targets),_add_arr,false];};
                              };
                       }else{LOG_ERR("MAINTARGETS : WRONG DATATYPES IN FUNCTION PARAMETERS DETECTED!");};

                     };
  case "MAINACTIONS":{
                      If((typeName _value) isEqualTo "ARRAY")then
                      {
                        _holder = missionNamespace getVariable [STRVAR_DO(mission_actions),[]];
                        If(count _holder > 0)then
                        {
                          _search_it = [2,_holder,(_value select 0)] call MFUNC(system,getInfoArray);
                          If(count _search_it == 0)then
                          {
                            ARR_ADDVAR(_holder,_value); missionNamespace setVariable [STRVAR_DO(mission_actions),_holder,true];_output = true;
                          }else{LOG_ERR("MAINACTIONS : SAME VALUE IN INFO STORAGE DETECTED");};
                          ARR_ADDVAR(_holder,_value); missionNamespace setVariable [STRVAR_DO(mission_actions),_holder,true];_output = true;
                        }else{_holder = [_value]; missionNamespace setVariable [STRVAR_DO(mission_actions),_holder,true];_output = true;};
                      }else{LOG_ERR("MAINACTIONS : WRONG DATATYPE IN FUNCTION PARAMETERS DETECTED!");};
                     };
  case "ACTIONSTORAGE":{

                          If((typeName _value) isEqualTo "ARRAY")then
                          {
                            _holder = missionNamespace getVariable [STRVAR_DO(action_storage),[]];
                            If(count _holder > 0)then
                            {
                              _search_it = [2,_holder,(_value select 0)] call MFUNC(system,getInfoArray);
                              If(count _search_it == 0)then
                              {
                                ARR_ADDVAR(_holder,_value); missionNamespace setVariable [STRVAR_DO(action_storage),_holder,true];_output = true;
                                REMOTE_TRIEXESM(_value,system,setClientAction,0);
                              }else{LOG_ERR("ACTIONSTORAGE : SAME VALUE IN INFO STORAGE DETECTED");};
                              ARR_ADDVAR(_holder,_value); missionNamespace setVariable [STRVAR_DO(action_storage),_holder,true];_output = true;
                            }else{_holder = [_value]; missionNamespace setVariable [STRVAR_DO(action_storage),_holder,true];
                                  REMOTE_TRIEXESM(_value,system,setClientAction,0);
                                  _output = true;
                                 };
                          }else{LOG_ERR("ACTIONSTORAGE : WRONG DATATYPE IN FUNCTION PARAMETERS DETECTED!");};
                       };
  case "RESPAWNPOSES":{
                        If((typeName _value) isEqualTo "ARRAY")then
                        {
                          _holder = missionNamespace getVariable [STRVAR_DO(resp_poses),[]];
                          If(count _holder > 0)then
                          {
                            _search_it = [2,_holder,_value] call MFUNC(system,getInfoArray);
                            If(count _search_it == 0)then
                            {
                              _add_arr = [_value,_add_at_choice];
                              ARR_ADDVAR(_holder,_add_arr); missionNamespace setVariable [STRVAR_DO(resp_poses),_holder,true];_output = true;
                              _found_arr = [0,_add_arr];
                              REMOTE_TRIEXESM(_found_arr,system,doClientRespawn,0);
                            }else{LOG_ERR("RESPAWNPOSES : SAME VALUE IN INFO STORAGE DETECTED");};
                          }else{
                                _add_arr = [_value,_add_at_choice];
                                _holder = [_add_arr]; missionNamespace setVariable [STRVAR_DO(resp_poses),_holder,true];
                                _found_arr = [0,_add_arr];
                                REMOTE_TRIEXESM(_found_arr,system,doClientRespawn,0);
                               };
                        }else{LOG_ERR("RESPAWNPOSES : WRONG DATATYPE IN FUNCTION PARAMETERS DETECTED!");};
                      };
   case "MAINTRIGGER":{
                        If((typeName _value) isEqualTo "ARRAY" && {(typeName _add_at_choice) isEqualTo "ARRAY"})then
                        {
                          _holder = missionNamespace getVariable [STRVAR_DO(mission_main_trigger),[]];
                          If(count _holder > 0)then
                          {
                            _search_it = [2,_holder,_value] call MFUNC(system,getInfoArray);
                            If(count _search_it > 0)then
                            {
                              _found_arr = _holder select (_search_it select 0); _found_inside = _found_arr select 1;
                              ARR_ADDVAR(_found_inside,_add_at_choice);
                              ARR_SET(_found_arr,1,_found_inside); ARR_SET(_holder,(_search_it select 0),_found_arr);
                              //_found_arr set [1,_found_inside]; _holder set [(_search_it select 0),_found_arr];
                              missionNamespace setVariable [STRVAR_DO(mission_main_trigger),_holder,false];
                            }else{
                                   _add_arr = [_value,[_add_at_choice]];
                                   ARR_ADDVAR(_holder,_add_arr);
                                   missionNamespace setVariable [STRVAR_DO(mission_main_trigger),_holder,false];
                                 };
                          }else{_holder = [[_value,[_add_at_choice]]]; missionNamespace setVariable [STRVAR_DO(mission_main_trigger),_holder,false];};
                        }else{LOG_ERR("MAINTRIGGER : WRONG DATATYPES IN FUNCTION PARAMETERS DETECTED!");};
                      };
};
missionNamespace setVariable [STRVAR_DO(write_to_missinfo),false,true];
_output
