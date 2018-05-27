If(isMultiplayer)then{if(hasInterface)exitWith{};};

#include "msot_components.hpp"
/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_setTrigger

Description: Set a defined Trigger on Map

             SERVER ONLY

Parameters: [INDEX,POSITION,RADIUS]

            INDEX        -      "ACTIVATE" : activate Trigger by own Side (Playerside)
                                "LEAVE"    : activate Trigger when leaving the Area by own Side (Playerside)
                                "DETECTED" : activate Trigger when Enemies discover your Side
                                "CONTROLLED" : activate Trigger when Enemy units count less than 5 and Enemy Vehicles no longer exists

            Position     -      Position to create the Trigger

            RADIUS       -      Radius of the Trigger (Circle)

Returns: Triggername (ObjectName)

Examples:
          _triggername = ["ACTIVATE",(getMarkerPos "Town"),400] spawn MSOT_system_fnc_setTrigger;

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_trigger_name","_exp_arr"];

params ["_idx","_pos","_size"];

_trigger_name = createTrigger ["EmptyDetector",_pos,false];
_trigger_name setTriggerArea [_size, _size, 0, false];
switch(_idx)do
{
 case "ACTIVATE":{
                    _trigger_name setTriggerActivation ["ANYPLAYER","PRESENT", false];
                    _trigger_name setTriggerStatements ["this", "nul = ['MAINTRIGGER',thisTrigger] spawn MSOT_system_fnc_manageMissionCheck",""];
                 };
 case "LEAVE":{
               _trigger_name setTriggerActivation ["ANYPLAYER", "NOT PRESENT", false];
               _trigger_name setTriggerStatements ["this", "nul = ['MAINTRIGGER',thisTrigger] spawn MSOT_system_fnc_manageMissionCheck",""];
              };
 case "DETECTED":{
                  _trigger_name setTriggerActivation [MSOT_FRLYTR_SIDE, (MSOT_EMYTR_SIDE + " D"), false];
                  _trigger_name setTriggerStatements ["this", "nul = ['MAINTRIGGER',thisTrigger] spawn MSOT_system_fnc_manageMissionCheck",""];
                };
 case "CONTROLLED":{
                      _exp_arr = [
                                  "this && {('Man' countType thisList) < 5} && {('LandVehicle' countType thisList) == 0}",
                                  "nul = ['MAINTRIGGER',thisTrigger] spawn MSOT_system_fnc_manageMissionCheck",
                                  ""
                                 ];
                      _trigger_name setTriggerActivation ["ANYPLAYER","PRESENT", false];
                      _trigger_name setTriggerStatements _exp_arr;
                    };

};

//"nul = ['MAINTRIGGER',thisTrigger] spawn MSOT_system_fnc_manageMissionCheck"
_trigger_name
