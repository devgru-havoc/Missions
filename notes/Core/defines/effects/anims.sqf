/*======MMF_fnc_anims======CALL======animate units
_caller			unit		unit to animate
_currentState 		string		behaviour state-- must be "SAFE" to animate any other state will end animation
_arr 			array		array from which to select animations (mmf_anims is preconfigured in MMF_core/defines/start/start_default)
_thisMove 		number		selection (by number) from _arr

returns: true

example call:
	[_npc, "SAFE", MMF_anims, 9] call MMF_fnc_anims
*/


params	[["_caller", player], ["_currentState", "SAFE"], ["_arr", []], ["_thisMove", 0]];

if (_currentState=="SAFE") then {
	if !(_caller in allPlayers) then {_caller disableAI "ALL"};
	[_caller, (_arr select _thisMove)] remoteExec ["switchMove", 0];
} else {
	_caller enableAI "ALL";
	[_caller, ""] remoteExec ["switchMove", 0];
};

true