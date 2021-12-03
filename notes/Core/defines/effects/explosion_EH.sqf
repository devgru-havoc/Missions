/*======MMF_fnc_explosion_EH======CALL======Add explosive event handler

create dangerous explosive objects (like barrels)
* works with vehicles, too

EXAMPLE

this call MMF_fnc_explosion_EH

*/


_this addMPEventHandler ["MPHit", {
	params ["_unit", "_causedBy", "_damage", "_instigator"];
	//if !(_instigator in allplayers) exitWith {false};

	if (damage _unit > 0.4) then {
		_unit removeMPEventHandler ["MPHit", _thisEventHandler]; 
		_unit spawn {
			private _emitter = "#particlesource" createVehicle position _this;
			_emitter setParticleClass "MediumDestructionFire";
			sleep ((round random 3) +3);
			"HelicopterExploSmall" createVehicle position _this;
			{
				if !(_x isKindOf "LandVehicle") then {deleteVehicle _x}
			} forEach [_emitter, _this];
		}
	}
}];