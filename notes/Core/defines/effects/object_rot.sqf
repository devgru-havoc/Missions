/*======mmf_fnc_object_rot======CALL====== rotate object

Rotate object
_this		object		object to rotate

returns: nothing

Example:
object_0 call MMF_fnc_object_rot

*/

_this spawn {
	_this setVariable ["do_spin", true];  
  	 while {sleep 0.02;	_this getVariable "do_spin"} do {  
		_this setDir (getDirVisual _this + 3);
	}
}

