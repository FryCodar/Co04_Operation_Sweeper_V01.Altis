If(!hasInterface)exitWith{};
#include "msot_components.hpp"
private ["_chk_state","_task_arr","_task_name","_task_Type","_task_description_long","_task_description_forHUD","_task_priority"];
params ["_idx","_state",["_target",objNull],["_added_txt",""]];


  _chk_state = toUpper(_state);_task_arr = [];_task_name = "";_task_Type = "";_task_description_long = "";_task_description_forHUD = "";
  _task_priority = 2;

switch(_idx)do
{
  case 0:{
            _task_name = "Task01";

            _task_description_long = "Verschiedenen Meldungen zufolge planen die Separatisten etwas, von dem Sie glauben, dass beim Erfolg dieser Aktion sich noch mehr Bewohner der Insel auf die Seite der Separatisten schlagen. Aufgrund der feindlichen Luftabwehr wurden einige unserer Helikoter ganz schön hart rangenommen  und müssen repariert und gewartet werden. Aber irgendwo auf diesem Schiff finden Sie sicher noch einen funktionierenden Helikopter. Fliegen Sie zur Insel ATSALIS!  Ihr Anflug sollte aus Nordwesten in Richtung Südosten erfolgen! Fliegen sie so tief wie möglich! Dann haben Sie eine Chance, der feindlichen Luftabwehr zu entgehen! Auf der Insel befindet sich ein Erkundungsteam! Melden Sie sich bei dem Team! Dort erhalten Sie weitere Instruktionen und Ausrüstung!";

            _task_description_forHUD = "Verlegung nach Atsalis";

            _task_Type  = "move";

         };
   case 1:{
            _task_name = "Task02";

            _task_description_long = "Begeben Sie sich zum SDV und durchqueren Sie die Ammolofi-Bucht. Landen Sie in der Nähe der Ortschaft KRYA NERA wo sich Laut unseren Informationen 2 Flugabwehrsysteme mitsamt Ihren Besatzungen und Sicherungseinheiten befinden! Zerstören Sie alle Flugabwehrgeschütze und suchen Sie in der Ortschaft nach weiteren Informationen! Alles erforderliche für Ihren Auftrag befindet sich bereits an Bord des SDV! Die erfolgreiche Zerstörung der Flugabwehr ist zwingend erforderlich für den weiteren Verlauf Ihres Einsatzes! Viel Erfolg!";

            _task_description_forHUD = "Zerstörung Flugabwehr/ Informationen finden";

            _task_Type  = "target";
          };
   case 2:{
            _task_name = "Task03";

            _task_description_long = "Nutzen Sie das von Ihnen verursachte Durcheinander und dringen entlang des Flusslaufes weiter in Richtung Süden vor! Im Bereich Planquadrat 920216 befindet sich ein kleiner privater Flugplatz. 1. Beschaffen Sie sich dort ein Fluggerät! Sollten Sie auf ziviles Personal  treffen, so ist dieses nichtlethal aus dem Verkehr zu ziehen! KEINE zivilen Verluste! Doch Vorsicht! Bei dieser Bevölkerungsgruppe ist praktisch jeder bewaffnet!";

            _task_description_forHUD = "Beschaffung Helikopterschlüssel / Bordbuch";

            _task_Type  = "heli";
          };
   case 3:{
            _task_name = "Task04";

            _task_description_long = "Fliegen Sie zum Zielgebiet Alpha! Es handelt sich hier um eine kleine Halbinsel im Planquadrat 200200! Dort findet das Treffen  statt! Eleminieren Sie dort General Badnajev und suchen Sie bei seiner Leiche nach Informationen! (Details siehe Lageupdate Nr. 1)   !Hinweis! Fliegen Sie so tief sie können, damit sie nicht entdeckt werden! Fliegen Sie auf keinen Fall an der Küste entlang! Wir haben keine Erkenntnisse über die Flugabwehr entlang der Küstenlinie! Viel Glück!!!";

            _task_description_forHUD = "Töten Sie den General/ Durchsuchen Sie den Körper nach Infos";

            _task_Type  = "kill";
          };
   case 4:{
            _task_name = "Task05";

            _task_description_long = "Lokalisieren Sie den Konvoi und zerstören ihn!  Die im Lageupdate Nr. 2 befindliche Luftaufnahme entstand südlich der Stadt KALOCHORI mit Fahrtrichtung WESTEN!";

            _task_description_forHUD = "Finden und Zerstören Sie den Konvoi (siehe neues Lageupdate Nr.2)";

            _task_Type  = "destroy";
          };
   case 5:{
            _task_name = "Task06";

            _task_description_long = "Begeben Sie sich nach Faronaki, um dort mit dem Boot oder entsprechender Ausrüstung auf die Insel Makrynisi zu gelangen!";

            _task_description_forHUD = "Bewegung nach Faronaki";

            _task_Type  = "boat";
          };
   case 6:{
            _task_name = "Task07";

            _task_description_long = "Infiltrieren Sie unbemerkt die Insel! Suchen Sie den Sprengsatz! Bei Auffindung entschärfen Sie  die Bombe! Alle Personen auf der Insel werden als feindlich eingestuft!  Anzahl und Ausrüstung des Gegners ist unbekannt!";

            _task_description_forHUD = "Infiltration und Säuberung der Insel Makrynisi";

            _task_Type  = "attack";
          };
   case 7:{
            _task_name = "Task08";

            _task_description_long = "Durchsuchen Sie das Labor nach weiteren Informationen und Daten und sichern Sie diese!";

            _task_description_forHUD = "Datensicherung (optional)";

            _task_Type  = "download";
          };
   case 8:{
            _task_name = "Task09";

            _task_description_long = "Suchen Sie nach einer Möglichkeit, die Insel zu verlassen und verlegen Sie schnellstmöglich in die Stadt Pyrgos!";

            _task_description_forHUD = "Verlegung nach Pyrgos";

            _task_Type  = "move";
          };
   case 9:{
            _task_name = "Task10";

            _task_description_long = "Suchen Sie nach der Bombe und Entschärfen Sie den Sprengsatz! Eleminieren Sie jede Person, die Sie daran hindern will!";

            _task_description_forHUD = "Lokalisierung und Entschärfung des Sprengsatzes";

            _task_Type  = "destroy";
          };
  case 10:{
            _task_name = "Task11";

            _task_description_long = "Nachdem alles erledigt ist, sehen Sie zu, dass Sie dort schnellstmöglich verschwinden! Ihr Taxi wartet südlich von hier beim KAP MAKRINOS!!!";

            _task_description_forHUD = "Exfiltration";

            _task_Type  = "getout ";
          };
};

if(count (missionNamespace getVariable [STRVAR_DO(missions_stored_tasks),[]]) > 0)then{_task_priority = 1;};

switch(typeName _target)do
{
  case "OBJECT":{_task_arr = [player,[_task_name],[_task_description_long,_task_description_forHUD,""],_target,_chk_state,_task_priority,true,_task_Type];};
  case "ARRAY":{_task_arr = [player,[_task_name],[_task_description_long,_task_description_forHUD,""],_target,_chk_state,_task_priority,true,_task_Type];};
  default {
            hint format ["FEHLER IN TASK AUFRUF: TASK_MARK_POS_OBJ - VARIABLE >>> %1",(typeName _target)];
            diag_log format ["FEHLER IN TASK AUFRUF: TASK_MARK_POS_OBJ - VARIABLE >>> %1",(typeName _target)];
          };
};

If(count _task_arr > 0)then
{
  _task_arr call BIS_fnc_taskCreate;
};
