_object allowDamage false;
(group this) setVariable ["Vcm_Disable",true];
this setVariable ["ace_medical_medicClass", 1];
clearWeaponCargoGlobal this;
clearMagazineCargoGlobal this;
clearItemCargoGlobal this;
this addItemCargoGlobal ["ACE_adenosine", 40];
this addItemCargoGlobal ["ACE_atropine", 40];
this addItemCargoGlobal ["ACE_fieldDressing", 80];
this addItemCargoGlobal ["ACE_elasticBandage", 80];
this addItemCargoGlobal ["ACE_bloodIV", 40];
this addItemCargoGlobal ["ACE_bodyBag", 20];
this addItemCargoGlobal ["ACE_CableTie", 60];
this addItemCargoGlobal ["ACE_epinephrine", 40];
this addItemCargoGlobal ["ACE_Flashlight_XL50", 6];
this addItemCargoGlobal ["ACE_morphine", 40];
this addItemCargoGlobal ["ACE_packingBandage", 80];
this addItemCargoGlobal ["ACE_personalAidKit", 40];
this addItemCargoGlobal ["ACE_plasmaIV", 40];
this addItemCargoGlobal ["ACE_salineIV", 40];
this addItemCargoGlobal ["ACE_tourniquet", 40];
this addItemCargoGlobal ["ACE_surgicalKit", 8];
this addItemCargoGlobal ["ACE_EarPlugs", 10];
this addItemCargoGlobal ["adv_aceCPR_AED", 4];



[objNull, this] call ace_medical_fnc_treatmentAdvanced_fullHeal;
