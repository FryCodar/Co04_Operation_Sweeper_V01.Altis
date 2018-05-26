If(!hasInterface) exitWith {};
#include "msot_components.hpp"
private ["_cam","_segment_time","_is_night"];
params ["_first_point","_second_point","_time"];
_is_night = false;

If(sunOrMoon <= 0.4)then{_is_night = true;};

_segment_time = round(_time * 0.33);

_cam = "camera" camCreate [0,0,0];
_cam cameraeffect ["internal", "back"];
showcinemaborder false;
If(_is_night)then{camUseNVG true;};


_cam camPrepareTarget player;
_cam camPreparePos [(_first_point select 0),(_first_point select 1),((_first_point select 2) + 100)];
_cam camPrepareFov 0.1;
_cam camCommitPrepared 0;

_cam camPrepareTarget player;
_cam camPreparePos [(_second_point select 0),(_second_point select 1),((_second_point select 2) + 100)];
_cam camPrepareFov 0.1;
_cam camCommitPrepared _segment_time;

sleep _segment_time;

_cam camPrepareTarget player;
_cam camPreparePos [((getPos player) select 0),((getPos player) select 1),(((getPos player) select 2) + 30)];
_cam camPrepareFov 0.1;
_cam camCommitPrepared _segment_time;

sleep _segment_time;

cutText ["","BLACK FADED",1];
sleep 2;
player cameraEffect ["terminate","back"];
camDestroy _cam;
camera_run = true;
cutText ["","BLACK IN",2];

true
