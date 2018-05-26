If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "msot_components.hpp"

private ["_chk_new_state_arr","_x","_send_to_client","_holder","_loop_idx","_found"];

params ["_idx","_state","_target_name"];

_chk_new_state_arr = ["SUCCEEDED","FAILED","CANCELED"];
_send_to_client = false;
_holder = (missionNamespace getVariable [STRVAR_DO(missions_stored_tasks),[]]);

//Prüfe, ob im Task Server Store Daten vorhanden sind
If(count _holder > 0)then
{
  _loop_idx = -1;
  _found = false;
  {
   If((_x select 0) isEqualTo _idx)then{_found = true;_loop_idx = _forEachIndex;};
  }forEach _holder;

  If(_found)then
  {
    If((toUpper _state) in _chk_new_state_arr)then
    {
      ARR_MINIDX(_holder,_loop_idx);
      missionNamespace setVariable [STRVAR_DO(missions_stored_tasks),_holder,true];
      _send_to_client = true;
    };
  }else{
         ARR_ADDVAR(_holder,_this);
         missionNamespace setVariable [STRVAR_DO(missions_stored_tasks),_holder,true];
         _send_to_client = true;
       };
}else{
        ARR_ADDVAR(_holder,_this);
        missionNamespace setVariable [STRVAR_DO(missions_stored_tasks),_holder,true];
        _send_to_client = true;
     };

If(_send_to_client)then
{
  REMOTE_TRIEXESM(_this,tasks,storedTasks,0);
};
