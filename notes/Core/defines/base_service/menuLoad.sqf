params [["_caller", player, []]];
		_display = createDialog "RscBaseObject";
	private _tree = (findDisplay 30000) displayCtrl 30001;
	private _plrInfoCtrl = ((findDisplay 30000) displayCtrl (30003));
	private _resources = _caller getVariable "MMF_account";
		_resources params ["_money", "_res"];
		_plrInfoTitle = name _caller;

		_plrInfoCtrl ctrlSetStructuredText parseText format [
"<t align='center' shadow='true' shadowColor='#000000' underline='1'>%1's Base</t><br/>
<t align='left' shadow='true' shadowColor='#000000'>Money: %2</t>
<t align='right' shadow='true' shadowColor='#000000'>Resources: %3</t><br/><br/>",
_plrInfoTitle, _money, _res];

		_configs = "true" configClasses (missionConfigFile >> "cfgBaseBuild" >> "baseObjects");
		_grps = [];
		{
			_className = configName _x;
			_grp = getText (_x >> "treeGrp");
			if !(_grp in _grps) then {
				_grps pushBack _grp;
				_trunk = _tree tvAdd [[], _grp];
			};
		for "_i" from 0 to (_tree tvCount []) do {
			_text = _tree tvText [_i];
			if (_text == _grp) then {
				_objName = getText (_x >> "displayName");
				_obj = _tree tvAdd [[_i], _objName];
				_tree tvSetData [[_i,_obj], _className];
				};
			};
		} forEach _configs;
	tvExpandAll _tree;
