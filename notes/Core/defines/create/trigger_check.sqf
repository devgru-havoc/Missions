/*

* requires a trigger to define area
* can be called with "thisTrigger" or trigger name

example:
[[unit_1, unit_2], thisTrigger, [true, 8], {systemChat "custom code"}] spawn mmf_fnc_trigger_check

*/

if !(isServer) exitWith {false};

	params [["_units", allPlayers], ["_trigger", objNull], ["_time", [false, 5]], ["_code", {systemChat "Countdown finished"}]];

	//systemChat "Spawned... waiting";

	waitUntil {uiSleep 1; {_x inArea _trigger} count _units == count _units};
	private _show= _time select 0;
	private _time= _time select 1;
	while {_time >0} do {

		if({_x inArea _trigger}count _units == count _units) then {
			if (_show) then {hintSilent str _time};
			uiSleep 1;
			_time = _time -1
		} else {_time=0}
	};

	if({_x inArea _trigger}count _units == count _units) exitWith {
		_this spawn _code
	};
		_this spawn mmf_fnc_trigger_check;


