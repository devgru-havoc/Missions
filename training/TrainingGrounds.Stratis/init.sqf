#include "script_component.hpp"

// Disable Ambient Animals
[{time > 0}, {enableEnvironment [false, false];}] call CBA_fnc_waitUntilAndExecute;

// Environment Control Event Handlers
[QGVAR(setTime), {
    ["Environment changing..."] call CBA_fnc_notify;
    skipTime skipTime ((_this select 0) - daytime); // Skip forward to a specific time
    forceWeatherChange;
}] call CBA_fnc_addEventHandler;

[QGVAR(setDate), {
    ["Environment changing..."] call CBA_fnc_notify;
    setDate (_this select 0); // Set date
    forceWeatherChange;
}] call CBA_fnc_addEventHandler;

[QGVAR(setFog), {
    ["Environment changing..."] call CBA_fnc_notify;
    0 setFog (_this select 0); // Set fog
    forceWeatherChange;
}] call CBA_fnc_addEventHandler;

[QGVAR(setOvercast), {
    ["Environment changing..."] call CBA_fnc_notify;
    0 setOvercast (_this select 0); // Set overcast
    forceWeatherChange;
}] call CBA_fnc_addEventHandler;

[QGVAR(setRain), {
    ["Environment changing..."] call CBA_fnc_notify;
    0 setRain (_this select 0); // Set rain
    forceWeatherChange;
}] call CBA_fnc_addEventHandler;

// Medical Event Handlers
[QGVAR(disableAI), {
    (_this select 0) disableAI "ALL";
}] call CBA_fnc_addEventHandler;

[QGVAR(applyDamage), {
    _this call ace_medical_fnc_addDamageToUnit;
}] call CBA_fnc_addEventHandler;
