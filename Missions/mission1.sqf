If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_force_calc","_script","_triggername"];
params ["_idx"];

switch(_idx)do
{
  case 1:{

            sleep 40;
            [0,"AUTOASSIGNED",(getMarkerPos "Atsalis")] call MFUNC(tasks,setTask);
         };
  case 2:{
            //TriggerMAINPos [9778.05,22219.1,0]

            //scliesse Task1 ab
            [0,"SUCCEEDED"] call MFUNC(tasks,setTask);
            sleep 6;
            // Add New Task
            [1,"AUTOASSIGNED"] call MFUNC(tasks,setTask);
            sleep 1;
            //Set Respawnpos
            ["RESPAWNPOSES",[9778.05,22219.1,0],[8892.31,23677.1,0]] spawn MFUNC(system,addMissionInfos);
            //Change Target Positions :)
            {
              private _new_pos = [[9778.05,22219.1,0],150,15] call MFUNC(geometry,getCirclePos);
              If(count _new_pos > 0)then{_x setPos _new_pos;};
            }forEach [Ziel01,Ziel02];
            //Create TargetUnits
            _force_calc = [([] call MFUNC(system,getPlayerCount)),([] call MFUNC(usage,checkNight))] call MFUNC(system,getForcesCalc);
            [[9778.05,22219.1,0],250,(_force_calc select 0),(_force_calc select 1),"MIXED_ALL","MIXED"] call MFUNC(creating,setUnits);
            //Change Behavior
            _script = {[(_this select 1)] call MFUNC(system,setTargetBehavior);sleep 1;};
            _triggername = ["DETECTED",[9778.05,22219.1,0],250] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",[9778.05,22219.1,0],[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
         };
  case 3:{
            "Neues Lageupdate!" remoteExec ["hint",([0,-2] select isDedicated)];
            [1,"SUCCEEDED"] call MFUNC(tasks,setTask);
            sleep 6;
            [2,"AUTOASSIGNED",[9197.17,21691.9,0.612]] call MFUNC(tasks,setTask);
            [1] execVM "Missions\mission2.sqf";
            _script = {[(_this select 1)] call MFUNC(system,delFromSystem);
                       {deleteVehicle _x}forEach nearestObjects [[9778.05,22219.1,0], ["all"],250];
                       ["RESPAWNPOSES",[9778.05,22219.1,0]] spawn MFUNC(system,doMissionCheck);
                      };
            _triggername = ["LEAVE",[9778.05,22219.1,0],350] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",[9778.05,22219.1,0],[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
            ["RESPAWNPOSES",[9148.21,21611.9,0],[9153.67,21645.8,0]] spawn MFUNC(system,addMissionInfos);
         };

};
