/*======MMF_fnc_blackOut======CALL======blackout lights in area

object nameSpace variables:
"MMF_light_DAM"
bool			if true object must be destroyed to turn lights off; if false (default) lights go off immediately
*if object is hidden nearest building is used instead
*if true (alternative syntax) remove action after use

"MMF_light_RAD"
Number			Radius of lights to affect, default is 10

"MMF_light_ACT" (alternative syntax)
bool	optional	default true, must be true for action to be shown

=================================EXAMPLE 1: Turn off lights in 10 m
this call MMF_fnc_blackOut;

=================================EXAMPLE 2: toggle lights every 3 seconds in 10 m
null=this spawn {
	waitUntil {sleep 3;
		if (missionNameSpace getVariable ["toggle_lights", true]) then {
			_this call MMF_fnc_blackOut;
			false
		} else {true}
	}
};

=================================EXAMPLE 3: Turn off lights in 100 m when object is damaged
*if object is hidden then nearest building is used!
this setVariable ["MMF_light_DAM", true];
this setVariable ["MMF_light_RAD", 100];
this call MMF_fnc_blackOut;


Alternate syntax======================Add actions to object for blackout and/or restore power
_caller		object		unit/object to add action
_action		bool		true= power on, false= power off
_title		string		action title displayed to player
_alt		array		*optional	array of alternative objects to add action

==================================EXAMPLE 4: (alternate syntax) Create "Power On" and "Power Off" actions on object for lights in 10 m
[this, true, "POWER ON"] call MMF_fnc_blackOut;
[this, false, "POWER OFF"] call MMF_fnc_blackOut;

==================================EXAMPLE 5: Create power switch on 2 alternative objects
[this, true, "POWER ON", [alt_power_0, alt_power_1]] call MMF_fnc_blackOut;
[this, false, "POWER OFF", [alt_power_0, alt_power_1]] call MMF_fnc_blackOut;


====================================function========================================*/


mmf_toggle_power={
	params [["_caller", objNull], ["_area", 10], ["_state", "OFF"]];
	{
		[_x, _state] remoteExec ["switchLight",0,true]
	} forEach (nearestObjects [_caller, [], _area])
};

if !(_this isEqualType []) exitWith {
	private _area= _this getVariable ["MMF_light_RAD", 10];

	if (_this getVariable ["MMF_light_DAM", false]) exitWith {

		private _buildingARR=[objNull,_this];
		if (isObjectHidden _this) then {
			_buildingARR= nearestObjects [_this, ["House", "Building"], _area];
			_buildingArr = [_buildingARR, [], {_x distance _this}, "ASCEND"] call BIS_fnc_sortBy
		};

		[_this, (_buildingArr select 1), _area] spawn {

			waitUntil {sleep 0.5; damage (_this select 1) >0.6};
			[(_this select 0), (_this select 2), "OFF"] call MMF_toggle_power
		}
	};

	private _objects= nearestObjects [_this, [], _area];
	_objects = [_objects, [], {_x distance _this}, "ASCEND",{!(lightIsOn _x isEqualTo "ERROR") && !(_x isKindOf "MAN")}] call BIS_fnc_sortBy;
	[_objects, _area] spawn {
		{
			private _state= lightIsOn _x;
			if !( _state isEqualTo "OFF") then {
				[_x, "OFF"] remoteExec ["switchLight",0,true]
			} else {
				[_x, "ON"] remoteExec ["switchLight",0,true]
			}
		}forEach (_this select 0)
	}
};


params [["_caller", objNull], ["_action", false], ["_title", "POWER OFF"], ["_alt", []]];

if (_alt isEqualTo []) then {_alt pushback _caller};

private _area= _caller getVariable ["MMF_light_RAD", 10];

{//open forEach _alt
	_x setVariable ["MMF_light_ACT", true];
	if !(_action) then {
//=================================================power off
		[_x, _title,
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"_target getVariable ['MMF_light_ACT', false] && _target distance _this < 3", "alive _this", {}, {}, {
			params ["_target", "_caller", "_actionId", "_arguments"];

			if (_target getVariable ["MMF_light_DAM", false]) then {
				_target removeAction _actionID
			};
			[_target, (_arguments select 0), "OFF"] call MMF_toggle_power

		}, {}, [_area], 2, 0, false, false, false] call BIS_fnc_holdActionAdd
	}else{
//=================================================power on
		[_x, _title,
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"_target getVariable ['MMF_light_ACT', false] && _target distance _this < 3", "alive _this", {}, {}, {
    			params ["_target", "_caller", "_actionId", "_arguments"];
			if (_target getVariable ["MMF_light_DAM", false]) then {
				_target removeAction _actionID
			};
			[_target, (_arguments select 0), "ON"] call MMF_toggle_power

		}, {}, [_area], 2, 0, false, false, false] call BIS_fnc_holdActionAdd
	}
}forEach _alt
