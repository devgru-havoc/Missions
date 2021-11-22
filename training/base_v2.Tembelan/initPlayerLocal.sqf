#include "script_component.hpp"
/*
* Author: Theseus incorporated
* initialization of scripts local to player
* executed locally when player joins mission (includes both mission start and JIP)
* executed after initServer and before initplayerServer and init.
*
* Arguments:
* 0: player <OBJECT>
* 1: Did JIP <BOOL>
*
* Return Value:
* None
*
* Example:
* None
*/



if (player getVariable ["isSneaky",false]) then {
    [player] execVM "INC_undercover\Scripts\initUCR.sqf";
};
