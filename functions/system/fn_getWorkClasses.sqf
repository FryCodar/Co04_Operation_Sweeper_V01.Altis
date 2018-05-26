If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_getWorkClasses

Description: Search for available Unit Classes!.

Parameters: [CLASSNAME INDEX, NUMBER]

            CLASSNAME INDEX - "NORMAL_UNITS","URBAN_UNITS","SPECIAL_UNITS","MIXED_NORMSPEC","MIXED_NORMSNIP","MIXED_ALL"
                              "CIV_MEN" - (Ignores NUMBER of CLasses and return a List of all available Classnames)


Returns: ARRAY - with List of Unit Classes

Examples:
            _isStored = ["NORMAL_UNITS",5] call MSOT_system_fnc_getWorkClasses;

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_output","_holder_arr","_store_arr","_i"];
params ["_idx","_chk_num"];


_output = [];
_holder_arr = [];
_store_arr = [];

switch(_idx)do
{
  case "NORMAL_UNITS":{If(count MSOT_MEN > 0)then{_store_arr = MSOT_MEN;}else{If(count MSOT_SFMEN > 0)then{_store_arr = MSOT_SFMEN;};};};
  case "URBAN_UNITS":{If(count MSOT_MENURBAN > 0)then{_store_arr = MSOT_MENURBAN;}else{If(count MSOT_MEN > 0)then{_store_arr = MSOT_MEN;};};};
  case "SPECIAL_UNITS":{If(count MSOT_SFMEN > 0)then{_store_arr = MSOT_SFMEN;}else{If(count MSOT_MEN > 0)then{_store_arr = MSOT_MEN;};};};
  case "SNIPER_UNITS":{If(count MSOT_SNIPER > 0)then{_store_arr = MSOT_SNIPER;}else{If(count MSOT_MEN > 0)then{_store_arr = MSOT_MEN;};};};
  case "MIXED_NORMSPEC":{
                          If(count MSOT_MEN > 0)then{ARR_ADDARR(_holder_arr,MSOT_MEN);};If(count MSOT_SFMEN > 0)then{ARR_ADDARR(_holder_arr,MSOT_SFMEN);};
                          If(count _holder_arr > 0)then{_store_arr = _holder_arr call BFUNC(arrayShuffle);};
                        };
  case "MIXED_NORMSNIP":{
                          If(count MSOT_MEN > 0)then{ARR_ADDARR(_holder_arr,MSOT_MEN);};If(count MSOT_SNIPER > 0)then{ARR_ADDARR(_holder_arr,MSOT_SNIPER);};
                          If(count _holder_arr > 0)then{_store_arr = _holder_arr call BFUNC(arrayShuffle);};
                        };
  case "MIXED_ALL":{
                     If(count MSOT_MEN > 0)then{ARR_ADDARR(_holder_arr,MSOT_MEN);};
                     If(count MSOT_MENURBAN > 0)then{ARR_ADDARR(_holder_arr,MSOT_MENURBAN);};
                     If(count MSOT_SFMEN > 0)then{ARR_ADDARR(_holder_arr,MSOT_SFMEN);};
                     If(count MSOT_SNIPER > 0)then{ARR_ADDARR(_holder_arr,MSOT_SNIPER);};
                     If(count _holder_arr > 0)then{_store_arr = _holder_arr call BFUNC(arrayShuffle);};
                   };
  case "CIV_MEN":{If(count MSOT_CIVMEN > 0)then{_output = MSOT_CIVMEN;};};
  case "CIV_VEC":{If(count MSOT_CIVCAR > 0)then{_output = MSOT_CIVCAR;};};
};

If(count _store_arr > 0)then
{
  F_LOOP(_i,1,_chk_num)
  {
    ARR_ADDVAR(_output,(selectRandom _store_arr));
  };
};
_output
