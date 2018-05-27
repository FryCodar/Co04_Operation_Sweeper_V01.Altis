If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_main_radius","_script","_triggername"];
params ["_idx"];

_main_pos = [9148.21,21611.9,0];
_main_radius = 250;

switch(_idx)do
{
  case 1:{
            _script = {[2] execVM "Missions\mission2.sqf";};
            _triggername = ["ACTIVATE",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
         };
  case 2:{
            private _house_arr = [[9197.17,21691.9,0.612],5,false,true] call MFUNC(spawnhelp,checkHouses);
            If(count _house_arr > 0)then
            {
              MSOT_AIRPORT_HOUSE = (_house_arr select 0);
              MSOT_AIRPORT_HOUSE setVariable ["bis_disabled_Door_1",1,true];
              private _pos = MSOT_AIRPORT_HOUSE selectionPosition "Door_1_trigger";
					    private _doorpos = MSOT_AIRPORT_HOUSE modelToWorld _pos;
              private _dummy = createVehicle ["Land_MetalBarrel_F", _doorpos, [], 0, "CAN_COLLIDE"];
              _dummy enableSimulation false;
					    _dummy setPos [_doorpos select 0, _doorpos select 1, (_doorpos select 2) - 1];
              _dummy hideObjectGlobal true;

              [_dummy] spawn {
              params ["_dummy1"];
              private _check_dummy = true;
              private _pos = position _dummy1;
              private _found_claymore = false;
					    while{_check_dummy}do
              {
                _is_in = nearestObjects [_pos,["ACE_Explosives_Place_Claymore"], 2, false];
                switch(true)do
                {
                  case ((count _is_in) > 0):{_found_claymore = true;};
                  case ((damage _dummy1) > 0):{If(_found_claymore && {(damage _dummy1) > 0})then
                                               {
                                                 MSOT_AIRPORT_HOUSE setVariable ["bis_disabled_Door_1",0,true];
                                                 [MSOT_AIRPORT_HOUSE, 1, 1] call BIS_fnc_Door;
                                                 _check_dummy = false;
                                               };
                                              };
                };
                sleep 0.4;
              };
             };
            };

            [] spawn {

             private _run = true; private _civ_dect = true; private _civ_dead = true; private _is_cuffed = true;
             while{_run}do
             {
               switch(true)do
               {
                 case ((ZIV01 call BIS_fnc_enemyDetected) && _civ_dect):{ _civ_dect = false;
                                                                          "Der Zivilist hat Sie entdeckt.\nEr versucht Verstärkung zu rufen!" remoteExec ["hint",([0,-2] select isDedicated)];
                                                                           [] spawn {sleep 5;If(alive ZIV01)then
                                                                                            {[205,{[3] execVM "Missions\mission2.sqf";},false] spawn MSOT_fnc_startCount;};
                                                                                    };
                                                                         };
                case (_civ_dead && {!alive ZIV01}):{ _civ_dead = false; missionNamespace setVariable ["msot_run_countdown",false,true];

                                                        sleep 2;
                                                        "VERDAMMT!!!!\nDer ZIVILIST IST TOT...\nANDERE ZIVILISTEN RUFEN VERSTÄRKUNG!" remoteExec ["hint",([0,-2] select isDedicated)];
                                                        [3] execVM "Missions\mission2.sqf";
                                                     };
                 case (_is_cuffed && {ZIV01 getVariable ["ace_captives_isHandcuffed",false]}):{_is_cuffed = false;
                                                                                               missionNamespace setVariable ["msot_run_countdown",false,true];
                                                                                               [] spawn {sleep 5;missionNamespace setVariable ["msot_run_countdown",false,true];
                                                                                                         "Gut gemacht!\n Bringen Sie den Zivilisten in ein Gebäude!" remoteExec ["hint",([0,-2] select isDedicated)];
                                                                                                        };
                                                                                             };
                 case ((missionNamespace getVariable[STRVAR_DO(have_book),false]) && {missionNamespace getVariable[STRVAR_DO(have_keys),false]}):{_run = false;
                                                                                                                                                  "Sehr gut!\nNehmen Sie sich einen Helikopter und verlassen Sie das Gebiet" remoteExec ["hint",([0,-2] select isDedicated)];
                                                                                                                                                  [4] execVM "Missions\mission2.sqf";
                                                                                                                                                 };

               };
               sleep 0.2;
             };
            };

         };
 case 3:{
            [_main_pos,800,["CAR","TRUCK"],"PATROL",_main_radius] call MFUNC(creating,setConvoy);
        };
 case 4:{
          [2,"SUCCEEDED"] call MFUNC(tasks,setTask);
          sleep 6;
          [3,"AUTOASSIGNED",[20120.4,20054.7,0]] call MFUNC(tasks,setTask);
          [1] execVM "Missions\mission3.sqf";
          _script = {[(_this select 1)] call MFUNC(system,delFromSystem);
                     {deleteVehicle _x}forEach nearestObjects [[9148.21,21611.9,0], ["all"],250];
                     ["RESPAWNPOSES",[9148.21,21611.9,0]] spawn MFUNC(system,doMissionCheck);
                    };
          _triggername = ["LEAVE",[9148.21,21611.9,0],350] call MFUNC(system,setTrigger);
          ["MAINTRIGGER",[9148.21,21611.9,0],[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
          ["RESPAWNPOSES",[20595.6,20106.3,0],[20143.1,19799.4,0]] spawn MFUNC(system,addMissionInfos);
        };
};
