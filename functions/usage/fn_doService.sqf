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
private ["_vec_type","_vec_parents","_allow","_driver","_magazines","_timer","_removed","_turret_config","_x","_mags","_turrets","_i","_config"];
params ["_vehicle",["_set_fuel",false]];
_chk_arr = ["Air","LandVehicle"];

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

_turrets = _vec_type call BFUNC(allTurrets);
_turret_config = [_vehicle] call BFUNC(getTurrets);
_magazines_arr = [];
{
  _magazines = getArray(_x >> "magazines");
  If(count _magazines > 0)then{ARR_ADDVAR(_magazines_arr,_magazines);};
}forEach _turret_config;


If((count _turrets) isEqualTo (count _magazines_arr))then
{
  {
    _vehicle removeMagazinesTurret [(_x select 0),(_x select 1)];
    sleep 0.5;
  }forEach (magazinesAllTurrets _vehicle);
  {
   _mags = (_magazines_arr select _forEachIndex);
    F_LOOP(_i,0,((count _mags) - 1))
    {
      _vehicle addMagazineTurret [(_mags select _i),_x];
      sleep 0.5;
    };
  sleep 0.5;
 }forEach _turrets;
};
_vehicle setVehicleAmmo 1;

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
}else{If(hasInterface && player == _vehicle)then{cutText ["<t color='#ff0000' size='3'>THIS SERVICEPOINT IS FOR<br/>!!! VEHICLES ONLY !!!</t>","PLAIN",-1,true,true];
      sleep 4;cutText ["","PLAIN",-1,true,true];
      };};
true
