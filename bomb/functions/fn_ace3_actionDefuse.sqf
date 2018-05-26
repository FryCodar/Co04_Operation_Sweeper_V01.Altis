params ["_target", "_caller", "_args"];
diag_log format ["fn_ace3_actionDefuse | _target: %1 | _caller: %2 | _args: %3", _target, _caller, _args];

_target setVariable ["a3f_bomb_active", true, true];
_isExpert = [_caller] call bomb_fnc_isExpert;
_target setVariable ["a3f_bomb_defuser", _caller, true];
_target setVariable ["a3f_bomb_expert", _isExpert, true];
[_target, 0, ["ACE_MainActions", "a3f_bomb_defuse"]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject", 0, true];
