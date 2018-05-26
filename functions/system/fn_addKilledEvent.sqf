If(isMultiplayer)then{if(hasInterface)exitWith{};};
#include "msot_components.hpp"
/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_addKilledEvent

Description: add a Killed EventHandler to an defined Object

             SERVER ONLY

Parameters: [OBJECTNAME,STATE]

            OBJECT     -    Object, which you want to attach the event handler
            STATE      -    State when Eventhandler was activated : "SUCCESS"/ "FAILED"

Returns: Nothing

Examples:
          [CAR1,"FAILED"] call MSOT_system_fnc_addKilledEvent;

Author: Fry

----------------------------------------------------------------------------------------------------------------- */
private ["_chk","_script"];
params["_obj","_state"];

_chk = true;
_script = switch(toUpper _state)do
          {
            case "SUCCESS":{{["MAINTARGETS",(_this select 0),"SUCCESS"] spawn MSOT_system_fnc_eventHandling;}};
            case "FAILED":{{["MAINTARGETS",(_this select 0),"FAILED"] spawn MSOT_system_fnc_eventHandling;}};
            default {_chk = false;LOG_ERR("ADDKILLEDEVENT : WRONG INDEX TYPE DETECTED! NO EVENTHANDLER ATTACHED!");};
          };
If(_chk)then
{
  _obj addEventHandler ["killed", _script];
};
