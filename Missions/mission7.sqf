If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "..\msot_macros.hpp"

private ["_main_pos","_main_radius","_secmain_pos","_secmain_radius","_grps","_force_calc","_script","_triggername","_civ_grp","_spawn_at_pos","_unit"];
params ["_idx"];

_main_pos = [16654.5,12667.9,0];
_main_radius = 500;
_secmain_pos = [16588.3,12779.4,0];
_secmain_radius = 70;
_grps = [];
//[16586.7,12834.2,0.281] ArtilleryPosition

switch(_idx)do
{
  case 1:{
            ["RESPAWNPOSES",[16654.5,12667.9,0],[16654.3,12288.1,0]] spawn MFUNC(system,addMissionInfos);
            [8,"AUTOASSIGNED",[16654.5,12667.9,0]] call MFUNC(tasks,setTask);
            _script = {[2] execVM "Missions\mission7.sqf";};
            _triggername = ["ACTIVATE",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
            _force_calc = [([] call MFUNC(system,getPlayerCount)),([] call MFUNC(usage,checkNight))] call MFUNC(system,getForcesCalc);
            [_main_pos,300,((_force_calc select 0) + 3),(_force_calc select 1),"MIXED_ALL","AREA"] call MFUNC(creating,setUnits);
            [[_main_pos,_secmain_pos],_secmain_radius,((_force_calc select 0) + 2),1,"MIXED_ALL","HOUSE"] call MFUNC(creating,setUnits);
            [[_main_pos,_secmain_pos],_secmain_radius,3,2,"MIXED_ALL","AREA"] call MFUNC(creating,setUnits);
            _script = {
                        [(_this select 1)] call MFUNC(system,setTargetBehavior);sleep 1;
                        missionNamespace setVariable[STRVAR_DO(reforce_ctrl),true,true];
                      };
            _triggername = ["DETECTED",_main_pos,_main_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_main_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);

            {
              _civ_grp = CREA_GROUP(CIVILIAN);
              _spawn_at_pos = [_secmain_pos,_secmain_radius] call MFUNC(geometry,getCirclePos);
              _unit = _civ_grp createUnit [_x,_spawn_at_pos, [], 0, "NONE"];
              [_civ_grp,_secmain_pos,((_secmain_radius) - 10)] call BFUNC(taskPatrol);
              ARR_ADDVAR(_grps,_civ_grp);
            }forEach ["C_IDAP_MAN_AidWorker_01_F","C_IDAP_MAN_AidWorker_07_F","C_IDAP_MAN_AidWorker_08_F","C_IDAP_MAN_AidWorker_02_F","C_IDAP_MAN_Paramedic_01_F","C_IDAP_MAN_AidWorker_03_F"];
            ["GROUPS",_main_pos,_grps] call MFUNC(system,addToSystem);

         };
  case 2:{
            missionNamespace setVariable ["msot_sweepermis6",true,true];
            [8,"SUCCEEDED"] call MFUNC(tasks,setTask);
            sleep 6;
            [9,"AUTOASSIGNED",_secmain_pos] call MFUNC(tasks,setTask);
         };
  case 3:{
            [] spawn {
                      waitUntil{!(Kofferbombe2 getVariable ["a3f_bomb_active", true]) || !alive Kofferbombe2};
                      switch(true)do
                      {
                        case (!alive Kofferbombe2):{[9,"FAILED"] call MFUNC(tasks,setTask);sleep 6;[5] execVM "Missions\mission7.sqf";};
                        case (!(Kofferbombe2 getVariable ["a3f_bomb_active", true])):{[9,"SUCCEEDED"] call MFUNC(tasks,setTask);sleep 6;[4] execVM "Missions\mission7.sqf";};
                      };
                    };
         };
  case 4:{
            [10,"AUTOASSIGNED",[14813.3,6046.16,0]] call MFUNC(tasks,setTask);
            [6] execVM "Missions\mission7.sqf";
            If(missionNamespace getVariable[STRVAR_DO(reforce_ctrl),false])then
            {
              [[_main_pos,_secmain_pos],70,3,3,"MIXED_ALL","BORDER"] call MFUNC(creating,setUnits);
              sleep 5;
              [[_main_pos,_secmain_pos],70,3,3,"MIXED_ALL","BORDER"] call MFUNC(creating,setUnits);
              "Man hat Sie bemerkt!\nWeitere Truppen wurden angefordert!" remoteExec ["hint",([0,-2] select isDedicated)];
            };
         };
  case 5:{
            [10,"AUTOASSIGNED",[14813.3,6046.16,0]] call MFUNC(tasks,setTask);
            _script = {
                        missionNamespace setVariable [STRVAR_DO(artillery_ctrl),false,false];
                        [6] execVM "Missions\mission7.sqf";
                      };
            _triggername = ["LEAVE",_secmain_pos,_secmain_radius] call MFUNC(system,setTrigger);
            ["MAINTRIGGER",_secmain_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);
            missionNamespace setVariable [STRVAR_DO(artillery_ctrl),true,false];
            [] spawn {
                        sleep 5;
                        "Es wurde Verstärkung gerufen, seien Sie vorsichtig!" remoteExec ["hint",([0,-2] select isDedicated)];
                        sleep 10;
                        [[16586.7,12834.2,0.281],120,40,"MORTAR"] spawn MFUNC(creating,setArtillery);
                        private _s_timer = 5;
                        F_LOOP(_i,0,3)
                        {
                          [[[16654.5,12667.9,0],[16588.3,12779.4,0]],70,3,3,"MIXED_ALL","BORDER"] call MFUNC(creating,setUnits);
                          sleep _s_timer;
                          _s_timer = _s_timer + 5;
                        };
                     };
         };
  case 6:{
          _script = { [(_this select 1)] call MFUNC(system,delFromSystem);
                      {deleteVehicle _x}forEach nearestObjects [[16654.5,12667.9,0], ["all"],500];
                      "Ende" remoteExec ["playMusic",([0,-2] select isDedicated)];
                    };
          _triggername = ["LEAVE",_main_pos,(_main_radius + 200)] call MFUNC(system,setTrigger);
          ["MAINTRIGGER",_main_pos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
          missionNamespace setVariable ["msot_sweepermis7",true,true];
          "Submarine_01_F" createVehicle [14813.3,6046.16,0];
         };
  case 7:{
            [10,"SUCCEEDED"] call MFUNC(tasks,setTask);sleep 20;
            missionNamespace setVariable ["msot_sweepermis8",true,true];
         };
};
