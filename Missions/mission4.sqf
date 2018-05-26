If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_route_poss","_main_radius","_force_calc","_script","_triggername","_cars"];
params ["_idx"];

_main_pos = [20705.6,15716.3,0.365];
_main_radius = 300;


switch(_idx)do
{
  case 1:{
            _route_poss = [
                            [22714.9,15792.6,0],
                            [22608,15811.3,0],
                            [22306.9,15904.1,0],
                            [21861.2,15519.7,0],
                            [21275.8,15479.8,0],
                            [20768.1,15654.7,0],
                            [20398.1,15283.9,0],
                            [19506.4,15401.6,0],
                            [19377.5,15315.7,0],
                            [19399.8,13259.2,0]
                          ];


            missionNamespace setVariable[STRVAR_DO(convoy_route),_route_poss,false];
            _cars = [(_route_poss select ((count _route_poss) - 1)),(_route_poss select 0),["O_G_Offroad_01_armed_F","TRUCK","O_G_Offroad_01_armed_F"],"DELETE"] call MFUNC(creating,setConvoy);
           If(count _cars > 0)then
           {
             hint "läuft rein";
             _script = {"Sie haben ein Fahrzeug aus dem Konvoi zerstört" remoteExec ["hint",([0,-2] select isDedicated)];};
            {
             ["MAINTARGETS",_main_pos,[_x,"",_script]] spawn MFUNC(system,addMissionInfos);
             [_x,"SUCCESS"] call MFUNC(system,addKilledEvent);
            }forEach _cars;

            _script = {
                        switch(toUpper (_this select 2))do
                        {
                          case "SUCCESS":{[4,"SUCCEEDED"] call MFUNC(tasks,setTask);};
                          case "FAILED":{[4,"FAILED"] call MFUNC(tasks,setTask);};
                        };
                        sleep 6;
                        [2] execVM "Missions\mission4.sqf";
                      };
            ["MAINMARKER",_main_pos,["",_script]] spawn MFUNC(system,addMissionInfos);
           };
         };
  case 2:{
              missionNameSpace setVariable ["msot_next_mis2",true,true];
              "Neues Lageupdate!" remoteExec ["hint",([0,-2] select isDedicated)];
              missionNamespace setVariable ["msot_next_mis3",true,true];
              [5,"AUTOASSIGNED",[13594.4,12184.6,0.00128937]] call MFUNC(tasks,setTask);
              [1] execVM "Missions\mission5.sqf";
              _script = {[(_this select 1)] call MFUNC(system,delFromSystem);
                         {deleteVehicle _x}forEach nearestObjects [[20705.6,15716.3,0.365], ["all"],300];
                         ["RESPAWNPOSES",[20705.6,15716.3,0.365]] spawn MFUNC(system,doMissionCheck);
                        };
              _triggername = ["LEAVE",_main_pos,400] call MFUNC(system,setTrigger);
              ["MAINTRIGGER",_main_pos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
              ["RESPAWNPOSES",[13465.7,12012,0],[13392.3,11767.2,0]] spawn MFUNC(system,addMissionInfos);
         };
};
