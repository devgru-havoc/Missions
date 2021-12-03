/*
wrapper params: _caller (position), returns true when called (this wrapper function initiates all 4 population types)

Shared params;
_caller			object treated as centre
_area			area to populate
_num			number of units/vehicles
_type			array of strings, class names
_arr			array to return

MMF_unitPop special param
_side			units side

returns: bool		true if successful, otherwise false
	*array

**	all functions populate the provided array if any

examples:

traffic,
[player, 500, 5, MMF_civVeh, []] call MMF_vehPop;

civilians,
[player, 100, 5, (selectRandom MMF_civArr), [], CIVILIAN] call MMF_unitPop;

empty vehicles,
[player, 200, 10, MMF_civVeh, []] call MMF_emptyVeh;

ambient civilians (campfires),
[_this, 100, 3, MMF_civArr, []] call MMF_ambientGrp;

TEST CALLS ARE AT THE BOTTOM OF THIS WRAPPER FUNCTION
*/

if !(isServer) exitWith {false};
//===============================================================functions


MMF_traffic_check={

	_this setVariable ["traffic_check", true];

	_this spawn {
		while {sleep 1; _this getVariable ["traffic_check", false]} do {

		private	_sel= [
			(_this modelToWorld [0, ((boundingBox _this) select 2)*2, 0]),
			["MAN", "LandVehicle"],
			((boundingBox  _this) select 2)
		];

		private _filter= [
			_this,
			objectParent _this
		];

			if !(	(nearestObjects _sel - _filter) isEqualTo []	) then {

				private _obs=  (nearestObjects _sel - _filter);

				if !(	(toLower(str (_obs select 0)) find "agent") >= 0 	) then {

					_this disableAI "PATH";

					private _res=	[_this, (_obs select 0)] call MMF_fnc_vector_check;
//systemChat str _res;
//systemChat str ((_obs select 0) getVariable ["traffic_priority", 0]);
//systemChat str vehicleMoveInfo (objectParent _this);
					if (_res) then {
						if !(((_obs select 0) getVariable ["traffic_priority", 0]) > (_this getVariable ["traffic_priority", 0])) then {
							//systemChat "traffic priority";
							_this enableAI "PATH";
						}
					};

					waitUntil {sleep 1; 
						if (((nearestObjects _sel -  _filter) isEqualTo []) || !alive (_obs select 0)) then {
							_this enableAI "PATH";
							true
						}else{false}
					}

				}	
			}
		}
	}
};


MMF_flee=
{	params [["_caller", objNull, []], ["_area", 200, []]];

	private		_pos = [_caller, (_area * 0.1), _area, 1, 0, 30, 0] call BIS_fnc_findSafePos;
	private 	_pos= nearestObjects [_pos, [], 100];
	private 	_buildingARR= nearestObjects [_caller, ["House", "Building"], _area];

	[_caller] join grpNull;
	_caller switchMove "";
	_caller enableAI "ANIM";
	group _caller setSpeedMode "full";

	if (_buildingArr isEqualTo []) then {
		[_caller, "AWARE", "MOVE", [(selectRandom _pos)], false, ["true", "systemChat ''; {deleteVehicle _x} forEach thisList"]] call MMF_fnc_wpNAV
	} else {
		[_caller, "AWARE", "MOVE", [(selectRandom _buildingArr)], false, ["true", "systemChat ''; {deleteVehicle _x} forEach thisList "]] call MMF_fnc_wpNAV
	}
};

MMF_traffic_EH={

	_this call MMF_fnc_explosion_EH;

	_this addEventHandler ["EpeContact", {
		params ["_object1", "_object2", "_selection1", "_selection2", "_force"];
		if (driver _object1 in allPlayers) exitWith {_object1 removeEventHandler ["EpeContact", _thisEventHandler]};
		if (_object2 isKindOf "HOUSE" || _object2 isKindOf "BUILDING") exitWith {{deleteVehicle _x}forEach [driver _object1, _object1]};
		if (damage _object1 > 0.3) then {
			_object1 removeEventHandler ["EpeContact", _thisEventHandler];
			if !(isNull objectParent _object1) then {_object1 leaveVehicle (objectParent _object1)};
		}
	}];
};

