//[vehicle_0, vehicle_1, vehicle_2, vehicle_3] call MMF_fnc_mission_targets

missionNameSpace setVariable ["MMF_mission_targets", _this];

addMissionEventHandler["EntityKilled",{
	params ["_unit", "_killer"];
	if (_unit in (missionNameSpace getVariable ["MMF_mission_targets", []])) then {
		if (_killer in allPlayers) then {_killer sideChat "Mission target destroyed!"};
		private _arr= (missionNameSpace getVariable ["MMF_mission_targets", []]) - [_unit];

		if (count _arr ==0) exitWith {
			removeMissionEventHandler ["EntityKilled", _thisEventHandler];
			leader (group _killer) sideChat "All targets destroyed! Side objective completed!"
		};

		missionNameSpace setVariable ["MMF_mission_targets", _arr];
		leader (group _killer) sideChat (format ["Locate and destroy the next mission objective! %1 more!", (count _arr)]);
	};
}];