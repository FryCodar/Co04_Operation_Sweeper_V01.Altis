if(!hasInterface) exitwith {};
#include "msot_components.hpp"
private ["_black_list","_arsenal_component","_is_changed","_i"];



if(count ARSENAL_BLACKLIST > 0)then{
If(!(missionNamespace getVariable [STRVAR_DO(used_arsenal),false]))then
{
  _black_list = ARSENAL_BLACKLIST;
  ["Preload"] call BFUNC(arsenal);
  {
    _arsenal_component = _x;
    _is_changed = false;
    for "_i" from 0 to ((count _black_list ) - 1) do
    {
      If(({_x == (_black_list select _i)} count _arsenal_component) > 0)then
      {_arsenal_component = _arsenal_component - [(_black_list select _i)];_is_changed = true;};
    };
    If(_is_changed)then{bis_fnc_arsenal_data set[_forEachIndex,_arsenal_component];};
  }forEach bis_fnc_arsenal_data;
  missionNamespace setVariable [STRVAR_DO(used_arsenal),true,false];
};
};
["Open",true] spawn BFUNC(arsenal);
