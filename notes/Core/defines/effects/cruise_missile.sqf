/*======MMF_fnc_cruise_missile======CALL======create missile and assign target

spawn a cruise missile at the location of the provided object; send to target

_loc		object		launch location
_target		object		target location
_side		*optional	EAST, WEST, INDEPENDENT

*use helper objects to define specific launch location

EXAMPLE
[missile_launcher, missile_target, east] call cruise_missile

*see bottom for example action

*/


	params [["_loc", objNull], ["_target", objNull], ["_side", WEST]];

	private	_veh= createVehicle ["b_ship_mrls_01_f", getPosATL _loc,[],0, "CAN_COLLIDE"];

	_veh enableSimulationGlobal false;
	_veh hideObjectGlobal true;
	_veh allowDamage false;
	private _crew =createVehicleCrew _veh;
	_grp =createGroup _side;
	
	{[_x] join _grp} forEach units _crew;

	_grp deleteGroupWhenEmpty true;

	_side reportRemoteTarget [_target, worldSize];
	_target confirmSensorTarget [_side, true];
	_veh fireAtTarget [_target, "weapon_vls_01"];

	{deleteVehicle vehicle _x; deleteVehicle _x;} forEach units _crew;





/*================================test action
[ player, "Fire Missile",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"alive _this", "alive _this", {}, {}, {
	[missile_launcher, missile_target] call MMF_fnc_cruise_missile;
}, {}, [], 2, 14, false, false, false] call BIS_fnc_holdActionAdd;
/*




