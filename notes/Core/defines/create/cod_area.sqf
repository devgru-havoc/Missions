/*

Call On Demand trigger: Spawn the required number of units and continue spawning until;
a) Player Activated: player moves out of area (or area is moved away from player)
b) Remote: trigger is deleted

*requires trigger area
*requires nearby buildings (use Nemesis for empty areas)
*can put multiple calls in one trigger
*can remote activate (delete to cancel spawning)

_side		side			unit side (EAST, WEST, INDEPENDENT)
_type		array of strings 	(class names), MMF_IND, MMF_EAST, MMF_WEST
_num		number			number of units to maintain
_trigger	object			trigger name
_remote		bool	*optional	is remote trigger (not player activated)			default: false
_loadout	array	*optional	defined loadout (see MMF_fnc_getSet)				default: none
_act		string	*optional	action for group ("MOVE", "DEFEND", "PATROL", "STALK")		default: "STALK"

example,

AREA:			min ~10 m x ~10 m 
TYPE:			NONE
ACTIVATION:		ANYPLAYER
REPEAT:			TRUE
CONDITION:		THIS

ON ACTIVATION:
call {
	thisTrigger spawn {sleep 1;
	[EAST, (MMF_EAST select 0 select 0), 3, _this, false, [], "MOVE"] spawn mmf_fnc_COD_area;
	}
}

*/

if !(isServer) exitWith {false};

params [["_side", WEST], ["_type", []], ["_num", 1], ["_trigger", objNull], ["_remote", false], ["_loadout", []], ["_act", "STALK"]];

private _area = triggerArea _trigger;
private _cond= (triggerStatements _trigger) select 0;
private _unit_arr=[];
private _unit_arr = [_unit_arr, [], {_x distance _trigger}, "ASCEND",{alive _x}] call BIS_fnc_sortBy;

while {!(_remote) && {side _x== _side && _x inArea _trigger} count allUnits < _num ||  _remote && {alive _x} count _unit_arr < _num || !isNull _trigger} do {
	//if (isNull _trigger) exitWith {false};
	private _pos = [_trigger, (_area select 0) *0.5, (_area select 0), 1, 0, 10, 0] call BIS_fnc_findSafePos;
	private _near= nearestObjects [_pos, ["house", "building"], (_area select 0) *0.5];
	if !(_near isEqualTo []) then {
		private _arr=[];
		private _players = [allPlayers, [], {_x distance _trigger}, "ASCEND",{hasInterface}] call BIS_fnc_sortBy;
		[(_near select 0), (_players select 0), 1, _side, _type, "SAFE",_arr, false, false, 0, _act] call MMF_fnc_soldiers;

		{
			if !(_loadout isEqualTo []) then {
				_x setUnitLoadout (selectRandom _loadout)
			};
			_unit_arr pushBack _x;
		} forEach units (_arr select 0);

	};

	waitUntil {sleep 1;
		!(_remote) && {side _x== _side && _x inArea _trigger} count allUnits <_num ||
		!(_remote) && {_x inArea _trigger} count allPlayers==0 ||
		{_remote && {alive _x} count _unit_arr <_num} ||
		{isNull _trigger}
	};
	if (isNull _trigger) exitWith {false};
	if ({_x inArea _trigger} count allPlayers==0 && !(_remote)) exitWith {
			{deleteVehicle _x}forEach _unit_arr;
	};
};






