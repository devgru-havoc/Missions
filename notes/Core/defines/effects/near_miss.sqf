/*=========================MMF_fnc_near_miss===================spawn missile============CALL
_start		number		negative to create missile behind target, positive to create missile in front		default -300
_height		number		altitude to create missile								default 5
_target		object		target object for near miss								default player
_type		string		missile classname (must be steerable)							default "M_Scalpel_AT"

EXAMPLE 1:
private _missile= [500, 5, player, [1, 1]] call MMF_fnc_near_miss;
systemChat str _missile;

EXAMPLE 2:
null= [] spawn {
	waitUntil {sleep 1;
		if (missionNameSpace getVariable ["missile_storm", true]) then {
			[((random 300)+300)*(selectRandom [1, -1])]call mmf_fnc_near_miss;
			sleep 3;
			false
		} else {true}
	}
}			
========================================================================*/

params [	["_start", -300], ["_height", 5], ["_target", (allPlayers select 0)], ["_offset", [20, (random 10)+10]], ["_type", "M_Scalpel_AT"]];

	private _missile = createVehicle [
		_type,
		[
			(_target getRelPos [_start, (random 10)+10]) select 0,
			(_target getRelPos [_start, (random 10)+10]) select 1,
			_height
		]
	];

	_missile setDir ([_missile, _target] call bis_fnc_dirTo);

	if (isTouchingGround _target) then {
		_missile setMissileTargetPos [ 		
			(_target getRelPos _offset) select 0,
			(_target getRelPos _offset) select 1,
			100
		];

		[_missile, _target, _offset] spawn {sleep 1;
			(_this select 0) setMissileTargetPos [ 		
				((_this select 1) getRelPos (_this select 2)) select 0,
				((_this select 1) getRelPos (_this select 2)) select 1,
				(getPosATL (_this select 1)) select 2
			];
		}
	}else{
		_missile setMissileTargetPos [ 		
			(_target getRelPos _offset) select 0,
			(_target getRelPos _offset) select 1,
			(getPosATL _target) select 2
		];
	};

_missile

