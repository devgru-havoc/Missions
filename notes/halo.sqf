
_caller = _this select 1;
_face  = ["MRH_HaloMask"];
_Chute = ["MRH_AADEquippedParachute", "B_Parachute"];
_RChute = ["MRH_AADEquippedParachute", "B_Parachute"];
_watch = ["MRH_AADEquippedParachute", "B_Parachute"];
_items = items player;


if (not ((backpack _caller) in _Chute)) exitwith {_caller groupchat "You will need a steerable parachute with aad, Burn Baby Burn.";};
_caller groupchat "chute check!";

if (not ((items _caller) in _RChute)) exitwith {_caller groupchat "You will need a steerable parachute with aad, Burn Baby Burn.";};


if (not(_RChute in _items)) exitwith {_caller groupchat "You will need a reserve parachute with aad, Burn Baby Burn.";};
_caller groupchat "reserve chute check!";
if (not ((face  _caller) in _watch )) exitwith {_caller groupchat "You will need a proper face Mask , Not Dressed Like that, this is not your high school prom.";};





if (not ((backpack _caller) in _Chute)) exitwith {_caller groupchat "You will need a steerable parachute with aad, Burn Baby Burn.";};




// required jump gear
_rqdHeadgear_P = _logic getVariable "vqi_module_leap_rqd_headgear_p";
missionNamespace setVariable ["VQI_LEAP_RQD_HEADGEAR_P", _rqdHeadgear_P];
VQI_LEAP_RQD_HEADGEAR_P = VQI_LEAP_RQD_HEADGEAR_P splitString ", ";

_rqdFacewear_P = _logic getVariable "vqi_module_leap_rqd_facewear_p";
missionNamespace setVariable ["VQI_LEAP_RQD_FACEWEAR_P", _rqdFacewear_P];
VQI_LEAP_RQD_FACEWEAR_P = VQI_LEAP_RQD_FACEWEAR_P splitString ", ";

_rqdMiscgear_P = _logic getVariable "vqi_module_leap_rqd_miscgear_p";
missionNamespace setVariable ["VQI_LEAP_RQD_MISCGEAR_P", _rqdMiscgear_P];
VQI_LEAP_RQD_MISCGEAR_P = VQI_LEAP_RQD_MISCGEAR_P splitString ", ";


// required halo gear
_rqdHeadgear_H = _logic getVariable "vqi_module_leap_rqd_headgear_h";
missionNamespace setVariable ["VQI_LEAP_RQD_HEADGEAR_H", _rqdHeadgear_H];
VQI_LEAP_RQD_HEADGEAR_H = VQI_LEAP_RQD_HEADGEAR_H splitString ", ";

_rqdFacewear_H = _logic getVariable "vqi_module_leap_rqd_facewear_h";
missionNamespace setVariable ["VQI_LEAP_RQD_FACEWEAR_H", _rqdFacewear_H];
VQI_LEAP_RQD_FACEWEAR_H = VQI_LEAP_RQD_FACEWEAR_H splitString ", ";

_rqdO2system_H = _logic getVariable "vqi_module_leap_rqd_o2system_h";
missionNamespace setVariable ["VQI_LEAP_RQD_O2SYSTEM_H", _rqdO2system_H];
VQI_LEAP_RQD_O2SYSTEM_H = VQI_LEAP_RQD_O2SYSTEM_H splitString ", ";

_rqdJumpsuit_H = _logic getVariable "vqi_module_leap_rqd_jumpsuit_h";
missionNamespace setVariable ["VQI_LEAP_RQD_JUMPSUIT_H", _rqdJumpsuit_H];
VQI_LEAP_RQD_JUMPSUIT_H = VQI_LEAP_RQD_JUMPSUIT_H splitString ", ";

_rqdMiscgear_H = _logic getVariable "vqi_module_leap_rqd_miscgear_h";
missionNamespace setVariable ["VQI_LEAP_RQD_MISCGEAR_H", _rqdMiscgear_H];
VQI_LEAP_RQD_MISCGEAR_H = VQI_LEAP_RQD_MISCGEAR_H splitString ", ";
