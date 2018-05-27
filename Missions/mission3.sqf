If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_main_radius","_script","_triggername","_force_calc"];
params ["_idx"];

_main_pos = [9148.21,21611.9,0];
_main_radius = 250;


switch(_idx)do
{
  case 1:{
            [2,"AUTOASSIGNED"] call MFUNC(tasks,setTask);
            ["RESPAWNPOSES",_main_pos,[9153.67,21645.8,0]] spawn MFUNC(system,addMissionInfos);
            _script = {[2] execVM "Missions\mission3.sqf";};
            _triggername = ["ACTIVATE",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
         };
  case 2:{

         };
};
