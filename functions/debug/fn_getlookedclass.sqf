if(!hasInterface) exitwith {};

  _object_type = typeOf cursorTarget;
  hintSilent format ["%1", _object_type];
  diag_log format ["DEBUG MODE ---->>> KLASSNAME %1",_object_type];
  copyToClipboard str _object_type;

  true;
