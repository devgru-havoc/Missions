/*======MMF_fnc_ppEffect======CALL======add post-processing screen effects

Add screen effects

_type		string			Effect name: "BLUR", "CHROM", "INVER", "COLOR"
_time		number	*optional	Time (in seconds) to display effect- default 0

*/


params[["_type", "NONE", [""]], ["_time", 0, []]];

if (_type isEqualTo "NONE") exitWith {false};

if (_type isEqualTo "BLUR") then {
	MMF_effect = ["RadialBlur", 100, [0.01, 0.01, 0.06, 0.06], -1, _time]
};

if (_type isEqualTo "CHROM") then {
	MMF_effect = ["ChromAberration", 200, [0.05, 0.05, true], -1, _time]
};

if (_type isEqualTo "INVER") then {
	MMF_effect = ["ColorInversion", 2500, [0.5, 0.5, 0.5], -1, _time]
};

if (_type isEqualTo "COLOR") then {
	MMF_effect = ["ColorCorrections", 1500, [1, 0.4, 0, [0, 0, 0, 0], [1, 1, 1, 0], [1, 1, 1, 0]], -1, _time]
};

MMF_effect spawn {
	params ["_name", "_priority", "_effect", "_handle", "_time"];

	_handle = ppEffectCreate [_name, _priority];
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 1;

	waitUntil {ppEffectCommitted _handle};

	if !(_time==0) then {
		uiSleep _time;
		_handle ppEffectEnable false;
		ppEffectDestroy _handle;
	};
missionNameSpace setVariable ["MMF_ppe_effect", _handle];
_handle

};

