/*======MMF_fnc_lightEffect======CALL====== Create light source with defined parameters at _caller

_caller		object		object location to spawn light
_arr		array		named array to save locations (can be emtpy array [])
_color		array		RGB coordinates for light color
_ambient	array		RGB coordinates for light ambient
_brightness	number		Light brightness default 1
_intensity	number		Light intensity default 1600

Returns: light object

EXAMPLE:
[player, [], [1,1,1], [1,1,1], 1, 1600] call MMF_fnc_lightEffect

*/


params [["_caller", objNull, []], ["_arr", [], []], ["_color", [1,0.85,0.6], []], ["_ambient", [1,0.3,0], []], ["_brightness", 1, []], ["_intensity", 1600, []]];

private _pos= getPos _caller;
private _light = createVehicle ["#lightpoint", _pos, [], 0, "CAN_COLLIDE"];

_arr pushBack _light;

_light setLightBrightness _brightness;
_light setLightColor _color;
_light setLightAmbient _ambient;
_light setLightIntensity _intensity;
_light setLightAttenuation [0,0,0,1.6];
_light setLightDayLight false;

_light
