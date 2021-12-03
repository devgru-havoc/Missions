disableSerialization;
params
[
  ["_text", ["Test"]],
  ["_attributes", [["1", "PuristaMedium", "#FFFFFF", "Left", "0", "#FFFFFF", "0", "0"]]],
  ["_position", [SafeZoneX, SafeZoneY]],
  ["_bgColor", [0,0,0,0.5]],
  ["_dim", []]
];
titleRsc ["Notification","PLAIN"];

private _parent = uiNamespace getVariable "MMF_Notification";
private _ctrl = _parent displayCtrl 1;
private _lines = [];

for "_i" from 0 to ((count _text) -1) do
{
  private _line = text (_text select _i);
  private _preset = _attributes select _i;

  _line setAttributes
  [
    "size", _preset select 0,
    "font", _preset select 1,
    "color", _preset select 2,
    "align", _preset select 3,
    "shadow", _preset select 4,
    "shadowColor", _preset select 5,
    "shadowOffset", _preset select 6,
    "underline", _preset select 7
  ];

  _lines pushBack _line;

  if (_i != ((count _text) -1)) then
  {
    _lines pushBack lineBreak;
  };
};

_ctrl ctrlSetStructuredText (composeText _lines);
_ctrl ctrlSetBackgroundColor _bgColor;

private _width = ctrlTextWidth _ctrl;
private _height = ctrlTextHeight _ctrl;

if ((count _dim) > 0) then
{
  _width = _dim select 0;
  _height = _dim select 1;
};

_ctrl ctrlSetPosition [_position select 0, _position select 1, _width, _height];
_ctrl ctrlCommit 0;

true;
