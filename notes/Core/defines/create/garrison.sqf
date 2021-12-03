/*
garrison the calling group at nearest building to centre

_grp		the calling group
_centre		object considered centre (can be group leader)
_area		area to search for suitable buildings

returns: true if a building was garrisoned, false if no suitable building was found

**if false group will defend at _centre

example call:
	[group player, player, 100] call MMF_fnc_garrison
*/


params [["_grp", group player, [grpNull]], ["_centre", player, [objNull]], ["_area", 100, []]];

private _buildingARR= nearestObjects [_centre, ["House", "Building"], _area];

_buildingARR = [_buildingARR, [], {_x distance _centre}, "ASCEND",{count (_x buildingPos -1) > 1}] call BIS_fnc_sortBy;

private _count = count _buildingARR;

if (_count ==0) exitWith {
		[_grp, getPos _centre] call bis_fnc_taskDefend;
		false
};

private _pos=  _buildingARR select 0;
private _building = _buildingARR select 0;
	_pos = _pos buildingPos -1;
	_pos = _pos call BIS_fnc_arrayShuffle;
	
if ((count units _grp) > count _pos) then {
	private _dif=(count (units _grp) - (count _pos));
	for "_i" from 1 to _dif do {
		_grpArr= units _grp;
		_unit= _grpArr select 0;
		[_unit] join grpNull;
			_unit setPosATL [((getPosATL _building select 0) + random 3), ((getPosATL _building select 1) + random 3), getPosATL _building select 2];
		[(group _unit), getPos _building] call bis_fnc_taskDefend
	};
};

{
	_x disableAI "PATH";
	_x setUnitPos selectRandomWeighted ["UP", 2/3, "MIDDLE", 1/3];
	_x setPos (_pos select _forEachIndex);
	_x addEventHandler ["Fired", {
					params ["_unit"];

					_unit enableAI "PATH";
					_unit setUnitPos "AUTO";
					_unit removeEventHandler ["Fired",_thisEventHandler];
				}];
} foreach units _grp;

true
