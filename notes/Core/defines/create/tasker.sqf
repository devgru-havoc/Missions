/*

Create/assign/complete group tasks

_name		string		task system name
_type		string		task display name
_pos		object		task object
_state		string		task state "ASSIGNED", "SUCCEEDED", "FAILED", etc. (use CAPS)
_grp		group		task owner group	(use grpNull to hide task objective)

EXAMPLES
example task,
["you_example_task", "Task Display Text", objNull, "Assigned"] call MMF_fnc_tasker

Complete the example task,
["you_example_task", "Task Display Text", objNull, "SUCCEEDED"] call MMF_fnc_tasker

Fail the example task,
["you_example_task", "Task Display Text", objNull, "Failed"] call MMF_fnc_tasker


*/

params [["_name", "task_1"], ["_type", "Objective"], ["_pos", []], ["_state", "Assigned"], ["_grp", grpNull]];


	private _dest=[];
	if !( _pos isEqualType [] ) then {
		_dest= [_name, [_pos, true]];
	} else {
		_dest= [_name, _pos];
	};


if (_state isEqualTo "SUCCEEDED") exitWith
{
		[_name,_state] call BIS_fnc_taskSetState;  [ _name ] call BIS_fnc_deleteTask;
};

[true,[_name],[_type,_type,_type],objNULL,1,3,false] call BIS_fnc_taskCreate;

[_name,_state] call BIS_fnc_taskSetState;

if !(_grp isEqualTo grpNull) exitWith
{
		_dest call BIS_fnc_taskSetDestination
};
