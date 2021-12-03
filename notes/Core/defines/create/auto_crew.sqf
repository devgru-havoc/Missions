/* 

Automatically crew player vehicle (enabled in initplayer local SP startup or called with examples below)

Controller:
this setVariable ["MMF_autoCrew", "ON"]			//delete crew on exit
this setVariable ["MMF_autoCrew", "PER"]		//persist crew on exit
this setVariable ["MMF_autoCrew", "OFF"]		//disable

*extra spawn ground crew

Example:
[player, "PER", player, false] call MMF_fnc_auto_crew

Example:
[(allPlayers select 0), "ON", this, true] call MMF_fnc_auto_crew

*/


params [["_caller", player], ["_type", "OFF"], ["_loc", player], ["_extra", false]];


_caller setVariable ["MMF_autoCrew", _type];
_caller setVariable ["MMF_crew_loc", [_loc, _extra]];

_caller addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	if (_unit getVariable ["MMF_autoCrew", "OFF"] isEqualTo "OFF") exitWith {_unit removeEventHandler ["GetInMan", _thisEventHandler]};

	private _loc= _unit getVariable ["MMF_crew_loc", [objNull, false]];

	if (count (fullCrew _vehicle) <2 && _unit distance (_loc select 0) < 50) then { 
		private	_grp= createVehicleCrew _vehicle;
		_unit setVariable ["auto_crew", _grp];
		if ((_loc select 1) && (_vehicle isKindOf "helicopter" ||_vehicle isKindOf "plane")) then {[_unit] spawn MMF_fnc_ground_crew};
	}
}];

_caller addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	private _type= _unit getVariable ["MMF_autoCrew", "OFF"];

	if (_type isEqualTo "OFF") exitWith {_unit removeEventHandler ["GetOutMan", _thisEventHandler]};
	if (_type isEqualTo "PER") exitWith {true};

	private _grp= _unit getVariable ["auto_crew", grpNull];
	{
		deleteVehicle _x
	} forEach units _grp
}];


