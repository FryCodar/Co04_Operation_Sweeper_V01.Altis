if(!isServer) exitWith {};
params ["_object", ["_time", 15], ["_needKit", true], ["_debug", false]];
diag_log format ["fn_init | _object: %1 | _needKit: %2 | _debug: %3", _object, _needKit, _debug];

#include "settings.sqf"

null = [_object] spawn bomb_fnc_attachObjects;
null = [_object] spawn bomb_fnc_soundLoop;
_condition = [_needKit] call bomb_fnc_getCondition;

_object setVariable ["a3f_bomb_explosion", _explosion];

if (isClass(configFile >> "CfgPatches" >> "ace_main")) then 
{
	_action = ["a3f_bomb_defuse", "<t color='#ff0000'>defuse bomb</t>", "", bomb_fnc_ace3_actionDefuse, _condition] call ace_interact_menu_fnc_createAction;
	[_object, 0, ["ACE_MainActions"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
}
else 
{
	[_object, ["<t color='#ff0000'>Defuse bomb</t>", bomb_fnc_actionDefuse, [], 1.5, true, true, "", _condition, 3, false]] remoteExec ["addAction", 0, true];	
};

waitUntil { sleep 1; _object getVariable ["a3f_bomb_active", false] };

_defuser = _object getVariable ["a3f_bomb_defuser", 0];

_string = [_choices, _matrix] call bomb_fnc_createMatrix;

{
	_x params ["_wire", "_color"];

	_actionText = format ["<t color='%1'>Cut %2 wire</t>", _color, _wire];
	
	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		_action = [format ["a3f_bomb_defuse_%1", _forEachIndex], _actionText, "", bomb_fnc_ace3_actionCutWire, {true}, {}, [_wire]] call ace_interact_menu_fnc_createAction;
		[_object, 0, ["ACE_MainActions"], _action] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
	}
	else 
	{
		[_object, [_actionText, bomb_fnc_actionCutWire, [_wire], 1.5, true, true, "", "_target getVariable ['a3f_bomb_active', false] && " + _condition, 3, false]] remoteExec ["addAction", 0, true];
	};

} forEach _choices;

_wire = [_choices] call bomb_fnc_getHotWire;
_object setVariable ["a3f_bomb_wire", _wire, true];

if(!_debug) then {
	_wire = "";
};

if(_object getVariable ["a3f_bomb_expert", false]) then 
{
	if(isNil "_expertMultiplier" || _expertMultiplier == 0) then { _expertMultiplier = 1; };
	_time = _expertMultiplier * _time;
};

while { alive _object && _object getVariable ["a3f_bomb_active", true] && _time > 0 } do 
{
	_show = parseText format ["<t size='3'>BOMB</t><br/>cut wire with most color<br/>%1<br/><br/>%2<br/>%3", _string, [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring, "<br/>" + _wire];
	_show remoteExec ["hintSilent", _defuser, true];
	sleep 1;
	_time = _time - 1;
};

if( alive _object && _object getVariable ["a3f_bomb_active", true]) exitWith 
{
	[_object] spawn bomb_fnc_defuseFail;
};

if( alive _object ) exitWith 
{
	[_object] spawn bomb_fnc_defuseSuccess;
};

if(true) exitWith {};
