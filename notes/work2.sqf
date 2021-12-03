this addEventHandler ["HandleDamage", {(_this select 2)*0.05)}];
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


this call ace_fastroping_fnc_equipFRIES;(group this) setVariable ["Vcm_Disable",true];

this call ace_fastroping_fnc_equipFRIES; this setDir 135;
this setvariable ["CS_TYPE","TRANSPORT"];
this setvariable ["CS_CALLSIGN","Hawk One"];
(group this) setVariable ["Vcm_Disable",true];

this addeventhandler ["handledamage",{ (_this select 2) /1.005}];

this addEventHandler ["handledamage",{(_this select 2) *0.05}];

this setObjectTexture [0, "textures\Heli_Transport_03_ext01_md.paa"];
this setObjectTexture [1, "textures\Heli_Transport_03_ext02_md.paa"];

_object allowDamage 0;
(group this) setVariable ["Vcm_Disable",true];
clearWeaponCargoGlobal this;
clearMagazineCargoGlobal this;
clearItemCargoGlobal this;
this setVariable ["ace_medical_medicClass", 1];
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
this addItemCargoGlobal ["adv_aceCPR_AED", 2];



RHS_AH1Z,
RHS_AH64D_wd,
RHS_MELB_AH6M,
rhsusf_f22,
RHS_A10,
NB_MV22







this addEventHandler ["HandleDamage", {(_this select 2)*0.05)}];
(group this) setVariable ["Vcm_Disable",true];
this setVariable ["ace_medical_medicClass", 1];
clearWeaponCargoGlobal this;
clearMagazineCargoGlobal this;
clearItemCargoGlobal this;
this addItemCargoGlobal ["ACE_adenosine", 40];
this addItemCargoGlobal ["ACE_atropine", 40];
this addItemCargoGlobal ["ACE_fieldDressing", 80];
this addItemCargoGlobal ["ACE_elasticBandage", 80];
this addItemCargoGlobal ["ACE_bodyBag", 20];
this addItemCargoGlobal ["ACE_CableTie", 60];
this addItemCargoGlobal ["ACE_epinephrine", 40];
this addItemCargoGlobal ["ACE_Flashlight_XL50", 6];
this addItemCargoGlobal ["ACE_morphine", 40];
this addItemCargoGlobal ["ACE_packingBandage", 10];
this addItemCargoGlobal ["ACE_plasmaIV", 40];
this addItemCargoGlobal ["ACE_salineIV", 40];
this addItemCargoGlobal ["ACE_tourniquet", 40];
this addItemCargoGlobal ["ACE_surgicalKit", 8];
this addItemCargoGlobal ["ACE_EarPlugs", 10];
this addItemCargoGlobal ["adv_aceCPR_AED", 8];
this addItemCargoGlobal ["KAT_larynx", 20];
this addItemCargoGlobal ["KAT_accuvac", 8];
this addItemCargoGlobal ["adv_aceSplint_splint", 20];
this addItemCargoGlobal ["KAT_guedel", 20];
this addItemCargoGlobal ["KAT_X_AED", 8];
this addItemCargoGlobal ["KAT_CrossPanel", 8];
this addItemCargoGlobal ["KAT_Pulseoximeter", 8];
this addItemCargoGlobal ["KAT_ChestSeal", 20];
this addItemCargoGlobal ["KAT_bloodIV_O", 8];
this addItemCargoGlobal ["KAT_bloodIV_A", 8];
this addItemCargoGlobal ["KAT_bloodIV_B", 8];
this addItemCargoGlobal ["KAT_bloodIV_AB", 8];


(group this) setVariable ["Vcm_Disable",true]; this call ace_fastroping_fnc_equipFRIES;




clearWeaponCargoGlobal this;
clearMagazineCargoGlobal this;
clearItemCargoGlobal this;
this addItemCargoGlobal ["ACE_adenosine", 4];
this addItemCargoGlobal ["ACE_atropine", 4];
this addItemCargoGlobal ["ACE_fieldDressing", 10];
this addItemCargoGlobal ["ACE_elasticBandage", 10];
this addItemCargoGlobal ["ACE_bodyBag", 10];
this addItemCargoGlobal ["ACE_CableTie", 10];
this addItemCargoGlobal ["ACE_epinephrine", 4];
this addItemCargoGlobal ["ACE_Flashlight_XL50", 6];
this addItemCargoGlobal ["ACE_morphine", 4];
this addItemCargoGlobal ["ACE_packingBandage", 10];
this addItemCargoGlobal ["ACE_personalAidKit", 4];
this addItemCargoGlobal ["ACE_plasmaIV", 4];
this addItemCargoGlobal ["ACE_salineIV", 4];
this addItemCargoGlobal ["ACE_tourniquet", 4];
this addItemCargoGlobal ["ACE_surgicalKit", 8];
this addItemCargoGlobal ["ACE_EarPlugs", 10];
this addItemCargoGlobal ["adv_aceCPR_AED", 8];
this addItemCargoGlobal ["KAT_larynx", 20];
this addItemCargoGlobal ["KAT_accuvac", 8];
this addItemCargoGlobal ["adv_aceSplint_splint", 8];
this addItemCargoGlobal ["KAT_guedel", 4];
this addItemCargoGlobal ["KAT_X_AED", 81];
this addItemCargoGlobal ["KAT_CrossPanel", 1];
this addItemCargoGlobal ["KAT_Pulseoximeter", 81];
this addItemCargoGlobal ["KAT_ChestSeal", 4];
this addItemCargoGlobal ["DemoCharge_Remote_Mag", ];
this addItemCargoGlobal ["ACE_VMM3", 1];
this addItemCargoGlobal ["ACE_VMH3", 1];
this addItemCargoGlobal ["ACE_Clacker", 1];
this addItemCargoGlobal ["EOD_Uniform", 1];
this addItemCargoGlobal ["EOD_SUIT_vest", 1];
this addItemCargoGlobal ["EOD9_HELMET", 1];
this addItemCargoGlobal ["MineDetector", 1];


							value="[[[[""ACE_VMM3"",""ACE_VMH3""],[1,1]],[[""DemoCharge_Remote_Mag"",""rhs_mine_M19_mag""],[1,1]],[[""ACE_Clacker"",""ACE_M26_Clacker"",""EOD_Uniform"",""EOD_SUIT_vest"",""V_EOD_olive_F"",""V_EOD_coyote_F"",""EOD9_HELMET_Base"",""EOD9_HELMET"",""MineDetector""],[1,1,1,1,1,1,1,1,1]],[[""rhs_assault_umbts_engineer_empty""],[1]]],false]";



