/*

WIP do not use

*/


params [["_caller", player]];

if (isMultiplayer) exitWith {false};

_caller setVariable ["MMF_spawn_loot", true];			//controller

waitUntil {sleep 1; !((nearestObjects [_caller, ["House", "Building"], 100]) isEqualTo []) && isNull objectParent _caller};

private _buildingARR= nearestObjects [_caller, ["House", "Building"], 100];
private _arr =[];


	_buildingARR = [_buildingARR, [], {_x distance _caller}, "ASCEND",{count (_x buildingPos -1) > 1}] call BIS_fnc_sortBy;

if !(_buildingArr isEqualTo []) then {

	if (count _buildingArr > 2) then {		//unit hax

		private _grp= [objNull, objNull, 1, INDEPENDENT, (selectRandom (MMF_IND select 0)), "CARELESS"] call MMF_fnc_soldiers;
		[_grp, (_buildingArr select 2), 100] call MMF_fnc_garrison;

		{

			_x setDamage 1;
			_arr pushBack _x

		}forEach units _grp;


		private _pos_arr= [(_buildingArr select 1)] call BIS_fnc_buildingPositions;
		private _side = selectRandom ["IND", "EAST", "NATO"];
		private _type = selectRandom ["ammo", "wps", "ammoOrd", "grenades", "wpsLaunch", "wpsSpecial", "uniforms"];
		private _box= createVehicle [(format ["Box_%1_%2_f", _side, _type]), (selectRandom _pos_arr), [], 1, "CAN_COLLIDE"];

		_box setPos (_box modelToWorld [0,0,0.5]);
		_box allowDamage false;
		_arr pushBack _box;
	};

};




//============================cycle
	private _pos= position _caller;
	waitUntil {sleep 1; _caller getVariable ["MMF_spawn_loot", false] && _caller distance _pos >50};
	
		{deleteVehicle _x} forEach _arr;
		if !(_caller getVariable ["MMF_spawn_loot", false]) exitWith {true};
		[_caller] spawn MMF_fnc_loot_spawn;
//systemChat "updated loot";




























/*==========================================random experiments
private _arr=[];
private _loot_arr=[];
//private _pos_arr=[];
private _type = _caller getVariable "MMF_side" select 3;
private	_box = _type createVehicle [0,0,0];

{
	_loot_arr pushBackUnique _x
} forEach ((itemCargo _box) + (weaponCargo _box) + (magazineCargo _box) + (backpackCargo _box));

deleteVehicle _box;


//==================================================random loot
private _buildingARR= nearestObjects [_caller, ["House", "Building"], 100];

if !(_buildingArr isEqualTo []) then {

	_buildingARR = [_buildingARR, [], {_x distance _caller}, "ASCEND",{count (_x buildingPos -1) > 1}] call BIS_fnc_sortBy;

	private _pos_arr= [(_buildingArr select 0)] call BIS_fnc_buildingPositions;

	for "_i" from 0 to 1 do {
		private _holder = "WeaponHolderSimulated_scripted" createVehicle (selectRandom _pos_arr);

		_holder addItemCargoGlobal [ (selectRandom _loot_arr), 1];
		_holder setPos (_holder modelToWorld [0,0,0.5]);
		_arr pushBack _holder;
	}
};

*/

