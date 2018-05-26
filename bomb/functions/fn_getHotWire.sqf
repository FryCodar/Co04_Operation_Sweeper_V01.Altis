params ["_choices"];
diag_log format ["fn_getHotWire | _choices: %1", _choices];

_wire = "NONE";
_max = 0;
{
	_x params ["_choice", "_color", "_counter"];
	if(_counter > _max) then 
	{
		_max = _counter;
		_wire = _choice;
	};
} forEach _choices;
	
_wire
