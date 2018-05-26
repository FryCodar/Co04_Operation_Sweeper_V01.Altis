#include "msot_components.hpp"
/* ---------------------------------------------------------------------------------------------------------
Function: MSOT_geometry_fnc_inAngleSector

Description: Return true when a Position is in Sector of a center in defined Degrees

Parameters: [Position,Direction,SectorInDegrees,CenterPosition]


Returns:  BOOL
Examples:
          _isInSector = [(position player),(getDir player), 180, (getPos Tank)] call MSOT_geometry_fnc_inAngleSector;

Author: Peter Morrison (snYpir) & Philipp Pilhofer (raedor), optimised by Killzone_Kid

------------------------------------------------------------------------------------------------------------- */
params ["_center", "_dir", "_sector", "_pos"];

private _dirTo = _center getDir _pos;
acos ([sin _dir, cos _dir, 0] vectorCos [sin _dirTo, cos _dirTo, 0]) <= _sector*0.5
