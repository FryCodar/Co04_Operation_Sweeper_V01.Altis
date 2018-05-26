If(isMultiplayer)then{if(hasInterface) exitWith{};};
#include "msot_components.hpp"

/* --------------------------------------------------------------------------------------------------------------
Function: MSOT_system_fnc_getPlayerCount

Description: Counts the available Players on Server

Parameters: []


Returns: NUMBER

Examples:
          _playercount = [] call MSOT_system_fnc_getPlayerCount

Author: Fry

----------------------------------------------------------------------------------------------------------------- */

private _counter = If(isMultiplayer)then{count(allPlayers - entities "HeadlessClient_F")}else{1};
_counter
