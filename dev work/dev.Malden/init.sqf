
// Fixing warning spam from ambientLife. Also, if I hear "Look a bunny!" one more bloody time...
sleep 0.2;
enableEnvironment [false, true];

if (isServer) then {
    ["ace_captiveStatusChanged", {
        params ["_unit", "_state", "_reason"];
 
        if ((getPos _unit) inArea prison_marker_or_trigger_name) then {
            _unit setVariable ["detained", true, true];
        };
    }] call CBA_fnc_addEventHandler;
 
    [{
        [getPos prison_marker_or_trigger_name, [side player], -10] call ALIVE_fnc_updateSectorHostility;
    }, 3600, []] call CBA_fnc_addPerFrameHandler;
};
