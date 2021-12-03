
//WIP courtesy of Czepis

//params [["_caller", objNull], ["_target", objNull], ["_tol", 30]];

private _u1 = param[0,objnull]; //unit 1
private _u2 = param[1,objnull]; //unit 2
private _dist = param[2,(_u2 distance2D _u1) + 10]; //diameter of the cone, should always be greater than actual distance between the units
private _tol = param[3,50]; //tolerance
private _phi = 180 - acos((vectorDir _u1) vectorCos (vectorDir _u2));
//hint(str _phi);
private _return = false;
if(_phi < _tol/2.0)then //check if they are in each others angle cones, but ANY angle cones that fulfill the angles
{
    //need to check if they even see each other within that 30 degree angle
    _phi = _tol/2;
    private _pos1 = getpos _u1;
    private _pos2 = getpos _u2;
    private _vectorRight = [_dist*cos(_phi),_dist*sin(90 - _phi),0];
    private _vectorLeft = [_dist*cos(_phi),_dist*sin(-90 + _phi),0];
    private _vectorCentre = _pos2 vectorDiff _pos1;
    _phi1 = acos(_vectorLeft vectorCos _vectorCentre);
    _phi2 = acos(_vectorRight vectorCos _vectorCentre);
    //hint(str([_vectorLeft,_vectorRight,_phi1,_phi2]));
    if(abs(_phi1) <= _tol || abs(_phi2) <= _tol)then
    {
        _return = true;
    };
};
_return;



/*






	params [["_caller", objNull], ["_target", objNull], ["_tol", 30]];

	private _dist = (_caller distance2D _target) + 10;
	private _phi = 180 - acos ((vectorDir _caller) vectorCos (vectorDir _target));
	private _rtn= false;

	if (_phi < _tol) then {

			private _vector_norm =	[_dist * cos (-90 + (_tol *0.5)), _dist * sin (-90+ (_tol *0.5)), 0];
			//systemChat str _vector_norm;

		if(	abs(acos(_vector_norm vectorCos ((getPos _target) vectorDiff (getpos _caller)))) <= _tol	)then {
			_rtn= true;
		};
	};
	_rtn



[player, bob] spawn {
	while {sleep 1; true} do {

		private _res=	[(objectParent _this select 0), (objectParent _this select 1)] call MMF_fnc_vector_check;

		if (_res) then {
			systemChat "Units are facing"
		} else {
			systemChat "Units are not facing"
		}
	}
};
*/