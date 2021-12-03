/*======MMF_fnc_colorSpace======CALL====== applies color correction based on time of day

returns: true

**changes at 05:00, 10:00, 16:00, 19:00
**must be called for changes to take affect

example call:
	[] call MMF_fnc_colorSpace
*/

[]spawn {	waitUntil {time > 0};
	private _time=date select 3;

	if (_time >= 10 && _time <= 16) then {
		you_effect = ["ColorCorrections", 1500,
		[0.88, 0.88, 0.002, [0.2, 0.29, 0.4, -0.22], [1, 1, 1, 1.3], [0.15, 0.09, 0.09, 0.0]]]
	} else {
		if ((_time > 16 && _time <= 19) || (_time >= 5 && _time < 10)) then {
			you_effect = ["ColorCorrections", 1500,
			[ 0.9, 0.88, 0.002, [-0.11, -0.65, -0.76, 0.015],[-5, -1.74, 0.09, 0.86],[-1.14, -0.73, 1.14, -0.09]]]
		} else {
			you_effect = ["ColorCorrections", 1500,
			[1.0, 1.0, 0.0,[0.2, 0.2, 1.0, 0.0],[0.4, 0.75, 1.0, 0.60],[0.5,0.3,1.0,-0.1]]]
		}
	};

	you_effect spawn {
		params ["_name", "_priority", "_effect", "_handle"];

		private	_handle = ppEffectCreate [_name, _priority];
			_handle ppEffectEnable true;
			_handle ppEffectAdjust _effect;
			_handle ppEffectCommit 1;

	}
};

true