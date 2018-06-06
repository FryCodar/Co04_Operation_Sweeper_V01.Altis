//Parameter

respawnTemplates[] = {"MenuPosition"};

enableItemsDropping = 0;
showGPS = 1;
showCompass = 1;
showMap = 1;
showWatch = 1;
showSquadRadar = 0;
enableDebugConsole = 1;
allowFunctionsRecompile = 0;
ReviveMode = 0;
respawnOnStart = -1;
//*******************************************************************************************
// Veränderbar
showHUD[] = {
	true,	// Scripted HUD (same as showHUD command)
	true,	// Vehicle + soldier info
	false,	// Vehicle radar [HIDDEN]
	false,	// Vehicle compass [HIDDEN]
	true,	// Tank direction indicator
	true,	// Commanding menu
	false,	// Group Bar
	true,	// HUD Weapon Cursors
	true	// Vehicle display panels
};

//*******************************************************************************************
//Garbage Collector (Entfernt tote Einheiten)
//Einheiten:
corpseManagerMode = 1; 					// Type of removed bodies: 0 - none, 1 - all, 2 - only respawnable, 3 - only non-respawnable
corpseLimit = 15	; 						// Max number of bodies which can be available at the same time. When exceeded, start deleting immediately.
corpseRemovalMinTime = 300; 		// Minimal time in seconds a body stays in the scene (can't be removed sooner).
corpseRemovalMaxTime = 400; 		// Maximal time in seconds after which a dead body is removed (can't stay longer)

//Wrecks
wreckManagerMode = 1; 					// Type of removed wrecks: 0 - none, 1 - all, 2 - only respawnable, 3 - only non-respawnable
wreckLimit = 5; 								// Max number of wrecks which can be available at the same time. When exceeded, start deleting immediately.
wreckRemovalMinTime = 300; 			// Minimal time in seconds a wreck stays in the scene (can't be removed sooner).
wreckRemovalMaxTime = 400;			// Maximal time in seconds after which a wreck is removed (can't stay longer)

minPlayerDistance = 50;         //Minimal Distance between corpse or wreck and nearest player before the corpse or wreck is allowed to be removed by the garbage collector

//*********************************************************************************************

// Parameter werden geladen
#include "params\params.hpp"

//Functions
class CfgFunctions
{

    #include "functions\intout\cfgFunctions.hpp"
		#include "functions\difficult\cfgFunctions.hpp"
		#include "functions\setting\cfgFunctions.hpp"
		#include "functions\debug\cfgFunctions.hpp"
		#include "functions\varsenal\cfgFunctions.hpp"
		#include "functions\tasks\cfgFunctions.hpp"
		#include "functions\usage\cfgFunctions.hpp"
		#include "functions\system\cfgFunctions.hpp"
		#include "functions\spawnhelp\cfgFunctions.hpp"
		#include "functions\geometry\cfgFunctions.hpp"
		#include "functions\creating\cfgFunctions.hpp"
		#include "functions\briefing\cfgFunctions.hpp"
};

class CfgRemoteExec
{
			class Commands
			{
				mode = 2;
				jip = 1;
			};
      class Functions
      {
              // RemoteExec modes:
              // 0-turned off
              // 1-turned on, taking whitelist into account
              // 2-turned on, ignoring whitelist (default, because of backward compatibility)
              mode = 2;
              // Ability to send jip messages: 0-disabled, 1-enabled (default)
              jip = 1;
      };
};
