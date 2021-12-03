/*======MMF_fnc_intoxicated======CALL======drunk screen effect

example: drunk for 10 seconds
[10] call MMF_fnc_intoxicated

example: drunk until variable switched
[0] call MMF_fnc_intoxicated

example: cancel drunkness
[-1] call MMF_fnc_intoxicated
*/

params [["_duration", 0, []], ["_caller", player, []]];

if (_duration== -1) exitWith {_caller setVariable ["MMF_drunk", false]};

	["CHROM", _duration] call MMF_fnc_ppEFFECT;
	_caller setVariable ["MMF_drunk", true];
	_caller forceWalk true;

	if (_duration !=0) then {
		_this spawn {sleep (_this select 0); (_this select 1) setVariable ["MMF_drunk", false]; (_this select 1) forceWalk false}
	} else {
		_caller spawn {
			waitUntil {!(missionNameSpace getVariable ["MMF_ppe_effect", -1]==-1)};
			private _handle= missionNameSpace getVariable "MMF_ppe_effect";
			waitUntil {sleep 1; !(_this getVariable ["MMF_drunk", false])};
			_this forceWalk false;
			_handle ppEffectEnable false;
			ppEffectDestroy _handle;
		}
	}



//=============time dialation
/*
	while {sleep 1; _caller getVariable ["MMF_drunk", false]} do {

		setAccTime (selectRandom [0.25, 0.5, 0.75, 1, 1.25]);
		sleep 2
	};

	setAccTime 1
*/
