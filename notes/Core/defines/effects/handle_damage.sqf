/*======MMF_fnc_handle_damage======CALL======Add damage EH for NPCs and Players

_this is calling unit

EXAMPLE:
this call MMF_fnc_handle_damage

*player and units spawned from automatic features may have this enabled/disabled in initialization files
*if enabled in initialization files will apply to editor placed units

*/

MMF_wound_state= {

private		_wh = "GroundWeaponHolder_Scripted" createVehicle position _this;
		_this action ["PutWeapon", _wh, currentWeapon _this];
		_this call MMF_capture_actions;
		_this setUnconscious true;
		_this setCaptive true;
		_this spawn {
			if !((faction _this) == (faction (allplayers select 0))) then {removeAllWeapons _this};
			while { sleep 1; lifeState _this isEqualTo "INCAPACITATED"} do {
			sleep 8;
			_this say3D (selectRandom ["woundedGuyA_06", "woundedGuyA_07", "woundedGuyA_08"]);
			_this setDamage ((damage _this)+ 0.1);
			};
		}
};


MMF_surrender_state= {
if ((faction _this) == (faction (allplayers select 0))) exitWith {false};
		_this setVariable ["MMF_surrender", true];
		_this setCaptive true;
		_this disableAI "All";

private		_wh = "GroundWeaponHolder_Scripted" createVehicle position _this;
		_this action ["PutWeapon", _wh, currentWeapon _this];

		_this spawn {
			sleep 1;
			if (alive _this) then {
				[_this, ""] remoteExec ["switchMove", 0];
				_this action ["surrender", _this];
				_this call MMF_capture_actions
			} else {false};
		}
};


MMF_capture_state={
	_this setVariable ["MMF_surrender", false];
	_this setVariable ["MMF_captured", true];

if ((faction _this) == (faction (allplayers select 0))) exitWith {false};

	[_this, "Acts_AidlPsitMstpSsurWnonDnon04"] remoteExec ["switchMove", 0];
	removeAllWeapons _this;
	removeBackpackGlobal _this;
	{	_this unlinkItem _x	}forEach [(goggles _this), (headgear _this), (hmd _this)];
};

MMF_state_release={
		_this setUnconscious false;
		_this setCaptive false;
		_this enableAI "ALL";

private 	_pos= nearestObjects [_this, ["weaponHolderScripted"], 100];
	if (_pos isEqualTo []) exitWith {	false	};
		_this action ["rearm", (_pos select 0)]
};

if (_this in allPlayers) then {
//===========================================capture actions

MMF_capture_actions={
[_this, "<t color='#208040'>CAPTURE UNIT</t>",
"a3\modules_f\data\iconlock_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"alive _target && {!((faction _target) == (faction _this))} && {(_target distance _this) <4}", "isNull objectParent _this", {}, {}, {
	params ["_target", "_caller", "_actionId", "_arguments"];
		_target removeAction _actionId;

		if (lifeState _target isEqualTo "INCAPACITATED") then {
			[_target, "revive_secured"] remoteExec ["switchMove", 0];
		}else{
			_target call MMF_capture_state;
		};

		[_caller, 0, 1] call MMF_fnc_account;
		_caller sideChat "Captive Secured";
	private _arr= _caller getVariable ["MMF_capture_list", []];
	private _arr = [_arr, [], {damage _x}, "ASCEND",{alive _x}] call BIS_fnc_sortBy;
		_arr pushBack _target;
		_caller setVariable ["MMF_capture_list", _arr];

}, {}, [], 5, 12, false, false, true] call BIS_fnc_holdActionAdd;


[_this, "<t color='#208040'>ASSIST UNIT</t>",
"a3\ui_f\data\igui\cfg\revive\overlayicons\r100_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"alive _target && {(faction _target) == (faction _this)} && {(_target distance _this) <4}", "isNull objectParent _this", {}, {}, {
	params ["_target", "_caller", "_actionId", "_arguments"];
		_target removeAction _actionId;
		_target call MMF_state_release;
		_target sideChat "Thanks!";

}, {}, [], 5, 12, false, false, true] call BIS_fnc_holdActionAdd;

};

//=======================================================================players

_this setVariable ["MMF_handle_damage", true];		//controller

_this addMPEventHandler ["MPHit", {
	params ["_unit", "_causedBy", "_damage", "_instigator"];
	if !(local _unit || _unit == player) exitWith {false};
	["CHROM", 0.5] call MMF_fnc_ppEFFECT;
}];

_this addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
if !(_unit getVariable ["MMF_handle_damage", false]) exitWith {_damage};
if !(_projectile isEqualTo "") then {0};
}];

} else {
//=======================================================================NPCs

_this setVariable ["MMF_handle_damage", true];		//controller

_this addMPEventHandler ["MPHit", {
	params ["_unit", "_causedBy", "_damage", "_instigator"];

	_unit removeMPEventHandler ["MPHit", _thisEventHandler];

	if (!(_unit getVariable ["MMF_handle_damage", false]) || (!isNull objectParent _unit)) exitWith {false};
		_unit setVariable ["MMF_handle_damage", false];
	if ((_damage >0.4 || _instigator distance _unit >30)) then {
		if (_instigator in allPlayers || !(faction _instigator isEqualTo faction _unit)) exitWith {_unit call MMF_wound_state}
	} else {
		if ((round random 10)>6) then {
			if (_instigator in allPlayers || !(faction _instigator isEqualTo faction _unit)) exitWith {_unit call MMF_surrender_state}
		}
	}
}];

_this addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
	if (_damage >=1) exitWith {_damage};
	if (!(_unit getVariable ["MMF_handle_damage", false]) || (!isNull objectParent _unit)) then {_damage} else {0};
}];


};

_this