If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_doMissionCheck

Description: Stores Units/Vehicles etc in System.

Parameters: [INDEX,POSITION/OBJECT,STRING/NUMBER]

            INDEX             -    "MAINTARGETS","RESPAWNPOSES","MAINTRIGGER"
            POSITION/OBJECT   -     OBJECT at "MAINTARGETS" & "MAINTRIGGER" / POSITION at "RESPAWNPOSES"
            STRING/NUMBER     -     STRING at "MAINTARGETS" / NUMBER at "MAINTRIGGER"

Returns: Nothing

Examples:
            _isStored = [] spawn MSOT_system_fnc_doMissionCheck

Author: Fry

----------------------------------------------------------------------------------------------------------------- */

private ["_work_arround","_output","_found_pos","_holder","_search_idx","_f1_idx","_f2_idx","_founded_arr","_founded_2nd_arr","_target_arr","_target","_marker_name",
         "_script","_clear_mission","_holder_action","_handle","_size","_st_idx","_del_bool"];
params ["_idx","_value","_value1","_value2"];

If(missionNamespace getVariable [STRVAR_DO(write_to_missinfo),false])then
{waitUntil{!(missionNamespace getVariable [STRVAR_DO(write_to_missinfo),false])};};

missionNamespace setVariable [STRVAR_DO(delete_from_missinfo),true,true];

_work_arround = [];
_output = [];
_found_pos = [];
_clear_mission = false;

