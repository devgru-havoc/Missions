/*======MMF_fnc_explosive_ammo======CALL======add explosive ammo EH

make ammo explode on impact

EXAMPLE: (unit init)

this call MMF_fnc_explosive_ammo

=====================================================================*/

_this setVariable ["explosive_ammo", true];
_this addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	if !(_unit getVariable ["explosive_ammo", false]) exitWith {_unit removeEventHandler ["Fired", _thisEventHandler]};
	if (_unit getVariable ["weapon_waiting", false]) exitWith {false};
	_unit setVariable ["weapon_waiting", true];
	[_unit, _projectile] spawn {		params ["_unit", "_projectile"];

		private _pos=	[0,0,0];
		private _speed = speed _projectile;

		while {sleep 0.02; speed _projectile == _speed && alive _projectile  } do {_pos = position _projectile};

		if (alive _projectile) then {_projectile setVelocity [0,0,0]};

		if (	_pos distance _unit > 10	) then {
			"SmallSecondary" createVehicle _pos
		};
		_unit setVariable ["weapon_waiting", false];
	}
}]