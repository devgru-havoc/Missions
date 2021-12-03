/*
EXAMPLE: end mission after 3 hostages
missionNameSpace setVariable ["MMF_hostage_num", 3];
null=[player, hostage_center, 50, {_this sideChat "Hostage Mission Complete!";"end1" call BIS_fnc_endMission}] spawn MMF_fnc_easy_hostage

EXAMPLE: infinite hostages
missionNameSpace setVariable ["MMF_hostage_num", -1];
null=[player, hostage_center,60] spawn MMF_fnc_easy_hostage
*/

params [["_caller", objNull], ["_hostage_pos", objNull], ["_area", 10], ["_code", {}]];

	if ((_hostage_pos getVariable ["MMF_defpos", []]) isEqualTo []) then {	_hostage_pos setVariable ["MMF_defpos", (getPosATL _hostage_pos)] };
	private _center= _hostage_pos getVariable ["MMF_defpos", []];
	private _num= missionNameSpace getVariable ["MMF_hostage_num", 0];
	if (_num == 0) exitWith {_caller spawn _code};

	_hostage_pos setPos _center;
	[_hostage_pos, _area, 0] call MMF_fnc_start_random;
	private _hostage=[_caller, _hostage_pos] call MMF_fnc_hostage_maker;
	["hostage_task", "Rescue the Hostage", _hostage, "ASSIGNED", group _caller] call MMF_fnc_tasker;

	waitUntil {sleep 1;
		if ( alive _hostage && _hostage getVariable ["MMF_is_hostage", false]) then {false} else {
			["hostage_task", _center] call BIS_fnc_taskSetDestination;
			true
		}
	};

	if !(alive _hostage) exitWith {_this spawn MMF_fnc_easy_hostage; true};
	["hostage_task", "Return the hostage", _center, "ASSIGNED", group _caller] call MMF_fnc_tasker;
	waitUntil {sleep 1;
		if (_hostage distance _center> 10 && alive _hostage) then {false} else {
			if (!alive _hostage) exitWith {
				["hostage_task", _center] call BIS_fnc_taskSetDestination;
				_this spawn MMF_fnc_easy_hostage;
				{deleteVehicle _x}forEach (_caller getVariable ["MMF_capture_list", []]);
				[_hostage] join grpNull;
				_caller sideChat "A hostage was killed!";
				true
			};
			["hostage_task", "Rescue the Hostage", objNull, "SUCCEEDED", group _caller] call MMF_fnc_tasker;
			deleteVehicle _hostage;
			missionNameSpace setVariable ["MMF_hostage_num", _num -1];
			_this spawn MMF_fnc_easy_hostage;
			{deleteVehicle _x}forEach (_caller getVariable ["MMF_capture_list", []]);
			_caller sideChat "Hostage secured!";
			true
		};
	};	