MMF_ambientNPC={
	{
		if ((faction _x) == "CIV_f" && !isNull objectParent _x) then {_x disableAI "FSM"};
		_x setSpeaker "NoVoice";
		_x setBehaviour "CARELESS";

		_x addEventHandler ["GetOutMan", {
			params ["_unit", "_role", "_vehicle", "_turret"];
			_unit setVariable ["traffic_check", false];
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
			_unit spawn MMF_flee
		}];

		_x addEventHandler ["HandleDamage", {
			params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
			if !(_instigator in allPlayers) exitWith {0};
			_unit removeEventHandler ["HandleDamage", _thisEventHandler];

			if !(isNull objectParent _unit) exitWith {_unit leaveVehicle (objectParent _unit)};

			_unit spawn MMF_flee
		}];

		_x addEventHandler ["FiredNear", {
			params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
			_unit removeEventHandler ["FiredNear", _thisEventHandler];
			if !(isNull objectParent _unit) exitWith {_unit leaveVehicle (objectParent _unit)};
			_unit spawn MMF_flee
		}];
	}forEach units _this;

	_this deleteGroupWhenEmpty true
};


MMF_preparePos={
	{
		if !(isObjectHidden _x)	then {deleteVehicle _x}
	} forEach (nearestObjects [_this, [], 8])
};

//===========================================================populate traffic

mmf_vehPop=
{	params [["_caller", player, []], ["_area", 100, []], ["_num", 0, []], ["_type", [""], []], ["_arr", [], []]];

	for "_i" from 1 to _num do {

		private		_near_roads= _caller nearRoads (_area *0.5);
		private		_far_roads= (_caller nearRoads _area) - _near_roads;

		if (count _far_roads < _num) then {	_num= (count _far_roads)	};

					_pos = getPos (selectRandom _far_roads);
					_pos call MMF_preparePos;
			private		_veh = (selectRandom _type) createVehicle _pos;
			private		_grp= createVehicleCrew _veh;
					_grp call MMF_ambientNPC;
					_veh call MMF_traffic_EH;
					//_veh allowDamage false;
					_veh forceSpeed 10;
					_arr pushBack _veh;
					_veh setVariable ["traffic_priority", _i];
					leader _grp call MMF_traffic_check;

private	_near = nearestLocations [position _caller, ["CityCenter","NameCity","NameCityCapital","NameVillage"], worldSize];
_near resize 3;
private _wp_arr=[];
{
	//systemChat format ["NAME: %1", (text (_near select _forEachIndex))];
	private _pos= locationPosition (_near select _forEachIndex);
	private _list = _pos nearRoads 300;
	_wp_arr pushback (selectRandom _list);

} forEach _near;
[leader _grp, "SAFE", "MOVE", _wp_arr, true] call MMF_fnc_wpNav;

//[leader _grp, "CARELESS", "MOVE", [(selectRandom _far_roads), (selectRandom _far_roads), (selectRandom _far_roads)], true] call MMF_fnc_wpNav;

		true
	}
};

//===========================================================populate units

mmf_unitPop=
{	params [["_caller", player, []], ["_area", 100, []], ["_num", 0, []], ["_type", [""], []], ["_arr", [], []], ["_side", CIVILIAN, []]];

	for "_i" from 1 to _num do {

		private		_near= _caller nearRoads _area;

		if (_near isEqualTo []) exitWith {	false	};

		private 	_buildingARR= nearestObjects [(selectRandom _near), ["House", "Building"], _area];

		if (_buildingArr isEqualto []) exitWith {	false	};

		private 	_pos=  _buildingARR select 0;
		private 	_building = _buildingARR select 0;
				_pos = _pos buildingPos -1;

		if (count _pos > 0) then {
				_pos = _pos call BIS_fnc_arrayShuffle;
		private		_grp = createGroup [_side, true];
		private 	_unit= (selectRandom _type) createUnit [[((selectRandom _pos) select 0), ((selectRandom _pos) select 1), ((selectRandom _pos) select 2)], _grp];
			{
				_arr pushBack _x;
				_x setVariable ["traffic_priority", 0];
				[_x, "SAFE", "MOVE", [(selectRandom _buildingArr), (selectRandom _buildingArr), (selectRandom _buildingArr)], true] call MMF_fnc_wpNav;
			}forEach units _grp;

			if (faction leader _grp isEqualTo "CIV_F") then {
				_grp call MMF_ambientNPC
			} else { _grp setBehaviour "SAFE"};

			_grp setSpeedMode "Limited";

		} else {false};
	};
	true
};

