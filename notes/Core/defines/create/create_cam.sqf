/*======MMF_fnc_create_cam======CALL======create and display camera feeds
create a camera at object position, focus on target and display on all screens listed in array

_cam				object		camera location
_target				object		camera focal point
_screen				array		object(s) to display feed
_effect		*optional	number		0 default, (1== NV), (2== IR), (7== IR invert), (8== IR green)
_fov		*optional	number		field of view (zoom) 1==default, 2== wide, 0.1==close
_surface	*optional	string		desired name of render surface (must be unique for multiple cams)
_light		*optional	bool		create light source, default: false
_pip		*optional	bool		show pip, default: false

returns: terminal handle

*you may call the function multiple times to select new effects but FOV is fixed at creation
*you may call the function without any screen objects and still create a PIP (empty array)
*camera attaches to camera object and tracks target automatically (use static target for static image)

example 1:
	[player, cam_target, [screen_obj_0, screen_obj_1], 0, 1, "rtt_1", true, true] call MMF_fnc_create_cam
example 2:
	[camera_object, camera_target, [screen_object]] call MMF_fnc_create_cam
example 3: (create PIP & remove after 20 seconds)
	private _terminal = format ["rtt_%1", _this]; 
	private _rtt=[cam_object, cam_target, [], 2, 1, _terminal, true, true] call MMF_fnc_create_cam;
	[_helper, _terminal, _rtt] spawn {sleep 20;
		(_this select 0) cameraEffect ["terminate","back", (_this select 1)];
		ctrlDelete (_this select 2);
		deleteVehicle (_this select 0)
 	};


terminate feed with damage example:
this addMPEventHandler ["MPHit", {
	params ["_unit", "_causedBy", "_damage", "_instigator"];
	comment "if !(_instigator in allplayers) exitWith {false};";

	if (damage _unit > 0.4) then {
		cam_object cameraEffect ["terminate","back", "rtt_1"]
	}
}];
================================================================================================*/

	params [["_cam", objNull, []], ["_target", objNull, []], ["_screen", [], []], ["_effect", 0, []], ["_fov", 1, []], ["_surface", "rtt_1", []], ["_light", false, []], ["_pip", false, []]];

private	_light_effect={
	private _light = createVehicle ["#lightpoint", position _this, [], 0, "CAN_COLLIDE"];
	_light setLightBrightness 0.6;
	_light setLightColor [1,1,1];
	_light setLightAmbient [1,1,1];
	_light setLightIntensity 200;
};

		private 	_cam_obj = "Camera" camCreate (_cam modelToWorld [0,0,0]);
				[_cam_obj, _cam] call BIS_fnc_attachToRelative;
		private 	_display= format ["#(argb,512,512,1)r2t(%1,1.0)", _surface];
		private		_rtt = findDisplay 46 ctrlCreate ["RscPicture", -1];

				if !(_pip) then {_rtt ctrlSetPosition [1200, 0]};
				_rtt ctrlCommit 0;
				_rtt ctrlSetText _display;
				_cam_obj cameraEffect ["internal","back", _surface];
				_surface setPiPEffect [_effect];
				_cam_obj camSetDir (position _cam vectorFromTo position _target);
				_cam_obj camSetFov _fov;
[_cam_obj, _target] spawn {
				(_this select 0) camSetTarget (_this select 1);
				(_this select 0) camCommit 2;
};


				{
					_x setObjectTextureGlobal [0, _display];
					if (_light) then {_x call _light_effect}
				}forEach _screen;

		if !(_pip) then {_rtt spawn { sleep 0.2; ctrlDelete _this}};
_rtt;
