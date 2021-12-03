/*======mmf_fnc_addIR======CALL======addIR beacon to units
_grp is calling group

returns _grp

example call:
	[] call MMF_fnc_addIR
	[group this] call MMF_fnc_addIR

to remove lights,
{deleteVehicle (_x getVariable ["MMF_IRlight", objNull])} forEach units _grp

*/


params [["_grp", group player]];

{
	private _IRLight = "NVG_TargetC" createVehicle [0,0,0];
	_x setVariable ["MMF_IRLight", _IRlight];
	_IRLight attachTo [_x, [0,-0.03,0.07], "LeftShoulder"];

	_x addEventHandler ["Killed", {deleteVehicle ((_this select 0) getVariable ["MMF_IRlight", objNull])}];
	_x addEventHandler ["GetInMan", {deleteVehicle ((_this select 0) getVariable ["MMF_IRlight", objNull])}];
	_x addEventHandler ["GetOutMan", {
		private _IRLight = "NVG_TargetC" createVehicle [0,0,0];
		(_this select 0) setVariable ["MMF_IRLight", _IRlight];
		_IRLight attachTo [(_this select 0), [0,-0.03,0.07], "LeftShoulder"];
	}];

} forEach units _grp;

_grp
