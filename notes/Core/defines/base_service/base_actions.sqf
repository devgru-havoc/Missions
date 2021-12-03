/*

addActions assigned to player by Base Services

*/


params [["_unit", player]];

if (_unit getVariable ["MMF_inCamp", false]) then {

	{
		_caller removeAction _x

	}forEach (_caller getVariable ["MMF_exit_actions", []]);

// base actions

private _recruit_action=[ _unit, "<t color='#208040'>RECRUIT</t>",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"(cursorTarget getvariable 'MMF_isRecruit') && {_this distance cursorTarget<5}", "alive cursorTarget", {}, {}, {
	params ["_target", "_caller", "_actionId", "_arguments"];
	cursorTarget removeAction _actionID;
	[cursorTarget] join (group _caller);
	_caller groupChat "Recruit hired";
	cursorTarget setVariable ["MMF_isRecruit", false];
	cursorTarget enableAI "ALL";
	cursorTarget addAction ["Dismiss", {
			params ["_target", "_caller", "_actionId", "_arguments"];
			[_target] join grpNull;
			_target setVariable ["MMF_isRecruit", true];
			_target removeAction _actionID;
	}];
	cursorTarget addEventHandler ["Killed", {removeAllActions (_this select 0)}];
}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;


private _pack_action=[_unit, "<t color='#208040'>PACK CAMP</t>",
"a3\modules_f\data\iconsector_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"_this getVariable 'MMF_inCamp' && {_this getVariable 'MMF_campData' select 1}", "alive _this", {}, {}, {
	private _campData=_caller getVariable "MMF_campData";
		deleteMarker "CAMP";
		deleteVehicle (_campData select 0);
		_caller setVariable ["MMF_campData", [player, false, _campData select 2]];
		_caller setVariable ["MMF_inCamp", false];
		[false, _caller, _campData select 1, _campData select 2] call MMF_fnc_BASEService;
		["MMF_campTask", "Camp", _caller, "SUCCEEDED", group _caller] call MMF_fnc_tasker;
}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;


private _load_action=[ _unit, "<t color='#208040'>LOAD GROUP</t>",
"a3\3den\data\displays\display3den\panelright\modegroups_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"_target getVariable 'MMF_inCamp' && {!isNull objectParent _this} && {side _target != sideEnemy} && {!(_this getvariable ['MMF_hasGroup', false])}", "(speed vehicle _this)<2 && (vehicle _this emptyPositions ""cargo"") > 1", {}, {}, {
	[_caller, [], _caller getVariable ["MMF_side", []] select 0, true] call MMF_fnc_loadGroup;
_caller spawn {
	waitUntil {!(_this getVariable ["MMF_hasGroup", false]) || {!alive _x} forEach units (_this getVariable ["MMF_cargo_grp", grpNull]) || {isNull objectParent _x} forEach units (_this getVariable ["MMF_cargo_grp", grpNull])};
		if (_this getVariable "MMF_hasGroup") then {systemChat "Group deployment cancelled"};
		if ({!alive _x} forEach units (_this getVariable ["MMF_cargo_grp", grpNull])) then {{deleteVehicle _x}forEach units (_this getVariable ["MMF_cargo_grp", grpNull])};
		_this setVariable ["MMF_hasGroup", false];
	};
}, {}, [], 2, 12, false, false, false] call BIS_fnc_holdActionAdd;


private _deploy_action=[_unit, "<t color='#208040'>DEPLOY GROUP</t>",
"a3\3den\data\displays\display3den\panelright\modegroups_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"!isNull objectparent _this && {_this getvariable ['MMF_hasGroup', false]}", "!isNull objectparent _this && {(speed vehicle _this)<5}", {}, {}, {

[_caller, [], [], false] call MMF_fnc_loadGroup;
}, {}, [], 2, 12, false, false, false] call BIS_fnc_holdActionAdd;


private _arsenal_action=[ _unit, "<t color='#208040'>OPEN ARSENAL</t>",
"a3\supplies_f_exp\ammoboxes\data\ui\icon_uniforms_box_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"_target getVariable 'MMF_inCamp' && {isNull objectParent _this}", "alive _this", {}, {}, {

	[ "Open", [ true ] ] call BIS_fnc_arsenal;
}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;


