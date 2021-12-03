/*

Create mobile group

_caller			object		center object
_distance		number		distance from object
_type			string		class string
_crew			bool		create crew
_obj			object		objective
_act			string		action or waypoint type
_arr			array		named array to store vehicle/group

Returns: empty vehicle or group

example:
private _veh=[player, 10, "B_LSV_01_ARMED_f"] call MMF_fnc_mobileGroup;
systemChat str (_grp)

example:
private _grp=[player, 100, "B_LSV_01_ARMED_f", true, player, "STALK"] call MMF_fnc_mobileGroup;
systemChat str (_grp);
*/



params [["_caller", player], ["_distance", 10], ["_type", "B_LSV_01_ARMED_f"], ["_crew", false], ["_obj", player], ["_act", "HOLD"], ["_arr", []]];

private _loc= _caller getPos [_distance, getDir _caller];
private	_veh = _type createVehicle _loc;

_veh addeventhandler ["Fired",{ (this select 0) setvehicleammo 1}];
_veh setPilotLight true;

if !(_crew) exitWith
{
		_arr pushBack _veh;
_veh
};

if (_crew) exitWith {
	private	_grp =createVehicleCrew _veh;
	_arr pushBack _veh;

	if (_act isEqualTo "PATROL") then {
			[_grp, getPos _obj, 500] call BIS_fnc_taskPatrol
	};

	if (_act isEqualTo "STALK") then {
			[_grp, group _obj] spawn BIS_fnc_stalk
	};

	if !(_act isEqualTo "PATROL" || _act isEqualTo "STALK") then {
			_wp = _grp addWaypoint [(getPos _obj), 0];
			_wp setWaypointType _act;
	};
_grp
};
