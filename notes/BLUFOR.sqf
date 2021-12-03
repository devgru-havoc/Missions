BLUFOR
Next, we'll set up a base for BLUFOR. The AI need a base to start from so make sure there is some type of military building within the marker area, such as a barracks or compound.
	Place at least one playable unit on the map
	Place a circular area marker covering a military compound on the map and name it BLUFOR_1
	Place a Military Placement (Military Objectives) module in your BLUFOR base, choose the desired options (e.g. light infantry, company strength) and faction and add the marker zone name to the TAOR box (type in BLUFOR_1)
	Place a Military AI Commander module for BLUFOR and select Invasion mode in the options
	Sync(R-CLick > Connect > Sync to) the BLUFOR Mil Placement module to your BLUFOR AI Commander module

OPFOR
Now add some OPFOR occupying the rest of the map
	Place a second Military Placement (Military Objectives) module, select desired options (e.g. Light Inf, Battalion Strength) and an OPFOR faction. Type the name of the BLUFOR base marker into the Blacklist box (BLUFOR_1)
	Place a Military Placement (Civilian Objectives) module and select desired options. Once again, type the name of the BLUFOR base marker into the Blacklist box (BLUFOR_1)
	Place an Military AI Commander module, set it to OPFOR and select Occupy mode
	Sync the OPFOR Mil Placement and Civ Placement modules to your OPFOR AI Commander module
	Place a Military CQB module, set the OPFOR faction and sync it to the Military Placement (Civilian Objectives)



Onebit note.png Note: CQB Density Settings of over 10% may cause very long load times, especially on large heavily urbanised maps with enterable buildings such as Altis!



mklink /d "B:\SteamLibrary\steamapps\common\Arma 3\x\cba" "P:\CBA_A3"
mklink /J "P:\x\cba" "P:\CBA_A3"
mklink /d "B:\SteamLibrary\steamapps\common\Arma 3\x\alive" "P:\ALiVE.OS"
mklink /J "P:\x\alive" "P:\ALiVE.OS"



this setFlagTexture 'armamission.paa';
this addAction["<t color='#551A8B'>Sanctuary</t>", {player setPos getMarkerPos("sanctuary")}];




_action = ["VulcanPinch","Vulcan Pinch","",{_target setDamage 1;},{true},{},[parameters], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[cursorTarget, 0, ["ACE_TapShoulderRight"], _action] call ace_interact_menu_fnc_addActionToObject;


{
	_ammoBox = _x;
	_ammoBoxCode = "[[" + (str _x) + "],'fn_addCargoToArsenal',false,false] call BIS_fnc_MP;"; // create a string composed of what stays the same and the changing array item
	_addedAction = ['addToArsenal','Add cargo to arsenal','', compile _ammoBoxCode ,{true}] call ace_interact_menu_fnc_createAction; // create the action and compile the previously composed string
	[_ammoBox, 0, ["ACE_MainActions"], _addedAction] call ace_interact_menu_fnc_addActionToObject;

} foreach _allAmmoBoxes;


[this, 0, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;



 [player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;

 Replace _action with your execVM call;



/*
 * Argument:
 * 0: Object the action should be assigned to <OBJECT>
 * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
 * 2: Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
 * 3: Action <ARRAY>
 */

 0 = ["AmmoboxInit",[this,true]] spawn BIS_fnc_arsenal;



this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.50 + getDammage Unit)}];
this setposASL [getpos this select 0,getpos this select 1,2000];
this flyInHeight 2000;
[this, 0, ["ACE_MainActions"], "["AmmoboxInit",[this,true]] call BIS_fnc_arsenal;"] call ace_interact_menu_fnc_addActionToObject;




[player, 0, ["ACE_MainActions"], ["AmmoboxInit",[this,true]] spawn BIS_fnc_arsenal] call ace_interact_menu_fnc_addActionToObject;

