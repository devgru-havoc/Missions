params	[["_caller", player]];

private _campData = _caller getVariable ["MMF_campData", [player, false]];

null= [_caller, "<t color='#208040'>PLACE CAMP</t>",
"a3\modules_f\data\iconsector_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",

"!(_this getVariable 'MMF_campData' select 1) && {isTouchingGround _this} && {isNull objectParent _this}", "(lifeState _this) != 'INCAPACITATED' ",{},{}, {
	private _campData=_caller getVariable "MMF_campData";
	private	_helper= createVehicle ["Land_ClutterCutter_large_F",_caller,[],0,"can_collide"];
	createMarker ["CAMP", _helper];
	"CAMP" setMarkerShape "ELLIPSE";
	"CAMP" setMarkerSize [80, 80];
	_caller setVariable ["MMF_campData", [ _helper, true]];
	[true, _caller, _helper] call MMF_fnc_BASEService;
	["MMF_campTask", "Camp", _helper, "Assigned", group _caller] call MMF_fnc_tasker;

},{},[],2,0,false,true] call BIS_fnc_holdActionAdd;
