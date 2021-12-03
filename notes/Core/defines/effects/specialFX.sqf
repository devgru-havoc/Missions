
/*======MMF_fnc_specialFX======CALL======create various effects
_caller					object treated as center
_num					number of wrecks to spawn
_area					(number) area to spawn in
_arr					array to save objects in
_type					array [type string (see types), number (0-4): vehicle selection (from MMF_wreck)]
_doBomb					(bool) spawn explosion

types:	"WRECKFIRE", "WRECKSMOKE", "WRECKCOLOR", "FIRE", "COLOR", "SMOKE"

returns: true

example call: (see bottom for more examples)
	bomb
	[player, 1, 100, [], ["NONE", []], true] spawn MMF_fnc_specialFX
	flaming wreck
	[player, 1, 100, [], ["WRECKFIRE", []], false] spawn MMF_fnc_specialFX
	wreck
	[player, 1, 100, [], ["WRECK", []], false] spawn MMF_fnc_specialFX
*/

if !(isServer) exitWith {false};

params [["_caller", objNull, [objNull]], ["_num", 1, [0]], ["_area", 100, [0]], ["_arr", [], []], ["_type", ["SMOKE", ["Land_wreck_offroad2_f"]], [["",0]]], ["_doBomb", false, [false]]];

for "_i" from 1 to _num do {
private _pos = [_caller, _area *0.5, _area, 3, 0, 20, 0] call BIS_fnc_findSafePos;

if (_doBomb) then {
	"HelicopterExploBig" createVehicle _pos;
};

if !(_type select 0 isEqualTo "NONE") then {
	if (_type select 0 isEqualTo "WRECK" || _type select 0 isEqualTo "WRECKFIRE" || _type select 0 isEqualTo "WRECKSMOKE" ||  _type select 0 isEqualTo "WRECKCOLOR") then {
		private _veh= createVehicle [(selectRandom (_type select 1)), _pos, [], 0, "CAN_COLLIDE"];
		_veh setdir (random 360);
		_arr pushback _veh;
	};

	if (_type select 0 isEqualTo "FIRE" || _type select 0 isEqualTo "WRECKFIRE") then {
		private _fire= createVehicle ["test_EmptyObjectForFireBig", _pos, [], 0, "CAN_COLLIDE"];
		[_fire, _arr] call MMF_fnc_lightEffect;
		_arr pushback _fire;
	};

	if (_type select 0 isEqualTo "SMOKE" || _type select 0 isEqualTo "WRECKSMOKE") then {
		private _smoke= createVehicle ["test_EmptyObjectForSmoke", _pos, [], 0, "CAN_COLLIDE"];
		_arr pushback _smoke;
	};

	if (_type select 0 isEqualTo "COLOR" || _type select 0 isEqualTo "WRECKCOLOR") then {
		private _color= createVehicle ["SmokeShellGreen_Infinite", _pos, [], 0, "CAN_COLLIDE"];
		_arr pushback _color;
	};
};

};

_arr



/*======================================================more examples--> object init
	//car bomb
call {
	this spawn {waitUntil {sleep 3; player distance _this < 20};
		[_this, 1, 1, [], ["NONE", []], true] spawn MMF_fnc_specialFX;
		_this setDamage 1;
	}
}

	//random area bombing continuous
call {
	missionNameSpace setVariable ["MMF_bomb_run", true];
	this spawn {
		while {sleep ((round random 10)+1); MMF_bomb_run} do {
			[_this, 1, 100, [], ["NONE", []], true] spawn MMF_fnc_specialFX
		}
	}
}

	//flaming wreck 3 in 300 m
call {
	[this, 3, 300, [], ["WRECKFIRE", ["Land_wreck_offroad2_f"]]] spawn MMF_fnc_specialFX
}


	//object fire
call {
	[this, 1, 1, [], ["FIRE", []]] spawn MMF_fnc_specialFX
}

	//object smoke, save the array
call {
	my_smoke_arr=[];
	[this, 1, 1, my_smoke_arr, ["SMOKE", []]] spawn MMF_fnc_specialFX
}

*/