[bob, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

this call ace_interact_menu_fnc_addActionToObject [c13, 0, ["ACE_MainActions"], 0 = ["AmmoboxInit",[this,true]] spawn BIS_fnc_arsenal];

["AmmoboxInit",[this,true]] call BIS_fnc_arsenal;

[this, 0, ["ACE_MainActions"], ["AmmoboxInit",[this,true]] call BIS_fnc_arsenal;] call ace_interact_menu_fnc_addActionToObject;];




[c130, 0, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;



[c130, 1, ["ACE_MainActions"], [2000,100,this] execVM "halo.sqf"] call ace_interact_menu_fnc_addActionToObject;
[c130, 0, ["ACE_MainActions"], ["AmmoboxInit",[this,true]] call BIS_fnc_arsenal] call ace_interact_menu_fnc_addActionToObject;
this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.50 + getDammage Unit)}];
this setposASL [getpos this select 0,getpos this select 1,2000];
this flyInHeight 2000;


this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.50 + getDammage Unit)}];
this setposASL [getpos this select 0,getpos this select 1,2000];
this flyInHeight 2000;

[c130, 1, "ACE_MainActions", [2000,100,this] execVM "halo.sqf"] call ace_interact_menu_fnc_addActionToObject;

[c130, 0, ["ACE_MainActions"], ["AmmoboxInit",[this,true]] call BIS_fnc_arsenal] call ace_interact_menu_fnc_addActionToObject;

_halo_jump =[2000,100,this] execVM "halo.sqf";

_action = ["ace_MainActions", "Interactions", "", {true}, {true}, {}, [], [0,0,0], 5] call ace_interact_menu_fnc_createAction;
[_object, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;



this setvariable ["CS_TYPE","TRANSPORT"];
this setvariable ["CS_CALLSIGN","Stray Cat One"];
this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.50 + getDammage Unit)}];
this setposASL [getpos this select 0,getpos this select 1,1000];
this flyInHeight 1000;
this addAction ["Halo", {[this] execVM "halo.sqf"}];




0 = ["AmmoboxInit",[this,true]] spawn BIS_fnc_arsenal;




_Halo = this addAction [[2000,100,this] execVM "halo.sqf",player distance [15]];

_halo_jump =[this] execVM "halo.sqf";

radius

_halo_jump = ["menu_name", "Your new menu", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], execVM "halo.sqf"] call ace_interact_menu_fnc_addActionToObject;


_act = player addAction ["Exec the file", "somescript.sqf"]

_halo_jump = [2000,100,this] execVM "halo.sqf",radius 15;


Halo = this addAction [[2000,100,this] execVM "halo.sqf",player distance 15];





_halo_jump = [c130, 1, "ACE_MainActions", execVM "halo.sqf"] call ace_interact_menu_fnc_addActionToObject;

_halo_jump = ["ace_MainActions", "Interactions", "", {true}, {true}, {}, [], [0,0,0], 5] call ace_interact_menu_fnc_createAction;


[_object, 0, [], [2000,100,this] execVM "halo.sqf";]] call ace_interact_menu_fnc_addActionToObject;







_halo_jump = ["menu_name", "Your new menu", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["option_name", "Option", "", {hint "stuff"}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "menu_name"], execVM "halo.sqf"] call ace_interact_menu_fnc_addActionToObject;





atm_C130_J







this setvariable ["CS_TYPE","TRANSPORT"];
this setvariable ["CS_CALLSIGN","Stray Cat One"];
this addEventHandler ["HandleDamage", {false}];
this addEventHandler ["Hit", {Unit setDamage (0.50 + getDammage Unit)}];
this setposASL [getpos this select 0,getpos this select 1,2000];
this flyInHeight 2000;
this addAction["<t color='#ff9900'>HALO jump</t>", "ATM_airdrop\atm_airdrop.sqf"]


this moveInCargo ;

this setFlagTexture 'armamission.paa'; _halo_jump =[2000,100,this] execVM "halo.sqf";
this addAction["<t color='#551A8B'>LCAC</t>", {player moveInCargo LCAC}];
this addAction["<t color='#551A8B'>SPEED BOAT 1</t>", {player moveInCargo GUNBOAT1}];
this addAction["<t color='#551A8B'>SPEED BOAT 2</t>", {player moveInCargo GUNBOAT2}];
