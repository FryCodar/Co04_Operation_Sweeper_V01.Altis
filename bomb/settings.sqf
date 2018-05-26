/*
	SETTINGS:

	_choices - array of choices to cut wires, more choices will have more colors to cut, default: red, green, blue
	_explosion - change classname of explosion, possible values in comments
	_matrix - show size of matrix with colors, default: big
	_expertMultiplier - if expert is defusing bomb, unit will have more time to defuse bomb, default: 2  (time * 2x)
*/

_choices = [
	["ORANGE", "#ff8000"],
	["PINK", "#ff80ff"],
	["RED", "#ff0000"], 
	["GREEN", "#00ff00"],
	["BLUE", "#0000ff"]
];

_explosion = "HelicopterExploBig"; //M_Mo_82mm_AT_LG, M_PG_AT, R_80mm_HE, R_60mm_HE, G_40mm_HE, M_NLAW_AT_F, M_RPG32_F, M_Titan_AP, HelicopterExploBig, HelicopterExploSmall */
_matrix = "big"; //small, medium, big
_expertMultiplier = 2; //2
