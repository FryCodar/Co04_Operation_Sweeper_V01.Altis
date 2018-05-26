private ["_explosion", "_defuser"];
params ["_object"];
//diag_log format ["fn_defuseFail | _object: %1", _object];

_explosion = _object getVariable ["a3f_bomb_explosion", "M_Mo_82mm_AT_LG"];
_defuser = _object getVariable ["a3f_bomb_defuser", 0];

diag_log format ["fn_defuseFail | _object: %1 | _explosion: %2 | _defuser: %3", _object, _explosion, _defuser];
	
for "_i" from 1 to 3 do 
{
	_explosion createVehicle (_object modelToWorld [0,0,0.5]);
};

{
	detach _x;
	_x setDamage 1;
	deleteVehicle _x;
} forEach attachedObjects _object;

if (alive _object) then 
{
	_object setDamage 1;
	deleteVehicle _object;
};

"" remoteExec ["hintSilent", _defuser, true];
