	params [["_caller", player, []]];

	private _tree = (findDisplay 30000) displayCtrl 30001;
	_treeSel = tvCurSel _tree;

	if ((count _treeSel) > 1) then {

		private _resources = _caller getVariable "MMF_account";
		_resources params ["_money", "_res"];
		_objClass = _tree tvData _treeSel;
		_objArray = getArray (missionConfigFile >> "cfgBaseBuild" >> "baseObjects" >> _objClass >> "costArray");
		_difArray = [];

		for "_i" from 0 to ((count _objArray) -1) do {
			_dif = (_resources select _i) - (_objArray select _i);
			if (_dif < 0) then {
				systemChat "You need more resources"
			 } else {
				_difArray pushBack _dif
			};
		};

		if ((count _objArray) == (count _difArray)) then {
			private _control= false;
			closedialog 0;
			if (_objClass isEqualTo "B_LSV_01_ARMED_f") exitWith {
				_objClass =_caller getVariable "MMF_side" select 1 select 0;
				[_objClass, _caller, _objArray] spawn MMF_fnc_placeObj;
			};

			if (_objClass isEqualTo "B_truck_01_covered_f") exitWith {
				_objClass =_caller getVariable "MMF_side" select 1 select 1;
				[_objClass, _caller, _objArray] spawn MMF_fnc_placeObj;
			};

			if (_objClass isEqualTo "B_APC_WHEELED_01_CANNON_F") exitWith {
				_objClass =_caller getVariable "MMF_side" select 1 select 2;
				[_objClass, _caller, _objArray] spawn MMF_fnc_placeObj;
			};

			if (_objClass isEqualTo "B_MBT_01_CANNON_F") exitWith {
				_objClass =_caller getVariable "MMF_side" select 1 select 3;
				[_objClass, _caller, _objArray] spawn MMF_fnc_placeObj;
			};

			if (_objClass isEqualTo "B_UAV_02_dynamicLoadout_f") exitWith {
				_objClass =_caller getVariable "MMF_side" select 2 select 2;
				[_caller, _objClass, "FLY", _caller, "PATROL", [], [180, [180, 100, 100], 80]] call MMF_fnc_airGroup;
				[_caller, ((_objArray select 0) *-1), ((_objArray select 1) *-1)] call MMF_fnc_account;
				_control = true;
			};

			if (_objClass isEqualTo "B_UGV_01_rcws_f") exitWith {
				_objClass =_caller getVariable "MMF_side" select 1 select 5;
				[_caller, 3, _objClass, true, _caller, "PATROL", []] call MMF_fnc_mobileGroup;
				[_caller, ((_objArray select 0) *-1), ((_objArray select 1) *-1)] call MMF_fnc_account;
				_control = true;
			};

		if !(_control) then {[_objClass, _caller, _objArray] spawn MMF_fnc_placeObj};
		};
	};