/*
This is debug script

_arr		array of relevant variables
_fnc 		string of function name (can be any string)

returns: name space variable state (bool)

**will system chat variables and called function name for select functions (soldiers, startUp, startPlayer) if enabled

example call:
	[[_data], "function name"] call MMF_fnc_callMonitor
*/


	params [["_arr", [], []], ["_fnc", "mmf_call_monitor", []]];

	if (missionNameSpace getVariable ["MMF_call_monitor", false]) then
	{
		systemChat format ["%1 call %2", _arr, _fnc]
	};

(missionNameSpace getVariable ["MMF_call_monitor", false])