If(isMultiplayer)then{If(!hasInterface)exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_setClientAction

Description: Add a defined AddAction to an Object.

Parameters: [OBJECT,ACTIONTYPE,COLOR,TEXT]

            OBJECT         -     NAME OF OBJECT TO ADD THE ACTION
            ACTIONTYPE     -     A DEFINED ACTION OR INITIALIZE AN AMMO BOX  - "ACTION" / "AMMO"
                                 (AMMOBOX VERSION IS A OWN SYSTEM FUNCTION - Blacklist Option possible >> initplayerlocal.sqf)

            COLOR          -     "RED","GREEN","BLUE","YELLOW","LYELLOW","PINK","NORMAL"

            TEXT           -     NORMAL TEXT STRING "" OR "STR_BOX_ACTION"

Returns: Nothing

Examples:
            [BOX,"AMMO","RED","STR_BOX_ACTION"] spawn MSOT_system_fnc_setClientAction

Author: Fry

----------------------------------------------------------------------------------------------------------------- */

private ["_action_text","_text_part"];
params ["_obj","_type","_color","_txt"];


_action_text = If(isLocalized _txt)then{localize _txt}else{_txt};
_text_part = switch(toUpper _color)do
             {
               case "RED":{'<t color=''#ff4500''>' + _action_text + '</t>'};
               case "GREEN":{'<t color=''#f000ff00''>' + _action_text + '</t>'};
               case "BLUE":{'<t color=''#f000ffff''>' + _action_text + '</t>'};
               case "YELLOW":{'<t color=''#dddd00''>' + _action_text + '</t>'};
               case "LYELLOW":{'<t color=''#fdddfd4f''>' + _action_text + '</t>'};
               case "PINK":{'<t color=''#ff45f0''>' + _action_text + '</t>'};
               case "NORMAL":{_action_text};
               default {_action_text};
             };
switch(toUpper _type)do
{
  case "AMMO":{_obj addAction [_text_part,{[] spawn MFUNC(arsenal,initArsenal)},nil,1.5,false,true,"","true",6];};
  case "ACTION":{_obj addAction [_text_part,{_this spawn MFUNC(system,getClientAction)},nil,1.5,false,true,"","true",6];};
  default {LOG_ERR("SET_CLIENT_ACTION : NO MATCH FOUND FOR CREATE A ADDACTION");};
};
