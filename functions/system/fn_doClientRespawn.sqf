If(isMultiplayer)then{if(!hasInterface) exitWith{};};
#include "msot_components.hpp"

private ["_pos","_resp_pos","_id","_holder","_add_arr","_search_it"];
params ["_idx","_value"];

switch(_idx)do
{
  case 0:{
           _pos = (_value select 0); _resp_pos = (_value select 1);
           _id = [player,_resp_pos] call BFUNC(addRespawnPosition);
           _holder = missionNamespace getVariable [STRVAR_DO(client_respawn_pos),[]]; _add_arr = [_pos,_id];
           ARR_ADDVAR(_holder,_add_arr); missionNamespace setVariable [STRVAR_DO(client_respawn_pos),_holder,false];
         };
  case 1:{
           _holder = missionNamespace getVariable [STRVAR_DO(client_respawn_pos),[]];
          {
            _pos = (_x select 0); _resp_pos = (_x select 1);
            _id = [player,_resp_pos] call BFUNC(addRespawnPosition);
           _add_arr = [_pos,_id]; ARR_ADDVAR(_holder,_add_arr);
          }forEach _value;
          missionNamespace setVariable [STRVAR_DO(client_respawn_pos),_holder,false];
         };
  case 2:{
           _holder = missionNamespace getVariable [STRVAR_DO(client_respawn_pos),[]];
           If(count _holder > 0)then
           {
             _search_it = [2,_holder,_value] call MFUNC(system,getInfoArray);
             If(count _search_it > 0)then
             {
               _add_arr = _holder select (_search_it select 0);
               (_add_arr select 1) call BFUNC(removeRespawnPosition);
               ARR_MINIDX(_holder,(_search_it select 0));
               missionNamespace setVariable [STRVAR_DO(client_respawn_pos),_holder,false];
             };
           };
         };
};
