/*======mmf_fnc_action_key======LOCAL======various effects
=======================================Sit Key
sit anywhere as usual but if there's a chair nearby (map or editor), sit on it instead
group leader may sit group if there are enough chairs nearby (~12 m)

=======================================Account
press numpad "." to check balance of account

=======================================Car Control
D-PAD up 					= toggle radio
D-PAD down 					= cabin light
D-PAD L/R 					= radio next

=======================================Menu Control
D-PAD up (if no target)				= open menu
D-PAD up (if target is base object)		= grab object
D-PAD up (if holding object)			= place object
D-PAD down (if holding object)			= cancel move
D-PAD down (not holding object)			= remove object
D-PAD L/R  (if target is base object)		= rotate object

*/


params[ "_key" ];

private _filter=[	40,		// sit/sit group
			83,		//account
			200,		//menu/radio
			203,		//rotate obj / radio next
			205,		//rotate obj / radio next
			208		//cancel/remove obj / cabin light
];

//id key =========================================remove the comments to discover key numbers
//systemChat str _key;

if !(_key in _filter) exitWith {false};

//account
if (_key == (_filter select 1)) exitWith {[player, 0, 0] call MMF_fnc_account};

//sit
if (_key == (_filter select 0)) then {
	if !(player getVariable ["MMF_sit", false]) then {

		private _obj=nearestObjects [player, [], (count units group player)+2];

		private _obj = [_obj, [], {_x distance player}, "ASCEND",{(toLower(str _x) find "chair") >= 0}] call BIS_fnc_sortBy;

		if (_obj isEqualto []) exitWith {false};
		if ((toLower(str (_obj select 0)) find "folded") >= 0 || (toLower(str (_obj select 0)) find "sun") >= 0) exitWith {false};
		[(_obj select 0), player] spawn MMF_sit_down;

		if (count (units group player) >1 && player== leader group player) then {

			[_obj, player] spawn {
				uiSleep 0.5;
				private _result= ["Sit Group?", "Select Action", "OK", "CANCEL"] call BIS_fnc_guiMessage;

				if (_result) then {
					[(_this select 0), group (_this select 1)] call MMF_sit_group
				}
			}
		}

	} else {
		{
			if (_x getVariable ["MMF_sit", false]) then {
				_x switchmove "";
				_x setVariable ["MMF_sit", false];
				_x enableAI "ALL";
			}
		}forEach units group player;
	}
} else { //====================================================================================build menu
	if (isNull objectParent player && player getVariable ["MMF_can_build", false]) then {
		if (_key == (_filter select 3) && {cursorTarget getVariable ["MMF_isBaseObj", false]}) then {cursorTarget setDir (getDir cursorTarget)+90};
		if (_key == (_filter select 4) && {cursorTarget getVariable ["MMF_isBaseObj", false]}) then {cursorTarget setDir (getDir cursorTarget)-90};
		if (_key == (_filter select 2)) then {
			if (!(cursorTarget getVariable ["MMF_isBaseObj", false]) && !(player getVariable ["MMF_object_loc", false])) exitWith {[player] spawn MMF_fnc_menuLoad};
			if (cursorTarget getVariable ["MMF_isBaseObj", false] && !(player getVariable ["MMF_object_loc", false])) exitWith {
				player setVariable ["MMF_confirm_LOC", true];
				[player, true] spawn MMF_fnc_interact
			};
			player setVariable ["MMF_object_loc", false];
		};

		if (_key == (_filter select 5)) then {
			if (player getVariable ["MMF_object_loc", false]) exitWith {
				player setVariable ["MMF_confirm_LOC", false];
				player setVariable ["MMF_object_LOC", false];
			};
			[player, false] call MMF_fnc_interact
		}
	} else {//====================================================================================car controls
		if (_key == (_filter select 3) || _key == (_filter select 4)) then {
			if (player getVariable ["play_veh_radio", false]) then {
				player setVariable ["play_veh_radio", false];
				playMusic "";
				playSound ["click", true];
				terminate MMF_radio_handle;

				private _current= player getVariable ["MMF_radio_default", MMF_news];
				private _arr= [MMF_news, MMF_rock, MMF_ambient] - [_current];
				player setVariable ["MMF_radio_default", (selectRandom _arr)];

				player setVariable ["play_veh_radio", true];
				player call MMF_music_player;
			}
		};

		if (_key == (_filter select 2)) then {
			if (player getVariable ["play_veh_radio", false]) then {
				player setVariable ["play_veh_radio", false];
				playMusic "";
				playSound ["click", true];
				terminate MMF_radio_handle;
			}else{
				playSound ["click", true];
				player setVariable ["play_veh_radio", true];
				player call MMF_music_player;
			}
		};

		if (_key == (_filter select 5)) then {
			if (isNull objectParent player) exitWith {false};
			if (
				!(player getVariable ["MMF_cabinLight", [false, objNull]] select 0) &&
				cameraView == "Internal" &&
				(daytime < 5 || dayTime > 19)
			) then {
				private _light = "reflector_cone_01_white_F" createVehicle [0,0,0];
				_light attachTo [objectParent player, [0,1,-1]];
				_light setDir 180;
				player setVariable ["MMF_cabinLight", [true, _light]];
				playSound ["click", true];

				addMissionEventhandler ["EachFrame", {
								//_thisArgs in 2.03
					if (
						!(cameraView == "Internal") ||
						isNull objectParent player ||
						!(player getVariable ["MMF_cabinLight", [false, objNull]] select 0)
					) exitWith {
						removeMissionEventhandler ["EachFrame", _thisEventHandler];

						private _light =player getVariable "MMF_cabinLight" select 1;
						deleteVehicle _light;
						playSound ["click", true];
						player setVariable ["MMF_cabinLight", [false, objNull]];
					}
				}]
			}else{
				if (daytime < 5 || dayTime > 19) then {
					private _light =player getVariable "MMF_cabinLight" select 1;
					player setVariable ["MMF_cabinLight", [false, _light]];
				};
			};
		};
	};
};






