/*
_caller		object			treated as centre
_type		string			class name ie; "B_heli_light_01_f"
_airborne 	string			can be "FLY" or "NONE"
_obj 		object			treated as objective for _act
_act 		string 			can be "PATROL", "STALK" or standard Waypoint type
_arr 		array			named array to save group *optional
_flightENV	array 			[speed, flyInHeightASL, flyInHeight]

returns:	[_veh, _grp]

example:
	[player, "B_heli_light_01_f", "NONE", player, "MOVE"] call MMF_fnc_airgroup

example:
	private _veh= [player, "B_heli_light_01_f", "FLY", chopper_mark_0, "SAD"] call MMF_fnc_airgroup;
	player moveInAny (_veh select 0);

*/
if !(isServer) exitWith {false};

params [["_caller", player], ["_type", [""]], ["_airborne", "NONE"], ["_obj", player], ["_act", "MOVE"], ["_arr", []], ["_flightENV", [9999,[80,100,300],80]]];

private _speed = _flightENV select 0;
private _alt= _flightENV select 1;
private _altb= _flightENV select 2;
private	_veh= createVehicle [_type, _caller getPos[ 0, getDir _caller ],[],0, _airborne];

_veh addeventhandler ["Fired",{ (this select 0) setvehicleammo 1;}];
_veh setPilotLight true;
_veh limitspeed _speed;
_veh flyInHeightASL _alt;
_veh flyinheight _altb;

private _grp= createVehicleCrew _veh;

_arr pushBack _veh;

if (_act isEqualTo "PATROL") then {[_grp, getPos _obj, 3000] call BIS_fnc_taskPatrol};
if (_act isEqualTo "STALK") then {[_grp, group _obj] spawn BIS_fnc_stalk};
if !(_act isEqualTo "PATROL" || _act isEqualTo "STALK") then {_wp = _grp addWaypoint [(getPos _obj), 0]; _wp setWaypointType _act};

[_veh, _grp];
