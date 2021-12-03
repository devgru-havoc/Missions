/*======mmf_fnc_skip_time======SPAWN======local SP/ONLY
WIP, skip approximately 6 hours

null= [] spawn MMF_fnc_skip_time

*/





player switchMove "HubSpectator_stand";
player allowDamage false;

setAccTime 1600;
sleep 25;
setAccTime 1;

player allowDamage true;
player switchMove "";
[] call MMF_fnc_colorSpace;
[]  execVM "\a3\missions_f_bootcamp\Campaign\Functions\GUI\fn_SITREP.sqf";
