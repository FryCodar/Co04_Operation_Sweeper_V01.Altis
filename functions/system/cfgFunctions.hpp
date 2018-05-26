#include "msot_components.hpp"

class TAGADD
	{
     class system
		 {
			 class addKilledEvent {
				 											description = "add a Killed EventHandler to an defined Object";
			 											};
			 class addMissionInfos {
				 												description = "Add defined Informations to System Storage";
			 											 };
			 class addToSystem {
				 										description = "Add defined Objects to System Storage";
			 									 };
			 class delFromSystem {
				 											description = "Delete defined Objects from System Storage";
			 										 };
			 class doClientRespawn {
				 												description = "Add and Remove Respawnpositions";
			 											 };
			 class doMissionCheck {
				 											description = "Framework for Missions";
			 											};
			 class eventHandling {
				 										 description = "Edit and handle the pushed Event";
			 										 };
			 class getClientAction {
				 											 description = "AddAction Framework";
			 											 };
			 class getForcesCalc {
				 										 description = "Calculated number of enemies";
			 										 };
			 class getInfoArray {
														description = "Search SystemInfos in Arrays";
													};
			 class getPlayerCount {
				 											description = "Counts Player on Server";
			 											};
			 class setUnitSkill {
														 description = "Set the Skill for each Units in Group";
 												 	};
			 class getWorkClasses {
				 											description = "Search available Classes";
			 											};
			 class manageMissionCheck{
				 												 description = "manage Requests to MissionCheck";
			 												 };
			 class setClientAction {
				 											 description = "Add a Action to Objects";
			 											 };
			 class setWorkClasses {
				 											description = "Load Classes to System";
															postInit = 1;
			 											};
			 class setRespawnVecs {
				 											description = "Respawn defined Vehicles";
			 											};
			 class setTargetBehavior {
				 												description = "Change Group Behavior";
			 												 };
			 class setTrigger {
				 									description = "set Triggers for defined Actions";
			 									};
			 class testHandler {
				 										description = "test it";
			 									 };
			 class workOffMisHolder {
				 												description = "Work Off the filled Holder for MissionCheckSystem";
			 												};
		 };
	};
