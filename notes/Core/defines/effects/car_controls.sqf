/*======MMF_fnc_car_controls======CALL======start and stop radio automatically

example:

player call MMF_fnc_car_controls
*/


//set default
if (faction _this == "civ_F") then {
	_this setVariable ["MMF_radio_default", MMF_news]
}else{
	_this setVariable ["MMF_radio_default", MMF_ambient]
};


radio_handle_in= _this addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

if (_unit== (driver objectParent _unit)) exitWith {_unit call MMF_music_player}

}];


radio_handle_out= _this addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	playMusic "";
	playSound ["click", true];
	terminate MMF_radio_handle;

}];


