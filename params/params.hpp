class Params
{
  class msot_dummy_info_line1
  {
  title = "---------------------- Missions Einstellungen ---------------------";
  values[] = {-99999};
  default = -99999;
  texts[] = {""};
  };

  class Daytime
  {
    title = "Time of Day:";
    texts[] = {"01h","02h","03h","04h","05h","06h","07h","08h","09h","10h","11h","12h","13h","14h","15h","17h","18h","19h","20h","21h","22h","23h","00h"};
    values[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0};
		default = 10;
		function = "BIS_fnc_paramDaytime";
  };

  class play_faction
  {
    title = "Gegen welche Fraktion willst du spielen:";
    texts[] = {"CSAT","CSAT Pazifik","FIA Red","AAF","FIA Green","Syndicat"};
    values[] = {1,2,3,4,5,6};
    default = 3;
  };
  class mission_difficulty
  {
    title = "Schwierigkeitsgrad:";
    texts[] = {"Easy","Normal","Hard","Ultra"};
    values[] = {0,2,3,4};
    default = 2;
  };
  class play_intro
  {
    title = "Spiele Intro ab:";
    texts[] = {"Nein","Ja"};
    values[] = {0,1};
    default = 0;
    isGlobal = 1;
  };
  class play_intro_music
  {
    title = "Spiele Intro Music ab:";
    texts[] = {"Nein","Ja"};
    values[] = {0,1};
    default = 0;
    isGlobal = 1;
  };
  class start_with_nothing
  {
    title = "Starte ohne Ausrüstung:";
    texts[] = {"Nein","Ja"};
    values[] = {0,1};
    default = 0;
    isGlobal = 1;
  };
  class debug_modus
  {
    title = "DEBUG MODUS:";
    texts[] = {"Nein","Ja"};
    values[] = {0,1};
    default = 1;
    isGlobal = 1;
  };
  class who_is_medic
  {
      title = "Wer ist Sanitäter:";
      texts[] = {"nur Sanitäter","alle Spieler"};
      values[] = {0,1};
      default = 1;
      isGlobal = 1;
  };
};
