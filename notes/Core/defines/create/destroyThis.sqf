/*
creates "destroy the target" task

_caller 		unit		playable unit
_target			object/unit	thing to be destroyed (must be destructible)
_showtask		bool		reveal the task location
_code			code		code to spawn when object is destroyed	

returns: nothing

example call:
	[player, _target, true, {systemChat format ["%1 destroyed the target", name _this]}] call MMF_fnc_destroyThis
*/


params [["_caller", player], ["_target", player], ["_showTask", false], ["_code", {}]];

if !(_caller in allPlayers) then {
	[_caller, "AWARE", "SAD", [_target], false] call MMF_fnc_wpNAV
} else {

	if (_showTask) then {
		["task_destroy", "Objective", _target, "Assigned", group _caller] call MMF_fnc_tasker;
	} else {
		["task_destroy", "Objective", objNull, "Assigned", gpNull] call MMF_fnc_tasker;
	}
};

_this spawn { params [["_caller", player], ["_target", player], ["_showTask", false], ["_code", {}]];
	waitUntil {	sleep 1; 
		if (!alive _target) then {
			if (_caller in allPlayers) then {
				["task_destroy", "Objective Destroyed!", objNull, "SUCCEEDED", group _caller] call MMF_fnc_tasker
			};
			_caller spawn _code;
			true
		}else{false}
	};
};
