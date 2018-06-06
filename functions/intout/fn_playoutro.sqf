If(!hasInterface) exitWith {};
#include "msot_components.hpp"

private _missionauthors = (getMissionConfigValue ["author", "MSOT-TEAM"]) splitString "/&,. ";
private _info = ["a Mission by"]; _info append _missionauthors;
[(format ["<img size= '10' style='vertical-align:middle' shadow='true' image='pics\MSOT.paa'/><br/><t size='.9' color='#FFFFFF'>Have a nice day!</t>"]),0,0,2,2] spawn BFUNC(dynamicText);
_info spawn BIS_fnc_infoText;
