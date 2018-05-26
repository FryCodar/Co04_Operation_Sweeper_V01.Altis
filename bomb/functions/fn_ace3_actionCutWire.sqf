params ["_target", "_caller", "_args"];
diag_log format ["fn_bomb_ace3_actionCutWire | _target: %1 | _caller: %2 | _args: %3", _target, _caller, _args];

private _color = _args select 0;
private _wire = _target getVariable ["a3f_bomb_wire", ""]; 
if(_wire == _color) then 
{ 
	_target setVariable ["a3f_bomb_active", false, true]; 
} 
else 
{ 
	[_target] spawn bomb_fnc_defuseFail;
};

for "_i" from 0 to 10 do {
	[_target, 0, ["ACE_MainActions", format ["a3f_bomb_defuse_%1", _i] ]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject", 0, true];
};
