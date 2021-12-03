/*
This is an automatic function called by the base object

_openServices 		(bool) true to enter, false to exit
_caller 		base owner
_obj 			base object (can be player)

returns: nothing

**base services require the addActions added by MMF_fnc_base_actions
**MMF_fnc_placeCamp contains addAction for placing camps

example call:
	[true, player, player] call MMF_fnc_baseService
*/


params [["_openServices", true], ["_caller", player], ["_obj", player]];


private _campData=_caller getVariable ["MMF_campData", [player, false]];

if (_openServices) exitWith {

private _obj= _campData select 0;
_caller setVariable ["MMF_inCamp", true];
_caller setVariable ["MMF_object_loc", false];
_caller call MMF_fnc_base_actions;

[_caller, _obj] spawn {
waitUntil{sleep 1; ((_this select 0) distance (_this select 1))> 80 || !((_this select 0) getVariable "MMF_campData" select 1)};

	if ((_this select 0) getVariable "MMF_campData" select 1) then {
		(_this select 0) sideChat "Moving out!";
		(_this select 0) setVariable ["MMF_inCamp", false ];
		[false, _this select 0, _this select 1] call MMF_fnc_baseService;
	}
};

	//do heal
	_caller setHitPointDamage ["hitHead", 0];
	_caller setHitPointDamage ["hitBody", 0];
	_caller setHitPointDamage ["hitArms", 0];
	_caller setHitPointDamage ["hitLegs", 0];
};


if !(_openServices) exitWith {
	private _obj= _campData select 0;
	_caller setVariable ["MMF_object_LOC", false];
	_caller setVariable ["MMF_confirm_LOC", false];
	_caller call MMF_fnc_base_actions;

	[_caller, _obj] spawn {
waitUntil{sleep 1; ((_this select 0) distance (_this select 1))< 80 || !((_this select 0) getVariable "MMF_campData" select 1)};
	if ((_this select 0) getVariable "MMF_campData" select 1) then {
			(_this select 0) sideChat "In base!";
			(_this select 0) setVariable ["MMF_inCamp", true ];
			[true, _this select 0, _this select 1] call MMF_fnc_baseService;
		}
	}
};
