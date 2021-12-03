/*======MMF_fnc_fire_at======CALL======Force a unit (or gunner) to fire at target

_unit			object	unit to fire		(can be vehicle gunner)
_target			array	target to hit		(can be unit, vehicle, object (building, etc.))
_type			*bool*	*optional* 	type of fire: default (false) secondary weapon (launcher)

returns: true if target found in range (500 m), otherwise false

note:
	*vehicles have unlimited range
	*target may be showObject false
	*target may be allowDamage false
	*target may be friendly to unit

example:
Vehicle or Unit
[test_shooter, test_target] call MMF_fnc_fire_at

Unit primary fire
[test_shooter, test_target, true] call MMF_fnc_fire_at

*/

params [["_unit", objNull, []], ["_target", [objNull], []], ["_type", false, []]];

_unit setVariable ["fire_at", true];	//controller

if !(_unit getVariable ["scripted_fire", false]) then {

	_unit setVariable ["scripted_fire", true];

	_unit addeventhandler ["FiredMan",{
    		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
    		_unit addItemToBackpack _magazine
	}];

	(objectParent _unit) addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}]
};

private _gun_cycle={	params [["_unit", objNull, []], ["_target", [objNull], []], ["_type", false, []]];

	while {_unit getVariable ["fire_at", false]} do {
		private _target= selectRandom _target;
		if (isNull objectParent _unit && _unit distance _target> 500) exitWith {_unit sideChat "Target out of range!"};

		if (isNull objectParent _unit) then {
			_unit setUnitPos "MIDDLE";
			_unit dotarget _target;
			if !(_type) then {
				_unit forceWeaponFire [(secondaryWeapon _unit), "Single"]
			}else{
				sleep (round random 3)+1;
				_unit forceWeaponFire [(primaryWeapon _unit), "Single"]
			}
		} else {
			_unit doSuppressiveFire _target;
			sleep 1;
			_unit fireAtTarget [_target];
			sleep (round random 9) +4;
		//systemChat "volley";
		}
	};
	_unit setUnitPos "AUTO";
	_unit doWatch objNull;
	_unit sideChat "Target Destroyed";
};

_this spawn _gun_cycle;

true
