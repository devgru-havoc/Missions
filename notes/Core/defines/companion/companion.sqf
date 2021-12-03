/*============================mmf_fnc_companion=====================CALL=============makes NPC a player follower

Turns editor based NPC into player follower

EXAMPLE: (unit init)
_this call MMF_fnc_start_companion

*/



if !(_this in allUnits) exitWith {systemChat "That's not a unit!"};

_this addeventhandler ["Fired",{
	private _count = (_this select 0) ammo primaryWeapon (_this select 0);
	if (_count > 0) exitWith {false};
	(_this select 0) setvehicleammo 1;
}];

MMF_comp_target= {
	waitUntil {uiSleep 5; (count (_this targets [true, 500])) >0 || {!alive _this}};
	if (!alive _this) exitWith {false};
	
		private _targetData= count (_this targets [true, 500]);
		private _nearTarg= count (_this targets [true, 100]);
		player commandTarget (assignedTarget _this);
		_this setBehaviour "AWARE";

		if (_targetData==1) then {
			_this sideChat "There is a target!"
		} else {
			private _targets= format ["There are %1 targets!", _targetData];
			_this sideChat _targets;
		};

	waitUntil {uiSleep 5; (count (_this targets [true, 500])) != _targetData || {!alive _this}};
		if (!alive _this) exitWith {false};
		_this spawn MMF_comp_target;
};


MMF_comp_rtn={

[[player], "MMF_comp_rtn"] call mmf_fnc_callMonitor;

_this setPosATL [((getPosATL player select 0) + random 3), ((getPosATL player select 1) + random 3), getPosATL player select 2];

	_this enableAI "PATH";
	group _this setSpeedMode "NORMAL";
	unassignvehicle _this;

	_this setVariable ["MMF_wait", false];
	_this spawn MMF_comp_move;

};


MMF_comp_move={
	_this disableAI "FSM";
	while {uiSleep 1; !(_this getVariable ["MMF_wait", false]) && {alive _this}} do {

		if (!(_this getVariable ["MMF_wait", false]) && {isNull objectParent player} && {_this distance player> 55}) exitWith {
			_this spawn MMF_comp_rtn
		};

		if (_this distance player > 5) then {
			_this enableAI "PATH";
			_this setBehaviour "CARELESS";
			_this disableAI "TARGET";
			_this disableAI "AUTOTARGET";
			if (stance player isEqualTo "CROUCH" || stance player isEqualTo "PRONE") then {
				_this setUnitPos "middle"
			} else {
				_this setUnitPos "up"
			};

			if !(speed player == 0) then {
				_this doMove getPosATL player
			}
		} else {
			_this disableAI "PATH";
			_this setBehaviour "AWARE";
			_this enableAI "AUTOTARGET";
			_this enableAI "TARGET";
		}
	};
	if (!alive _this) exitWith {[player, side player] spawn MMF_fnc_startCompanion};
};


MMF_comp_wait={
	private	_grp= group _this;
		{
			deleteWaypoint [group _this, _forEachIndex]
		} forEach (waypoints group _this);

			_this disableAI "PATH";
			_this setVariable ["MMF_wait", true];
			_this setUnitPos "middle";
			_this sideChat "Holding.";
};

//vars / calls / task

_this allowDamage false;
_this setUnitPos "UP";
(group _this) allowFleeing 0;

_this setGroupID ["Companion"];
[_this] call MMF_fnc_addIR;
_this spawn MMF_comp_target;
_this spawn MMF_comp_move;
["MMF_companionLoc", "Companion", _this, "Assigned", group player] call MMF_fnc_tasker;

_this addAction ["<t color='#606000'>SET EQUIPMENT</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setUnitLoadout (getUnitLoadout _caller);
},[],0,false, false,"", "alive _this"];

//save var & action
player setVariable ["MMF_NPC_comp", _this];

if !(player getVariable ["MMF_hasCompanion", false]) then {

player setVariable ["MMF_hasCompanion", true];
[player, "<t color='#606000'>ORDER COMPANION</t>",
"a3\3den\data\cfg3den\comment\texture_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"alive (_this getVariable ""MMF_NPC_comp"") ", "isNull objectparent _this", {}, {}, {

private _npc= _target getVariable "MMF_NPC_comp";
_npc spawn {
	uiSleep 0.5;
	private _result= ["Companion", "Select Action", "Wait", "Recall"] call BIS_fnc_guiMessage;

	if (_result) then {
		_this spawn MMF_comp_wait
	} else {
		_this spawn MMF_comp_rtn
	};
};

}, {}, [], 1, 0, false, false, false] call BIS_fnc_holdActionAdd;

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	private _NPC= _unit getVariable ["MMF_NPC_comp", objNUll];
	if !(_NPC getVariable ["MMF_wait", false]) then {
		private _avail=  allTurrets _vehicle;
		if !((count _avail)==0) then {
			_NPC assignAsGunner _vehicle;
			_NPC moveInGunner _vehicle;
			[_NPC, _vehicle] spawn {uiSleep 3;
				if (isNull objectParent (_this select 0)) then {
					(_this select 0) assignAsCargo (_this select 1);
					(_this select 0) moveInAny (_this select 1);
				}
			}
		} else {
			_NPC assignAsCargo _vehicle;
			_NPC moveInAny _vehicle;
		}

	} else {
		_NPC sideChat "I'm waiting"
	}
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	private _NPC= _unit getVariable ["MMF_NPC_comp", objNUll];
	moveOut _NPC;
	unassignvehicle _NPC;
	[_NPC] orderGetIn false;
	_NPC disableAI "ALL";
	_NPC enableAI "ALL";

}];

};
