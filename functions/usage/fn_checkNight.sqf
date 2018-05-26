#include "msot_components.hpp"
/* -----------------------------------------------------------------------------------------------
Function: MSOT_usage_fnc_checkNight

Description: Check for Night.

Parameters:


Returns: BOOL

Examples:
          _isnight = call MSOT_usage_fnc_checkNight;

Author: Fry

-------------------------------------------------------------------------------------------------- */


private _output = If(sunOrMoon <= 0.4)then{true}else{false};

_output
