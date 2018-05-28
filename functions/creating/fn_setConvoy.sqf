If(isMultiplayer)then{If(!isServer)exitWith{};};
#include "msot_components.hpp"

/* ---------------------------------------------------------------------------------------------------------
Function: MSOT_creating_fnc_setConvoy

Description:

Parameters: [Position,Radius,[Vehicletypes],Patrol/Delete,PatrolRadius]

            POSITION          -   Center Position and Target Position for the convoy
            RADIUS/POSITION   -   Radius to search for a Spawnposition/ Positionarray for a defined Spawnposition
            [Vehicletypes]    -   "CAR","TRUCK","APC","TANK" - (Vehicle order)
                                  When you insert ["CAR","CAR","TRUCK"] then is the first Vehicle a Car the second a Car and the Last a Truck

            PATROL/DELETE     -   Select the Behaviour of the Groups for the Target Point "PATROL" or "DELETE"
            PatrolRadius      -   (Optional)  Radius for Group Patrol Area

Info: All Trucks and APC´s are Transport Systems and will filled with Groups of Enemies!
      For a planned Convoy Route you can define a List of Coordinates in (missionNamespace setVariable ["msot_convoy_route",[List with Coordinates],false])


Returns:  [LIST OF VEHICLES]
Examples:
          _streetblocks = [] call MSOT_creating_fnc_setConvoy;

Author: Fry

------------------------------------------------------------------------------------------------------------- */
private ["_output","_class_types","_street_data","_street_block","_vec_block","_crew_count","_vec_store","_re_veh","_force_calc","_script","_grp_arr","_street_wp","_street_wppos"];
params ["_main_pos","_radius","_types","_delopat",["_pat_radius",200]];

