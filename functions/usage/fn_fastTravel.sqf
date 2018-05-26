if(!hasInterface) exitwith {};
#include "msot_components.hpp"

params ["_obj","_caller","_idx","_xtra"];

hint "Press Mouse-Button to Teleport you on Mouseposition";
sleep 1;
openMap true;
onMapSingleClick "Player setPos _pos;openMap false;hintSilent """";onMapSingleClick """"; true;";
