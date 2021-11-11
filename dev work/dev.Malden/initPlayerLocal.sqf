
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};

nul = [] execVM "scripts\EHL\EHL.sqf";

// Fixing warning spam from ambientLife. Also, if I hear "Look a bunny!" one more bloody time...
sleep 0.2;
enableEnvironment [false, true];





