/*
[(_arr select _i), _side, true, _type, 1, 10, []] call MMF_fnc_easyGroup
*/


if !(isServer) exitWith {false};

params [["_caller", player], ["_side", civilian], ["_vehicle", false], ["_type", [""]], ["_num", 1], ["_area", 100], ["_arr", []], ["_garrison", false, []]];

for "_i" from 1 to _num do {

	private _pos = [_caller, (_area *0.2), _area, 3, 0, 20, 0] call BIS_fnc_findSafePos;

	_pos = _pos findEmptyPosition [5, 24, (_type select 0)];

	if (_pos isEqualTo []) exitWith {false};

	if (_vehicle) then {
		private _veh=	[_pos, (random 360), (selectRandom _type), _side] call BIS_fnc_spawnVehicle;
		_arr pushBack (_veh select 2);
		_veh
	} else {
		private	_type= selectRandom _type;
		private	_grp = createGroup [_side, true];
		private _unit= _type createUnit [_pos, _grp];

		{
			_x setVariable ["MMF_account", MMF_kill_pnts];
		} forEach units _grp;

		_arr pushBack _grp;

		[_grp, _pos] call bis_fnc_taskDefend;

		if (_garrison) then {
			[_grp, leader _grp] call MMF_fnc_garrison
		};
		_grp;
	};
};

