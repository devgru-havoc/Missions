//////Enhanced High&Low Script Ver2.0 by Rodeostar42//////    ///adviced by Halal///


///World index///
_mediterranean = [
"Altis",
"Stratis",
"Koplic",
"bozcaada",
"evergreen",
"SugarLake",
"Gorgona"
];
_middleeast = [
"Takistan",
"Zargabad",
"pja310",
"Shapur_BAF"
];
_winter_maps = [
"Chernarus_winter",
"utes_winter",
"anim_helvantis_v2",
"ThirskW"
];
_euro = [
"Panthera3",
"Chernarus",
"Chernarus_Summer",
"Woodland_ACR",
"ProvingGrounds_PMC",
"utes",
"Bornholm",
"Thirsk",
"sfp_wamako",
"Napf",
"sfp_sturko",
"imrali",
"imralispring"
];
_tropical = [
"pja305",
"Sara_dbe1",
"SaraLite",
"Sara",
"Porto",
"Intro",
"IslaDuala3",
"Mog",
"lingor3",
"wake",
"Atlantis"
];
_Southern = [
"abramia",
"australia"
];
_World = [
"Altis",
"Stratis",
"bozcaada",
"Takistan",
"Zargabad",
"pja310",
"Shapur_BAF",
"Chernarus_winter",
"utes_winter",
"ThirskW",
"anim_helvantis_v2",
"Panthera3",
"Chernarus",
"Chernarus_Summer",
"Woodland_ACR",
"ProvingGrounds_PMC",
"utes",
"Bornholm",
"Thirsk",
"pja305",
"Sara_dbe1",
"SaraLite",
"Sara",
"Porto",
"Intro",
"IslaDuala3",
"Mog",
"lingor3",
"abramia",
"australia",
"Koplic",
"sfp_wamako",
"Napf",
"evergreen",
"sfp_sturko",
"SugarLake",
"imrali",
"imralispring",
"wake",
"Atlantis",
"Gorgona"
];

