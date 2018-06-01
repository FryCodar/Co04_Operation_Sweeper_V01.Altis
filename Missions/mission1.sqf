If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_main_radius","_script","_triggername"];
params ["_idx"];

_main_pos = [8483.27,25095,0];
_main_radius = 70;

switch(_idx)do
{
  case 1:{
            sleep 40;
            [0,"AUTOASSIGNED",(getMarkerPos "Atsalis")] call MFUNC(tasks,setTask);
            _script = {[2] execVM "Missions\mission1.sqf";};
            _triggername = ["ACTIVATE",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
         };
   case 2:{//[9062.38,23392.3,0]
            [] execVM "Skripte\Animationen2.sqf";
            _script = {
                        {deleteVehicle _x} forEach nearestObjects [[8483.27,25095,0], ["all"],70];
                        "Atsalis" remoteExec ["deleteMarker", 0, true];
                        "SDV" remoteExec ["deleteMarker", 0, true];
                      };
            _triggername = ["LEAVE",_main_pos,800] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
            [0,"SUCCEEDED"] call MFUNC(tasks,setTask);
            _script = {[3] execVM "Missions\mission1.sqf"};
            _triggername = ["ACTIVATE",[9062.38,23392.3,0],500] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",[9062.38,23392.3,0],[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
            _force_calc = [([] call MFUNC(system,getPlayerCount)),([] call MFUNC(usage,checkNight))] call MFUNC(system,getForcesCalc);
            [[9062.38,23392.3,0],350,(_force_calc select 0),(_force_calc select 1),"MIXED_ALL","MIXED"] call MFUNC(creating,setUnits);
            [4] execVM "Missions\mission1.sqf";
          };
   case 3:{
            _script = {[(_this select 1)] call MFUNC(system,setTargetBehavior);sleep 1;};
            _triggername = ["DETECTED",[9062.38,23392.3,0],500] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);

            _script = {[(_this select 1)] call MFUNC(system,delFromSystem);
                       {deleteVehicle _x}forEach nearestObjects [[9062.38,23392.3,0], ["all"],500];
                      };
            _triggername = ["LEAVE",[9062.38,23392.3,0],700] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",[9062.38,23392.3,0],[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
          };
   case 4:{
            sleep 5;
            [1] execVM "Missions\mission2.sqf";
          };
};
