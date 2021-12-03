if !(isServer) exitWith {false};

params [["_caller", objNull], ["_arr", []]];

private	_count = count _arr;
if (_count <1) exitWith {false};

private _type = missionNameSpace getVariable "MMF_nemesis_type" select 0;
private _side = missionNameSpace getVariable "MMF_nemesis_type" select 1;
private _veh_type= [(_type select 1) select 0, (_type select 1) select 2];
private _air_veh= (_type select 2) select 0;
private _nemesis=[];

for "_i" from 0 to (_count -2) do {

	private _mort= createVehicle ["b_mortar_01_f",(_arr select _i),[],20,"NONE"];
	private _gun= createVehicle ["b_HMG_01_f",(_arr select _i),[],20,"NONE"];
	private _garrison=[_arr select _i, _arr select _i, 3, _side, _type select 0, "AWARE", [], false, false, 0, "DEF"] call MMF_fnc_soldiers;
	private _guard =[(_arr select _i), (_arr select _i), 3, _side, _type select 0, "SAFE", [], false, false, 0, "DEF"] call MMF_fnc_soldiers;
	private _veh= [(_arr select _i), _side, true, _veh_type, 1, 50, []] call MMF_fnc_easyGroup;
	private _pos= [_caller, 150, 350, 12, 0, 20, 0] call BIS_fnc_findSafePos;
	[_garrison, leader _garrison, 100] call MMF_fnc_garrison;

	if !(_veh isEqualType []) exitWith {[_veh, [_garrison, _guard, _mort, _gun]]};
	//driver (_veh select 0) setBehaviour "CARELESS";
	driver (_veh select 0) disableAI "FSM";
	(_veh select 0) setBehaviour "SAFE";
	(_veh select 0) forceSpeed 10;
	driver (_veh select 0) addEventHandler ["GetOutMan", {
		(_this select 0) enableAI "FSM";
		(_this select 0) removeEventHandler ["GetOutMan", _thisEventHandler]
	}];

	if !((_arr select _i) == (_arr select 0)) then {
		[_veh select 0, [], _type select 0, true] call MMF_fnc_loadGroup;
		private _near=[];
		if !( (_pos nearRoads 100) isEqualTo []) then {_near= (_pos nearRoads 100) select 0} else {_near=_pos};
		[_veh select 0, "AWARE", "MOVE", [_near], false, ["true", "[vehicle this, [], []] call MMF_fnc_loadGroup"]] call MMF_fnc_wpNAV;
		_veh select 0 setSpeedMode "LIMITED";
		{_nemesis pushBack _x} forEach [_garrison, _guard, _mort, _gun, (_veh select 0)]
	} else {
		private _grp= [objNull, objNull, 6, _side, _type select 0, "AWARE", [], false, true, 0, "MOVE"] call MMF_fnc_soldiers;
		private _heli= [leader _grp, true, _air_veh, [(_arr select 0), _pos], "FLY"] call MMF_fnc_heli_service;
		[(_heli select 0), _grp, (_arr select 0), _caller] spawn { params ["_veh", "_grp", "_pos", "_caller"];
			waitUntil {sleep 1; (({_x in _veh} count (units _grp)) == 0)	};
			uiSleep 10;
			if (_caller in allPlayers) then {
				[_grp, group _caller] spawn BIS_fnc_stalk
			} else {
				//[_grp, _caller, 100] call BIS_fnc_taskPatrol
				[leader _grp, "AWARE", "MOVE", [_caller]] call MMF_fnc_wpNAV;
			}
		};
		{_nemesis pushBack _x} forEach [_garrison, _guard, _mort, _gun, _grp, _heli]
	};
};
_nemesis
