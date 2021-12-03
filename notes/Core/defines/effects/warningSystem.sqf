/*======MMF_fnc_warningSystem======CALL======gear state controlled warning system

Indicate low speed/altitude for aircraft

_veh		vehicle		vehicle to activate system
_alt		number		desired low altitude	(helicopters use 10 m)
_spd		number		desired low speed	(disabled for helicopters)

*controlled by state of aircraft landing gear
*can use variable to toggle

EXAMPLE:
[vehicle player, 100, 300] call MMF_fnc_warningSystem

VARIABLE:
vehicle player setVariable ["MMF_warnSys", false];

*/

MMF_altWARN= {
	params [["_veh", objNull], ["_alt", 100], ["_spd", 300]];
	while {sleep 0.5; _veh getVariable ["MMF_warnSys", false]} do {
		if (!alive _veh || isNull driver _veh) exitWith {_this setVariable ["MMF_warnSys", false]};
		if !(_veh isKindOf "helicopter") then {

			if (speed _veh < _spd) then {
				titleText ["SPEED UP", "Plain", 0.1];
				sleep 2.5;
			}; 

			if ((getPos _veh select 2) < _alt) then {
				titleText ["WARNING", "Plain", 0.1];
				playSound ["vtolalarm", true];
				sleep 2.5;
				titleText ["ALTITUDE", "Plain", 0.1];
			}
		} else {
			if ((getPos _veh select 2) < 10) then {
				titleText ["WARNING", "Plain", 0.1];
				playSound ["vtolalarm", true];
				sleep 2.5;
				titleText ["ALTITUDE", "Plain", 0.1];
			}
		};
		sleep 0.5
	}
};

(_this select 0) addEventHandler ["Gear", {
	params ["_vehicle", "_gearState"];

	if (!_gearState) then {
		titleText ["SYSTEM ENABLED", "Plain", 0.1];
		_vehicle setVariable ["MMF_warnSys", true];
		_vehicle spawn MMF_altWARN;
	} else {
		titleText ["SYSTEM DISABLED", "Plain", 0.1];
		_vehicle setVariable ["MMF_warnSys", false];
	}

}];