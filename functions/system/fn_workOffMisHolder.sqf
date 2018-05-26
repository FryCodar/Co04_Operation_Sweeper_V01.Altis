If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_workOffMisHolder

Description: Work Off the filled Holder for MissionCheckSystem

Examples:
            [] spawn MSOT_system_fnc_workOffMisHolder

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_handle"];

missionNamespace setVariable [STRVAR_DO(manage_delete_missinfo),true,false];
missionNamespace setVariable [STRVAR_DO(delete_from_missinfo),true,true];

If(missionNamespace getVariable [STRVAR_DO(write_to_missinfo),false])then
{waitUntil{!(missionNamespace getVariable [STRVAR_DO(write_to_missinfo),false])};};

If(count MANAGE_MISSION_HOLDER > 0)then
{
  {
    _handle = _x spawn MFUNC(system,doMissionCheck);
    waitUntil{scriptDone _handle};
    sleep 1;
  }forEach MANAGE_MISSION_HOLDER;
  MANAGE_MISSION_HOLDER = [];
};
missionNamespace setVariable [STRVAR_DO(manage_delete_missinfo),false,false];
missionNamespace setVariable [STRVAR_DO(delete_from_missinfo),true,true];
