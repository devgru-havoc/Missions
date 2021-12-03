/*
set up player variables based on params supplied by initPlayerLocal.sqf

MMF_side
MMF_account
MMF_act_complete
MMF_defpos
MMF_default_loadout
*group ID
*MP respawn handler (loadout/magazines)

account add action
spawn MMF_inj_play (if any)

configure these startup parameters for this function in initPlayerLocal.sqf

*/


params	[["_caller", [player, "MASTER_TESTER", [false, player, 1, 100, [100, 1], "OFF"]], []]];

[[_caller select 0, _caller select 2 select 4, _caller select 2 select 5], "mmf_fnc_startPlayer"] call mmf_fnc_callMonitor;

private _unit= _caller select 0;
private _campData= _caller select 2;

//establish MMF_side array used for automatic selection of side appropriate vehicles and units
if !(side _unit isEqualto CIVILIAN || side _unit isEqualto INDEPENDENT) then {
	if (side _unit isEqualto WEST) then {
		_unit setVariable ["MMF_side", [(MMF_units select 1), (MMF_milVeh select 1), (MMF_airVeh select 1), (MMF_milSupply select 1)]]
	} else {
		_unit setVariable ["MMF_side", [(MMF_units select 0), (MMF_milVeh select 0), (MMF_airVeh select 0), (MMF_milSupply select 0)]]
	}

} else {

	if (side _unit isEqualto CIVILIAN) then {
		_unit setVariable ["MMF_side", [MMF_civARR, MMF_civVeh, (MMF_airVeh select 2), (MMF_milSupply select 1)]]
	} else {
		_unit setVariable ["MMF_side", [(MMF_units select 2), (MMF_milVeh select 2), (MMF_airVeh select 2), (MMF_milSupply select 2)]]
	}
};

//set variables
_unit setvariable ["MMF_account", (_campData select 4) ];
_unit setVariable ["MMF_defpos", [getposATL (_caller select 0), getdir (_caller select 0)]];
_unit setVariable ["MMF_default_loadout", (getUnitLoadout _unit)];
if ((_caller select 1) != "") then {_unit setGroupID [(_caller select 1)]};
_unit action ["WeaponOnBack", _unit];


//=====================================================================single-player buttons
if !(isMultiplayer) then {

	//camp data
	if (_caller select 2 select 0) then {
		private _campData= _caller select 2;
		(_caller select 0) setVariable ["MMF_campData", [_campData select 1, false]];

		[_campData select 1] call MMF_fnc_placeCamp;
		[_campData select 1, _campData select 2, _campData select 3] call MMF_fnc_randomLoot;

		if ((_campData select 5) isEqualTo "ON" || (_campData select 5) isEqualTo "PER") then {
			[(_caller select 0), (_campData select 5), (_campData select 1), true] call MMF_fnc_auto_crew
		}
	};

}else{	//respawn with loadout (fill magazines)

	_unit addMPEventHandler ["MPRespawn", {
    		params ["_unit", "_corpse"];
		_unit setUnitLoadout [(getUnitLoadout _corpse), true];
	}];
};


//sit_key
findDisplay 46 displayRemoveEventHandler ["keyUp", (_unit getVariable ["sit_handle", 0])];

_unit spawn {

	waitUntil { !isNull findDisplay 46 };

	[ missionNamespace, "keyPress", MMF_fnc_action_key ] call BIS_fnc_addScriptedEventHandler;

	private _sit_handle =findDisplay 46 displayAddEventHandler [ "KeyUp", {
		params[ "", "_key" ];
	
	[ missionNamespace, "keyPress", [ _key ] ] call BIS_fnc_callScriptedEventHandler;
	}];
	_this setVariable ["sit_handle", _sit_handle];
};

// inj_play is custom code block in initPlayerLocal.sqf (_caller is _this)
_unit spawn MMF_inj_play;
