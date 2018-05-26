params ["_target", "_caller", "_id", "_args"];
diag_log format ["fn_actionCutWire | _target: %1 | _caller: %2 | _id: %3 | _args: %4", _target, _caller, _id, _args];

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
removeAllActions _target;
