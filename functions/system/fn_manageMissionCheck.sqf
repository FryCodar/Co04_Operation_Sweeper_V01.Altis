If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_manageMissionCheck

Description: manage Requests to MissionCheck

Examples:
            [] spawn MSOT_system_fnc_manageMissionCheck

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_check_arr"];

If(isNil "MANAGE_MISSION_HOLDER")then{MANAGE_MISSION_HOLDER = [];};
_check_arr = _this;
sleep (1 + (random 3));

If((missionNamespace getVariable [STRVAR_DO(write_to_missinfo),false]) || (missionNamespace getVariable [STRVAR_DO(delete_from_missinfo),false]))then
{
  ARR_ADDVAR(MANAGE_MISSION_HOLDER,_check_arr);
  If(!(missionNamespace getVariable [STRVAR_DO(manage_delete_missinfo),false]))then
  {
   [] spawn MFUNC(system,workOffMisHolder);
  };
}else{
  _check_arr spawn MFUNC(system,doMissionCheck);
};
