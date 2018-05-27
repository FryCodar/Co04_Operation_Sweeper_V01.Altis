If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_main_radius","_script","_triggername","_force_calc"];
params ["_idx"];

_main_pos = [9778.05,22219.1,0];
_main_radius = 250;

switch(_idx)do
{
  case 1:{
            [1,"AUTOASSIGNED"] call MFUNC(tasks,setTask);
            sleep 1;
            ["RESPAWNPOSES",_main_pos,[8892.31,23677.1,0]] spawn MFUNC(system,addMissionInfos);

            _script = {[2] execVM "Missions\mission2.sqf";};
            ["MAINMARKER",_main_pos,["",_script]] spawn MSOT_system_fnc_addMissionInfos;

            {
              private _new_pos = [_main_pos,150,15] call MFUNC(geometry,getCirclePos);
              If(count _new_pos > 0)then{_x setPos _new_pos;};
              _script = {"Sie haben eine Flugabwehr ausgeschaltet!" remoteExec ["hint",([0,-2] select isDedicated)];};
              ["MAINTARGETS",_main_pos,[_x,"",_script]] call MFUNC(system,addMissionInfos);
              [_x,"SUCCESS"] call MFUNC(system,addKilledEvent);
              sleep 1;
            }forEach [Ziel01,Ziel02];

            ["MAINTARGETS",_main_pos,[Docs1,"",""]] call MFUNC(system,addMissionInfos);

            _force_calc = [([] call MFUNC(system,getPlayerCount)),([] call MFUNC(usage,checkNight))] call MFUNC(system,getForcesCalc);
            [_main_pos,_main_radius,(_force_calc select 0),(_force_calc select 1),"MIXED_ALL","MIXED"] call MFUNC(creating,setUnits);
            _script = {[(_this select 1)] call MFUNC(system,setTargetBehavior);sleep 1;};
            _triggername = ["DETECTED",_main_pos,700] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);

         };
  case 2:{
            "Neues Lageupdate!" remoteExec ["hint",([0,-2] select isDedicated)];
            [1,"SUCCEEDED"] call MFUNC(tasks,setTask);
            missionNamespace setVariable ["msot_sweepermis2",true,true];
            _script = {[(_this select 1)] call MFUNC(system,delFromSystem);
                       {deleteVehicle _x}forEach nearestObjects [[9778.05,22219.1,0], ["all"],250];
                       ["RESPAWNPOSES",[9778.05,22219.1,0]] spawn MFUNC(system,doMissionCheck);
                      };
            _triggername = ["LEAVE",[9778.05,22219.1,0],350] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",[9778.05,22219.1,0],[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
            sleep 6;
            [1] execVM "Missions\mission3.sqf";
         };
};
