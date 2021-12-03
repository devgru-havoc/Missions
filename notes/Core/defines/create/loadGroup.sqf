/*

[cursorTarget, [], MMF_west select 0 select 0, true] call MMF_fnc_loadGroup


*/


params [["_caller", player], ["_arr", []], ["_type", []], ["_doLoad", false]];
private _grp=grpNull;
	if (_doLoad) then {
		private	_freeSpace = vehicle _caller emptyPositions "cargo";
		if (_freeSpace < 1) exitWith {
			systemChat "No space"
		};

		private _grp=[objNull, _caller, _freeSpace, side _caller, _type, "CARELESS", [], false, false, 0, "LOAD"] call MMF_fnc_soldiers;
		_caller setVariable ["MMF_cargo_grp", _grp];
		_caller setvariable ["MMF_hasGroup", true];
	} else {
		_this spawn { params [["_caller", player], ["_arr", []], ["_type", []], ["_doLoad", false]];
			if !(_caller in allPlayers) then {waitUntil {speed _caller ==0}};
			private	_grp = _caller getVariable ["MMF_cargo_grp", grpNull];
			_caller setvariable ["MMF_hasGroup",false];
		[_caller, _grp] spawn { params ["_caller", "_grp"];
			{
				moveOut _x; unassignvehicle _x;
				sleep 0.5;
			} foreach units _grp;

			_grp setBehaviour "AWARE";
			if (_caller in allPlayers) then {(leader _grp) sideChat "Moving out!"};

			[_grp, getPos (leader _grp), 100] call bis_fnc_taskPatrol;
			{
				_x setWaypointSpeed "FULL";
			}forEach waypoints _grp;
			_grp setBehaviour "AWARE";
			_grp setSpeedMode "FULL";
		};
		};
	};
_grp
