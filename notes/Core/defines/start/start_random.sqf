/*======mmf_fnc_start_random======CALL======various effects================random time, area, parachute (height), start injured

*set random object position in area (can be used to randomize position of any object)
*set random time
*start parachute routine
*start injured routine
**garrison
note: damage handling ends when injured routine ends. To restart damage handling toggle,
_unit setVariable ["MMF_handle_damage", true];

_caller		unit/helper object	object to randomize position			can be objNull
_area		number			*optional	area to randomize position
_height		number >0		*optional	height to begin at		must be > 0 to trigger
_r_time		bool			*optional	random time (server only)
_injured	number			*optional	duration to play injured routine (0 to skip) default: 0

*extra: send -1 as "_height" to garrison the calling group in nearest building

returns: array [time, _caller posATL, injured duration]

EXAMPLE:
=============================random area in 100, at 500 m altitude
_params=[player, 100, 500] call MMF_fnc_start_random;
systemChat str _params;

=============================editor location, start injured routine for 15 seconds
_params=[player, 0, 0, false, 15] call MMF_fnc_start_random;
systemChat str _params;

=============================random server time
if (isServer) then {[objNull, 0, 0, true] call MMF_fnc_start_random};

=============================garrison in 100 m
[player, 100, -1] call MMF_fnc_start_random;

=========================================================================================*/

mmf_start_injured= { params ["_caller", "_dur"];
	[_caller, "SAFE", MMF_anims, 4] call MMF_fnc_anims;
	_caller setVariable ["MMF_handle_damage", true];
	sleep _dur;
	private _name= format ["Get up %1", name _caller];
	titleCut [_name,"BLACK IN", 10];
	_caller switchMove "";
	_caller setVariable ["MMF_handle_damage", false];
};
//====================================function=================================>>

params [["_caller", objNull, []], ["_area", 0, []], ["_height", 0,  []], ["_r_time", false,  []], ["_injured", 0,  []]];

if (_r_time && isServer) then {
			//random time
		skipTime (round random 24);
};

if (_area >0) then {
	private _pos = [_caller, (_area * 0.5), _area, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_caller setpos [(_pos select 0), (_pos select 1), _height];
};

if (_height > 0 && _caller isKindOf "Man") then {
	_caller addBackpack  "B_Parachute";
	_caller spawn {
		waitUntil {sleep 1; isTouchingGround _this};
		removeBackPackGlobal _this;
	};
};

if (_height == -1 && _caller isKindOf "Man") then {
	[group _caller, _caller, _area] call MMF_fnc_garrison
};

if (_injured >0 && _height <1) then {
	[_caller, _injured] spawn mmf_start_injured
};

[time, (getPosATL _caller), _injured]