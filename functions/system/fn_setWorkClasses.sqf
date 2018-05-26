If(isMultiplayer)then{if(hasInterface) exitWith{};};
[] spawn {
#include "msot_components.hpp"

/* -----------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_setWorkClasses

Description: Set Variables with Unit-,Vehicle Classnames etc.

Author: Fry

-------------------------------------------------------------------------------------------------- */
private ["_faction","_civ_faction","_faction_classes","_strsintxt","_weapon_arr","_x","_men_trans","_chk_weapmag","_timer",
         "_turrets","_mag_count","_mag_con","_cl","_i","_ct","_config_mag","_random_class","_magazines","_mag_rounds"];
params ["_idx"];


_faction = "";
_civ_faction = "";
_special_search = false;

//Available Global Variables___________________________________________________________________________________________
MSOT_MEN = [];
MSOT_MENURBAN = [];
MSOT_SFMEN = [];
MSOT_SNIPER = [];
MSOT_DIVER = [];
MSOT_PILOT = [];
MSOT_PARACHUT = [];
MSOT_TANKS = [];
MSOT_ARTILLERY = [];
MSOT_CARS = [];
MSOT_TRANSPORT = [];
MSOT_APC = [];
MSOT_BOATS = [];
MSOT_DRONES = [];
MSOT_ANTIAIR = [];
MSOT_TRANSHELI = [];
MSOT_AIRFORCE = [];
MSOT_STATICWEAPONS = [];
MSOT_CIVMEN = [];
MSOT_CIVCAR = [];
MSOT_OWN_SIDE = WEST;
MSOT_ENEMY_SIDE = EAST;
MSOT_C4_CLASSES = [
                   "FuelExplosionBig","DemoCharge_Remote_Ammo","SatchelCharge_Remote_Ammo","SatchelCharge_Remote_Ammo_Scripted",
                   "DemoCharge_Remote_Ammo_Scripted"];
//DONT TOUCH THIS______________________________________________________________________________________________________

handle = [] execVM "init_classes.sqf";
_timer = time + 10;
waitUntil{scriptDone handle || time > _timer};


MSOT_EMYTR_SIDE = (str MSOT_ENEMY_SIDE);
switch(true)do
{
  case (MSOT_ENEMY_SIDE == resistance):{MSOT_EMYTR_SIDE = "GUER";};
  case (MSOT_ENEMY_SIDE == independent):{MSOT_EMYTR_SIDE = "GUER";};
};
MSOT_FRLYTR_SIDE = (str MSOT_OWN_SIDE);
switch(true)do
{
  case (MSOT_OWN_SIDE == resistance):{MSOT_FRLYTR_SIDE = "GUER";};
  case (MSOT_OWN_SIDE == independent):{MSOT_FRLYTR_SIDE = "GUER";};
};

//_____________________________________________________________________________________________________________________

   If(isServer)then{missionNamespace setVariable [STRVAR_DO(com_explosives),MSOT_C4_CLASSES,true];};
};
