If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_secmain_pos","_main_radius","_secmain_radius","_force_calc","_script","_triggername"];
params ["_idx"];

_main_pos = [20595.6,20106.3,0];
_secmain_pos = [20120.4,20054.7,0];
_main_radius = 600;
_secmain_radius = 300;

switch(_idx)do
{
  case 1:{
            [3,"AUTOASSIGNED",[20120.4,20054.7,0]] call MFUNC(tasks,setTask);
            ["RESPAWNPOSES",[20595.6,20106.3,0],[20143.1,19799.4,0]] spawn MFUNC(system,addMissionInfos);
         };
  case 2:{

          };
};
