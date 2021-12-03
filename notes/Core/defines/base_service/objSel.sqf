	disableSerialization;
	_objInfoTitle = "Object";
	params ["_tree","_index","_powerInfo"];
	if ((count _index) > 1) then {
		private _modelCtrl = ((findDisplay 30000) displayCtrl (30002));
		private _objInfo = ((findDisplay 30000) displayCtrl (30004));
		_objClass = _tree tvData _index;
		_objArray = getArray(missionConfigFile >> "cfgBaseBuild" >> "baseObjects" >> _objClass >> "costArray");
		_objArray params ["_money", "_res"];

	_objInfo ctrlSetStructuredText parseText format [
"<t align='center' shadow='true' shadowColor='#000000' underline='1'>%1</t><br/>
<t align='left' shadow='true' shadowColor='#000000' >Money: %2</t>
<t align='right' shadow='true' shadowColor='#000000' >Resources: %3</t><br/><br/>",
_objInfoTitle, _money, _res];

	_objModel = getText(configFile >> "cfgVehicles" >> _objClass >> "model");
	_modelCtrl ctrlShow false;
sleep 0.05;
	_dummy = _objClass createVehicleLocal [0,0,0];
	_modelSize = sizeOf (typeOf _dummy);
	deleteVehicle _dummy;
	_modelPos = ctrlPosition _modelCtrl;
	_modelPos set [1,(_modelSize * 1.3)];
	_modelCtrl ctrlSetPosition _modelPos;
	_modelCtrl ctrlSetModel _objModel;
	_modelCtrl ctrlShow true;
	while {ctrlShown _modelCtrl} do {
		_vectorDirAndUp = ctrlModelDirAndUp _modelCtrl;
		_vectorDir = _vectorDirAndUp select 0;
		_newVector = [_vectorDir,0.5] call BIS_fnc_rotateVector2D;
		_modelCtrl ctrlSetModelDirAndUp [_newVector,(_vectorDirAndUp select 1)];
		sleep 0.015;
		};
	};

