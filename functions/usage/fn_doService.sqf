#include "msot_components.hpp"
/* -----------------------------------------------------------------------------------------------
Function: MSOT_usage_fnc_doService

Description: Servicing and Reload Vehicles.

Parameters: [Vehiclename,(Optinal: true)]

            Optional: Refueling Gasoline for Server/HC Vehicles
                      - Default: false / for PlayerVehicles always true

Returns: BOOL

Examples:
          _service = [CAR1] spawn MSOT_usage_fnc_doService;

Author: Fry

-------------------------------------------------------------------------------------------------- */
private ["_set_fuel","_vec_type","_vec_parents","_allow","_driver","_magazines","_timer","_removed","_x","_count","_i","_config"];
params ["_vehicle","_set_fuel"];
_chk_arr = ["Air","LandVehicle"];
If(isNil "_set_fuel")then{_set_fuel = false;};
If(hasInterface)then{_set_fuel = true;};

_vec_type = typeOf _vehicle;
_vec_parents = [configfile >> "CfgVehicles" >> _vec_type, true] call BIS_fnc_returnParents;
_allow = ({_x In _vec_parents} count _chk_arr) > 0;
If(_allow)then{
_timer = time + 40;
waitUntil{speed _vehicle <= 1 || time > _timer};
_driver = "";
If(hasInterface)then{
  If((getText(configfile >> "CfgVehicles" >> _vec_type >> "vehicleClass")) isEqualTo "Autonomous")then
  {
    _driver = ((UAVControl _vehicle) select 0);
  }else{_driver = driver _vehicle;};
};
_magazines = getArray(configFile >> "CfgVehicles" >> _vec_type >> "magazines");

If(alive _vehicle)then
{
If(hasInterface)then
{
_vehicle setfuel 0;
if(player == _driver)then
{
cutText ["Servicing... Please stand by...","PLAIN",4];
sleep 5;
cutText ["Reloading weapons ...","PLAIN",4];
};
};

If(count _magazines > 0)then
{
    _removed = [];
    {
If(!(_x in _removed))then
{
_vehicle removeMagazines (format["%1",_x]);
_removed = _removed + [_x];
};
    }forEach _magazines;
{
_vehicle addMagazine (format["%1", _x]);
    }forEach _magazines;
_vehicle setVehicleAmmo 1;
};
_count = count (configFile >> "CfgVehicles" >> _vec_type >> "Turrets");

If(_count > 0)then
{
for "_i" from 0 to (_count - 1) do
{
_config = (configFile >> "CfgVehicles" >> _vec_type >> "Turrets") select _i;
_magazines = getArray(_config >> "magazines");
_removed = [];

{
 if (!(_x in _removed))then
{
_vehicle removeMagazinesTurret [(format["%1",_x]),[_i]];
_removed = _removed + [_x];
};
}forEach _magazines;
{
 _vehicle addMagazineTurret [(format["%1",_x]),[_i]];
}forEach _magazines;
sleep 0.04;
};
};

If(hasInterface)then
{
sleep 7;
   If(player == _driver)then{cutText ['Repairing ...','PLAIN',2];};
   _vehicle setDamage 0;
   sleep 5;
  if(player == _driver)then
{
cutText ['Refueling...','PLAIN',2];
   sleep 5;
   cutText ["<t color='#f000ff00' size='3'>VEHICLE IS READY</t>","PLAIN DOWN",2,true,true];
  };
  };

If(_set_fuel)then
{
_vehicle setfuel 1;
};
};
}else{If(hasInterface && player == _vehicle)then{cutText ["<t color='#ff0000' size='3'>THIS SERVICEPOINT IS FOR<br/>!!! VEHICLES ONLY !!!</t>","PLAIN",0,true,true];
      sleep 4;cutText ["","PLAIN",0,true,true];
      };};
true
