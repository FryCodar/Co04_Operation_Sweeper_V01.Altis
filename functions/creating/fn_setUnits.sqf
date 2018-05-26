If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_creating_fnc_setUnits

Description: Creates Groups of Units on Battlefield.

              SERVER/HEADLESS CLIENT

Parameters: [POSITION,RADIUS,NUMBER GROUPS,NUMBER UNITS,GROUP INDEX,LOCATION,(BEHAVIORMODE),(COMBATMODE)]

            POSITION  -  ARRAY with Position or ARRAY with 2 Position Arrays
                         1 Positionarray is the Main- and Spawnposition together to add the Units in System
                         2 Positionarrays the 1st is the Mainposition to add the Units in System & the 2nd to spawn the Units on Battlefield

            RADIUS    -  the Distance where the Units will spawn around the Spawnpoint

            NUMBER GROUPS -  NUMBER of all Groups (new Calculation in the LOCATION Mode "MIXED")

            NUMBER UNITS  -  Number of Units in the Group

            GROUP INDEX   -  Index of Different Classnames(if Classnames available!)
                             "NORMAL_UNITS","URBAN_UNITS","SPECIAL_UNITS","MIXED_NORMSPEC","MIXED_NORMSNIP","MIXED_ALL"

            LOCATION      -  Location where will spawn the Groups
                             "AREA" :   Everywhere on Area around the Spawnpoint
                             "BORDER" : Randomized Spawnpoint at the Border of Area
                             "HOUSE"  : If Houses available, random House Position will used
                             "HOUSE_TOP" : If Houses available, highest House Position will used
                             "MIXED"  : A Mix between AREA and HOUSE if Houses available

             (BEHAVIORMODE) - Optional: default "CARELESS"

             (COMBATMODE)   - Optional : default "YELLOW"

             !INFORMATION!: "CIV_MEN" at GROUP INDEX is not supported!

Returns: [ARRAY with Names of all created Groups]

Examples:
            _isStored = [(getMarkerPos "start"), 200, 20, 5, "NORMAL_UNITS","MIXED"] call MSOT_creating_fnc_setUnits;

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_output","_do_your_job","_main_pos","_spawn_pos","_work_arr","_allowed_to_create","_calculate_units","_house_arr",
         "_x","_setting_grp_num","_setting_unit_num","_grp_crea","_group_classes","_unit_crea","_grp_arr","_grp","_house_ctrl_arr","_set_in_house","_house_ctrl",
         "_ctrl_num","_house_lvl","_unit","_spawn_pos_holder","_unit_counter","_housew_arr","_everyhouse","_gethouse","_house_spawn","_border_pos","_searched_house"];

params ["_position","_radius","_grp_num","_units_in_grp_num","_group_choice","_location_idx",["_behaviour_idx","CARELESS"],["_combat_idx","YELLOW"]];

IF(count MSOT_MEN == 0 && count MSOT_SFMEN == 0) exitWith {LOG_ERR("Control MSOT_MEN ARRAY");};

_output = [];
_do_your_job = If(_group_choice != "CIV_MEN")then{true}else{false};


