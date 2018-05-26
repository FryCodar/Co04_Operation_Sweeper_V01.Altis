If(isMultiplayer)then{If(!isServer)exitWith{};};
params ["_pos"];

{
  private _new_pos = _pos getPos [2.5,(random 360)];
  _x setPos _new_pos;
}forEach [Laptop01,Kiste01];
