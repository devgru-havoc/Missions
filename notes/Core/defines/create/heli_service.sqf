/*================================================================

Insert or extract player or NPC groups

_caller		unit		player or NPC (group leader)
_insert		bool		collect group before moving or move before collecting group
_type		string		vehicle class name
_loc		array		spawn location, insert/extract location
_fly		string		start on ground or start in flight: "NONE", "FLY"

returns: select 0= vehicle, select 1= crew

*if _insert and _caller is NOT player then NPC groups will be loaded automatically without animation

EXAMPLES:
example location array: [spawn_loc, insert_loc, objNull]

//insert player group vehicle starts on ground
[player, true, "B_Heli_Light_01_F", [spawn_loc, insert_loc, objNull]] call MMF_fnc_heli_service

//insert NPC group vehicle starts in flight
private _grp=MMF_3_west call MMF_fnc_soldiers;
private _veh=[leader _grp, true, "B_Heli_Light_01_F", [spawn_loc, player, objNull], "FLY"] call MMF_fnc_heli_service


//Extract NPC group (leader init)
null=this spawn {
private _veh = [_this, false, "B_Heli_transport_03_F", [spawn_loc, insert_loc, objNull], "FLY"] call MMF_fnc_heli_service;
waitUntil {sleep 1; (_veh select 0) distance insert_loc< 9};
private _grp= []; 
{ 
 _grp pushback _x; 
 _x assignAsCargo (_veh select 0); 
} forEach units group _this; 
 
_grp orderGetIn true;
waitUntil {_this in (_veh select 0)};
waitUntil {!(_this in (_veh select 0))}; 
 
[_this, "AWARE", "move", [spawn_loc]] call MMF_fnc_wpNAV;

//insert player group vehicle waiting with hot engine
private _veh = [player, true, "B_Heli_transport_03_F", [spawn_loc, insert_loc]] call MMF_fnc_heli_service;
(_veh select 0) engineOn true;


==================================================================*/



params [["_caller", player], ["_insert", false], ["_type", "B_Heli_Light_01_F"], ["_loc", []],["_fly", "NONE"]];


private _arr=[];
{
	if !(_x isEqualType []) then {_x= getPos _x};
	private _pad=	createVehicle ["land_heliPadEmpty_f", _x,[],0, "NONE"];
	_arr pushBack _pad
}forEach _loc;

private _veh= [(_arr select 0), _type, _fly] call MMF_fnc_airgroup;
if (isTouchingGround (_veh select 0)) then {[leader (_veh select 1), "careless", "MOVE", [_arr select 0]] call MMF_fnc_wpNAV};


{
		_x setCaptive true;
		_x setBehaviour "CARELESS";
		//_x allowDamage false
}forEach units (_veh select 1);


if (!(_caller in allPlayers) && _insert) then {
	{
		_x assignAsCargo (_veh select 0);
		_x moveInCargo (_veh select 0);
	}forEach units group _caller
};



[_caller, _insert, _loc, _veh, _arr] spawn {	params ["_caller", "_insert", "_loc", "_veh", "_arr"];

	if (_insert) then {

		if (isTouchingGround (_veh select 0)) then {(_veh select 0) flyInHeight 0};

		waitUntil {sleep 5;	(({_x in (_veh select 0)} count (units group _caller)) == (count (units group _caller)))	};

		if (isTouchingGround (_veh select 0)) then {(_veh select 0) engineOn false};
		(_veh select 0) flyInHeight 100;
		[leader (_veh select 1), "CARELESS", "MOVE", [_arr select 1], false, ["true", "(vehicle this) land 'Get out'"]] call MMF_fnc_wpNAV;
		[_caller, "AWARE", "GETOUT", [_arr select 1]] call MMF_fnc_wpNAV;

		waitUntil {sleep 1;	!(isTouchingGround (_veh select 0))	};
		waitUntil {sleep 1;
				isTouchingGround (_veh select 0) ||	
				(	({_x in (_veh select 0)} count (units group _caller)) == 0	)
		};

		(_veh select 0) flyInHeight 0;
		group _caller leaveVehicle (_veh select 0);
		if !(_caller in allPlayers) then {
			while { (({_x in (_veh select 0)} count (units group _caller)) != 0) } do {
				(_veh select 0) setVelocity [0,0,0];
				{
					moveOut _x; unassignvehicle _x;
				} foreach units group _caller
			}
		};

		waitUntil {sleep 5;	(({_x in (_veh select 0)} count (units group _caller)) == 0)	};

		(_veh select 0) flyInHeight 100;

		{deleteVehicle _x} forEach _arr;
		[leader (_veh select 1), "CARELESS", "MOVE", [objNull], false, ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} forEach thislist"]] call MMF_fnc_wpNAV;

	} else {
		
		[leader (_veh select 1), "CARELESS", "MOVE", [_arr select 1], false, ["true", "(vehicle this) land 'Get In'"]] call MMF_fnc_wpNAV;

		waitUntil {sleep 5;	(({_x in (_veh select 0)} count (units group _caller)) == (count (units group _caller)))	};

		[leader (_veh select 1), "CARELESS", "MOVE", [_arr select 0], false, ["true", "(vehicle this) land 'Get Out'"]] call MMF_fnc_wpNAV;
		waitUntil {sleep 1;	!(isTouchingGround (_veh select 0))	};
		[_caller, "AWARE", "GETOUT", [_loc select 0]] call MMF_fnc_wpNAV;
		
		waitUntil {sleep 1;	isTouchingGround (_veh select 0)	};
		group _caller leaveVehicle (_veh select 0);

		waitUntil {sleep 5;	(({_x in (_veh select 0)} count (units group _caller)) == 0)	};

		{deleteVehicle _x} forEach _arr;
		[leader (_veh select 1), "CARELESS", "MOVE", [objNull], false, ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} forEach thislist"]] call MMF_fnc_wpNAV;

	};
};

_veh


