If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "msot_components.hpp"

/* ---------------------------------------------------------------------------------------------------------
Function: MSOT_creating_fnc_setCargoUnits

Description: Fills the Cargo Slots of an Vehicle with Soldiers

Parameters: [VEHICLENAME,GROUP INDEX]

            VEHICLENAME   -  Name of the Vehicle with Cargo Slots
            GROUP INDEX   -  Index of Different Classnames(if Classnames available!)
                             "NORMAL_UNITS","URBAN_UNITS","SPECIAL_UNITS","MIXED_NORMSPEC","MIXED_NORMSNIP","MIXED_ALL"


Returns:  [LIST OF GROUPS]
Examples:
          _streetblocks = [] call MSOT_creating_fnc_setCargoUnits;

Author: Fry

------------------------------------------------------------------------------------------------------------- */
private ["_output","_cargo_idx","_cargo_num","_i","_grp","_group_classes","_cargo_counter"];
params ["_main_vec","_group_choice"];

_output = [];
_cargo_idx = _main_vec emptyPositions "cargo";
If(_cargo_idx > 0)then
{
  _cargo_num = (floor ((_cargo_idx - 2) * 0.25));
  _cargo_counter = 1;
  If(_cargo_num > 1)then
  {
    F_LOOP(_i,1,_cargo_num)
    {
      _spawn_pos = [(getPos _main_vec),5,1,90] call MFUNC(geometry,getNumPosLine);
      _group_classes = [_group_choice,4] call MFUNC(system,getWorkClasses);
      _grp = CREA_GROUP(MSOT_ENEMY_SIDE);
      {_grp createUnit [_x, (_spawn_pos select 1), [], 1,"CAN_COLLIDE"];}forEach _group_classes;
      [_grp] call MFUNC(system,setUnitSkill);sleep 0.2;
      {_x assignAsCargoIndex [_main_vec,_cargo_counter];sleep 0.3;_x moveInCargo _main_vec;sleep 0.2;_cargo_counter = _cargo_counter + 1;}forEach units _grp;
      ARR_ADDVAR(_output,_grp);
    };
  }else{
         _group_classes = [_group_choice,(_cargo_idx - 2)] call MFUNC(system,getWorkClasses);
         _spawn_pos = [(getPos _main_vec),5,1,90] call MFUNC(geometry,getNumPosLine);
         _grp = CREA_GROUP(MSOT_ENEMY_SIDE);
         {_grp createUnit [_x, (_spawn_pos select 1), [], 1,"CAN_COLLIDE"];}forEach _group_classes;
         [_grp] call MFUNC(system,setUnitSkill);sleep 0.2;
         {_x assignAsCargoIndex [_main_vec,_cargo_counter];sleep 0.3;_x moveInCargo _main_vec;sleep 0.2;_cargo_counter = _cargo_counter + 1;}forEach units _grp;
         ARR_ADDVAR(_output,_grp);
       };
};

_output
