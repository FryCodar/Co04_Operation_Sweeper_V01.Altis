If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "msot_components.hpp"

private ["_work_arr","_get_grps","_searched_arr","_grps_arr","_x"];

params ["_pos","_behavior_mode","_combat_mode"];

If(isNil "_combat_mode")then{
   _combat_mode = switch (["mission_difficulty",2] call BFUNC(getParamValue)) do
                  {
                    case 0:{"WHITE"};
                    case 2:{"YELLOW"};
                    case 3:{"YELLOW"};
                    case 4:{"RED"};
                  };
};

If(isNil "_behavior_mode")then{
 _behavior_mode = switch (["mission_difficulty",2] call BFUNC(getParamValue)) do
                  {
                    case 0:{"AWARE"};
                    case 2:{"COMBAT"};
                    case 3:{"COMBAT"};
                    case 4:{"STEALTH"};
                  };
};

_work_arr = missionNamespace getVariable[STRVAR_DO(group_store),[]];
If(count _work_arr > 0)then
{
  _get_grps = [2,_work_arr,_pos] call MFUNC(system,getInfoArray);
  If(count _get_grps > 0)then
  {
    _searched_arr = _work_arr select (_get_grps select 0);
    _grps_arr = (_searched_arr select 1);
    {
      If(!isNull _x)then{_x setCombatMode _combat_mode; _x setBehaviour _behavior_mode;};
    }forEach _grps_arr;
  };
};
