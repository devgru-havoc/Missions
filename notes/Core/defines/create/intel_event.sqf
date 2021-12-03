/*

add custom intel hints to killed enemy units

example:
["This is a hint", "This is another hint", "This is the final hint"] call mmf_fnc_intel_event

*/


missionNameSpace setVariable ["intel_hints", _this];

addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer", "_instigator"];
if ((faction _killed) == "CIV_f" || faction _killer isEqualTo faction _killed) exitWith {false};
	[ _killed, "Search for intel",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",

		"!alive _target", "_caller distance _target <3", {}, {}, {

			params ["_target", "_caller", "_actionId", "_arguments"];

			_target removeAction _actionID;
			[]spawn {
				titleText ["Searching...", "PLAIN", 0.1];
				sleep 1;

				if ((round random 10) > 5) then {
					hintC selectRandom (missionNameSpace getVariable ["intel_hints", []])
				} else {
					hintC "Nothing found..."
				}
			}
	}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;
}];