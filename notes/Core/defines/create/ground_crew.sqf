/*

[] spawn MMF_fnc_ground_Crew;
*/


	params [["_caller", player], ["_heightRel", -1]];

	private _crew=[];


	[objNull, objNull, 1, side _caller, ["B_deck_crew_f"], "SAFE", _crew, false, false, 1] call MMF_fnc_soldiers;

	_crew= leader (_crew select 0);
  	_crew setPos (_caller modelToWorld [5,12,_heightRel]);  
	_crew setDir (getDir _caller -180);
	_crew allowDamage false;
	_crew setGroupId ["Ground Crew"];

	waitUntil {sleep 1; isEngineOn vehicle _caller || isNull objectParent _caller};

		if (isNull objectParent _caller) then {deleteVehicle _crew} else {
			[_crew, "SAFE", MMF_anims, 10] spawn MMF_fnc_anims;
		};
	waitUntil {sleep 1; _caller distance _crew >100 || !isEngineOn objectParent _caller};
		if (_caller distance _crew >100 || isNull objectParent _caller) then {deleteVehicle _crew} else {
			if (!isEngineOn objectParent _caller && !isNull objectParent _caller) then {deleteVehicle _crew;
				[_caller, _heightRel] call MMF_fnc_ground_crew} else {deleteVehicle _crew};
		};