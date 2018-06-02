If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_getForcesCalc

Description: Calculated number of enemies, depending on the number of players!

Parameters: [NUMBER,(Optional:BOOL)]

            NUMBER :  Number of player or number of Enemy Groups
            OPTIONAL: BOOL - true/false (dividing the number of groups and soldiers for Night Effect)


Returns: ARRAY

Examples:
            [NUMBER GROUPS,NUMBER SOLDIERS,NUMBER VEHICLES,NUMBER STATICWEAPONS] = [12,true] call MSOT_system_fnc_getForcesCalc;
            [6,3,4,5] = [12,true] call MSOT_system_fnc_getForcesCalc; (with NightEffect)
            [11,5,4,5] = [12,false] call MSOT_system_fnc_getForcesCalc; (without NightEffect)

            [NUMBER GROUPS,NUMBER SOLDIERS] = [6,3] call MSOT_system_fnc_getForcesCalc; (For House Spawn)



Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_output","_human_dep_forces","_unit_calc","_group_calc","_vehicle_calc","_static_weapon_calc","_i","_cal_num"];
params ["_men_count",["_is_night",false]];




If(_men_count < 2)then{_men_count = 2;};

_output = [];
_unit_calc = 0;
_group_calc = 0;
_vehicle_calc = 0;
_static_weapon_calc = 0;



  switch(["mission_difficulty",2] call BFUNC(getParamValue))do
  {
    case 0:{_group_calc = 0.9;_unit_calc = 3;};
    case 1:{_group_calc = 0.8;_unit_calc = 4;};
    case 2:{_group_calc = 0.615;_unit_calc = 4;_vehicle_calc = 0.2;};
    case 3:{_group_calc = 0.615;_unit_calc = 5;_vehicle_calc = 0.3;_static_weapon_calc = 0.4;};
    default {_group_calc = 0.615;_unit_calc = 6;_vehicle_calc = 0.3;_static_weapon_calc = 0.4;};
  };

  if(_is_night)then
  {
    F_LOOP(_i,0,3){
      _cal_num = 0;
      switch(_i)do
      {
        case 0:{_cal_num = If((round(_men_count * _group_calc)) > 22)then{(22 * 0.5)}else{(round((_men_count * _group_calc) * 0.5))};ARR_ADDVAR(_output,_cal_num);};
        case 1:{_cal_num = (round(_unit_calc * 0.5));ARR_ADDVAR(_output,_cal_num);};
        case 2:{If(_vehicle_calc > 0)then{_cal_num = If((round(_men_count * _vehicle_calc)) > 12)then{12}else{(round(_men_count * _vehicle_calc))};ARR_ADDVAR(_output,_cal_num);}else{ARR_ADDVAR(_output,_cal_num);};};
        case 3:{If(_static_weapon_calc > 0)then{_cal_num = If((round(_men_count * _static_weapon_calc)) > 15)then{15}else{(round(_men_count * _static_weapon_calc))};ARR_ADDVAR(_output,_cal_num);}else{ARR_ADDVAR(_output,_cal_num);};};
      };
    };
  }else{
         F_LOOP(_i,0,3){
          _cal_num = 0;
          switch(_i)do
          {
            case 0:{_cal_num = If((round(_men_count * _group_calc)) > 22)then{22}else{(round(_men_count * _group_calc))};ARR_ADDVAR(_output,_cal_num);};
            case 1:{_cal_num = _unit_calc; ARR_ADDVAR(_output,_cal_num);};
            case 2:{If(_vehicle_calc > 0)then{_cal_num = If((round(_men_count * _vehicle_calc)) > 12)then{12}else{(round(_men_count * _vehicle_calc))};ARR_ADDVAR(_output,_cal_num);}else{ARR_ADDVAR(_output,_cal_num);};};
            case 3:{If(_static_weapon_calc > 0)then{_cal_num = If((round(_men_count * _static_weapon_calc)) > 15)then{15}else{(round(_men_count * _static_weapon_calc))};ARR_ADDVAR(_output,_cal_num);}else{ARR_ADDVAR(_output,_cal_num);};};
          };
         };
       };

_output
