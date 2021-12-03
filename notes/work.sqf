/*
null=[this,[0,0,1.5],[0,0,1],21000,true] execvm "scripts\AL_ambient_light\al_spot.sqf";



////////////////////////////////////////////////////////////////////////////////
// Helicopter-door-opening-script by Delta8.																	//
// http://www.armaholic.com/page.php?id=27385																	//
////////////////////////////////////////////////////////////////////////////////

0 = execVM "msk\[MSK]_HD.sqf";
compile preprocessFileLineNumbers "msk\[MSK]_HD.sqf";



////////////////////////////////////////////////////////////////////////////////
// add on free radio 																													//
// will dectect acer and tfar and disable
////////////////////////////////////////////////////////////////////////////////

_afar = [] execVM "AFAR\init.sqf";
waitUntil {scriptDone _afar};



_killhouse_1 = [killhouse1,40] execVM "scripts\reset.sqf";
_killhouse_2 = [killhouse2,20] execVM "scripts\reset.sqf";
_killhouse_3 = [killhouse3,20] execVM "scripts\reset.sqf";
this addAction ["Reset targets", {killhouse_1 = [killhouse1,40] execVM "scripts\reset.sqf";}];
this addAction ["Reset targets", {killhouse_2 = [killhouse2,20] execVM "scripts\reset.sqf";}];
this addAction ["Reset targets", {killhouse_3 = [killhouse3,420] execVM "scripts\reset.sqf";}];

this addAction ["<t color='#551A8B'>Halo Insertion</t>", "scripts\halo.sqf"]; this addAction ["<t color='#551A8B'>Free Jump</t>", "scripts\para.sqf"];


this setDir 177; clearWeaponCargoGlobal this;
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