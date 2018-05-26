If(isMultiplayer)then{if(!hasInterface) exitWith{};};


params ["_object","_callers","_ids","_argument"];


disableUserInput true;
_callers playMove "Acts_TreatingWounded05";
sleep 15;
disableUserInput false;
