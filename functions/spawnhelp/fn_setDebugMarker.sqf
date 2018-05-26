#include "msot_components.hpp"
/* ----------------------------------------------------------------------------
Function: MSOT_spawnhelp_fnc_setDebugMarker

Description: Set a Arrow with different Colors to Position

Parameters: [_position,_color_idx,(optional:true - House-/Ground Positions)]
            0 - Color Red
            1 - Color Blue
            2 - Color Green

Returns: Name of Arrow/Object

Examples:
          _arrow = [_position,1] call MSOT_spawnhelp_fnc_setDebugMarker;

Author: Fry

---------------------------------------------------------------------------- */

private ["_type","_arrow_over_point"];
params ["_position","_idx",["_chk_posses",false]];

_type = "";
_arrow_over_point = "";
switch(_idx)do
{
	case 0:{_type = "Sign_Arrow_F";};
	case 1:{_type = "Sign_Arrow_Blue_F";};
	case 2:{_type = "Sign_Arrow_Green_F";};
	default{If(true)exitWith{LOG_ERR("GRAD_spawnhelp_fnc_setDebugMarker: NO AVAILABLE CLASSNAME DETECTED!");};};
};

If(_chk_posses)then
{
  _arrow_over_point = createVehicle [_type,_position, [], 0, "CAN_COLLIDE"];
  SET_POSATL(_arrow_over_point,_position,0.2);
}else{
			_arrow_over_point = createVehicle [_type,_position, [], 0, "CAN_COLLIDE"];
      SET_POSATL(_arrow_over_point,(getPosASL _arrow_over_point),12);
     };
_arrow_over_point
