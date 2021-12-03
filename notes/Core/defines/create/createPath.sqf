/*
Create path from random point to _caller

_caller 		object treated as center (can be player)
_arr			desired name of array to be output (must be defined)
_area			max distance from centre to create random point (within 10% of area)
_type			string name for vehicle type ("MAN", "CAR", etc.)
_state			behavior state to simulate for path creation ("SAFE", "AWARE", etc.)

returns: nothing (see notes)

**populates supplied array with 5 objects spaced between _caller and generated position
**automatic functions use array: MMF_pathArr
**toggles nameSpace variable "MMF_pathCreated" to true
**can show the path on the map with nameSpace variable "MMF_drawPath" (see initServer)

example call:
	[player, MMF_pathArr, 1000, "MAN", "SAFE"] spawn MMF_fnc_createPath
*/


params [["_caller", objnull, [objNull]], ["_arr", [], []], ["_area", 1000, []], ["_type", "man", []], ["_state", "SAFE", []]];

	private _pos = [_caller, _area - (_area *0.1), _area, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	(calculatePath [_type, _state, _pos, (getPos _caller)]) addEventHandler ["PathCalculated", {

		params ["_agent", "_path"];
		private _count= count _path;
		private _temp=[
			_path select 0,
			_path select (round (_count *0.25)),
			_path select (round (_count *0.5)),
			_path select (round (_count *0.75)),
			_path select (_count -1)
			];

		if (count _temp > 5) then {_temp resize 5};
		private _posArr=[];

		{
			if (missionNameSpace getVariable ["MMF_drawPath", false]) then {
				private _marker = createMarker ["marker" + str _forEachIndex, _x];
				_marker setMarkerType "mil_dot";
				_marker setMarkerText str _forEachIndex;
			};
			private	_helper= "sign_arrow_direction_cyan_f" createVehicle _x;
			hideObjectGlobal _helper;
			_posArr pushBack _helper;

		} forEach _temp;

missionNameSpace setVariable ["MMF_currentPath", _posArr];
missionNameSpace setVariable ["MMF_pathCreated", true];
deleteVehicle _agent;

	}];

waitUntil {missionNameSpace getVariable "MMF_pathCreated"};
private _newArr= missionNameSpace getVariable "MMF_currentPath";
{
 _arr pushBack _x
} forEach _newArr;