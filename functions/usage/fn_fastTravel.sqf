if(!hasInterface) exitwith {};
#include "msot_components.hpp"

params ["_obj","_caller","_idx","_xtra"];

//hint "Press Mouse-Button to Teleport you on Mouseposition";

openMap true;
cutText ["<t color='#f000ff00' size='2'>Press Mouse-Button to Teleport you on Mouseposition</t>","PLAIN DOWN",-1,true,true];
//onMapSingleClick "Player setPos _pos;openMap false;hintSilent """";onMapSingleClick """"; true;";
onMapSingleClick {cutText ["<t color='#f000ff00' size='2'>Click again to travel</t>","PLAIN DOWN",-1,true,true];onMapSingleClick {MSOT_STOP_TRAVEL_COUNTER = false;cutText ["","PLAIN DOWN",0,true,true];Player setPos _pos;openMap false;onMapSingleClick "";};};
[30] spawn {

params ["_time"];
MSOT_STOP_TRAVEL_COUNTER = true;
while{_time > 0 && {MSOT_STOP_TRAVEL_COUNTER} && {visibleMap}}do
{
  hintSilent composeText[parseText("<t font = 'RobotoCondensed' size='1.2' align='center'>" + "Time to stop the trip:" + "</t>"),lineBreak, parseText("<t size='4' color='#f0ff0000' align='center'>" + format ["%1",_time] + "</t>")];
  _time = _time - 1;
  sleep 1;
};
hint "";
switch(true)do
{
  case (_time < 1 && MSOT_STOP_TRAVEL_COUNTER):{cutText ["<t color='#ff0000' size='2'>Trip canceled</t>","PLAIN",-1,true,true];onMapSingleClick "";openMap false;};
  case (_time > 0 && {MSOT_STOP_TRAVEL_COUNTER} && {!visibleMap}):{cutText ["<t color='#ff0000' size='2'>Trip canceled</t>","PLAIN",-1,true,true];onMapSingleClick "";};
};

};
