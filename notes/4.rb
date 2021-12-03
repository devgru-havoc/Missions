this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.10 + getDammage Unit)}];
this setVehicleRadar 1;
this setVehicleReceiveRemoteTargets true;
this setVariable ["NOAI",1,false];



this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.10 + getDammage Unit)}];];
this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.10 + getDammage Unit)}];

this addEventHandler ["HandleDamage", {false}]; this addEventHandler ["Hit", {Unit setDamage (0.10 + getDammage Unit)}];

this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.50 + getDammage Unit)}];


this setvariable ["CS_TYPE","HYBRID"];
this setvariable ["CS_CALLSIGN","Spirithawk One"];
this setVariable ["CS_SLINGLOADING", true];
this setVariable ["CS_CONTAINERS",0];
this setvariable ["CS_CODE","persistent _code as 'this addEventHandler ["HandleDamage", {false}];this addEventHandler ["Hit", {Unit setDamage (0.50 + getDammage Unit)}]';"];

this setvariable ["CS_CODE","persistent _code as 'string';"] //custom init line code