switch(toUpper _idx)do
{
  case "MAINTARGETS":{
                       If((typeName _value) isEqualTo "OBJECT" && {(typeName _value1) isEqualTo "STRING"})then
                       {
                        //Check & Clear MAINTARGETS
                        _holder = missionNamespace getVariable [STRVAR_DO(mission_main_targets),[]];
                        if(count _holder > 0)then
                        {
                          _search_idx = [3,_holder,_value] call MFUNC(system,getInfoArray);
                          If(count _search_idx == 2)then
                          {
                            _f1_idx = (_search_idx select 0); _f2_idx = (_search_idx select 1); _founded_arr = (_holder select _f1_idx);
                            _found_pos = (_founded_arr select 0);_founded_2nd_arr = (_founded_arr select 1); _target_arr = (_founded_2nd_arr select _f2_idx);
                            _target = (_target_arr select 0); _marker_name = (_target_arr select 1); _script = (_target_arr select 2);
                            If((typeName _marker_name) isEqualTo "STRING" && count _marker_name > 0)then{deleteMarker _marker_name;};
                            switch(typeName _script)do
                            {
                              case "STRING":{If(count _script > 0)then{
                                             [3,_found_pos,_target,_value1,_script] call {_handle = [(_this select 0),(_this select 1),(_this select 2),(_this select 3)] execVM (_this select 4);
                                                                                          waitUntil{scriptDone _handle};
                                                                                         };
                                             };
                                            };
                              case "CODE":{[3,_found_pos,_target,_value1] call _script;};
                            };
                            ARR_MINIDX(_founded_2nd_arr,_f2_idx);
                            If(count _founded_2nd_arr == 0)then
                            {
                              _clear_mission = true; ARR_MINIDX(_holder,_f1_idx);
                            }else{ARR_SET(_founded_arr,1,_founded_2nd_arr); ARR_SET(_holder,_f1_idx,_founded_arr);};
                            missionNamespace setVariable [STRVAR_DO(mission_main_targets),_holder,false];
                          };
                          //Check & Clear MAINACTIONS
                          _holder_action = missionNamespace getVariable [STRVAR_DO(mission_actions),[]];
                          If(count _holder_action > 0)then
                          {
                            _search_idx = [2,_holder_action,_value] call MFUNC(system,getInfoArray);
                            If(count _search_idx > 0)then
                            {
                              ARR_MINIDX(_holder_action,(_search_idx select 0));
                              missionNamespace setVariable [STRVAR_DO(mission_actions),_holder_action,true];
                              If(!isNull _value)then{REMOTE_NOREXESM(_value,removeAllActions,([0,-2] select isDedicated));};
                            };
                          };
                          //Check & Clear ACTIONSTORAGE
                          _holder_action = missionNamespace getVariable [STRVAR_DO(action_storage),[]];
                          If(count _holder_action > 0)then
                          {
                            _search_idx = [2,_holder_action,_value] call MFUNC(system,getInfoArray);
                            If(count _search_idx > 0)then
                            {
                              ARR_MINIDX(_holder_action,(_search_idx select 0));
                              If(!isNil "_value2" && (typeName _value2) isEqualTo "BOOL")then{If(_value2)then{deleteVehicle _value;};};
                              missionNamespace setVariable [STRVAR_DO(action_storage),_holder_action,true];
                            };
                          };
                        };
                        //Check & Clear MAINMARKER
                        If(_clear_mission)then
                        {
                          _holder = missionNamespace getVariable [STRVAR_DO(mission_main_marker),[]];
                          If(count _holder > 0)then
                          {
                            _search_idx = [2,_holder,_found_pos] call MFUNC(system,getInfoArray);
                            If(count _search_idx > 0)then
                            {
                              _f1_idx = (_search_idx select 0); _founded_arr = (_holder select _f1_idx); _founded_2nd_arr = (_founded_arr select 1);
                              _marker_name = (_founded_2nd_arr select 0); _script = (_founded_2nd_arr select 1);
                              ARR_MINIDX(_holder,_f1_idx); missionNamespace setVariable [STRVAR_DO(mission_main_marker),_holder,false];
                              If(count _marker_name > 0)then{deleteMarker _marker_name;};
                              switch(typeName _script)do
                              {
                                case "STRING":{If(count _script > 0)then
                                               {
                                                  [4,_found_pos,_value1,_script] spawn {
                                                                                        sleep 2;
                                                                                        [(_this select 0),(_this select 1),(_this select 2)] execVM (_this select 3);
                                                                                       };
                                               };
                                              };
                                case "CODE":{[4,_found_pos,_value1,_script] spawn {
                                                                                      sleep 2;
                                                                                      [(_this select 0),(_this select 1),(_this select 2)] spawn (_this select 3);
                                                                                  };
                                            };
                              };
                            };
                          };
                        };
                      }else{LOG_ERR("CHECK_FNC MAINTARGETS : WRONG DATATYPES IN FUNCTION PARAMETERS DETECTED!");};
                     };
  case "RESPAWNPOSES":{
                        If((typeName _value) isEqualTo "ARRAY")then
                        {
                          _holder = missionNamespace getVariable [STRVAR_DO(resp_poses),[]];
                          If(count _holder > 0)then
                          {
                            _search_idx = [2,_holder,_value] call MFUNC(system,getInfoArray);
                            If(count _search_idx > 0)then
                            {
                              _f1_idx = (_search_idx select 0);_founded_arr = (_holder select _f1_idx);_found_pos = (_founded_arr select 0);
                              _target_arr = [2,_found_pos];
                              REMOTE_TRIEXESM(_target_arr,system,doClientRespawn,0);
                              ARR_MINIDX(_holder,_f1_idx); missionNamespace setVariable [STRVAR_DO(resp_poses),_holder,false];
                            };
                          };
                        }else{LOG_ERR("CHECK_FNC RESPAWNPOSES : WRONG DATATYPE IN FUNCTION PARAMETERS DETECTED!");};
                      };
  case "MAINTRIGGER":{
                        If((typeName _value) isEqualTo "OBJECT")then
                        {
                          _holder = missionNamespace getVariable [STRVAR_DO(mission_main_trigger),[]];
                          If(count _holder > 0)then
                          {
                            _search_idx = [3,_holder,_value] call MFUNC(system,getInfoArray);
                            If(count _search_idx == 2)then
                            {
                              _f1_idx = (_search_idx select 0); _f2_idx = (_search_idx select 1); _founded_arr = (_holder select _f1_idx);
                              _found_pos = (_founded_arr select 0);_founded_2nd_arr = (_founded_arr select 1); _target_arr = (_founded_2nd_arr select _f2_idx);
                              _target = (_target_arr select 0); _script = (_target_arr select 1);_st_idx = (_target_arr select 2);_del_bool = (_target_arr select 3);
                              _size = ((triggerArea _value) select 0); deleteVehicle _value;
                              switch(typeName _script)do
                              {
                                case "STRING":{If(count _script > 0)then
                                               {
                                                  [_st_idx,_found_pos,_size,_script] spawn {
                                                                                              sleep 2;
                                                                                              [(_this select 0),(_this select 1),(_this select 2)] execVM (_this select 3);
                                                                                            };
                                               };
                                              };
                                case "CODE":{[_st_idx,_found_pos,_size,_script] spawn {
                                                                                        sleep 2;
                                                                                        [(_this select 0),(_this select 1),(_this select 2)] spawn (_this select 3);
                                                                                       };
                                            };
                             };
                            ARR_MINIDX(_founded_2nd_arr,_f2_idx);
                            If(count _founded_2nd_arr == 0)then
                            {ARR_MINIDX(_holder,_f1_idx);}else{
                                                               If(_del_bool)then{{deleteVehicle (_x select 0);}forEach _founded_2nd_arr;ARR_MINIDX(_holder,_f1_idx);
                                                               }else{ARR_SET(_founded_arr,1,_founded_2nd_arr); ARR_SET(_holder,_f1_idx,_founded_arr);};
                                                              };
                            missionNamespace setVariable [STRVAR_DO(mission_main_trigger),_holder,false];
                          };
                         };
                        }else{LOG_ERR("CHECK_FNC MAINTRIGGERS : WRONG DATATYPE IN FUNCTION PARAMETERS DETECTED!");};
                    };
};

missionNamespace setVariable [STRVAR_DO(delete_from_missinfo),false,true];
