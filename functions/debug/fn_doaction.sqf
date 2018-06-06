if(!hasInterface) exitwith {};
#include "msot_components.hpp"

params ["_obj","_caller","_idx","_xtra"];


  switch(_xtra)do
  {
   case 0:{
            _this call MFUNC(usage,fastTravel);
   	      };
   case 1:{
            private _pos = (position _caller);
            private _posatl = (getPosATL _caller);
            private _posasl = (getPosASL _caller);
            private _dir = (getDir _caller);
            hint format ["SPIELER DATEN:\n\nPOSITION: %1\nPOSITION_ATL: %2\nPOSITION_ASL: %3\nDIR: %4",_pos,_posatl,_posasl,_dir];
  		      diag_log format ["SPIELER DATEN:____POSITION: %1 ____POSITION_ATL: %2 ____POSITION_ASL: %3 ____DIR: %4",_pos,_posatl,_posasl,_dir];
            copyToClipboard format ["[SPIELER DATEN: >>> POSITION_NORMAL: %1 <<<_>>> POSITION_ATL: %2 <<<_>>> POSITION_ASL: %3 <<<_>>> DIR: %4 <<<]",_pos,_posatl,_posasl,_dir];
          };
   case 2:{
            // ERSTER TESTBEREICH
            hint "Script 1 begins";
            //_____________________________________________________________________________________________________________________________
            private _pos_doc = (position DOCS);

            ["MAINTARGETS",_pos_doc,[DOCS,"",{hint "MAINTARGET! OK";}]] spawn MSOT_system_fnc_addMissionInfos;
            ["MAINACTIONS",[DOCS,"SUCCESS",{hint "MAINACTIONS! OK";},"true",true]] spawn MSOT_system_fnc_addMissionInfos;
            ["ACTIONSTORAGE",[DOCS,"ACTION","RED","Dokumente nehmen"]] call MSOT_system_fnc_addMissionInfos;

            hint str (missionNamespace getVariable [STRVAR_DO(action_storage),[]]);
          };
   case 3:{
            //ZWEITER TESTBEREICH
            hint "Script 2 begins";
            //______________________________________________________________________________________________________________________________

            hint str (missionNamespace getVariable [STRVAR_DO(action_storage),[]]);


          };
   case 4:{
            If(captive player)then
            {
              player setCaptive false;
              hint format ["Friendly: %1",(captive player)];
            }else{
                  player setCaptive true;
                  hint format ["Friendly: %1",(captive player)];
                };
  		    };

  };

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
[Terminal,0] call BIS_fnc_dataTerminalAnimate; Terminal aufklappen 0 = zu 3 = auf
*/