this addAction ["<t color='#551A8B'>Halo Insertion</t>", "scripts\halo.sqf"]; this addAction ["<t color='#551A8B'>Free Jump</t>", "scripts\para.sqf"];


this setDir 177; 
clearWeaponCargoGlobal this;
clearMagazineCargoGlobal this;
clearItemCargoGlobal this;
this addItemCargoGlobal ["ACE_adenosine", 4];
this addItemCargoGlobal ["ACE_atropine", 4];
this addItemCargoGlobal ["ACE_fieldDressing", 10];
this addItemCargoGlobal ["ACE_elasticBandage", 10];
this addItemCargoGlobal ["ACE_bodyBag", 10];
this addItemCargoGlobal ["ACE_CableTie", 10];
this addItemCargoGlobal ["ACE_epinephrine", 4];
this addItemCargoGlobal ["ACE_Flashlight_XL50", 6];
this addItemCargoGlobal ["ACE_morphine", 4];
this addItemCargoGlobal ["ACE_packingBandage", 10];
this addItemCargoGlobal ["ACE_personalAidKit", 4];
this addItemCargoGlobal ["ACE_plasmaIV", 4];
this addItemCargoGlobal ["ACE_salineIV", 4];
this addItemCargoGlobal ["ACE_tourniquet", 4];
this addItemCargoGlobal ["ACE_surgicalKit", 8];
this addItemCargoGlobal ["ACE_EarPlugs", 10];
this addItemCargoGlobal ["adv_aceCPR_AED", 8];
this addItemCargoGlobal ["KAT_larynx", 20];
this addItemCargoGlobal ["KAT_accuvac", 8];
this addItemCargoGlobal ["adv_aceSplint_splint", 8];
this addItemCargoGlobal ["KAT_guedel", 4];
this addItemCargoGlobal ["KAT_X_AED", 81];
this addItemCargoGlobal ["KAT_CrossPanel", 1];
this addItemCargoGlobal ["KAT_Pulseoximeter", 81];
this addItemCargoGlobal ["KAT_ChestSeal", 4];
this addItemCargoGlobal ["DemoCharge_Remote_Mag", ];
this addItemCargoGlobal ["ACE_VMM3", 1];
this addItemCargoGlobal ["ACE_VMH3", 1];
this addItemCargoGlobal ["ACE_Clacker", 1];
this addItemCargoGlobal ["EOD_Uniform", 1];
this addItemCargoGlobal ["EOD_SUIT_vest", 1];
this addItemCargoGlobal ["EOD9_HELMET", 1];
this addItemCargoGlobal ["MineDetector", 1];


(group this) setVariable ["Vcm_Disable",true];
this setVariable ["ace_medical_medicClass", 1];
clearWeaponCargoGlobal this;
clearMagazineCargoGlobal this;
clearItemCargoGlobal this;
this addItemCargoGlobal ["ACE_adenosine", 40];
this addItemCargoGlobal ["ACE_atropine", 40];
this addItemCargoGlobal ["ACE_fieldDressing", 80];
this addItemCargoGlobal ["ACE_elasticBandage", 80];
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
this addItemCargoGlobal ["adv_aceCPR_AED", 8];
this addItemCargoGlobal ["KAT_larynx", 20];
this addItemCargoGlobal ["KAT_accuvac", 8];
this addItemCargoGlobal ["adv_aceSplint_splint", 20];
this addItemCargoGlobal ["KAT_guedel", 20];
this addItemCargoGlobal ["KAT_X_AED", 8];
this addItemCargoGlobal ["KAT_CrossPanel", 8];
this addItemCargoGlobal ["KAT_Pulseoximeter", 8];
this addItemCargoGlobal ["KAT_ChestSeal", 20];
this addItemCargoGlobal ["KAT_bloodIV_O", 8];
this addItemCargoGlobal ["KAT_bloodIV_A", 8];
this addItemCargoGlobal ["KAT_bloodIV_B", 8];
this addItemCargoGlobal ["KAT_bloodIV_AB", 8];
this addEventHandler ["HandleDamage", (_this select 2)*0.05)];

this additemcargo KAT_Painkiller
