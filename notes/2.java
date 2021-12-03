if (isServer) then {_myGroup = createGroup side; _myUnit = _myGroup createUnit ["B_Soldier_SL_F", getPos trigger_1,[], 0, "NONE"];};




this addAction [ "Medic", { [ "Medic", player getPos [ 1, getDir player ], [0,0,0], random 360 ] call LARs_fnc_spawnComp } ];

this setvariable ["CS_CODE","persistent _code as 'this addEventHandler [""HandleDamage"", {false}];this addEventHandler [""Hit"", {Unit setDamage (0.10 + getDammage Unit)}]';"];  this setVariable ["NOAI",1,false];   this setVehicleRadar 1;  this setVehicleReceiveRemoteTargets true; this addAction [""<t color='#2bf000'>HALO JUMP</t><br/><img size='3' image='\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa'/>"", ""scripts\heliHALO.sqf"", [], 1, false, true, """", ""_this in _target""];      " \n "};



this addAction [""<t color='#2bf000'>HALO JUMP</t><br/><img size='1' image='\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa'/>"", ""scripts\flagHALO.sqf""];";


this setvariable ["CS_CODE","persistent _code as 'this addEventHandler [""HandleDamage"", {false}];this addEventHandler [""Hit"", {Unit setDamage (0.10 + getDammage Unit)}]]';"];
this setVariable ["NOAI",1,false]; this setVehicleRadar 1;  this setVehicleReceiveRemoteTargets true; this addAction [""<t color='#2bf000'>HALO JUMP</t><br/>"", ""scripts\heliHALO.sqf"", [], 1, false, true, """", ""_this in _target""];      " \n "};



this setvariable ["CS_CODE","persistent _code as 'this addEventHandler [""HandleDamage"", {false}];this addEventHandler [""Hit"", {Unit setDamage (0.10 + getDammage Unit)}]';"];  this setVariable ["NOAI",1,false];   this setVehicleRadar 1;  this setVehicleReceiveRemoteTargets true; call{this setvariable [""CS_TYPE"",""TRANSPORT""]; this setvariable [""CS_CALLSIGN"",""Heaven""]; this setposATL [getpos this select 0,getpos this select 1,6500];this flyInHeight 6500;clearItemCargoGlobal this;   clearMagazineCargoGlobal this;   clearWeaponCargoGlobal this;   clearBackpackCargoGlobal this; this flyInHeight 2000; {this animateDoor [_x, 1]} forEach [""door_L"",""door_R""]; this attachTo [heliHolder,[0,0,0]]; this allowDamage false; this addAction [""<t color='#2bf000'>HALO JUMP</t><br/><img size='3' image='\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa'/>"", ""scripts\heliHALO.sqf"", [], 1, false, true, """", ""_this in _target""];      " \n "}";


this setvariable ["CS_CODE","persistent _code as 'this addEventHandler [""HandleDamage"", {false}];this addEventHandler [""Hit"", {Unit setDamage (0.10 + getDammage Unit)}]';"];  this setVariable ["NOAI",1,false];   this setVehicleRadar 1;  this setVehicleReceiveRemoteTargets true; call{this setvariable [""CS_TYPE"",""TRANSPORT""]; this setvariable [""CS_CALLSIGN"",""Heaven""]; this setposATL [getpos this select 0,getpos this select 1,6500];this flyInHeight 6500;clearItemCargoGlobal this;   clearMagazineCargoGlobal this;   clearWeaponCargoGlobal this;   clearBackpackCargoGlobal this; this flyInHeight 2000; {this animateDoor [_x, 1]} forEach [""door_L"",""door_R""]; this attachTo [heliHolder,[0,0,0]]; this allowDamage false; this addAction [""<t color='#2bf000'>HALO JUMP</t><br/><img size='3' image='\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa'/>"", ""scripts\heliHALO.sqf"", [], 1, false, true, """", ""_this in _target""];      " \n "}";  


this setvariable ["CS_CODE","persistent _code as 'this addEventHandler [""HandleDamage"", {false}];this addEventHandler [""Hit"", {Unit setDamage (0.10 + getDammage Unit)}]';"];  this setVariable ["NOAI",1,false];   this setVehicleRadar 1;  this setVehicleReceiveRemoteTargets true;


 setvariable ["CS_CODE","persistent _code as 'this addEventHandler [""HandleDamage"", {false}];this addEventHandler [""Hit"", {Unit setDamage (0.10 + getDammage Unit)}]';"];  this setVariable ["NOAI",1,false];   this setVehicleRadar 1;  this setVehicleReceiveRemoteTargets true;







_myUnit = _myGroup createUnit ["B_Soldier_SL_F", 7100,7324,, [], 10, "SPECIAL"];   

this addAction ["This is a Action", "hint "works"; _myGroup = createGroup west; _myUnit = _myGroup createUnit ["B_CTRG_Soldier_Medic_tna_F", [7100,7324,0],[], 50, "NONE"];"]

this addAction["<t color='#551A8B'>spawn</t>", _myUnit = _myGroup createUnit ["B_Soldier_SL_F", 7100,7324,, [], 10, "SPECIAL"]];


this addAction [ "yourAction", { hint "_myUnit = _myGroup createUnit ["B_Soldier_SL_F", 7100,7324,, [], 10, "SPECIAL"];" } ];

addAction ["A Useless Action That Does Nothing", {_myUnit = _myGroup createUnit ["B_Soldier_SL_F", 7100,7324,, [], 10, "SPECIAL"];}];

_myGroup = createGroup side; 
_myUnit = _myGroup createUnit ["B_Soldier_SL_F", getMarkerPos("sanctuary"),[], 0, "NONE"];};


this addAction [ "yourAction", { hint "" } ];

this addAction ["medic", {_compReference = [ Medic, sanctuary] call LARs_fnc_spawnComp;}];
addAction ["medic", {_compReference = [ Medic, getMarkerPos("sanctuary"),,,,] call LARs_fnc_spawnComp;}];
 this addAction["<t color='#551A8B'>medic</t>", {_compReference = [ Medic, getMarkerPos("sanctuary"),,,,] call LARs_fnc_spawnComp;}]; 

addAction [ "Medic", { [ "Medic", player getPos [ 1, getDir player ], [0,0,0], random 360 ] call LARs_fnc_spawnComp } ];


_compReference = [ COMP_NAME, POS_ATL, OFFSET, DIR, ALIGN_TERRAIN, ALIGN_WATER ] call LARs_fnc_spawnComp;
Where..
COMP_NAME - Classname given to composition in CfgCompositions
POS_ATL( optional, default compositions saved position ) - Position to spawn composition
If not given or empty array passed then original saved composition position is used
Also accepts OBJECT, MARKER, LOCATION
OFFSET( optional, default none ) - ARRAY [ x, y, z ] ammount to offset composition, as a compositions base pos can vary from what you want when its saved
DIR( optional, deafault 0 ) - Direction to face composition in, If POS_ATL is of type OBJECT, MARKER, LOCATION passing TRUE for direction will use objects direction
ALIGN_TERRAIN( optional, default True ) - BOOL, Whether composition objects should align themselves to their positions surface normal
ALIGN_WATER( optional, default True ) - BOOL, If a composition objects position is over water should they align themselves to sea level



You can connect remotely using this information:
Public IP	34.215.155.231
User name	Administrator
Password	
sC-HR4nbLp
