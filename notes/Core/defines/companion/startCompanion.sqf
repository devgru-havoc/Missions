/*============================mmf_fnc_start_companion=====================SPAWN=============automatically create player follower

Creates a follower of player's side, on player position with player's current loadout

EXMAPLE
[player, side player] spawn MMF_fnc_start_companion

*/


	params ["_caller", "_side"];

if (isMultiplayer) exitWith {false};

waitUntil {sleep 1; _caller getVariable ["MMF_inCamp", false]};

MMF_companionArr=[];

private _grp=[_caller, _caller, 1, _side, (_caller getVariable ["MMF_side", [WEST]] select 0), "SAFE", MMF_companionArr, false, false, 0, "MOVE"] call MMF_fnc_soldiers;

leader _grp setUnitLoadout (getUnitLoadout _caller);

leader _grp call MMF_fnc_companion;