private _repair_action=[_unit, "<t color='#208040'>REPAIR DAMAGE</t>",
"a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_debug_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"_this getVariable 'MMF_inCamp' && {!isNull objectParent _this} && {(getDammage vehicle _this) > 0}", "alive _this", {}, {}, {

	vehicle _caller setDamage 0;
	systemChat "Damage repaired";
}, {}, [], 2, 0, false, false] call BIS_fnc_holdActionAdd;

private _refuel_action=[_unit, "<t color='#208040'>REFUEL</t>",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"_this getVariable 'MMF_inCamp' && {(fuel vehicle _this) < 0.4}", "!isNull objectParent _this", {}, {}, {

	vehicle _caller setFuel 1; systemChat "Fuel Tanks Full";
}, {}, [], 2, 0, false, false] call BIS_fnc_holdActionAdd;

private _wait_action=[_unit, "<t color='#208040'>WAIT 6 HOURS</t>",
"a3\modules_f_curator\data\icontimeacceleration_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"_this getVariable 'MMF_inCamp' && {isnull objectParent _this}", "alive _this", {}, {}, {

	titleText ["Waiting...", "PLAIN", 0.4];
	[]spawn mmf_fnc_skip_time

}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;

private _insertion_action=[_unit, "<t color='#208040'>REQUEST MISSION VEHICLE</t>",
"a3\air_f\heli_light_01\data\ui\map_heli_light_01_armed_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"(_this getVariable ['MMF_inCamp', false]) && {_this getVariable 'MMF_campData' select 1}", "isNull objectParent _this", {}, {}, {

if (_caller getVariable ["MMF_supplyIN", false]) exitWith {_caller sideChat "Air service is busy"};

_caller sideChat "Requesting mission vehicle!";
_caller spawn {

private	_loc= [(_this getVariable "MMF_campData" select 0)];
private _type= _this getVariable "MMF_side" select 2 select 0; 
private _insert= _this getVariable ["MMF_mission_loc", []];
if (_insert isEqualType []) exitWith {_this sideChat "No mission..."};
private _veh=[_this, true, _type, [(_loc select 0), _insert, objNull]] call MMF_fnc_heli_service;
leader (_veh select 1) sideChat "Ready to go!";
(_veh select 0) engineOn true;

 	}

}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;


private _actions=[
	_recruit_action,
	_pack_action,
	_load_action,
	_deploy_action,
	_arsenal_action,
	_repair_action,
	_refuel_action,
	_wait_action,
	_insertion_action
];

