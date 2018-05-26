
/* -----------------------------------------------------------------------------------------------
Function: MSOT_creating_fnc_setFSeffect

Description: Sets Smoke and Fire Effekt to Objects

Parameters: [OBJECTNAME/ARRAY, SETDAMAGE]

           OBJECTNAME/ARRAY - OBJECTNAME or ARRAY filled with OBJECTS
           SETDAMAGE - BOOL: true for set damage to Object / default: false

Important: all Modulenames are saved in - missionNamespace getVariable ["msot_fs_modulenames",[]]

Returns: Array with Modulnames

Examples:
          _modules = [Car1,true] call MSOT_creating_fnc_setFSeffect;
          _modules = [[Car1,Car2,Car3],true] call MSOT_creating_fnc_setFSeffect;

Author: Fry

-------------------------------------------------------------------------------------------------- */
If(isMultiplayer)then{if(hasInterface)exitwith{};};
#include "msot_components.hpp"
private ["_make_damage","_output_arr","_module_name_arr","_center_log","_Gmodul","_pos","_bound_pos",
         "_modul1","_modul2","_save_arr","_x"];

params["_obj","_dofulldamage"];

_make_damage = If(count _this > 1)then{_dofulldamage}else{false};
_module_name_arr = [];
_output_arr = [];
switch(typeName _obj)do
{
  case "ARRAY":{
                 _center_log = createCenter sideLogic;
                 _Gmodul = CREA_GROUP(_center_log);
                {
                  If(typeName _x == "OBJECT")then
                  {
                   if(_make_damage)then
                   {
                     _x setDamage [1,false];
                   };
                  _pos = position _x;
                  _bound_pos = ((boundingCenter _x) select 2);
                  _modul1 = _Gmodul createUnit ["ModuleEffectsSmoke_F", _pos, [], 0, "CAN_COLLIDE"];
                  _modul2 = _Gmodul createUnit ["ModuleEffectsFire_F", _pos, [], 0, "CAN_COLLIDE"];
                  SET_POSNOR(_modul1,_pos,_bound_pos);
                  SET_POSNOR(_modul2,_pos,_bound_pos);
                  ARR_ADDVAR(_module_name_arr,_modul1);
                  ARR_ADDVAR(_module_name_arr,_modul2);
                 };
                }forEach _obj
               };
  case "OBJECT":{
                  _center_log = createCenter sideLogic;
                  _Gmodul = createGroup _center_log;

                  if(_make_damage)then
                  {
                    _obj setDamage [1,false];
                  };
                 _pos = position _obj;
                 _bound_pos = ((boundingCenter _obj) select 2);
                 _modul1 = _Gmodul createUnit ["ModuleEffectsSmoke_F", _pos, [], 0, "CAN_COLLIDE"];
                 _modul2 = _Gmodul createUnit ["ModuleEffectsFire_F", _pos, [], 0, "CAN_COLLIDE"];
                 SET_POSNOR(_modul1,_pos,_bound_pos);
                 SET_POSNOR(_modul2,_pos,_bound_pos);
                 ARR_ADDVAR(_module_name_arr,_modul1);
                 ARR_ADDVAR(_module_name_arr,_modul2);
                };
};

If(count _module_name_arr > 0)then
{
  _output_arr = _module_name_arr;
  If(count (missionNamespace getVariable [STRVAR_DO(fs_modulenames),[]]) > 0)then
  {
    _save_arr = missionNamespace getVariable [STRVAR_DO(fs_modulenames),[]];
    ARR_ADDARR(_save_arr,_module_name_arr);
    missionNamespace setVariable[STRVAR_DO(fs_modulenames),_save_arr,false];
  }else{missionNamespace setVariable[STRVAR_DO(fs_modulenames),_module_name_arr,false];};
};
_output_arr
