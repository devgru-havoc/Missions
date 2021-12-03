/*

Create WP network for players or NPCs

_caller		unit			unit to assign WP(s)
_state		string			behaviour state "SAFE", "AWARE", "COMBAT", etc.
_type		string			wp type		"MOVE", "HOLD", "GETOUT", etc.
_arr		array			array of locations (helpers, objects, positions)
_cycle		bool (optional)		cycle waypoints
_code		code (optional)		custom code to execute at WP completion

returns array of positions

create an array of objects or positions,
wp_ARR=[wp_nav_0, wp_nav_1, wp_nav_2, wp_nav_3]

Create a waypoint network that takes player to each location and chats "Waypoint",
[player, "AWARE", "MOVE", wp_arr, false, ["true", "systemChat 'Waypoint'"]] call MMF_fnc_wpNAV
[player, "AWARE", "MOVE", [[0,0,0]], false, ["true", "systemChat 'Waypoint'"]] call MMF_fnc_wpNAV
*/


params [["_caller", player], ["_state", "SAFE"], ["_type", "MOVE"], ["_arr", []], ["_cycle", false], ["_code", ["true", ""], []]];

	{
		if !(_x isEqualType []) then {_x = getPos _x} else {_x = _x}
	} forEach _arr;

	private _grp = group _caller;

	{
		deleteWaypoint [_grp, _forEachIndex]
	} forEach (waypoints _grp);

	{
		if !(isNil '_x') then {
		private _wp = _grp addwaypoint [_x, _forEachIndex];

			_wp setwaypointtype _type;

			_wp setWaypointStatements _code;
		}else{false}
	} forEach _arr;

	if (_cycle) then {
		private _wp = _grp addwaypoint [position (_arr select 0), (count waypoints _grp)];
			_wp setwaypointtype "CYCLE"
	};

_arr


