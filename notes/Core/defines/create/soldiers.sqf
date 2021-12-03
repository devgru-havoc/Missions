/*

_caller			object 			group spawn location
_loc			object 			treated as WP 0 or stalking target
_num			number 			number of units
_side			unit side 		(INDEPENDENT, EAST, WEST)
_type			array of strings	unit class names example: (MMF_EAST select 0 select 0)
_state			string 			group behaviour
_arr			array 			named array to save group
_addIR			bool			add IFF strobe to each unit
_light			bool			force gun lights (weapon must accept light)
_isActor		number			array selection for animation (mmf_anims, see: defines/start/start_default)
_act			string WP type "MOVE", "HOLD"-- can also be "STALK", "DEFEND", "PATROL", "JOIN", "LEAD" (refers to _loc)

returns: group

example:

private _grp=[player, player, 3, WEST, (MMF_WEST select 0 select 0), "SAFE", [], false, true, 0, "PATROL"] call MMF_fnc_soldiers;
systemChat str (_grp);


*/

params [["_caller", objNull], ["_loc", objNull], ["_num", 1], ["_side", WEST], ["_type", ["I_G_soldier_lite_f"]], ["_state", "AWARE"], ["_arr", []], ["_addIR", false], ["_light", false], ["_isActor", 0], ["_act", "MOVE"]];

if !(isServer) exitWith {	[["NOT SERVER"], "MMF_fnc_soliders"] call mmf_fnc_callMonitor	};
[[_num, _side, _act], "MMF_fnc_soliders"] call mmf_fnc_callMonitor;

private _pos=[];
if !(_caller isEqualType []) then {_pos = getPosATL _caller} else {_pos=_caller};
private _move_to=[];
if !(_loc isEqualType []) then {_move_to = getPosATL _loc} else {_move_to=_loc};

private	_grp =[ _pos, _side, _type, [],[],[],[],[_num, 0],0] call BIS_fnc_spawnGroup;

_grp setBehaviour _state;
_grp allowFleeing 0;
_grp deleteGroupWhenEmpty true;
_arr pushBack _grp;
if (missionNameSpace getVariable ["MMF_dynamic_sim", false] && !(_act == "STALK" || _act == "MOVE" || _act == "LOAD" )) then {_grp enableDynamicSimulation true};

{
	if (missionNameSpace getVariable ["MMF_do_injured", false]) then {_x call MMF_fnc_handle_damage};
	_x setVariable ["MMF_account", missionNameSpace getvariable ["MMF_kill_pnts", [0,0]]]
} forEach units _grp;




if (_addIR) then {
	//[leader _grp] call MMF_fnc_addIR

	[leader _grp] remoteExec ["MMF_fnc_addIR",0,true]
};

if (_light) then {
	{
		_x addPrimaryWeaponItem "acc_flashlight";
		_x enableGunLights "forceOn";
	} forEach units _grp
};

_grp;

if (_isActor !=0) exitWith {
	{
		[_x, "SAFE", MMF_anims, _isActor] call MMF_fnc_anims
	} forEach units _grp;
_grp
};

if (_act isEqualTo "PATROL") exitWith {
	[_grp, _move_to, 100] call BIS_fnc_taskPatrol;
_grp
};

if (_act isEqualTo "DEF") exitWith {
	[_grp, _move_to] call bis_fnc_taskDefend;
_grp
};

if (_act isEqualTo "MOVE") exitWith {
	private _wp = _grp addWaypoint [_move_to, 0];
		_wp setWaypointType "MOVE";
_grp
};

if (_act isEqualTo "LEAD") exitWith {
	{
		[_x] joinSilent group _loc
	} forEach units _grp;
_grp
};

if (_act isEqualTo "JOIN") exitWith {
	[_loc] join _grp;
_grp
};

if (_act isEqualTo "STALK") exitWith {
	[_grp, group _loc] spawn BIS_fnc_stalk;
_grp
};

if (_act isEqualTo "LOAD") exitWith {
private	_comm = ["Reporting for duty!", "Force online!", "Ready to deploy.", "We're fired up.", "Let's go.", "Let's get outta here!", "That's enough. Move out!"];
	_grp setBehaviour "CARELESS";
	if (_loc in allPlayers) then {leader _grp sidechat format ["%1", (selectRandom _comm)]};
	{
		_x assignAsCargo vehicle _loc;
		_x moveinCargo (vehicle _loc);
	} foreach units _grp;
_grp
};

if (_act isEqualTo "REC") exitWith {
	{
		_x setVariable ["MMF_isRecruit", true]
	} forEach units _grp;

	[_grp, _loc] call bis_fnc_taskDefend;
_grp
};
