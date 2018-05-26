If(isMultiplayer)then{If(!isServer) exitWith {};};

[] spawn {
#include "msot_components.hpp"
    waitUntil{(count(allPlayers - entities "HeadlessClient_F")) > 0};
    private ["_chk_arr","_groups","_sided_groups","_i","_side","_x"];
    _chk_arr = [];
    {
      If(!((side _x) In _chk_arr))then{_chk_arr pushBack (side _x)};
    }forEach (allPlayers - entities "HeadlessClient_F");

    If(count _chk_arr > 0 && count _chk_arr < 2)then
    {
      _side = _chk_arr select 0;
      _groups = allGroups;
      _sided_groups = [];

      If(count _groups > 0)then
      {
        F_LOOP(_i,0,((count _groups) - 1))
        {
          If(!(_side isEqualTo (side (_groups select _i)))) then
          {
           ARR_ADDVAR(_sided_groups,(_groups select _i));
          };
          sleep 0.04;
        };
      };

      If(count _sided_groups > 0)then
      {
        {
          [_x] call MFUNC(system,setUnitSkill);
          _x setCombatMode "YELLOW";
        }forEach _sided_groups;
      };
    };
};
