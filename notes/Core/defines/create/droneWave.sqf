/*
Spawn waves of bomb laden drones to 50 m target area
*drones will make multiple passes on target if unsuccessful

"_caller"		unit to stalk
"_target"		(object) defines 50 m  target area
"_arr" 			array of drone starting locations and may be operators (instead of helpers)
"_size"			* optional-- size of explosion "small", "big" -- default "big"
"_type" 		* optional-- aircraft class string-- default "O_UAV_01_f"

returns: true

example call:
[_targetObj, _targetObj, [_spawn_0, _spawn_1, _spawn_2 ]] call MMF_fnc_droneWave;

*/

if !(isServer) exitWith {false};

	params [["_caller", player, []],  ["_target", objNull, []], ["_arr", [], []], ["_size", "big", []], ["_type", "O_UAV_01_f", []]];

	private		_height=10;		//flyInHeight
			MMF_drone_arr=[];

	private _warHead={
			private _failsafe= diag_tickTime+180;
			waitUntil {sleep 3; ((_this select 0) distance (_this select 1))< 50 || {!alive (_this select 0)} || {diag_tickTime>_failsafe}};

			if (!alive (_this select 0)) exitWith {false};
					(_this select 0) setDamage 1;
				sleep (round random 3) +3;
			private 	_package= (format ["HelicopterExplo%1", (_this select 2)]) createVehicle position (_this select 0);
		};

	private _EH={
				_this addMPEventHandler ["MPKilled", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					if (_killer in allPlayers) then {_killer sideChat "Drone eliminated!"};
				}];

				_this addEventHandler ["EpeContact", {
					params ["_object1", "_object2", "_selection1", "_selection2", "_force"];
					_object1 removeEventHandler ["EpeContact", _thisEventHandler];
					_object1 setDamage 1;
				}];
		};


		for "_i" from 0 to (count _arr) -1 do {

		private 	_pos= position (_arr select _i);
		private		_veh= createVehicle [_type, _pos,[],0, "FLY"];
		private		_grp=	createVehicleCrew _veh;
				_veh call _EH;
				[_grp, group _caller] spawn BIS_fnc_stalk;

				_veh flyInHeight _height;
				_veh flyInHeightASL [_height, _height, _height];
				MMF_drone_arr pushBack _veh;

				[_veh, _target, _size] spawn _warHead
		};
true