if (!isDedicated) then {

   if ((worldName in _World )) then {

if (worldName in _mediterranean) then {

   nul=[] execVM "EHL\mediterranean.sqf";
};

if (worldName in _middleeast) then {

   nul=[] execVM "EHL\middleeast.sqf";
};

if (worldName in _winter_maps) then {

   nul=[] execVM "EHL\winter_maps.sqf";
};

if (worldName in _euro) then {

   nul=[] execVM "EHL\euro.sqf";
};

if (worldName in _tropical) then {

   nul=[] execVM "EHL\equator.sqf";
};

if (worldName in _Southern) then {

   nul=[] execVM "EHL\Southern.sqf";
};

hint "Water Temp Status Start.  World Index OK"
}
else{

   nul=[] execVM "EHL\Standard_temp.sqf";

   hint "Water Temp Status Start. Standard Temp Index"
};

   while {true} do {

_unit = player;
_uniform = uniform player;
_gear = [
   "USP_SOLR_AF",
   "USP_SOLR_AF_CBR",
   "USP_SOLR_AF_MC",
   "USP_SOLR_AF_RGR",
   "USP_SOLR_AF_NP",
   "USP_SOLR_AF_NT",
   "USP_SOLR_AF_OAK",
   "USP_SOLR_AF_CBR_OAK",
   "USP_SOLR_AF_MC_OAK",
   "USP_SOLR_AF_RGR_OAK",
   "USP_SOLR_AF_OAK_NP",
   "USP_SOLR_AF_OAK_NT",
   "USP_SOLR_AF2",
   "USP_SOLR_AF2_CBR",
   "USP_SOLR_AF2_MC",
   "USP_SOLR_AF2_RGR",
   "USP_SOLR_AF2_NP",
   "USP_SOLR_AF2_NT",
   "USP_SOLR",
   "USP_SOLR_CBR",
   "USP_SOLR_CBR_OAK",
   "USP_SOLR_MC_OAK",
   "USP_SOLR_RGR",
   "USP_SOLR_RGR_OAK",
   "USP_SOLR_NP",
   "USP_SOLR_OAK_NP",
   "USP_SOLR_NT",
   "USP_SOLR_OAK_NT",
   "USP_SOLR_OAK",
   "USP_SOLR2",
   "USP_SOLR2_CBR",
   "USP_SOLR2_MC",
   "USP_SOLR2_RGR",
   "USP_SOLR2_NP",
   "USP_SOLR2_NT",
   "USP_SOLR_TW",
   "USP_SOLR_TW_CBR",
   "USP_SOLR_TW_MC",
   "USP_SOLR_TW_RGR",
   "USP_SOLR_TW_NP",
   "USP_SOLR_TW_NT",
   "USP_SOLR_TW_OAK",
   "USP_SOLR_TW_CBR_OAK",
   "USP_SOLR_TW_MC_OAK",
   "USP_SOLR_TW_OAK_NP",
   "USP_SOLR_TW_OAK_NT",
   "USP_SOLR_TW2",
   "USP_SOLR_TW2_CBR",
   "USP_SOLR_TW2_MC",
   "USP_SOLR_TW2_RGR",
   "USP_SOLR_TW2_NP",
   "USP_SOLR_TW2_NT",
   "USP_SOLR_XP",
   "USP_SOLR_XP_CBR",
   "USP_SOLR_XP_MC",
   "USP_SOLR_XP_NP",
   "USP_SOLR_XP_NT",
   "USP_SOLR_XP_OAK",
   "USP_SOLR_XP_CBR_OAK",
   "USP_SOLR_XP_MC_OAK",
   "USP_SOLR_XP_RGR_OAK",
   "USP_SOLR_XP_OAK_NP",
   "USP_SOLR_XP_OAK_NT",
   "USP_SOLR_XP2",
   "USP_SOLR_XP2_CBR",
   "USP_SOLR_XP2_MC",
   "USP_SOLR_XP2_NP",
   "USP_SOLR_XP2_NT",
   "USP_SOLR_XP2_RGR",
   "USP_SOLR_XP_RGR",
   "USP_SOLR_TW_RGR_OAK",
   "USP_SOLR_MC"
];


if ((goggles player in _gear)&&(vehicle player == player)) then
      {

         player setFatigue 1;
      };

      sleep 1;


///Oxygen Enhanced ///

if (( vehicle player) isKindOf "Air" && ((getPosVisual (vehicle player) select 2) > 3000)&&(!(goggles player in _gear))) then {

      hint parseText format["<t size='1' color=""#FFFFFF"">We're in high altitude.jump from here?  %1 It must be equipped with oxygen helmet</t>"];
         };
            sleep 0.1;

if ((vehicle player == player)&&(!(goggles player in _gear))&&(( getPosASL (vehicle  player) select 2) > 3000 ))then {

   hint parseText format["<t size='1' color=""#FF0000"">Danger!! %1 Low oxygen concentration</t>"];

   dethcount = 0;

   private ["_black"];
   _black = ppEffectCreate ["ColorCorrections", 1500];
   _black  ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0], [0.75, 0.25, 0, 1.0]];
   _black  ppEffectCommit 10;
   _black  ppEffectEnable TRUE;

   private ["_bl"];
   _bl = ppEffectCreate ["DynamicBlur", 10];
   _bl ppEffectEnable true;
   _bl ppEffectAdjust [3];
   _bl ppEffectCommit 20;

   while {dethcount < 15} do{

if ((goggles player in _gear)or( getPosASL (vehicle  player) select 2) < 2990 )  then {

   hint parseText format["<t size='1' color=""#FFFFFF"">Oxygen concentration is normal %1 Status OK</t>"];

   ppEffectDestroy _black;
   ppEffectDestroy _bl;

   dethcount = 15;
};

   sleep 1;
   dethcount = dethcount + 1;
};

if ((vehicle player == player)&&(!(goggles player in _gear))&&(( getPosASL (vehicle  player) select 2) > 3000 ) )then {
   player setDamage 1;
};
   sleep 1;
};

};

};