//===========================================================populate empty vehicles
mmf_emptyVeh=
{	params [["_caller", player, []], ["_area", 100, []], ["_num", 0, []], ["_type", [""], []], ["_arr", [], []]];

	private 	_buildingARR= nearestObjects [_caller, ["House", "Building"], _area];
	_buildingARR = [_buildingARR, [], {_x distance _caller}, "ASCEND",{count (_x buildingPos -1) > 3}] call BIS_fnc_sortBy;

	if (count _buildingARR < _num) then {	_num= (count _buildingArr)	};

	for "_i" from 1 to _num do {

		private		_loc= selectRandom _buildingArr;
				_buildingArr deleteAt (_buildingArr findIf {_x == _loc});
				_pos = [_loc, 3, 18, 8, 0, 4, 0] call BIS_fnc_findSafePos;
				_pos = _pos findEmptyPosition [5, 24, (_type select 0)];

				if !(_pos isEqualTo []) then {

					if (isOnRoad _pos) then {
						false
					} else {
						_pos call MMF_preparePos;
		private				_veh = createVehicle [(selectRandom _type), _pos, [], 0, "NONE"];
						_veh setDir ((getDir _loc) -90);
						_arr pushBack _veh;
					}
				}
	};
	true
};

//===================================================================ambient units
MMF_ambientGrp={
params [["_caller", player, []], ["_area", 100, []], ["_num", 0, []], ["_type", [""], []], ["_arr", [], []], ["_side", CIVILIAN, []]];

for "_i" from 0 to _num do {
	private 	_buildingARR= nearestObjects [_caller, ["House", "Building"], _area];

	if (_buildingArr isEqualTo []) exitWith {	false	};

	private		_pos= getPos (selectRandom _buildingArr);
	private		_pos= _pos findEmptyPosition [5, 24];

	if (_pos isEqualTo []) exitWith {	false	};

		if !(isOnRoad _pos) then {
					_pos call MMF_preparePos;
			private		_helper= createVehicle ["Land_ClutterCutter_large_F", _pos,[],0,"can_collide"];

			private		_fire = createVehicle [selectRandom ["metalBarrel_burning_f", "land_campfire_f"], _pos, [], 0, "NONE"];
					_fire inflame true;

			private		_grp =[ _pos, _side, _type, [],[],[],[],[3, 0], (random 360), false] call BIS_fnc_spawnGroup;
			private		_dog = createAgent ["Fin_random_F", _pos, [], 5, "CAN_COLLIDE"];

			{
				if (_fire isEqualTo "land_campfire_f") then {_x disableAI "ANIM"; _x action ["SITDOWN",_x]};
				_arr pushBack _x;
				_x setVariable ["traffic_priority", 0];

			} forEach units _grp;
			_grp call MMF_ambientNPC;
			_arr pushBack _fire;
			_arr pushBack _dog
		} else {false}
	};
	true
};



//====================================================test calls for wrapper function

//default array
MMF_allPop=[];

if (missionNameSpace getVariable ["MMF_mil_pop", false]) then {

[_this, 500, 4, MMF_civVeh, MMF_allPop] call MMF_vehPop;
[_this, 300, 8, MMF_civArr, MMF_allPop, CIVILIAN] call MMF_unitPop;
[_this, 300, 16, MMF_civVeh, MMF_allPop] call MMF_emptyVeh;
[_this, 100, 2, MMF_civArr, MMF_allPop] call MMF_ambientGrp;

	private _type = missionNameSpace getVariable "MMF_nemesis_type" select 0;
	private _side = missionNameSpace getVariable "MMF_nemesis_type" select 1;
	private _veh_type= [(_type select 1) select 0, (_type select 1) select 2]; 

//mil units
[_this, 500, 3, _veh_type, MMF_allPop] call MMF_vehPop;
[_this, 100, 10, (_type select 0), MMF_allPop, _side] call MMF_unitPop;

if (missionNameSpace getVariable "mmf_call_monitor") then {[[text (_near select 0), (count MMF_allPop)], "mmf_fnc_autoPop"] call mmf_fnc_callMonitor};

} else {

[_this, 1000, 9, MMF_civVeh, MMF_allPop] call MMF_vehPop;
[_this, 300, 12, MMF_civArr, MMF_allPop, CIVILIAN] call MMF_unitPop;
[_this, 300, 24, MMF_civVeh, MMF_allPop] call MMF_emptyVeh;
[_this, 100, 3, MMF_civArr, MMF_allPop] call MMF_ambientGrp;

if (missionNameSpace getVariable "mmf_call_monitor") then {[[text (_near select 0), (count MMF_allPop)], "mmf_fnc_autoPop"] call mmf_fnc_callMonitor};

};

true



/*=======================notes (WIP)

[_this, 800, 20, MMF_civVeh, MMF_allPop] call MMF_vehPop;

[_this, 300, 20, MMF_civArr, MMF_allPop, CIVILIAN] call MMF_unitPop;

[_this, 300, 30, MMF_civVeh, MMF_allPop] call MMF_emptyVeh;

[_this, 100, 3, MMF_civArr, MMF_allPop] call MMF_ambientGrp;


remove population with default array

{
	deleteVehicle _x
}forEach MMF_allPop

*/
