params ["_object"];
diag_log format ["fn_defuseSuccess | _object: %1", _object];
	
private _defuser = _object getVariable ["a3f_bomb_defuser", 0];
{
	detach _x;
	deleteVehicle _x;
} forEach attachedObjects _object;	
"bomb deactivated" remoteExec ["hintSilent", _defuser, true];
