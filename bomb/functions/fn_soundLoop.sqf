params ["_object"];
diag_log format ["fn_soundLoop | _object: %1", _object];

while { alive _object && _object getVariable ["a3f_bomb_active", true] } do 
{
	playSound3D ["A3\Sounds_F\sfx\Beep_Target.wss", _object, false, getPos _object, 10, 1, 20];
	sleep 2;
};
