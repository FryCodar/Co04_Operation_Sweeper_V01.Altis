If(!isServer) exitWith {};

[] spawn {
waitUntil{!isNil "init_main_classes"};
call compile preprocessFileLineNumbers "Engima\Traffic\Init.sqf";
call compile preprocessFileLineNumbers "Engima\Civilians\Init.sqf";
}
