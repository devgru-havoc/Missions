/*======MMF_fnc_obj_move======CALL====== Move object back and forth on linear path

_object			object		prop to move
_dir			number		direction to move	1=E/W, 0=N/S
_speed			number		speed to move object	0.01=slow, 0.05=fast
_dist			number		distance from start to move before returning

Returns: End position (array)

EXAMPLE:
[this] call MMF_fnc_obj_move

EXAMPLE: move object quickly E/W for 10 m, return end position
private _endPos=[_this, 1, 0.05, 10] call MMF_fnc_obj_move;
systemChat str _endPos

=================================================================================*/

params [["_object", objNull], ["_dir", 0], ["_speed", 0.01], ["_dist", 10]];

_object setVariable ["target_move", true];
private _pos= ((getPos _object) select _dir) +_dist;

_this spawn {	params [["_object", objNull], ["_dir", 0], ["_speed", 0.01], ["_dist", 10]];

	private _travel_pos= ((getPos _object) select _dir) +_dist;
	private _defPos= (getPos _object) select _dir;
	while {_object getVariable ["target_move", false]} do {
		if ((getPos _object) select _dir< _travel_pos) then {
			while {(getPos _object) select _dir< _travel_pos} do{
				if (_dir==0) then {
					_object setPos [(getPos _object select 0)+_speed, (getPos _object select 1)];
					sleep 0.02
				}else{
					_object setPos [(getPos _object select 0), (getPos _object select 1)+_speed];
					sleep 0.02
				}
			}
		}else{
			while {(getPos _object) select _dir> _defPos} do{
				if (_dir==0) then {
					_object setPos [(getPos _object select 0)-_speed, (getPos _object select 1)];
					sleep 0.02
				}else{
					_object setPos [(getPos _object select 0), (getPos _object select 1)-_speed];
					sleep 0.02
				}
			}
		}
	}
};
_pos