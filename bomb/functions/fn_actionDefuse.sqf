params ["_target", "_caller", "_id", "_args"];
diag_log format ["fn_actionDefuse | _target: %1 | _caller: %2 | _id: %3 | _args: %4", _target, _caller, _id, _args];

_target setVariable ["a3f_bomb_active", true, true];
_isExpert = [_caller] call bomb_fnc_isExpert;
_target setVariable ["a3f_bomb_defuser", _caller, true];
_target setVariable ["a3f_bomb_expert", _isExpert, true];
_target removeAction _id;