If(_do_your_job)then
{
  _main_pos = [];_spawn_pos = [];_work_arr = [];_house_arr = [];_housew_arr = [];_allowed_to_create = true;_calculate_units = false;_grp_arr = [];_unit_counter = 0;
  _everyhouse = false;
  switch(true)do
  {
    case (typeName (_position select 0) == "ARRAY" && typeName (_position select 1) == "ARRAY"):{_main_pos = (_position select 0);_spawn_pos = (_position select 1);};
    case (typeName (_position select 0) == "SCALAR" && typeName (_position select 1) == "SCALAR"):{_main_pos = _position;_spawn_pos = _position;};
  };
  switch(_location_idx)do
  {
    case "AREA":{ARR_ADDVAR(_work_arr,"AREA");};
    case "BORDER":{ARR_ADDVAR(_work_arr,"BORDER");};
    case "HOUSE":{
                   _house_arr = [_spawn_pos,_radius,true,true] call MFUNC(spawnhelp,checkHouses);
                   If(count _house_arr > 0)then{ARR_ADDVAR(_work_arr,"HOUSE");};
                 };
    case "HOUSE_TOP":{
                       _housew_arr = [_spawn_pos,_radius,true,true] call MFUNC(spawnhelp,checkHouses);
                       If(count _housew_arr > 0)then
                       {{
                          If(count ([_x,"LEVELS"] call MFUNC(spawnhelp,checkHousePos)) >= 2)then
                          {ARR_ADDVAR(_house_arr,_x);};
                        }forEach _housew_arr;
                        switch(true)do
                        {
                          case (count _house_arr >= (2 * _grp_num)):{ARR_ADDVAR(_work_arr,"HOUSE_TOP");};
                          case (count _house_arr >= _grp_num):{ARR_ADDVAR(_work_arr,"HOUSE_TOP");_everyhouse = false;};
                          case (count _house_arr < _grp_num):{ARR_ADDVAR(_work_arr,"HOUSE_TOP");_everyhouse = true;};
                        };
                       };
                     };
    case "MIXED":{
                   _calculate_units = true;ARR_ADDVAR(_work_arr,"AREA");
                   _house_arr = [_spawn_pos,_radius,true,true] call MFUNC(spawnhelp,checkHouses);
                   If(count _house_arr > 0)then{ARR_ADDVAR(_work_arr,"HOUSE");};
                 };
    default {_allowed_to_create = false;LOG_ERR("Check Function Call! fn_setUnits");};
  };

  If(_allowed_to_create)then
  {{
    _setting_grp_num = 0;
    _setting_unit_num = 0;
    _house_ctrl_arr = [];
    _set_in_house = false;
    _border_pos = [];
    switch(_x)do
    {
      case "AREA":{_setting_grp_num = _grp_num;_setting_unit_num = _units_in_grp_num;};
      case "BORDER":{_setting_grp_num = _grp_num;_setting_unit_num = _units_in_grp_num;};
      case "HOUSE":{
                     If(_calculate_units)then{_setting_grp_num = (ceil(_grp_num * 0.5));_setting_unit_num = 1;
                    }else{_setting_grp_num = _grp_num;_setting_unit_num = _units_in_grp_num;};
                   };
      case "HOUSE_TOP":{_setting_grp_num = _grp_num;_setting_unit_num = _units_in_grp_num;};
    };
    F_LOOP(_grp_crea,1,_setting_grp_num)
    {
      _group_classes = [_group_choice,_setting_unit_num] call MFUNC(system,getWorkClasses);
      If(count _group_classes > 0)then
      {
        _spawn_at_pos = [];
        _house_spawn = [];
        switch(_x)do
        {
          case "AREA":{_spawn_at_pos = [_spawn_pos,_radius] call MFUNC(geometry,getCirclePos);};
          case "BORDER":{
                         _border_pos = (([_spawn_pos,(round(_radius * 4))] call MFUNC(geometry,getCircleBorderPos)) select 0);
                         _spawn_at_pos = [_border_pos,_radius] call MFUNC(geometry,getCirclePos);;
                          //If(!isMultiplayer)then{player setPos _border_pos;};
                        };
          case "HOUSE":{ _ctrl_num = 0;
                         _house_ctrl = (selectRandom _house_arr);
                         while{_house_ctrl In _house_ctrl_arr && _ctrl_num < (count _house_arr)}do
                         {_house_ctrl = (selectRandom _house_arr);_ctrl_num = _ctrl_num + 1;sleep 0.01;};
                          ARR_ADDVAR(_house_ctrl_arr,_house_ctrl);_spawn_at_pos = [_house_ctrl];_set_in_house = true;
                        };
          case "HOUSE_TOP":{_ctrl_num = 0;
                            If(_everyhouse)then
                            { _ctrl_num = ((count _house_arr) - 1);
                              for "_gethouse" from 0 to _ctrl_num do{
                              _searched_house = (_house_arr select _gethouse);
                              If(!(_searched_house In _house_ctrl_arr))then
                              {ARR_ADDVAR(_house_ctrl_arr,_searched_house);_ctrl_num = _gethouse;};sleep 0.01;};
                              _house_lvl = [(_house_arr select _ctrl_num),"LEVELS"] call MFUNC(spawnhelp,checkHousePos);
                              _spawn_at_pos = (_house_lvl select ((count _house_lvl) - 1));
                              _house_spawn = _spawn_at_pos;
                            }else{ _house_ctrl = (selectRandom _house_arr);
                                   while{_house_ctrl In _house_ctrl_arr && _ctrl_num < (count _house_arr)}do
                                   {_house_ctrl = (selectRandom _house_arr);_ctrl_num = _ctrl_num + 1;sleep 0.01;};
                                   _house_lvl = [_house_ctrl,"LEVELS"] call MFUNC(spawnhelp,checkHousePos);
                                   _spawn_at_pos = (_house_lvl select ((count _house_lvl) - 1));
                                   _house_spawn = _spawn_at_pos;
                                 };
                            _set_in_house = true;
                           };
        };
        If(count _spawn_at_pos > 0)then
        {
          _grp = CREA_GROUP(MSOT_ENEMY_SIDE);
          F_LOOP(_unit_crea,0,((count _group_classes) - 1))
          {
            switch(_x)do
            {
              case "HOUSE":{_spawn_pos_holder = [(_spawn_at_pos select 0),"ALL"] call MFUNC(spawnhelp,checkHousePos);
                            _spawn_at_pos = (selectRandom _spawn_pos_holder);
                           };
              case "HOUSE_TOP":{
                                 _spawn_at_pos = (selectRandom _house_spawn);
                               };
            };
            _unit = _grp createUnit [(_group_classes select _unit_crea), _spawn_at_pos, [], 1,"CAN_COLLIDE"];
            _unit_counter = _unit_counter + 1;
            If(_set_in_house)then{SET_POSATL(_unit,_spawn_at_pos,0.01);_unit moveTo _spawn_at_pos;_unit allowFleeing 0;
                                  If(!isMultiplayer && (["debug_modus",1] call BIS_fnc_getParamValue) == 1)then
                                  {[_spawn_at_pos,0] call MFUNC(spawnhelp,setDebugMarker);};};
            sleep 0.04;
          };
          If(!_set_in_house)then
          {
            _grp enableAttack true;
		        _grp enableGunLights "AUTO";
            If(_x isEqualTo "BORDER")then{
             [_grp,_spawn_pos] call BFUNC(taskAttack);
             _behaviour_idx = "AWARE";
           }else{[_grp,_spawn_pos,(round(_radius * 0.5))] call BFUNC(taskPatrol);};
          };
          _grp setBehaviour _behaviour_idx;
	        _grp setCombatMode _combat_idx;
          [_grp] call MFUNC(system,setUnitSkill);
          ARR_ADDVAR(_grp_arr,_grp);
        };
      };
    };

   }forEach _work_arr;
  };
  If(count _grp_arr > 0)then{["GROUPS",_main_pos,_grp_arr] spawn MFUNC(system,addToSystem);};
};
_output
