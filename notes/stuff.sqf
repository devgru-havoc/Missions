/*MODE:		1, 2 or 3;
		Mode 1 is minor injured patient.
		Mode 2 is severe injured patient.
		Mode 3 is patient with cardiac arrest.*/

//Example: null = [spawnPos, 10, 1] execVM "scripts\Tib_medical.sqf";

//You can use this script freely as long as you give credits.
//Good luck with it and I hope it will help.

[this, 0, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;



this addAction ["<t color='#551A8B'>Combat Drop</t>", "scripts\para.sqf"];



[this, 0, [], _this flyInHeight 15000;] call ace_interact_menu_fnc_addActionToObject;


_haloh = [] _this flyInHeight 15000;

haloh = ['TestAction 1','Test','_this flyInHeight 15000;',{hint 'test';},{true}] call ace_interact_menu_fnc_createAction;
[this, 1, ["ACE_SelfActions"], haloh] call ace_interact_menu_fnc_addActionToObject;


this addAction ["<t color='#2bf000'>minor injured patient</t><br/>", "null = [spawnPos, 10, 1] execVM "scripts\Tib_medical.sqf"];
this addAction ["<t color='#2bf000'>severe injured patient</t><br/>", "null = [spawnPos, 10, 2] execVM "scripts\Tib_medical.sqf";
this addAction ["<t color='#2bf000'>patient with cardiac arrest</t><br/>", "null = [spawnPos, 10, 3] execVM "scripts\Tib_medical.sqf";

ace_interact_menu_fnc_addActionToObject

this addAction ["<t color='#551A8B'>Halo Height</t>", "_this flyInHeight 15000;"];

_helicopter flyInHeight 40;

ace_interact_menu_fnc_addActionToObject




// ACE Vehicle Lock
ace_vehiclelock_defaultLockpickStrength = 10;
ace_vehiclelock_lockVehicleInventory = false;
force ace_vehiclelock_vehicleStartingLockState = 2;







opforUnit unassignItem "NVGoggles_OPFOR";
opforUnit removeItem "NVGoggles_OPFOR";
independentUnit unassignItem "NVGoggles_INDEP";
independentUnit removeItem "NVGoggles_INDEP";



