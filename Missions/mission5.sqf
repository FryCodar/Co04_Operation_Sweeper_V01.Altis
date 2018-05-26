If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_main_radius","_posses","_spec_grp","_unit","_force_calc","_script","_triggername"];
params ["_idx"];

_main_pos = [13465.7,12012,0];
_main_radius = 500;

switch(_idx)do
{
  case 1:{
            _posses = [[14896.3,11061.3,0],[14885.7,11069.9,0]];
            _spec_grp = CREA_GROUP(CIVILIAN);
            {_x createUnit [(_posses select (_forEachindex)),_spec_grp,"this allowFleeing 0",0.8,"corporal"];}forEach ["C_man_1","C_man_sport_1_F"];
            ["GROUPS",_main_pos,[_spec_grp]] call MFUNC(system,addToSystem);
            _spec_grp = CREA_GROUP(CIVILIAN);
            {
              _unit = _spec_grp createUnit ["C_scientist_F", (_x select 0), [], 0, "NONE"];
              _unit allowFleeing 0;
              _unit setPosATL (_x select 0); _unit setDir (_x select 1);
            }forEach[[[13592.2,12170.2,0.522778],102],[[13586.1,12169.3,0.651239],29]];
            ["GROUPS",_main_pos,[_spec_grp]] call MFUNC(system,addToSystem);
            _force_calc = [([] call MFUNC(system,getPlayerCount)),([] call MFUNC(usage,checkNight))] call MFUNC(system,getForcesCalc);
            [_main_pos,_main_radius,(_force_calc select 0),(_force_calc select 1),"MIXED_ALL","MIXED"] call MFUNC(creating,setUnits);
            _script = {[(_this select 1)] call MFUNC(system,setTargetBehavior);sleep 1;};
            _triggername = ["DETECTED",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);

        };
  case 2:{
           [6,"AUTOASSIGNED",(position Laptop02)] call MFUNC(tasks,setTask);
         };
  case 3:{
           [6,"SUCCEEDED"] call MFUNC(tasks,setTask);
         };
  case 4:{
            [] spawn {
                      waitUntil{!(Kofferbombe1 getVariable ["a3f_bomb_active", true]) || !alive Kofferbombe1};
                      switch(true)do
                      {
                        case (!alive Kofferbombe1):{[5,"FAILED"] call MFUNC(tasks,setTask);sleep 6;[5] execVM "Missions\mission5.sqf";};
                        case (!(Kofferbombe1 getVariable ["a3f_bomb_active", true])):{[5,"SUCCEEDED"] call MFUNC(tasks,setTask);sleep 6;[5] execVM "Missions\mission5.sqf";};
                      };
                     };
         };
  case 5:{
           [7,"AUTOASSIGNED",[16654.5,12667.9,0]] call MFUNC(tasks,setTask);
           missionNamespace setVariable ["msot_next_mis4",true,true];
           [1] execVM "Missions\mission6.sqf";
            _script = { [(_this select 1)] call MFUNC(system,delFromSystem);
                        {deleteVehicle _x}forEach nearestObjects [[20705.6,15716.3,0.365], ["all"],300];
                        ["RESPAWNPOSES",[13465.7,12012,0]] spawn MFUNC(system,doMissionCheck);
                      };
            _triggername = ["LEAVE",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
            ["RESPAWNPOSES",[16654.5,12667.9,0],[16654.3,12288.1,0]] spawn MFUNC(system,addMissionInfos);
         };
};


/* RespawnPunkte
[
[""Respawn01"",[8892.31,23677.1,0]], XX
[""Respawn02"",[9153.67,21645.8,0]], XX
[""Respawn03"",[20143.1,19799.4,0]], XX
[""Respawn04"",[20759.6,15782.8,0]],XX
[""Respawn05"",[13392.3,11767.2,0]],XX
[""Respawn06"",[16654.3,12288.1,0]]]


Waypoint Punkte
[
"[22714.9,15792.6,0]" //Startpunkt

[""Truck01"",[22608,15811.3,0]],
[""Truck02"",[22300.8,15906.6,0]],XX
[""Truck03"",[21882.3,15525.7,0]],XX
[""Truck04"",[21258.4,15488.7,0]],XX
[""Truck05"",[20768.3,15654.7,0]],XX
[""Truck06"",[20284.2,14765.8,0]],
[""Truck07"",[20162.3,14789.8,0]],XX
[""Truck08"",[20637,13932.6,0]],XX
[""Truck09"",[20302.5,13808.6,0]],
[""Truck10"",[19406,13249.6,0]],XX
[
                [22817.2,15788.9,0],
                [22608,15811.3,0],
                [22306.9,15904.1,0],
                [21323.5,16275.4,0],
                [21273.1,16247.9,0],
                [20768.1,15654.7,0],
                [20398.1,15283.9,0],
                [19506.4,15401.6,0],
                [19377.5,15315.7,0],
                [19399.8,13259.2,0]
               ],
]
setConvoySeparation
forceFollowRoad
setDriveOnPath

B_UAV_01_F
*/
