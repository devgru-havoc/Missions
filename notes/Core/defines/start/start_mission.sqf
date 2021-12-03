params	[
["_caller", objNull],
["_message", ["Creating Warzone...", "BLACK FADED", 0.5], []],
["_nemesis", [false, 1000, [], [], [], false], []],
["_dynaWeat", false, []],
["_doWreck", [false, 1, 100], []],
["_doPop", false, []]
];

if (missionNameSpace getVariable "mmf_call_monitor") then {[[_caller, _nemesis select 1, _doWreck select 0], "mmf_fnc_startUp"] call mmf_fnc_callMonitor; []spawn MMF_fnc_showDiag};


missionNameSpace setVariable ["MMF_nemesis_type", [_nemesis select 3 select 0, _nemesis select 3 select 1]];
missionNameSpace setVariable ["MMF_pathCreated", false];
missionNameSpace setVariable ["MMF_kill_pnts", [_nemesis select 4 select 1, 0]];
missionNameSpace setVariable ["MMF_do_injured", (_nemesis select 5)];

if (_nemesis select 4 select 0) then {
	addMissionEventHandler["EntityKilled",{
		params ["_unit", "_killer"];
		if (!((faction _unit) == (faction _killer)) && !((faction _unit) == "CIV_f")) exitWith {
			private _val=_unit getVariable ["MMF_account", [0,0]];
			if (_val select 0 >0 && local _killer) then {
				[_killer, _val select 0] call MMF_fnc_account
			}
		}
	}];
} else {call MMF_fnc_score_tiles};

if (_nemesis select 5) then {

	{
		if !(_x in allPlayers || faction _x == "CIV_f") then { _x call MMF_fnc_handle_damage}
	}forEach allUnits;

	[]spawn {
		while {sleep 100; true} do {
			private _arr = [allUnits, [], {damage _x}, "ASCEND",{_x getVariable ["MMF_surrender", false]}] call BIS_fnc_sortBy;
			{
				_x setVariable ["MMF_surrender", false];
				_x enableAI "ALL";
				_x setCaptive false;
				_x switchMove "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
			} forEach _arr;

		[[count _arr], "MMF_sweep"] call mmf_fnc_callMonitor;
		};
	};
};


if (_dynaWeat) then {
		[]spawn MMF_fnc_startWeather
};


//title text, type, time
[_message] spawn {
	[[(_this select 0 select 0), (_this select 0 select 1), (_this select 0 select 2)]] remoteExec ["titleText", 0, false];
	sleep (((_this select 0 select 2) *10)+0.2);
	{[] execVM "\a3\missions_f_bootcamp\Campaign\Functions\GUI\fn_SITREP.sqf"} remoteExec ["bis_fnc_call",0];
};


if (_nemesis select 0) then {
	[_caller, _nemesis select 1] spawn {
		MMF_pathArr=[];
		[(_this select 0), mmf_pathArr, _this select 1, "MAN", "COMBAT"] spawn MMF_fnc_createPath;
		waitUntil {	sleep 1; missionNameSpace getVariable ["MMF_pathCreated", false]	};
		[(_this select 0), mmf_pathArr] spawn MMF_fnc_nemesis;
	}
};


if (_doWreck select 0) then {
	MMF_wreck_arr=[];
	[_caller, 3, (_doWreck select 2), MMF_wreck_arr, ["WRECKFIRE", MMF_wreck]] spawn MMF_fnc_specialFX;
};


if (_doPop) then {
	_caller spawn {		params ["_caller"];
		while {sleep 1; true} do {

			waitUntil {sleep 3; !(nearestLocations [position _caller, ["CityCenter","NameCity","NameCityCapital","NameVillage"], worldSize] isEqualTo []) };

			private	_near = nearestLocations [position _caller, ["CityCenter","NameCity","NameCityCapital","NameVillage"], worldSize];
			if !(text (_near select 0) isEqualTo "") then {
				private _pos= locationPosition (_near select 0);
				private _list= nearestObjects [[_pos select 0, _pos select 1, 0], [], 100];
				(_list select 0) call MMF_fnc_autoPop;
				private _vehMod=0;
				if (objectParent _caller isKindOf "helicopter" || objectParent _caller isKindOf "plane") then {_vehMod=1000};
				waitUntil {sleep 3;(
					!(((nearestLocations [position _caller, ["CityCenter","NameCity","NameCityCapital","NameVillage"], worldSize]) select 0
					) isEqualTo (_near select 0)) &&
					_caller distance (_list select 0) > 500 + _vehMod)
				};

				{
					if !(_x == objectParent _caller) then {deleteVehicle _x}
				}forEach MMF_allPop
			}
		}
	}
};



[] spawn MMF_injector;
