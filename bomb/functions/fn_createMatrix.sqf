private ["_values", "_matrix"];
params ["_choices", "_size"];
diag_log format ["fn_createMatrix | _choices: %1 | _size: %2", _object, _size];
	
{ _x pushBack 0; } forEach _choices; //add counters

_values = switch (_size) do 
{
	case "small": { [35, 3] };
	case "medium": { [100, 2] };
	case "big": { [128, 1.5] };
	default { [35, 3] };
};

private _matrix = "";
for "_i" from 1 to (_values select 0) do 
{
	_color = selectRandom _choices;
	{
		if(_color select 0 == _x select 0) then 
		{
			_x set [2, (_x select 2) + 1];
		};
	} forEach _choices;
	_matrix = _matrix + format ["<t color='%1' size='%2' font='PuristaLight'>#</t>", _color select 1, _values select 1];
};

_matrix
