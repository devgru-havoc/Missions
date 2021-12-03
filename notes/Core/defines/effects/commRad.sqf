/*======MMF_fnc_commRad======CALL======Plays random radio chatter on object

_sounds			*optional*	array of sounds (strings)	default: ambient radio noises

**nameSpace variable "MMF_radioSound" false will stop radio repeating

example 1)
	[] call MMF_fnc_commRad

example 2)
	[["UAV_01", "UAV_02", "RadioAmbient8", "RadioAmbient2"]] call MMF_fnc_commRad
*/



params [["_caller", player], ["_sounds", []]];

_caller setVariable ["MMF_radioSound", true];
if (!alive _caller) exitWith {false};

private _comm_rad= {	params ["_arr", "_caller", "_track"];
	private _sound =playSound _track;
	waitUntil {sleep 1; (isNull _sound) || (!alive _caller) || !(_caller getVariable ["MMF_radioSound", false]) };
	if (!(_caller getVariable ["MMF_radioSound", false]) || (!alive _caller) ) exitWith {deleteVehicle _sound};
	sleep (round random 8)+2;
	[_caller, _arr] call MMF_fnc_commRad
};

if (_sounds isEqualTo []) then {
	private _radio = (configFile >> "CfgSounds") call BIS_fnc_getCfgSubClasses;
	private _radio = [_radio, [], {!(_x=="")}, "ASCEND",{(toLower(str _x) find "radioAmbient") >= 0}] call BIS_fnc_sortBy;
	private _track= selectRandom _radio;

	_handle =[_radio, _caller, _track] spawn _comm_rad
} else {
	private _track= selectRandom _sounds;
	_handle =[_sounds, _caller, _track] spawn _comm_rad
}


