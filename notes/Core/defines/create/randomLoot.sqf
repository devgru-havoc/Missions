params [["_caller", objNull], ["_num", 0], ["_area",100], ["_arr", []], ["_typeVeh", "Land_paperBox_closed_f"]];

if (isServer && _num > 0) then {
	for "_i" from 0 to _num do {
		private _pos = [_caller, _area *0.5, _area, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		if !(isOnRoad _pos) then {
			private	_obj = _typeVeh createVehicle _pos;
			_obj setVariable ["MMF_isResource", true];
			_arr pushback _obj;
		} else {false};
	};

	[_caller, "Gather Resources",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance cursorTarget < 3 && cursorTarget getVariable ['MMF_isResource', false]", "alive _this", {}, {}, {
		deleteVehicle cursorTarget;
		[_caller, 0, 1] call MMF_fnc_account;

	}, {}, [], 5, 12, false, true] call BIS_fnc_holdActionAdd;

	_arr
};
