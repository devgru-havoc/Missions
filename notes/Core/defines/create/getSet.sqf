/*

get / set unit loadout

example:

default_player_loadout= [player, true, (missionNameSpace getVariable ["default_player_loadOut", []])] call MMF_fnc_getSet;
[player, false, (missionNameSpace getVariable ["default_player_loadOut", []])] call MMF_fnc_getSet;

*/

params [["_target", objNull], ["_get", false], ["_arr", []]];

	if (_get) exitWith {
		{
			_arr pushBack (getUnitLoadout _x);
			deleteVehicle _x;
		} forEach units group _target;
		_arr
	};

	{
		private _load= selectRandom _arr;
		_x setUnitLoadout _load;
	} forEach units group _target;

	_arr;
