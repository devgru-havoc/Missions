/*======MMF_fnc_flare_event======SPAWN======Continuously spawn flares

spawn colored flares on interval in area

[] spawn MMF_fnc_flare_event
[some_object, "WHITE", 20, [0, 200, 300]] spawn MMF_fnc_flare_event
[player, "WHITE", 20, [round random 200, round random 200, (round random 100) +100]] spawn MMF_fnc_flare_event

*/



params [["_pos", player], ["_color", "red"], ["_time", 30], ["_area", [0,100,200]]];

	missionNameSpace setVariable ["do_flares", true];

	private	_flr = (format ["F_40mm_%1", _color]) createvehicle (_pos ModelToWorld _area); 
		_flr setVelocity [0,0,-10];
		_this spawn {	params [["_pos", player], ["_color", "red"], ["_time", 30], ["_area", [0,100,200]]];
				sleep _time;
				if (missionNameSpace getVariable ["do_flares", false]) exitWith {_this spawn MMF_fnc_flare_event}
		};
_flr