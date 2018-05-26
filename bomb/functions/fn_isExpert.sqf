private ["_search", "_isExpert"];
params ["_unit"];
diag_log format ["fn_isExpert | _unit: %1", _unit];

_search = ["_engineer_", "_exp_", "_repair_", "_para_8_", "_bandit_8_", "_bandit_7_"];
_isExpert = false;
{
	if ([toLower(_x), toLower(typeOf _unit)] call BIS_fnc_inString) exitWith 
	{
		_isExpert = true;
	};
} forEach _search;
	
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then 
{
	if( (_unit getVariable ["ACE_IsEngineer", 0] == 1) || (_unit getVariable ["ACE_isEOD", 0] == 1) ) then 
	{
		_isExpert = true;
	};
};

_isExpert
