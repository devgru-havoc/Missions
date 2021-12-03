/*

create a helper or hidden helper at position for debugging or calling position

returns: helper

example:
call {
	private _helper=[position player, [], true] call MMF_fnc_posHelper;
	_helper spawn {sleep 5; deleteVehicle _this}
}

*/

params [["_pos", locationNull], ["_arr", []], ["_visible", false]];

private _helper = createVehicle ["sign_arrow_direction_cyan_f", _pos, [], 0, "CAN_COLLIDE"];

if !(_visible) then {_helper hideObjectGlobal true};
_arr pushBack _helper;

_helper
