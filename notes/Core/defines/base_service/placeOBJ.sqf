params [["_select", ""], ["_caller", player], ["_cost", [0,0]]];

private	_objPOINT= _caller modelToWorld [0,6,0];
private _campData= _caller getVariable "MMF_campData";

if !(_caller getVariable ["MMF_object_LOC", false]) then {
	_obj= createVehicle [_select, _objPOINT, [], 0, "can_collide"];
	_obj setDir (getDir _caller);
	_obj enableSimulation true;
	if !(_obj isKindOf "LandVehicle") then {
		_obj setVariable ["MMF_isBaseOBj", true]
	};
	[_caller, ((_cost select 0) *-1), ((_cost select 1) *-1)] call MMF_fnc_account;



//========================================obj add actions

if !(isMultiplayer) then {

	if (_select isEqualTo "land_tentDome_F" || _select isEqualTo "Land_TentA_F") exitWith {
		private _tentArr= missionNameSpace getVariable ["MMF_tentARR", []];
		_tentARR pushback _obj;
		missionNameSpace setVariable ["MMF_tentARR", _tentARR];
		_obj addAction [ "Request Unit(s)", {
			private _num= count (missionNameSpace getVariable ['MMF_tentARR', []]);
			private _pos= _this select 1 getVariable 'MMF_campData' select 0;
			private _side= _this select 1 getVariable 'MMF_side' select 0;
			[_this select 0, _pos, _num, side (_this select 1), _side, 'SAFE', [], false, false, 0, 'REC'] call MMF_fnc_soldiers;
			[] spawn {
				sleep 1; {deleteVehicle _x}forEach (missionNameSpace getVariable ['MMF_tentARR', []]); MMF_tentARR=[];
			};
		}];
	};

	if (_select isEqualTo "Land_heliPadCircle_f") exitWith {
		private	_veh= createVehicle [_caller getVariable "MMF_side" select 2 select 0, _obj getPos[ 0, getDir _obj ],[],0, "NONE"]
	};

	if (_select isEqualTo "TargetP_inf2_f") exitWith {
		private _targetARR= missionNameSpace getVariable ["MMF_targetArr", []];
		_targetARR pushback _obj;
		missionNameSpace setVariable ["MMF_targetArr", _targetARR];
	};

	if (_select isKindOf "Building" || _select isKindOf "House") exitWith {
		if (count (_obj buildingPos -1)>1) then {
			[]spawn {hintSilent "Can Garrison"; uiSleep 3; hintSilent ""};
			_obj addAction ["Garrison", {
				params ["_target", "_caller", "_actionId", "_arguments"];

				private _num= count (_target buildingPos -1);
				private _side= _caller getVariable "MMF_side" select 0;
				private _grp=[_target, _target, _num, side _caller, _side, "SAFE", [], false, false, 0, "REC"] call MMF_fnc_soldiers;
				[_grp, _target] spawn MMF_fnc_garrison;
				_target setVariable ["MMF_isBaseOBj", false];
				_target removeAction _actionID;

		},[],0,false,true,"",""];

		};
	};
};

};
