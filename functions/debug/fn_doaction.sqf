if(!hasInterface) exitwith {};
#include "msot_components.hpp"

  private ["_obj","_caller","_idx","_xtra","_txt","_bunkers"];
  _obj = _this select 0;
  _caller = _this select 1;
  _idx = _this select 2;
  _xtra = _this select 3;


  switch(_xtra)do
  {
   case 0:{

            _this call MFUNC(usage,fastTravel);


   	      };
   case 1:{
            hint format ["DATEN ABFRAGE:\n POSASL: %1 \n DIRECTIONS: %2 \n POSITION: %3",(getPosATL _caller),(getDir _caller),(getPos _caller)];
  		      diag_log format ["DATEN ABFRAGE:\n POSASL: %1 \n DIRECTIONS: %2 \n POSITION: %3", (getPosATL _caller),(getDir _caller),(getPos _caller)];
            copyToClipboard str (position player);
  		  //hint format ["[%1,%2]",(getPos _caller),(getDir _caller)];
  		  //diag_log format ["[%1,%2]", (getPos _caller),(getDir _caller)];

  		  //hint format ["%1",(getDir _caller)];


          };
   case 2:{
            hint "Script begins";
            //[2] execVM "Missions\mission1.sqf";
            //player playMoveNow "AinvPknlMstpSlayWpstDnon_medicOther";
            //[[9148.21,21611.9,0],2000,["CAR","TRUCK"],"DELETE"] call MFUNC(creating,setConvoy);
            //deleteVehicle ((missionNamespace getVariable ["BAGP",[]]) select 0);
            //EventTrack01_F_EPA
            //[1] execVM "Missions\mission1.sqf";
            //copyToClipboard str (position Tr21);
            //missionNamespace setVariable ["msot_sweepermis2",true,true];
            
          };
   case 3:{
             If(captive player)then
  		       {
  		           player setCaptive false;
  			         hint format ["Friendly: %1",(captive player)];
  		        }else{
  		               player setCaptive true;
  			             hint format ["Friendly: %1",(captive player)];
  				         };
          };

   case 4:{
            /*
  			     hint "Open Map and Click on it to disable the Cursor Function";
            onMapSingleClick "hint 'All MouseCurser functions on Map are disabled!';onMapSingleClick '';true;";
            */
            //[[4856.38,11104.6,0]] call MFUNC(system,delFromSystem);

            //{_x setDamage 1; sleep 5;}forEach [Ziel01,Ziel02];
            //sleep 2;
            //hint str (missionNamespace getVariable[STRVAR_DO(vehicle_store),[]]);


            ["RESPAWNPOSES",[9148.21,21611.9,0]] spawn MFUNC(system,doMissionCheck);



  		    };

  };





//

/*
IDSEH = player addEventHandler ["InventoryOpened",{[[0],"Missions\mission_1.sqf"] remoteExec ["execVM", 0]; player removeEventHandler ["InventoryOpened",IDSEH];}];





PFEIL Blau = "Sign_Arrow_Blue_F"
              Sign_Arrow_F
moves = ["aidlpsitmstpsnonwnondnon_ground00"];

rosa = #ff45f0
gelb = #dddd00
hellblau = #f000ffff
grün = #f000ff00
rot = #ff1221
	#f00dffff

*/

//Ziele:
/*
[Terminal,0] call BIS_fnc_dataTerminalAnimate; Terminal aufklappen 0 = zu 3 = auf
*/
