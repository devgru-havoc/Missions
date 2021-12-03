
/*====================================MMF_fnc_ambient_flyby=======================SPAWN

*toggle missionNameSpace 'do_flyby' to false to end ambient flyby

example: (independent)
(MMF_airVEH select 2) spawn mmf_fnc_ambient_flyby;
missionNameSpace setVariable ["do_flyby", false];

=============================================MMF_fnc_ambient_flyby===================*/

	while {sleep 1; missionNameSpace getVariable ["do_flyby", true]} do {
		private	_start= leader group (selectRandom allPlayers);
		for "_i" from 0 to (random 3) +1 do {
			[
				(_start getRelPos [3500, (getDir _start)+180]),
				(_start getRelPos [-3500, (getDir _start)-180]),
				((random 100) + 100),
				"FULL",
				(selectRandom _this)
			] call BIS_fnc_ambientFlyby;
			sleep ((random 5)+10)
		};
		sleep ((random 100)+100)
	};