_output = [];
_street_pos = If((typeName _radius) isEqualTo "SCALAR")then{[_main_pos,_radius] call MFUNC(spawnhelp,getStreetInDistance)}else{_radius};
If(count _street_pos > 0)then
{
  //If(!isMultiplayer && (["debug_modus",1] call BIS_fnc_getParamValue) == 1)then{player setPos _street_pos;};
  _class_types = [];
  {
    _vec_class_arr = switch(toUpper _x)do
                     {
                       case "CAR":{If(count MSOT_CARS > 0)then{[(selectRandom MSOT_CARS),0]}else{[]}};
                       case "TRUCK":{If(count MSOT_TRANSPORT > 0)then{[(selectRandom MSOT_TRANSPORT),1]}else{[]}};
                       case "APC":{If(count MSOT_APC > 0)then{[(selectRandom MSOT_APC),1]}else{[]}};
                       case "TANK":{If(count MSOT_TANKS > 0)then{[(selectRandom MSOT_TANKS),0]}else{[]}};
                       default {[_x,0]};
                     };
    If(count _vec_class_arr > 0)then{ARR_ADDVAR(_class_types,_vec_class_arr);};
  }forEach _types;
  If(count _class_types > 0)then
  {
    _street_data = [_street_pos,_main_pos,(count _class_types)] call MFUNC(spawnhelp,getStreetLine);
    If((count _class_types) isEqualTo (count _street_data))then
    {
      _vec_store = [];
      _grp = CREA_GROUP(MSOT_ENEMY_SIDE);
      F_LOOP(_i,0,((count _street_data) - 1))
      {
        _street_block = (_street_data select _i);
        _vec_block = (_class_types select _i);
        _re_veh = [(_street_block select 0),(_street_block select 1),(_vec_block select 0),_grp] call BFUNC(spawnVehicle);
        _crew_count = (count (crew  (_re_veh select 0)));
        ARR_ADDVAR(_output,(_re_veh select 0));
        If((_vec_block select 1) > 0)then
        {
          _grp_arr = [(_re_veh select 0),"NORMAL_UNITS"] call MFUNC(creating,setCargoUnits);
          _vec_store pushBack [(_re_veh select 0),_grp_arr,_crew_count];
        }else{
               _vec_store pushBack [(_re_veh select 0),[],_crew_count];
             };
        sleep 0.02;
      };
      {(driver _x) assignAsDriver _x;}forEach _output;
      [_grp] call MFUNC(system,setUnitSkill);sleep 0.2;
      If(count (missionNamespace getVariable[STRVAR_DO(convoy_route),[]]) > 0)then
      {
        private _route_poss = (missionNamespace getVariable[STRVAR_DO(convoy_route),[]]);
        {
          If(_forEachindex isEqualTo ((count _route_poss) - 1))then
          {
            [_grp,_x,2,"TR UNLOAD","AWARE","GREEN","LIMITED","FILE"] call CBA_fnc_addWaypoint;
          }else{
                [_grp,_x,1,"MOVE","AWARE","GREEN","LIMITED","FILE"] call CBA_fnc_addWaypoint;
               };
          sleep 0.2;
        }forEach _route_poss;
       missionNamespace setVariable[STRVAR_DO(convoy_route),nil];
      }else{
            _street_wp = [_main_pos,_pat_radius] call MFUNC(spawnhelp,nearestStreet);
            _street_wppos = If(!(_street_wp isEqualTo ""))then{position _street_wp}else{_main_pos};
            sleep 0.1;
            [_grp,_street_wppos,1,"MOVE","AWARE","GREEN","NORMAL","FILE"] call CBA_fnc_addWaypoint;
            [_grp,_street_wppos,2,"TR UNLOAD","AWARE","GREEN","NORMAL","FILE"] call CBA_fnc_addWaypoint;
            [_grp,_street_wppos] spawn {sleep 10;
                                        private _run = false;
                                        {
                                          If(alive _x && (speed (vehicle _x) < 1))then{_x doMove (_this select 1);_run = true;};
                                          If(_run)then
                                          {
                                            [(_this select 0),(_this select 1),1,"MOVE","AWARE","GREEN","NORMAL","FILE"] call CBA_fnc_addWaypoint;
                                            [(_this select 0),(_this select 1),2,"TR UNLOAD","AWARE","GREEN","NORMAL","FILE"] call CBA_fnc_addWaypoint;
                                          };
                                        }forEach units (_this select 0);
                                       };

          };
          {_x setConvoySeparation 15;}forEach _output;
          _script = {If(!(missionNamespace getVariable["msot_convoy_stopped",false]))then
                     {
                       {if(alive _x && canMove _x)then{_x limitSpeed 40;};}forEach _this;
                     }else{
                       ["msot_speed_ctrl", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
                     };
                    };
           ["msot_speed_ctrl","onEachFrame",_script,_output] call BFUNC(addStackedEventHandler);
       //STARTE KONTROLLE DES KONVOI
      [_main_pos,_pat_radius,_delopat,_vec_store] spawn
      {
        private ["_first_vec","_m_group","_all_grps_arr","_all_vecs_arr","_crew_num","_convoy_attacked","_attackPos",
                 "_vec","_i","_o_grp","_m_grp","_script","_triggername","_add_driver","_driver"];
        params ["_m_pos","_m_radius","_m_behaviour","_m_vecs"];
        _first_vec = ((_m_vecs select 0) select 0);
        _m_group = (group (driver _first_vec));
        _waypoint_count = (count (waypoints _m_group));
        _all_grps_arr = []; _all_vecs_arr = [];
        _convoy_attacked = false;

        waitUntil{((driver _first_vec) call BFUNC(enemyDetected)) || {(!alive (driver _first_vec))} || {(currentWaypoint _m_group) > (_waypoint_count - 1)}};
        missionNamespace setVariable["msot_convoy_stopped",true,true];
        switch(true)do
        {
          case (((driver _first_vec) call BFUNC(enemyDetected))):{_convoy_attacked = true;};
          case (!alive (driver _first_vec)):{_convoy_attacked = true;};
        };
        If(_convoy_attacked)then
        {
          while{(count (waypoints _m_group)) > 0}do{deleteWaypoint ((waypoints _m_group) select 0);sleep 0.04;};
          _first_vec = If(alive ((_m_vecs select 0) select 0))then{((_m_vecs select 0) select 0)}else{((_m_vecs select ((count _m_vecs) - 1)) select 0)};
          _attackPos = (position _first_vec);
          {
            _vec = (_x select 0); _grp_arr = (_x select 1);_crew_num = (_x select 2);
            If(count _grp_arr > 0)then
            {
              If(alive _vec)then
              {
                F_LOOP(_i,0,((count _grp_arr) - 1))
                {
                  _o_grp = (_grp_arr select _i);
                  {unassignVehicle _x;}forEach units _o_grp;
                  _o_grp leaveVehicle _vec;
                  _o_grp setCombatMode "YELLOW";_o_grp setBehaviour "COMBAT";
                  If((_attackPos distance2D _m_pos) <= (_m_radius + 200))then
                  {
                    [_o_grp,_m_pos,_m_radius] call CFUNC(taskAttack);
                  }else{[_o_grp,_attackPos,_m_radius] call CFUNC(taskDefend);};
                };
                ARR_ADDARR(_all_grps_arr,_grp_arr);
                //Transporte mit mehr als 1 Crewmitglied werden zum Kampf aufgefordert
                If((count (crew _vec) > 0) && {_crew_num > 1})then
                {
                  _m_grp = CREA_GROUP(MSOT_ENEMY_SIDE);
                  (crew _vec) joinSilent _m_grp;
                  [_m_grp] call MFUNC(system,setUnitSkill);
                  _m_grp setCombatMode "YELLOW";_m_grp setBehaviour "COMBAT";
                  If((_attackPos distance2D _m_pos) <= (_m_radius + 200))then
                  {
                    [_m_grp,_m_pos,_m_radius] call CFUNC(taskAttack);
                  }else{[_m_grp,_attackPos,_m_radius] call CFUNC(taskDefend);};
                  ARR_ADDVAR(_all_grps_arr,_m_grp);
                };
              };
            }else{
                   If(alive _vec && {(count (crew _vec)) > 0})then
                   {
                     _m_grp = CREA_GROUP(MSOT_ENEMY_SIDE);
                     (crew _vec) joinSilent _m_grp;
                     [_m_grp] call MFUNC(system,setUnitSkill);
                     _m_grp setCombatMode "YELLOW";_m_grp setBehaviour "COMBAT";
                     If((_attackPos distance2D _m_pos) <= (_m_radius + 200))then
                     {
                       [_m_grp,_m_pos,_m_radius] call CFUNC(taskAttack);
                     }else{[_m_grp,_attackPos,_m_radius] call CFUNC(taskDefend);};
                     ARR_ADDVAR(_all_grps_arr,_m_grp);
                   };
                 };
            ARR_ADDVAR(_all_vecs_arr,_vec);
          }forEach _m_vecs;
          _m_group setCombatMode "YELLOW";_m_group setBehaviour "COMBAT";
          [_m_group,_attackPos,_m_radius] call CFUNC(taskDefend);
          ARR_ADDVAR(_all_grps_arr,_m_group);

          If((_attackPos distance2D _m_pos) <= (_m_radius + 200))then
          {
             If((toUpper (_m_behaviour)) isEqualTo "PATROL")then
             {
               ["GROUPS",_m_pos,_all_grps_arr] call MFUNC(system,addToSystem);
               ["VEHICLES",_m_pos,_all_vecs_arr] call MFUNC(system,addToSystem);
             }else{
                    ["GROUPS",_attackPos,_all_grps_arr] call MFUNC(system,addToSystem);
                    ["VEHICLES",_attackPos,_all_vecs_arr] call MFUNC(system,addToSystem);
                    _script = {[(_this select 1)] call MFUNC(system,delFromSystem);};
                    _triggername = ["LEAVE",_attackPos,(_m_radius + 100)] call MFUNC(system,setTrigger);
                    ["MAINTRIGGER",_attackPos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
                  };
          }else{
                 ["GROUPS",_attackPos,_all_grps_arr] call MFUNC(system,addToSystem);
                 ["VEHICLES",_attackPos,_all_vecs_arr] call MFUNC(system,addToSystem);
                 _script = {[(_this select 1)] call MFUNC(system,delFromSystem);};
                 _triggername = ["LEAVE",_attackPos,(_m_radius + 200)] call MFUNC(system,setTrigger);
                 ["MAINTRIGGER",_attackPos,[_triggername,_script,0,true]] call MFUNC(system,addMissionInfos);
               };

        }else{
                If((toUpper (_m_behaviour)) isEqualTo "PATROL")then
                {
                  {
                    _vec = (_x select 0); _grp_arr = (_x select 1);_crew_num = (_x select 2);
                    _add_driver = true; _driver = (driver _vec);
                    If(count _grp_arr > 0)then
                    {
                      F_LOOP(_i,0,((count _grp_arr) - 1))
                      {
                        _o_grp = (_grp_arr select _i);
                        {unassignVehicle _x;}forEach units _o_grp;
                        _o_grp leaveVehicle _vec;
                        If(_add_driver && {_crew_num < 2})then
                        {unassignVehicle _driver; [_driver] joinSilent _o_grp;_driver leaveVehicle _vec; _add_driver = false;};
                        sleep 0.2;
                        _o_grp setCombatMode "YELLOW";_o_grp setBehaviour "CARELESS";
                        [_o_grp,_m_pos,(round(_m_radius * 0.5))] call BFUNC(taskPatrol);
                      };
                      ARR_ADDARR(_all_grps_arr,_grp_arr);
                    };
                    ARR_ADDVAR(_all_vecs_arr,_vec);
                    If(_crew_num > 1)then
                    {
                      _m_grp = CREA_GROUP(MSOT_ENEMY_SIDE);
                      (crew _vec) joinSilent _m_grp;
                      _m_grp setCombatMode "YELLOW";_m_grp setBehaviour "CARELESS";
                      [_m_grp,_m_pos,(round(_m_radius * 0.5))] call BFUNC(taskPatrol);
                      ARR_ADDVAR(_all_grps_arr,_m_grp);
                    };
                  }forEach _m_vecs;
                  ["GROUPS",_m_pos,_all_grps_arr] call MFUNC(system,addToSystem);
                  ["VEHICLES",_m_pos,_all_vecs_arr] call MFUNC(system,addToSystem);
                  _script = {[(_this select 1)] call MFUNC(system,setTargetBehavior);};
                  _triggername = ["DETECTED",_m_pos,_m_radius] call MFUNC(system,setTrigger);
                  ["MAINTRIGGER",_m_pos,[_triggername,_script,0,false]] call MFUNC(system,addMissionInfos);

                }else{
                       {deleteVehicle _x;}forEach units _m_group;
                       {
                         _vec = (_x select 0); _grp_arr = (_x select 1);_crew_num = (_x select 2);
                         ARR_ADDVAR(_all_vecs_arr,_vec);
                         If(count _grp_arr > 0)then{F_LOOP(_i,0,((count _grp_arr) - 1)){{deleteVehicle _x;}forEach units (_grp_arr select _i);};};
                         deleteVehicle _vec;
                       }forEach _m_vecs;
                       If(count _all_vecs_arr > 0)then{{["MAINTARGETS",_x,"FAILED"] spawn MSOT_system_fnc_eventHandling;sleep 0.2}forEach _all_vecs_arr;};
                     };

             };
        missionNamespace setVariable["msot_convoy_stopped",nil];
      };
    };
  };

};
_output
