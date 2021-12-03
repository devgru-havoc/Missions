/*
_caller is account owner
_amount is transaction amount 	($)
_res is transaction amount	(resources)

returns [_caller, _amount (new), _res (new)]

example call:
	[player, 100, 0] call MMF_fnc_account
	private _new_bal_debt=[player, 0, -1] call MMF_fnc_account // [0, -1]
*/

params [["_caller", player, [objNull]], ["_amount", 0, [0]], ["_res", 0, [0]]];

private	_account = _caller getvariable "MMF_account";

_caller setvariable ["MMF_account", [(_account select 0) + _amount, (_account select 1) + _res]];

if (_caller in allPlayers) then {
	[
		[(format ["BALANCE: $%1", (_account select 0) + _amount]), (format ["RESOURCES: %1", (_account select 1) + _res])],
		[Text_Preset_White, Text_Preset_White]
	] call MMF_fnc_Notification;
};

[_caller, [(_account select 0) + _amount, (_account select 1) + _res]];
