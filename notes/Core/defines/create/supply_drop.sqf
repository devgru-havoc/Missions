params [["_caller", player, [objNull]], ["_ars", false, [false]]];

if (_caller getVariable ["MMF_supplyIN", false]) exitWith
{
		_caller sideChat "Not ready yet"
};

_caller setVariable ["MMF_supplyIN", true];

private _type = _caller getVariable "MMF_side" select 3;

private	_obj = _type createVehicle getPos objNull;
	_obj setPos (_caller modelToWorld [(round random 100), (round random 100), 200]);

private	_para = "B_Parachute_02_F" createVehicle getPos _obj;
	_para attachTo [_obj, [0, 0, 0.86]];

waitUntil {sleep 0.2; if (((getPos _obj) select 2)< 10) then {true} else {_obj setVelocity [0,0,-2]; false}};

_para spawn {sleep 5; deleteVehicle _this};

private	_eff = "SmokeShellGreen_infinite" createVehicle getPos _obj;
	_eff attachTo [_obj, [0,0,1]];

private		_time= diag_tickTime + 300;

		if (_ars) then
		{
				[_obj, "Open Arsenal",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
				"alive _this", "alive _this", {}, {}, {
				[ "Open", [ true ] ] call BIS_fnc_arsenal;
				}, {}, [], 2, 0, false, true] call BIS_fnc_holdActionAdd;
		};


waitUntil {sleep 1; _obj distance _caller < 10 || diag_tickTime> _time};

deleteVehicle _eff;

_caller setVariable ["MMF_supplyIN", false];

