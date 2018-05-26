#include "msot_components.hpp"
/*--------------------------------------------------------------
Function: MSOT_geometry_fnc_getImpactPos

Description: Find a random Impact Position for Artillery

Parameters: [Position/Object,Radius,Number of positions/SafetyZoneRadius,UseSafetyZone]


Returns:  Array with Positions
Examples:
          _pos_list = [TANK,50,10] call MSOT_geometry_fnc_getImpactPos;

Author: Fry

-------------------------------------------------------------------------------------------------- */
private ["_output","_co","_angel","_ari_point","_new_radius","_i"];
params ["_center","_radius","_num","_safety"];
_output = [];
_safety_zone = If(count _this > 3)then{_safety}else{false};

If(_safety_zone)then
{
  If(_radius > (_num * 2))then
  {
    _co = 0;
    _angle = floor (random 360);
    _new_radius = (round(random _radius));
    If(_new_radius <= _num)then{_new_radius = (_num + 2);};
    _ari_point = _center getPos [_new_radius * sqrt random 1, _angle];
    while{count _ari_point == 0 && _co < 20}do
    {
      _angle = floor (random 360);
      _new_radius = (round(random _radius));
      If(_new_radius <= _num)then{_new_radius = (_num + 2);};
      _ari_point = _center getPos [_new_radius * sqrt random 1, _angle];
      _co = _co + 1;
      sleep 0.04;
    };
    If(count _ari_point > 0)then{_output = _ari_point;};
  };
}else{
      F_LOOP(_i,1,_num)
      {
        _co = 0;
        _ari_point = _center getPos [(random _radius) * sqrt random 1, (random 360)];
        while{count _ari_point == 0 && _co < 20}do
        {
          _ari_point = _center getPos [(random _radius) * sqrt random 1, (random 360)];
          _co = _co + 1;
          sleep 0.04;
        };
        If(count _ari_point > 0)then{ARR_ADDVAR(_output,_ari_point);};
        sleep 0.04;
      };
};
_output
