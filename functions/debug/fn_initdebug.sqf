if(!hasInterface) exitwith {};

[] spawn {

private ["_counter"];

If((["debug_modus",1] call BIS_fnc_getParamValue) == 1)then
{
diag_log "INIT DEBUG: Starte DEBUG MODE";
_counter = 0;



0 = player addAction [(format ['<t color=''#ff4500''>Bewege %1</t>',(name player)]),{_this call MSOT_debug_fnc_doaction},(0),8,false,true,"","_this == player"];
1 = player addAction ['<t color=''#fddd00''>Koordinaten anfordern</t>',{_this call MSOT_debug_fnc_doaction},(1),8,false,true,"","_this == player"];
2 = player addAction ['<t color=''#ff45f0''>Starte Script 1</t>',{_this call MSOT_debug_fnc_doaction},(2),8,false,true,"","_this == player"];
3 = player addAction ['<t color=''#f00dffff''>Starte Script 2</t>',{_this call MSOT_debug_fnc_doaction},(3),8,false,true,"","_this == player"];
4 = player addAction ['<t color=''#f000ff00''>SetCaptive an/aus</t>',{_this call MSOT_debug_fnc_doaction},(4),8,false,true,"","_this == player"];
//5 = player addAction ['<t color=''#f000fff0''>Open Arsenal</t>',{[player, player, true] call ace_arsenal_fnc_openBox;}];
5 = player addAction ['<t color=''#f000fff0''>Open Arsenal</t>',{[] spawn MSOT_arsenal_fnc_initArsenal}];


player addWeapon "Rangefinder";
player addAction["Get Class", {call MSOT_debug_fnc_getlookedclass}];

player allowDamage false;

hint "DEBUG-MODE";
};
};
