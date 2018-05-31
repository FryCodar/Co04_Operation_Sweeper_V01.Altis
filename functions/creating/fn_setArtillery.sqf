/*--------------------------------------------------------------
Function: MSOT_creating_fnc_setArtillery

Description: Find a random Impact Position for Artillery

Parameters: [Position/Object,MAXRadius,MINRadius,ARTILLERY-INDEX]


Returns:  Array with Positions
Examples:
          _pos_list = [] call MSOT_creating_fnc_setArtillery;

Author: Fry

-------------------------------------------------------------------------------------------------- */
If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "msot_components.hpp"
private ["_expl_class","_do_it","_explosion_pos","_sleeper","_sounds","_sound_shuffle","_pl_sound","_imp_obj","_bombname"];
params ["_art_pos","_max_radius","_min_radius","_art_idx"];

_expl_class = "";
_do_it = true;
If(typeName _art_pos isEqualTo "ARRAY")then{If(count _art_pos < 3)then{_do_it = false;};}else{_do_it = false;};
switch(toUpper(_art_idx))do
{
 case "SMOKE":{_expl_class = "SmokeShellArty";};
 case "BOMB":{_expl_class = "BO_GBU12_LGB";};
 case "MORTAR":{_expl_class = "R_80mm_HE";};
 case "GLAUNCHER":{_expl_class = "R_60mm_HE";};
 case "HELIBIG":{_expl_class = "HelicopterExploBig";};
 case "HELISMALL":{_expl_class = "HelicopterExploSmall";};
 default {_do_it = false;};
};

If(_do_it)then
{

  while{missionNamespace getVariable [STRVAR_DO(artillery_ctrl),false]}do
  {
    _explosion_pos = [_art_pos,_max_radius,_min_radius,true] call MFUNC(geometry,getImpactPos);
    If(count _explosion_pos > 0)then
    {
       _sounds = [1,2,2,1,2,2,1,2,2,2,1,2,2,1,1,2,2,1,2,1,2,2,2,1,1,2,2,2,2,2,1,2,2,1,2,2,1,2,2];
       _sound_shuffle = _sounds call BFUNC(arrayShuffle);
       _pl_sound = format["mortar%1",(selectRandom _sound_shuffle)];
       _imp_obj = createVehicle ["Land_MetalWire_F",_explosion_pos,[], 0, "CAN_COLLIDE"];
       [_imp_obj, [_pl_sound,_max_radius]] remoteExec ["say3D",([0,-2] select isDedicated)];
       sleep 2;
       _bombname = createVehicle [_expl_class,_explosion_pos,[],0,"NONE"];
       deleteVehicle _imp_obj;
    };
    _sleeper = (random 8);
    If(_sleeper <= 2)then{_sleeper = 2;};
    sleep _sleeper;
  };

};