_unit setVariable ["MMF_base_actions", _actions];

} else {

	{
		_caller removeAction _x

	}forEach (_caller getVariable ["MMF_base_actions", []]);

//=================================================================extraction

private _extract_action=[_unit, "<t color='#208040'>REQUEST EXTRACTION</t>",
"a3\modules_f_curator\data\iconradio_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"!(_this getVariable ['MMF_inCamp', false]) && {_this getVariable 'MMF_campData' select 1}", "isNull objectParent _this", {}, {}, {

if (_caller getVariable ["MMF_supplyIN", false]) exitWith {_caller sideChat "Air service is busy"};

_caller sideChat "Requesting extraction!";
_caller spawn {
	private	_loc= [(_this getVariable "MMF_campData" select 0)];
	private _type= _this getVariable "MMF_side" select 2 select 0; 
	private _veh= [_this, false, _type, [(_loc select 0), _this, objNull], "FLY"] call MMF_fnc_heli_service;

	private _smoke=[];
	[_this, 1, 1, _smoke, ["COLOR", []], false] call MMF_fnc_specialFX;
	[(_smoke select 0), _this, (_veh select 0)] spawn {
		waitUntil { sleep 1; (objectParent (_this select 1)== (_this select 2))};
		deleteVehicle (_this select 0);
		["MMF_boardingTask", "Board the helicopter", objNull, "SUCCEEDED"] call MMF_fnc_tasker;
	};

	leader (_veh select 1) sideChat "Extraction inbound on your location. Stand by.";

	["MMF_boardingTask", "Board the helicopter", (_veh select 0), "Assigned", group _this] call MMF_fnc_tasker

 	}

}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;

//=================================================================reinforcements
private _reinforcements_action=[_unit, "<t color='#208040'>REQUEST REINFORCEMENTS</t>",
"a3\modules_f_curator\data\iconradio_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"!(_this getVariable 'MMF_inCamp') && {_this getVariable 'MMF_campData' select 1}", "isNull objectParent _this", {}, {}, {

_caller sideChat "Requesting reinforcements at my location, over!";

_caller spawn {
	private	_loc=[(_this getVariable "MMF_campData" select 0), _this, _this];
	private	_type= _this getVariable "MMF_side" select 2 select 0;
	private	_ally= _this getVariable "MMF_side" select 0;
	private _grp= [objNull, objNull, 6, side _this, _ally, "AWARE", [], false, false, 0, "MOVE"] call MMF_fnc_soldiers;
	private _veh= [leader _grp, true, _type, [(_loc select 0), _this], "FLY"] call MMF_fnc_heli_service;
	private _smoke=[];
	[_this, 1, 1, _smoke, ["COLOR", []], false] call MMF_fnc_specialFX;

	leader (_veh select 1) sideChat "Reinforcements inbound on your location. Stand by.";
	waitUntil {sleep 1;	(({_x in (_veh select 0)} count (units _grp)) == 0)	};
	uiSleep 10;
	[_grp, getPos _this, 100] call BIS_fnc_taskPatrol;
	deleteVehicle (_smoke select 0);
}

}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;

//=================================================================supply drop
private _supply_action=[ _unit, "<t color='#208040'>REQUEST SUPPLY DROP</t>",
"a3\ui_f\data\map\vehicleicons\iconparachute_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"!(_target getVariable 'MMF_inCamp') && {_this getVariable 'MMF_campData' select 1}", "alive _this", {}, {}, {

	[_caller, true]spawn MMF_fnc_supply_drop;
}, {}, [], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;

//=================================================================deploy group
private _deploy_action=[_unit, "<t color='#208040'>DEPLOY GROUP</t>",
"a3\3den\data\displays\display3den\panelright\modegroups_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"!isNull objectparent _this && {_this getvariable 'MMF_hasGroup'}", "!isNull objectparent _this && {(speed vehicle _this)<5}", {}, {}, {

[_caller, _caller getVariable "MMF_cargo_grp", [], false] call MMF_fnc_loadGroup;
}, {}, [], 2, 12, false, false, false] call BIS_fnc_holdActionAdd;

//=================================================================airstrike
private _missile_action=[_unit, "<t color='#208040'>REQUEST MISSILE STRIKE</t>",
"a3\modules_f_curator\data\iconordnance_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"!(_this getVariable 'MMF_inCamp') && {isnull objectParent _this} && {_this getVariable 'MMF_campData' select 1}", "!(_this getVariable ['MMF_player_action', false])", {}, {}, {
_caller setVariable ["MMF_player_action", true];
_caller spawn {

	private _pos=[];
	private _arr=[];
	if (isNull cursorTarget) then {
		_pos = screenToWorld [0.5,0.5];
		_pos= [_pos] call MMF_fnc_posHelper;
		_arr pushBack _pos
	}else{
		_pos = cursorTarget
	};

if (_pos distance _this> 100 && _pos distance _this< 2000) then {
	//private _dist= (_pos distance _this)*(selectRandom [-3, 3]);
	private _dist= 200;
	//private _height= ((getPosASL _this) select 2)+50;
	private _height= 200;
	for "_i" from 0 to 3 do {
		private _missile= [_dist, _height, _pos, [1, 1]] call MMF_fnc_near_miss;
		sleep 1;
	};
	
} else {_this sideChat "Target out of range."};

{deleteVehicle _x} forEach _arr;
_this setVariable ["MMF_player_action", false];

}

}, {}, [], 1, 0, false, false, false] call BIS_fnc_holdActionAdd;


private _actions=[
	_supply_action,
	_extract_action,
	_reinforcements_action,
	_deploy_action,
	_missile_action
];

_unit setVariable ["MMF_exit_actions", _actions];
};


