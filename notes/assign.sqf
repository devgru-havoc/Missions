_unit setVariable ["ace_medical_medicclass",1, true]; // set as medic
_unit setVariable ["ace_medical_medicclass",2, true]; // set as doctor

/*How to install: 

- Go to your Mission folder

- Open your Init.sqf and at the bottom of your init.sqf add:*/

//ranklist.sqf by Violt
[]execVM "Scripts\ranklist.sqf";
/*- Create a folder called Scripts in your mission folder. 

- Create a new .sqf file called ranklist

- Open the folder and add: */

//ranklist.sqf by Violt initially made for www.american-tactics.com
//This Script gives every player their rank and kicks players that are not in the rank list.

if (isServer) exitWith {}; // Do not delete this

sleep 2; //Delay to make sure that the script works.

//Rank and SteamID64 list
AMTAC_PRIVATE         =    [ // Private Rank
"765**************", // Your Friend
"765**************", // Your Friend
"765**************", // Your Friend
"765**************" // Your Friend

];
AMTAC_CORPORAL        =    [ // Corporal Rank
"765**************", // Your Friend
"765**************", // Your Friend
"765**************", // Your Friend
"765**************" // Your Friend

];
AMTAC_SERGEANT        =    [ // Sergeant Rank
"765**************", // Your Friend
"765**************", // Your Friend
"765**************" // Your Friend

];
AMTAC_LIEUTENANT      =    [ // Lieutenant Rank
"765**************", // Your Friend
"765**************" // Your Friend

];
AMTAC_CAPTAIN         =    [ // Captain Rank
"765**************" // Your Friend

];
AMTAC_MAJOR           =    [ // Major Rank
"765**************" // Your Friend

];
AMTAC_COLONEL         =    [ // Colonel Rank
"765**************" // You

];

_playerUID = getPlayerUID player; //Get Player UID

//check to see if the PlayerUID matches 
switch (true) do {
	case (_playerUID in AMTAC_PRIVATE)    : { player setRank "PRIVATE"; };
    case (_playerUID in AMTAC_CORPORAL)   : { player setRank "CORPORAL"; };
    case (_playerUID in AMTAC_SERGEANT)   : { player setRank "SERGEANT"; };
    case (_playerUID in AMTAC_LIEUTENANT) : { player setRank "LIEUTENANT"; };
    case (_playerUID in AMTAC_CAPTAIN)    : { player setRank "CAPTAIN"; };
    case (_playerUID in AMTAC_MAJOR)      : { player setRank "MAJOR"; };
    case (_playerUID in AMTAC_COLONEL)    : { player setRank "COLONEL"; };

    default { disableUserInput true; hint "You are not whitelisted... \nYou will be kicked back to the lobby in 30 seconds. \nIf you want to become a member visit our website for more information: \n wwww.yourwebsite.com \n \nIf you already are a member but you are getting this message then contact a staff member on TeamSpeak."; sleep 30; disableUserInput false; failMission "end1"; 
	};
};

///////////////////////////////////////////////////////////////////////

//ranks.sqf
//Original Script by hambeast
//Modified and Completed by Evan Black

// Wait for ingame
if (isServer) exitWith {}; // Do not delete this

sleep 2; //Delay to make sure that the script works.

// Rank/UID list. Use Example Below.

//UID Example: Ranks_CORPORAL        =    "7656xxxxxxxxxxxxxx","7656xxxxxxxxxxxxxx" no trailing comma
Ranks_CORPORAL        =    [];
Ranks_SERGEANT        =    [];
Ranks_LIEUTENANT      =    [];
Ranks_CAPTAIN         =    [];
Ranks_MAJOR           =    [];
Ranks_COLONEL         =    [];

_playerUID = getPlayerUID player; //get player UID

//check to see if our player matches
switch (true) do {
    case (_playerUID in Ranks_CORPORAL)   : { player setRank "CORPORAL"; }; //setRank to CORPORAL for everyone in the CORPORAL list.
    case (_playerUID in Ranks_SERGEANT)   : { player setRank "SERGEANT"; };
    case (_playerUID in Ranks_LIEUTENANT) : { player setRank "LIEUTENANT"; };
    case (_playerUID in Ranks_CAPTAIN)    : { player setRank "CAPTAIN"; };
    case (_playerUID in Ranks_MAJOR)      : { player setRank "MAJOR"; };
    case (_playerUID in Ranks_COLONEL)    : { player setRank "COLONEL"; };

    default { player setRank "PRIVATE"; }; //setting default rank for all others   
};
switch (true) do {
	case (_playerUID in ACE_MED)    : { player setVariable ["ace_medical_medicclass",1, true]; };
};
switch (true) do {
	case (_playerUID in ACE_DR)    : { player setVariable ["ace_medical_medicclass",2, true]; };
};
switch (true) do {
	case (_playerUID in ACE_EOD)    : { player setVariable ["ACE_isEOD",1, true]; };
};
switch (true) do {
	case (_playerUID in ACE_ENG)    : { player setVariable ["ace_isEngineer",1, true]; };
};
switch (true) do {
	case (_playerUID in ACE_AENG)    : { player setVariable ["ace_isEngineer",2, true]; };
};






switch (true) do {
	case (_playerUID in ACE_MED)    : { player setVariable ["ace_medical_medicclass",1, true]; };
	case (_playerUID in ACE_DR)    : { player setVariable ["ace_medical_medicclass",2, true]; };
	case (_playerUID in ACE_EOD)    : { player setVariable ["ACE_isEOD",1, true]; };
	case (_playerUID in ACE_ENG)    : { player setVariable ["ace_isEngineer",1, true]; };
	case (_playerUID in ACE_AENG)    : { player setVariable ["ace_isEngineer",2, true]; };
};

