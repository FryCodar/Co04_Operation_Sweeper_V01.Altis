If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_main_radius","_posses","_spec_grp","_unit","_force_calc","_script","_triggername"];
params ["_idx"];

_main_pos = [13465.7,12012,0];
_main_radius = 500;


switch(_idx)do
{
  case 1:{
            [6,"AUTOASSIGNED",[13594.4,12184.6,0.00128937]] call MFUNC(tasks,setTask);
            missionNamespace setVariable ["msot_sweepermis5",true,true];
            _spec_grp = CREA_GROUP(CIVILIAN);
            {
              _unit = _spec_grp createUnit ["C_scientist_F", (_x select 0), [], 0, "NONE"];
              _unit allowFleeing 0;
              _unit setPosATL (_x select 0); _unit setDir (_x select 1);
            }forEach[[[13592.2,12170.2,0.522778],102],[[13586.1,12169.3,0.651239],29]];
            ["GROUPS",_main_pos,[_spec_grp]] call MFUNC(system,addToSystem);
            _force_calc = [([] call MFUNC(system,getPlayerCount)),([] call MFUNC(usage,checkNight))] call MFUNC(system,getForcesCalc);
            [_main_pos,_main_radius,(_force_calc select 0),(_force_calc select 1),"MIXED_ALL","MIXED"] call MFUNC(creating,setUnits);
            _script = {
                        [(_this select 1)] call MFUNC(system,setTargetBehavior);sleep 1;
                        missionNamespace setVariable[STRVAR_DO(reforce_ctrl),true,true];
                      };
            _triggername = ["DETECTED",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
         };
  case 2:{
            [7,"AUTOASSIGNED",(position Laptop02)] call MFUNC(tasks,setTask);
         };
  case 3:{
            [7,"SUCCEEDED"] call MFUNC(tasks,setTask);
            If(missionNamespace getVariable[STRVAR_DO(reforce_ctrl),false])then
            {
              _script = {
                          missionNamespace setVariable [STRVAR_DO(artillery_ctrl),false,false];
                          sleep 1;
                          missionNamespace setVariable[STRVAR_DO(reforce_ctrl),false,true];
                        };
              _triggername = ["LEAVE",[13590.8,12167.2,0],200] call MFUNC(system,setTrigger);
              ["MAINTRIGGER",[13590.8,12167.2,0],[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
              missionNamespace setVariable [STRVAR_DO(artillery_ctrl),true,false];
              [] spawn {
                        sleep 10;
                        "Ihre Aktivitäten am Laptop sind nicht unbemerkt geblieben!" remoteExec ["hint",([0,-2] select isDedicated)];
                        sleep 5;
                        [[13590.8,12167.2,0],190,40,"MORTAR"] spawn MFUNC(creating,setArtillery);
                       };
            };
         };
  case 4:{
            [] spawn {
                      waitUntil{!(Kofferbombe1 getVariable ["a3f_bomb_active", true]) || !alive Kofferbombe1};
                      switch(true)do
                      {
                        case (!alive Kofferbombe1):{[6,"FAILED"] call MFUNC(tasks,setTask);[5] execVM "Missions\mission6.sqf";};
                        case (!(Kofferbombe1 getVariable ["a3f_bomb_active", true])):{[6,"SUCCEEDED"] call MFUNC(tasks,setTask);[5] execVM "Missions\mission6.sqf";};
                      };
                    };
         };
  case 5:{
          _script = { [(_this select 1)] call MFUNC(system,delFromSystem);
                      {deleteVehicle _x}forEach nearestObjects [[20705.6,15716.3,0.365], ["all"],300];
                      ["RESPAWNPOSES",[13465.7,12012,0]] spawn MFUNC(system,doMissionCheck);
                    };
          _triggername = ["LEAVE",_main_pos,_main_radius] call MFUNC(system,setTrigger);
          ["MAINTRIGGER",_main_pos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
          sleep 6;
          [1] execVM "Missions\mission7.sqf";
         };
};
