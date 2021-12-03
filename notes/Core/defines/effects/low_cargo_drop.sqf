/*============================low_cargo_drop=====================CALL=======================addAction to deploy cargo
Define the vehicle, cargo type and carry number
Define 'resupply_pos' variable on vehicle (if necessary)

_caller		object		should be vehicle (helicopter)
_load		number		cargo carry number			default: 2
_name		string		display name				default: "Inflatable Boats"
_type		string		vehicle classname to deploy		default: "B_Boat_Transport_01_F"
_light		bool		attach light				default: true

returns: resupply position (object or coordinates)			default: vehicle position

Set variable 'resupply_pos' to any object or position, default= vehicle location
this setVariable ["resupply_pos", object_or_position]

Set variable 'cargo_load' to -1 to remove action
this setVariable ["cargo_load", -1]

Example: basic (init field of vehicle)
[this] call MMF_fnc_low_cargo_drop

Example: full
_supply_loc=[objectParent player, 3, "Cargo", "B_cargoNet_01_ammo_f", false] call MMF_fnc_low_cargo_drop;
systemChat str _supply_loc
===============================================================================================*/


params [["_caller", objNull], ["_load", 2], ["_name", "Inflatable Boats"], ["_type", "B_Boat_Transport_01_F"], ["_light", true]];

if ((_caller getVariable ["resupply_pos", []]) isEqualTo []) then {
	_caller setVariable ["resupply_pos", (getPosATL _caller)];
};

private _action = format ["<t color='#208040'>Drop %1</t>", _name];
private _cargo_action=[_caller, _action,
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
"((getPosATL _this) select 2 < 10 && !isTouchingGround _target) ||
 (surfaceIsWater getPos _this && (getPosASL _this) select 2 < 20) ||
 !(_target isKindOf 'Helicopter')",
"alive _this && speed _this<20", {}, {}, {
	params ["_target", "_caller", "_actionId", "_arguments"];

	private _num= _target getVariable ["cargo_load", 0];
	if (_num==0) exitWith {_caller sideChat (format ["Need more %1", (_arguments select 1)])};
	_target setVariable ["cargo_load", _num -1];
	_caller sideChat (format ["%1 Remaining: %2", (_arguments select 1), _num -1]);
	private _offset=[0,0,0];
	if (_target isKindOf "Helicopter") then {_offset=[-1,1,-4]} else {_offset=[0,-4,0]};
	private _cargo = createVehicle [(_arguments select 0), _target modelToWorld _offset, [], 0, "CAN_COLLIDE"];
	if (_arguments select 2) then {
		private _irstrobe = "NVG_TargetC" createVehicle position _target;
		_irstrobe attachTo [_cargo, [0, 0, -0.5] ];
		_cargo setVariable ["attached_light", _irStrobe];
		_cargo addEventHandler ["GetIn", {
			params ["_vehicle", "_role", "_unit", "_turret"];
			deleteVehicle (_vehicle getVariable ["attached_light", objNull]);
		}]
	}
}, {}, [_type, _name, _light], 2, 0, false, false, false] call BIS_fnc_holdActionAdd;

[_caller, _cargo_action, _load, _name] spawn { params ["_caller", "_action", "_load", "_name"];
	waitUntil {sleep 1;
		if ((_caller getVariable ["cargo_load", 0]) < 0) exitWith {_caller removeAction _action; true};
		if ((_caller distance (_caller getVariable ["resupply_pos", objNull]))> 10) then {false} else {
			if ((_caller getVariable ["cargo_load", 0]) < 1 && {isTouchingGround _caller}) then {
				_caller setVariable ["cargo_load", _load];
				_caller sideChat (format ["%1 Resupplied", _name]);
				false
			} else {false}
		}
	}
};
_caller getVariable ["resupply_pos", []]
