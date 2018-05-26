params ["_needKit"];
diag_log format ["fn_getCondition | _needKit: %1", _needKit];

_condition = "true";
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then 
{
	_condition = { true };
};
if(_needKit) then 
{
	_condition = "'ToolKit' in (items _this)";
	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then 
	{
		_condition = { "ACE_DefusalKit" in (items (_this select 1)) };
	};
};

_condition
