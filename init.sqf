#include "msot_components.hpp"
//this in every Mission
//**************************************************************************************************************************************************
waitUntil{!isNil "bis_fnc_init"};
DEBUG_MODE = ((["debug_modus",1] call BIS_fnc_getParamValue) isEqualTo 0);
FRY_INIT = false;

If(!hasInterface)then{FRY_INIT = true;}else{If(isNull player)then{[] spawn {waitUntil {!isNull player && player == player}; FRY_INIT = true;};}else{FRY_INIT = true;};};
waitUntil {FRY_INIT};

diag_log "INIT BEGINNT";

enableSentences false;
//***************************************************************************************************************************************************
If(isServer)then
{
  [[H2,H3,H4,H5,H6],230] call MFUNC(usage,addRespawnVecs);
   execVM "Engima\enigma_init.sqf";
};
If(hasInterface)then
{
	setViewDistance 4000;
	player disableConversation true;
};

enableSaving [ false, false ];

call compile preprocessFile "downloadData.sqf";
call compileFinal preprocessFileLineNumbers "skripte\count_down.sqf";



waitUntil { !isNil "T8L_var_INITDONE" };

if ( !isServer ) exitWith {};

sleep 10; // I dont know why, but some sleep is requied or the Actions on the Objects wont work ... this is beyond my knowledge

[ [ laptop01 ], "T8L_fnc_addActionLaptop", true, true] spawn BIS_fnc_MP;
[ [ laptop02 ], "T8L_fnc_addActionLaptop", true, true] spawn BIS_fnc_MP;

init_run = true;
diag_log format ["INIT IST DURCHGELAUFEN: %1",init_run];
