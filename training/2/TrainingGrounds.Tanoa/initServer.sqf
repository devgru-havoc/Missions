#include "script_component.hpp"

[{
    // Removes corpse after disconnect.
    addMissionEventHandler ["HandleDisconnect", {
        deletevehicle (_this select 0);
    }];
    
    GVAR(spawnedvehiclesnamespace) = true call CBA_fnc_createnamespace;
    publicVariable QGVAR(spawnedvehiclesnamespace);
}] call CBA_fnc_directcall;