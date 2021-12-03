/*=======================================================create hostage=================================
	creates side appropriate hostage and guards (from nemesis)

_caller		unit		playable unit			requires MMF_side variable
_loc		object		any object/unit/vehicle		center location to search for suitable buildings

RETURNS: hostage unit

=========================================EXAMPLE 0:	script call
private _hostage = [_player, _location] call MMF_fnc_hostage_maker

=========================================EXAMPLE 1:	object init	create an array of helpers
null= this spawn { sleep 1;
	private _loc= selectRandom [loc_0, loc_1, loc_2];
	private _hostage=[(allPlayers select 0), _loc] call MMF_fnc_hostage_maker;
	["hostage_task", "Rescue the Hostage", _hostage, "ASSIGNED", group (allPlayers select 0)] call MMF_fnc_tasker;
	waitUntil {sleep 1;
		if ( alive _hostage && _hostage getVariable ["MMF_is_hostage", false]) then {false} else {
			if (!alive _hostage) then {
				["hostage_task", "Rescue the Hostage", objNull, "FAILED", group (allPlayers select 0)] call MMF_fnc_tasker
			}else{
				["hostage_task", "Rescue the Hostage", objNull, "SUCCEEDED", group (allPlayers select 0)] call MMF_fnc_tasker
			};
			true
		}
	}
}

=========================================EXAMPLE 2:	object init / remove on completion

null= this spawn { sleep 1;
	private _hostage=[player, _this] call MMF_fnc_hostage_maker;
	waitUntil {sleep 1;
		if ( alive _hostage && _hostage getVariable ["MMF_is_hostage", false]) then {false} else {
			if (alive _this) then {player sideChat "Hostage Secured!"} else {player sideChat "Hostage Killed!"};
			deleteVehicle _hostage;
			true
		}
	}
}

======================================================================================================*/



params [["_caller", player], ["_loc", objNull], ["_action", true]];

	private _type = missionNameSpace getVariable "MMF_nemesis_type" select 0;
	private _side = missionNameSpace getVariable "MMF_nemesis_type" select 1;
	private _ally = _caller getVariable "MMF_side" select 0;
	private _hostageArr = [];
	private _hostage = [_loc, _loc, 1, side _caller, _ally, "CARELESS", _hostageARR, false, false, 9, "MOVE"] call MMF_fnc_soldiers;
	_hostage =  leader _hostage;
	private _grp = [_loc, _loc, 2, _side, _type select 0, "AWARE", _hostageArr, false, true, 0, "DEF"] call MMF_fnc_soldiers;
	[_loc, _loc, 2, _side, _type select 0, "AWARE", _hostageARR, false, true, 0, "PATROL"] call MMF_fnc_soldiers;
	_hostage setgroupID ["Hostage"];
	[group _hostage, _loc] call MMF_fnc_garrison;
	[_grp, _loc] call MMF_fnc_garrison;

	{
		if (_x distance _hostage <2) then {
			deleteVehicle _x
		}
	} forEach units _grp;

	{
		_hostage unlinkItem _x
	} forEach [goggles _hostage, hmd _hostage, headgear _hostage, primaryWeapon _hostage, backpack _hostage];
	_hostage setCaptive true;
	_hostage setVariable ["MMF_is_hostage", true];
	removeAllWeapons _hostage;
	if (_action) then {
		[_hostage, "Assist Hostage",
			"a3\modules_f\data\iconunlock_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
			"_target getVariable ['MMF_is_hostage',false] && _target distance _this<3", "alive _target", {}, {}, {
 			_target setVariable ["MMF_is_hostage", false];
			[_target, "AWARE"] call MMF_fnc_anims;
			_target setCaptive false;
			[_target] joinSilent _caller;
			private _task= "hostage_task" call BIS_fnc_taskState;
			if (_task isEqualTo "ASSIGNED") then {
				["hostage_task", "Rescue the Hostage", objNull, "SUCCEEDED"] call MMF_fnc_tasker
			}
		}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;
	};
_hostage