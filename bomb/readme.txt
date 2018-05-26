/*
	AUTHOR: M1ke_SK 701st [S.O.G.]
	NAME: bomb.sqf
	VERSION: 1.2
	URL: https://forums.bistudio.com/topic/196588-release-simple-bomb-defuse-script/
	Armaholic: http://www.armaholic.com/page.php?id=31817
	
	DESCRIPTION:
	Make bomb from object with timer and cutting wires.

	INSTALATION:
	- copy folder "bomb" into your mission folder
	- include line 
		#include "bomb\cfgFunctions.hpp"
	into your CfgFunctions class in description.ext file

	Example:
	
	class CfgFunctions
	{
		#include "bomb\cfgFunctions.hpp"
	};
	
	USAGE:
	- place unit in editor
	- place object in editor (barrel)
	
	In object init line put
	null = ["object", "time", "kit", "debug"] execVM "bomb\bomb.sqf";
	
	Example:
	null = [this, 10, true, false] execVM "bomb\bomb.sqf";
	
	CONFIG:
	"object" - object to transform to bomb, default: this
	"time" - time in seconds for bomb defuse, default: 10
	"kit" - boolean value if needed tools to defuse bomb, default: true
	"debug" - boolean value if need show right wire to cut, default: false

	SETTINGS:
	
	open file ../bomb/settings.sqf in bomb folder where you can change internal settings of script.
	
	_choices - array of choices to cut wires, more choices will have more colors to cut, default: red, green, blue
	_explosion - change classname of explosion, possible values in comments
	_matrix - show size of maxtrix with colors, default: big
	_expertMultiplier - if expert is defusing bomb, unit will have more time to defuse bomb, default: 2  (time * 2x)

	FEATURES:
	- friendly hint with instructions
	- hint is showing only to defuser
	- ace3 support
	- multiplayer / dedicated server friendly
	- easy installation
	- plug & play system
	- specialist have more time to defuse bomb
	- custom time for specialist
	- defusing bomb with ToolKit or DefusalKit
	- random generation of matrix
	- custom size of matrix
	- custom choices (number of wires)
	- beeping sound
	- blinking light
  
	PLANNED:
	- dialog for cutting wires
	- cutting wires in right order
	- when wrong cut, timer will accelerate
	- "slippery hands" ( this is where I move toolkit from unit inventory and spawn it next to him, as he can't cut wires when he dont have toolkit)
	- probability of second wiring ( first wiring is dummy )
 
	CHANGELOG:
	
	v1.2
	- reformat to functions
	- added multiplayer / dedicated server support
	- hint showing to only defuser
	- battle-tested in real environment
	- changed to "plug & play" system
	- added settings file
	- added readme.txt file for instructions
	- cleaned code
	
	v1.1
	- added ace3 support
	- added customizable explosion size
	- added customizable size of maxtrix
	- added more wires (custom)
	- specialist have more time to defuse bomb
	- custom time for specialist (default 2x time)
	- custom internal settings
	- added documentation
	- added simple mission for test
 
	v1.0
	- public release
 
	LICENSE:
	Use it for public, non monetized purposes only. If you have modifications, use pull request in git repo. Will revise/include them in script.
 
	DISCLAIMER:
	Do not incorporate this script or portions of it in monetized products or servers without asking for permission and obtaining approval from me!
 
	CREDITS:
	Larrow - fix for c4 attachment
	
*/