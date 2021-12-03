/*======mmf_fnc_houseFire======CALL======Create fire propagation (buildings)

_caller		object						object to represent center
_dist		number						distance (in meters) to search for suitable buildings
_damage		bool	*optional		default TRUE	damage the building over time
_time		number	*optional		default 10	time (in seconds) between damage iterations
_arr		array	*optional		default NONE	array to save effects into

Returns: selected building

EXAMPLE:
[player, 10] call MMF_fnc_houseFire;


See bottom for example action
[player, 10] call MMF_fnc_houseFire;
missionNameSpace setVariable ["do_fire_damage", false]
*/



params [["_caller", objNull, []], ["_dist", 10, []], ["_damage", true, []], ["_time", 10, []], ["_arr", [], []]];

private _buildingARR= nearestObjects [_caller, ["House", "Building"], _dist];
_buildingARR = [_buildingARR, [], {_x distance _caller}, "ASCEND",{count (_x buildingPos -1) > 1}] call BIS_fnc_sortBy;

if ((count _buildingARR) ==0) exitWith {
	false
};

private	_pos=  _buildingARR select 0;
private _building= _buildingARR select 0;
private _fire= createVehicle ["test_EmptyObjectForFireBig", (getPos _building), [], 0, "CAN_COLLIDE"];

[_fire, _arr] call MMF_fnc_lightEffect;
_pos = _pos buildingPos -1;
_pos = _pos call BIS_fnc_arrayShuffle;

{
	private _emitter = "#particlesource" createVehicle (_pos select _forEachIndex);
	_emitter setParticleClass "BigDestructionFire";
	_arr pushBack _emitter;
}forEach _pos;

if (_damage) then {
	[_building, _arr, _time, _fire, _buildingARR, _dist] spawn {
		private _time= (_this select 2);
		missionNameSpace setVariable ["do_fire_damage", true];
		while {damage (_this select 0)< 1} do {
			uisleep _time;
			private _dam= damage (_this select 0);
			(_this select 0) setDamage (_dam + 0.1);
		};
		missionNameSpace setVariable ["do_fire_damage", false];
		{
			deleteVehicle _x
		} forEach (_this select 1);

		if ((count (_this select 4)) >0) then {
			_buildingARR= (_this select 4);
			_fire= (_this select 3);
			_buildingARR = [_buildingARR, [], {_x distance _fire}, "ASCEND",{(damage _x) <1}] call BIS_fnc_sortBy;
			[_buildingARR select 0, (_this select 5), true, (_this select 2)] call MMF_fnc_houseFire;
		};

		uiSleep (_time *10);
		deleteVehicle (_this select 3);
	};
} else {
		_arr pushBack _fire;
		_building setDamage 0.6;
		_building allowDamage false;
};

_building


/*

[_unit, "Start Fire",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"isNull objectparent _this && {!(_this getvariable [""MMF_hasFire"", false])}", "isNull objectparent _this", {}, {}, {

	_target setVariable ["MMF_hasFire", true];
	private _flr = "F_20mm_Red" createvehicle ((_target) ModelToWorld [0,2,0]);

	[_target, _flr] spawn {
		sleep 10;
		[(_this select 1), 10] call MMF_fnc_houseFire;
		sleep 30; (_this select 0) setVariable ["MMF_hasFire", false];
		deleteVehicle (_this select 1);
	};

}, {}, [], 4, 0, false, false, false] call BIS_fnc_holdActionAdd;

*/
