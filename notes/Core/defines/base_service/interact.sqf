params [["_caller", player], ["_interact", false]];

private _obj= cursorObject;
_isBaseObj= _obj getVariable ["MMF_isBaseObj", false];
_isBarObj= _obj getVariable ["MMF_isBarricade", false];

if (!(isNull _obj) && (_isBaseObj || _isBarObj || _obj isKindOf "WeaponHolder")) then {

	if (_interact) then {
		private _distance = _obj distance _caller;
		private _resetPos = getPos _obj;
		private _objDir = getDir _obj;

		_obj enableSimulation false;
		[_obj, _caller] call BIS_fnc_attachToRelative;
		_caller setVariable ["MMF_object_LOC", true];

		while {_caller getVariable ["MMF_object_LOC", false]} do {
_direction = ((acos((ATLtoASL positionCameraToWorld [0,0,1] select 2)-(ATLtoASL positionCameraToWorld [0,0,0] select 2))-90)*-1);
_high = ((tan _direction) * _distance) + 1.45 + ((getPos _caller) select 2);
_obj setPos (_caller modelToWorld [0,_distance,_high]);
		};

		if (_caller getVariable ["MMF_confirm_LOC", false]) then {
			detach _obj;
			_direction= ((acos((ATLtoASL positionCameraToWorld [0,0,1] select 2)-(ATLtoASL positionCameraToWorld [0,0,0] select 2))-90)*-1);
			_high = ((tan _direction) * _distance) + 1.45 + ((getPos _caller) select 2);
			_obj setPos(_caller modelToWorld [0,_distance,_high]);
			_obj enableSimulation true;
		} else {
			detach _obj;
			_obj enableSimulation true;
			_obj setDir _objDir;
			_obj setpos _resetPos;
		}
	} else {
		if !(_obj isKindOf "MAN" || _obj isKindOf "CAR") then {
			deleteVehicle _obj
		} else {
			systemChat "Can't remove that"
		}
	}
};
