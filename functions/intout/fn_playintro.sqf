If(!hasInterface) exitWith {};
#include "msot_components.hpp"

If(isMultiplayer)then{waitUntil{getClientStateNumber > 9};};

private ["_segmented_time","_hour","_minute","_missionName","_stringed_minute","_intro_datas"];
If(missionNamespace getVariable [STRVAR_DO(play_intro),true])then{
If((["play_intro_music",1] call BIS_fnc_getParamValue) isEqualTo 1)then{playMusic "EventTrack01_F_EPA";};
_intro_datas = missionNamespace getVariable [STRVAR_DO(intro_datas),[]];
_stringed_minute = "";
_hour = floor daytime;
_minute = floor ((daytime - _hour) * 60);
If(_minute < 10)then{_stringed_minute = format["0%1",_minute];}else{_stringed_minute = format["%1",_minute]};
If(count _intro_datas == 3)then
{
  _segmented_time = round((_intro_datas select 2) * 0.33);
  If((["play_intro", 1] call BFUNC(getParamValue)) == 1)then
  { cutText ["","BLACK"];
    sleep 2;
    _intro_datas spawn MFUNC(intout,runcamera);
    cutText ["","BLACK IN",2];
    sleep _segmented_time;
  }else{camera_run = true;};
}else{camera_run = true;};
 sleep 2;
_missionName = getMissionConfigValue ["onLoadName", "NAME NOT FOUND"];
_text = format ["<img size= '10' style='vertical-align:middle' shadow='true' image='pics\MSOT.paa'/><br/><t size='.9' color='#FFFFFF'>%1</t>", _missionName];
[_text,0,0,2,2] spawn BFUNC(dynamicText);
[str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(_hour) + ":" + _stringed_minute,worldName] spawn BIS_fnc_infoText;

}else{camera_run = true;};


true
