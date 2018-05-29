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
            [3,"AUTOASSIGNED",[20069.6,19593.1,0]] call MFUNC(tasks,setTask);
            ["RESPAWNPOSES",[20595.6,20106.3,0],[20143.1,19799.4,0]] spawn MFUNC(system,addMissionInfos);
            //Aktiviere Wegpunkt
            _script = {missionNamespace setVariable ["msot_sweepermis3",true,true];};

            _triggername = ["ACTIVATE",[20069.6,19593.1,0],1000] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
            _force_calc = [([] call MFUNC(system,getPlayerCount)),([] call MFUNC(usage,checkNight))] call MFUNC(system,getForcesCalc);
            [_main_pos,200,(_force_calc select 0),(_force_calc select 1),"MIXED_ALL","MIXED"] call MFUNC(creating,setUnits);
            [[_main_pos,_secmain_pos],_secmain_radius,2,2,"MIXED_ALL","AREA"] call MFUNC(creating,setUnits);
            _script = {[(_this select 1)] call MFUNC(system,setTargetBehavior);sleep 1;};
            _triggername = ["DETECTED",_main_pos,600] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
            _script = {[2] execVM "Missions\mission4.sqf";};
            ["MAINTARGETS",_main_pos,[Off02,"",_script]] spawn MSOT_system_fnc_addMissionInfos;
            _script = {
                        "Sie haben den Offizier getötet!\nDurchsuchen Sie seinen Körper nach Hinweisen!" remoteExec ["hint",([0,-2] select isDedicated)];
                        [position (_this select 0)] execVM "Skripte\LaptopSpawn.sqf";
                        ["MAINTARGETS",(_this select 0),"SUCCESS"] spawn MSOT_system_fnc_eventHandling;
                      };
            Off02 addEventHandler ["killed", _script];
         };
  case 2:{
            [] spawn {
                      waitUntil{(Laptop01 getVariable ["T8L_pvar_dataDownloaded",false])};
                      [3] execVM "Missions\mission4.sqf";
                     };
         };
  case 3:{
            "Neues Lageupdate!" remoteExec ["hint",([0,-2] select isDedicated)];
            _script = {[(_this select 1)] call MFUNC(system,delFromSystem);
                       {deleteVehicle _x}forEach nearestObjects [[20595.6,20106.3,0], ["all"],600];
                       ["RESPAWNPOSES",[20595.6,20106.3,0]] spawn MFUNC(system,doMissionCheck);
                      };
            _triggername = ["LEAVE",_main_pos,1000] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
            [3,"SUCCEEDED"] call MFUNC(tasks,setTask);
            sleep 6;
            [1] execVM "Missions\mission5.sqf";
         };
};
