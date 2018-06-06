If(!hasInterface) exitWith {};
#include "msot_components.hpp"
private ["_player","_type_player","_config_text","_searched_word","_searched_in_type","_searched_in_config","_uniform","_googles"];
diag_log "INITPLAYER: Starte INIT PLAYER";

_player = player;

_player setUnitTrait ["UAVHacker",true];

If((missionNamespace getVariable [STRVAR_DO(equip_cleaner),true]) && (["start_with_nothing",0] call BFUNC(getParamValue)) == 1)then{
If(count NEW_SETTING > 0)then{
  [_player] execVM NEW_SETTING;
}else{
_uniform = uniform _player;
removeAllWeapons _player;
removeHeadgear _player;
removeGoggles _player;
removeAllContainers _player;
If(!((hmd _player) isEqualTo ""))then{_googles = (hmd _player);_player unassignItem _googles;_player removeItem _googles;};
_player addUniform _uniform;
};
};

_type_player = typeOf _player;
_config_text = getText (configFile >> "CfgVehicles" >> _type_player >> "icon");
_searched_word = "medic";
_searched_in_type = [_searched_word,_type_player] call BFUNC(inString);
_searched_in_config = [_searched_word,_config_text] call BFUNC(inString);

switch(["who_is_medic", 0] call BFUNC(getParamValue))do
{
  case 0:{
           If(_searched_in_type || _searched_in_config)then
           {
              if((player getVariable ["Ace_medical_medicClass",0]) < 1)then{player setVariable ["Ace_medical_medicClass",1,true];};
           };
         };
   case 1:{
            if((player getVariable ["Ace_medical_medicClass",0]) < 1)then{player setVariable ["Ace_medical_medicClass",1,true];_player setUnitTrait ["Medic",true];};
          };
};

// Setzt Briefing
[] call MFUNC(briefing,addBriefing);

//Checkt Respawn Positionen ab
If(count (missionNamespace getVariable [STRVAR_DO(resp_poses),[]]) > 0)then
{
  [1,(missionNamespace getVariable [STRVAR_DO(resp_poses),[]])] call MFUNC(system,doClientRespawn);
};
//Checkt AddAction Einträge
If(count (missionNamespace getVariable [STRVAR_DO(action_storage),[]]) > 0)then
{
  {_x call MFUNC(system,setClientAction);}forEach (missionNamespace getVariable [STRVAR_DO(action_storage),[]]);
};
//Setzt Task
[] spawn {
waitUntil{!isNil "camera_run"};
sleep 2;
if(count (missionNamespace getVariable [STRVAR_DO(missions_stored_tasks),[]]) > 0)then
{
  {_x call MFUNC(tasks,setTask); sleep 6;}forEach (missionNamespace getVariable [STRVAR_DO(missions_stored_tasks),[]]);
};
};




init_player = true;

true
