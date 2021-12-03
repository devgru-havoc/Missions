/*

Add hold action to object and toggle nameSpace variable and spawn code

_obj		object		object to use
_action name	string		text to show on action
_code		code		code to spawn when hold action is used
_remove		bool		remove action after use		default false

example (with code)
[this, "USE ME", {systemChat format ["%1 used %2", name (_this select 1), (_this select 0)]}] call MMF_fnc_useThis

example (object init)

call {
	[this, "USE ME"] call MMF_fnc_useThis
	this spawn {
		waitUntil { sleep 1; _this getVariable ["MMF_used", false]};
		hintSilent "used"
	}
};

*/

params [["_obj", objNull], ["_actionNAME", "USE THIS"], ["_code", {}], ["_remove", false]];
_obj setVariable ['MMF_used', false];

private _handle=[_obj, _actionNAME,
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3", "!(_this getVariable ['MMF_used', false])",{},{},
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
			_target setVariable ["MMF_used", true];
			[_target, _caller] spawn (_arguments select 0);
			if (_arguments select 1) exitWith {_target removeAction _actionID};
			_target setVariable ['MMF_used', false];
	},{},[_code, _remove],2,0,false,true] call BIS_fnc_holdActionAdd;

_handle