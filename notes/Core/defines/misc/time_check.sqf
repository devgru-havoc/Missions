/*=======================MMF_fnc_time_check=========CALL============check if it is 7 pm - 4 am
Because sunOrMoon is lame

EXAMPLE:
if (call MMF_fnc_time_check) then {systemChat "NIGHT"} else {systemChat "DAY"}
============================================================*/

	private _time= date select 3;

	if (_time >= 10 && _time <= 16) then {
		//systemChat "DAY";
		false
	} else {
		if ((_time > 16 && _time <= 19) || (_time >= 4 && _time < 10)) then {
			//systemChat "MORNING, EVENING";
			false
		} else {
			//systemChat "NIGHT";
			true
		}
	}