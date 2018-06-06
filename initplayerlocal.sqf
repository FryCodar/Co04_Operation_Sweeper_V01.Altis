If(!hasInterface) exitWith {};
#include "msot_components.hpp"
private ["_intro_pos_time","_play_intro"];

//*********** Intro Daten - [Startposition,Zwischenposition, Zeit(in s)] zBsp: [(getMarkerPos "campos1"),(getMarkerPos "campos2"), 30] *************

_intro_pos_time = [(getMarkerPos "campos1"),(getMarkerPos "campos2"), 30];

//*********** Intro abschalten >>  setze es auf false >> kann zum bauen verwendet werden ***********************************************************

_play_intro = true;

//*********** Ohne/Ändere Ausrüstung Einstellung (true - Ausrüstung wird entfernt oder geändert / false - Ausrüstung bleibt vorhanden)**************

_changeorloose_equipment = true;

//*********** Neue Ausrüstung - NEW_SETTING = "scripts\newEquipments.sqf"; ***** Playernamen wird übergeben ****************************************

NEW_SETTING = "";

//**************************************************************************************************************************************************
// Blacklist Arsenal - um diese Arsenalbox zu nutzen, musst du folgenden Befehl in die Init-Zeile der Box eintragen
// this addAction ['<t color=''#f000ff00''>Open Arsenal</t>',{[] spawn MSOT_arsenal_fnc_initArsenal}];
//
// In die ARSENAL_BLACKLIST dann einfach die Classnames Eintragen die NICHT hinzugefügt werden sollen
// zBsp ARSENAL_BLACKLIST = ["B_UavTerminal","O_UavTerminal","I_UavTerminal","C_UavTerminal"];

ARSENAL_BLACKLIST = [];

//**************************************************************************************************************************************************


















//************************************************************************************************************************************************
//Dont Touch this

If(!isNil "_intro_pos_time")then{missionNamespace setVariable [STRVAR_DO(intro_datas),_intro_pos_time,false];};
If(!isNil "_changeorloose_equipment")then{missionNamespace setVariable [STRVAR_DO(equip_cleaner),_changeorloose_equipment,false];};
missionNamespace setVariable [STRVAR_DO(play_intro),_play_intro,false];

["id_start_intro","onPreloadFinished",{["id_start_intro","onPreloadFinished"] call BIS_fnc_removeStackedEventHandler;
                                       diag_log "INITPLAYERLOCAL: Starte INTRO";
                                      [] spawn MFUNC(intout,playintro);}] call BIS_fnc_addStackedEventHandler;
//____________________________________________________________

sleep 3;
//waitUntil{!isNil "camera_run"};
[] call MFUNC(setting,initPlayer);
