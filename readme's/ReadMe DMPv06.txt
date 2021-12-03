Drongo's Map Population
for Arma 3
v06

by Drongo
28 August 2021

Discord for my mods: https://discord.gg/XSRHPEd
Support me on Patreon: https://www.patreon.com/DrongoMods

REQUIREMENTS
Arma 3

OVERVIEW
Quickly and easily populate an entire map with any faction, no scripting required
Spawns patrols, garrisons, vehicles, air units, ships, occupied towns, HVTs, civilians, IEDs, VBIEDs, suicide bombers, SAM sites, abandoned vehicles, caches and loot
Mission generator (Kill, Recon, Destroy Squad, Destroy Vehicles, Clear, SEAD, Rescue, Interdict, Demo, Destroy Ships, Destroy Aircraft, Deliver, Clear Mines, Meet Leader, Find Cache)
Semi-persistent dynamic campaign (insurgency/COIN theme)
Semi-persistent dynamic campaign (frontline combat theme)
Place and play mission modules (go here, kill this, demo this building, defend here, clear this area, extract, hack, rescue, interact, destroy convoy, deliver)
HVT hunt open-world mission
Optional stealth gameplay
Tweak most settings through modules
Any mod, any map
Easy setup
WIP RPG system with XP, levels, skills and survival aspects (food, weather, exposure, poison, infection, etc)
Optional modules for skill, knockdown, infoshare, random time/weather and more
Stealth gameplay
Civilian/POW interaction
Morale system with surrender and panic
HETMAN - Artificial Leader [NR6 Edition] support
Persistent tasks

There are demo missions in the mod folder.


BASIC USE
Place a DMP Core module at the center of your desired AO
Select the desired AO size (values larger than the map will not go out of map bounds)
Place a Define Faction module
Adjust the composition options
Place the desired units and vehicles you wish to make up the faction within 200 meters of the Define Faction module
Upon mission start, the system will read and delete the units and use their classNames as the basis for spawning groups
If no units are placed, the module will default to a simple NATO force

Note: It is a good idea to right click on all placed units, go to Attributes > Special States and uncheck all boxes.

For more control about which classNames are used, set the rank of units according to this list:

COLONEL:	Leaders/HVTs
MAJOR:		Pilots
CAPTAIN:	Vehicle crew
SERGEANT:	Squad leader

Units with "pilot" or "helicrew" in their classname will be added to pilots
Units with "crew" in their classname will be added to vehicle crew
Units with "iconmanleader" as their icon will be squad leaders


FACTION AO
Each faction can have its own sub-AO within the primary AO. Place a "Faction AO" module and enter the faction name as it appears in the "Define Faction" module. Groups from that faction will only spawn within that AO. Note that Air, UAV and Long Patrol groups will patrol the entire AO, not just the Faction AO.


DELAYING STARTUP
The Core module has options to delay spawning by X seconds or until dmpWaitForGo=FALSE is set on the server (use dmpWaitForGo=FALSE;publicVariable"dmpWaitForGo").


EDITING
Each unit will have text variables called dmpFaction and dmpAItype which can be checked by getVariable. For example

systemChat format["%1",(_unit getVariable"dmpAItype")];

or more robustly:

if!(isNil{_unit getVariable"dmpAItype"})then{systemChat format["%1",(_unit getVariable"dmpAItype")]};


INTERACT KEY
In "HVT Hunt" missions, players can use their interact key to interrogate civilians and civilian leaders. The key is user action 10 and can be bound under Options > Controls > Custom Controls.


CUSTOM SCRIPTS
Men and units can have a custom script which is executed on each unit shortly after it is spawned using execVM. This happens at the mission level. For example, if you have a folder called MyScripts in your mission folder and an sqf file called EditMan.sqf, you would put this in the module script field:

MyScripts\EditMan.sqf

Do not use quotes: "MyScripts\EditMan.sqf" will not work.

The file might contain something like this:

private["_man"];
_man=_this;
// Execute code here


CIVILIAN MODULE
Air, vehicle, compound and leader groups will be spawned at mission start. Pedestrians are dynamically spawned in buildings around players. Like the Define Faction module, units and vehicles within 200m of the module will be spawned. If no such units are placed, vanilla civilian men and vehicles will spawn. Men that are set to rank Colonel will be used as civilian leaders.

Civilian approval is used in the HVT hunt mission. Approval is the chance that civilians will pinpoint civilian leaders. Approval is also the chance that civilian leaders will pinpoint HVTs.


ABANDONED VEHICLE MODULE
Spawns abandoned vehicles around the map. Like the Define Faction module, units and vehicles within 200m of this module will be spawned. If no such units are placed, vanilla civilian men and vehicles will spawn.


SHIP MODULE
Spawns ships in water areas within the AO. Like the Define Faction module, units and vehicles within 200m of this module will be spawned. If no such units are placed, NATO men and boats will spawn.


BLACKLIST MODULE
The blacklist module has a radius of 500. This will (mostly) prevent units from spawning in this area.


AMBIENT FACTION MODULE
Similar to the civilian module, this spawns a faction in buildings around the player. It only spawns infantry, no vehicles or statics. It is recommended to only run a single instance of this module at one time. High values may have a big impact on performance. The faction is defined as follows:

SERGEANT:	Squad Leader


LOOT MODULE (new version)
This module builds lists of gear based on all loaded mods. Loot can then be spawned dynamically around players or with one static wave at mission start. This module is required for Abandoned Vehicle loot and Traders.


MISSION GENERATOR
The module generates random missions based on the spawned forces. One side must be designated as the enemy (the target of the generated missions).

Recon:				Move to the task marker
Kill:				Kill the HVT near the task marker
Destroy Squad:		Destroy the designated group near the task marker
Destroy Vehicles:	Destroy the designated vehicles near the task marker
Clear:				Kill all enemy forces within 200 meters of the task marker
SEAD:				Destroy the designated radar/AA vehicles near the task marker
Rescue:				Rescue the captive near the task marker
Interdict:			Destroy the designated group before it reaches the task marker
Demo:				Destroy the designated structure near the task marker
Destroy Ships:		Destroy the designated ships near the task marker
Deliver:			This requires at least one vehicle to be synced to a [TASK] Designate Deliver Vehicles module. A compound or town will be selected and one of 	the vehicles must be delivered to the position
Clear Mines:		Clear the area of mines (requires editor-placed mines or the IED module to generate targets)
Meet Leader:		Interact with the designated civilian leader
Find Cache:			Find the cache in the designated area and interact with it to report it

You can also sync a unit or object to the mission generator module. That unit will get an action that lets players get a single new mission.

As of version 0.4, there is also a dynamic campaign that saves progress between sessions.


DEFINE DEMO/DEFINE RESCUE
These two modules can be used to overwrite the default targets used in generated Demo and Rescue missions. Sync the desired objects to the modules. Demo can only accept empty non-man objects. Rescue can only accept men.


HVT Hunt
There is also a "HVT Hunt" mission that can be enabled (and run without any other missions). This mission requires the players to find and kill all HVTs on the map. Players can use the interact key to ask civilians where the closest civilian leader is. Civilian leaders can be asked where the closest HVT is. The chance of a helpful answer is equal to the Civilian Approval rating. Civilians and civilian leaders can only be interrogated once every 3 minutes.


OCCUPIED TOWN
Force an occupied town to spawn at the module location. The Faction Name field must match the Faction Name field from a Define Faction module. Requires a Mission Generator module to be present.


STATIC MISSION MODULES
These modules require the Mission Generator module. Instead of being randomly generated, they will generate a mission at the module location. These modules will integrate with the Mission Generator for calculating victory points/mission end. Most modules also have an option to run a user script once the mission is completed.


Defend:		Groups will spawn at generated points around the module location and attack. The Faction Name field must match the Faction Name field from a Define Faction module.

Objective:	Same as the "Clear" mission type. Does not generate enemy forces. To capture the objective, units of the designated side must be within the designated radius and no enemy units can be present in the radius.

Kill:		Sync the desired targets to the module. Each of these units must be killed or destroyed to complete the mission.

Go:			One or more player units must move to within 20 meters of the module location to complete the mission.

Demo:		The closest building to the module (within 20 meters) will be selected as a target. This building must be destroyed to complete the mission.

Extract:	If one of these modules is placed, after completing all other missions all players must move within 20 meters of this location. There is also an option to generate an extraction point based on the location of players.

Kill Count:	Kill the specified amount of units on the specified side.

Deliver:	Sync desired units to the module. If at least one of them gets within 50m, the mission will be completed. If All vehicles are destroyed, the entire 	mission will end.

Hack:		Sync desired object to hack to the module. The object will get a hack option that the player must activate.

Interact:	Sync desired unit/object to interact with to the module. The object will get an interact option that the player must activate.

Rescue:		Sync desired unit to interact with to the module. The object will get a rescue option that the player must activate. Depending on module settings, if the unit is killed, the mission will be failed.

Prevent Arrival:	Sync desired enemy units to the module. If any of them reach the module, the mission will fail. If all units are killed/damaged enough, the mission will be successful.

Hold:		At least one friendly unit must be in the radius. If an enemy enters the radius and no friendly units are present, the mission will fail. If this does not happen before time is up, the task is successful.

Kill side:	The target side must be reduced to the number specified in the module.


AAA SITES MODULE
Radar, SAM and SPAAG groups will be spawned at mission start. A security patrol can also be spawned. Like the Define Faction module, units and vehicles within 200m of the module will be spawned. If no such units are placed, vanilla NATO men and vehicles will spawn. Men that are set to rank Colonel will be used as leaders. Other ranks will be used as crew. Drones will automatically have drone AI spawned.

The Faction Name field must match the Faction Name field from a Define Faction module.


SPAWNER MODULE
The spawner module will spawn units according to the settings in the module. The Faction Name field must match the Faction Name field from a Define Faction module. If there are units synced to the module, the module will stop spawning when all of those units are destroyed (to simulate destroying a factory, barracks, etc).


AI MODULES
These modules are for syncing to groups placed in the editor. They run AI scripts on the synced group(s).
Assault:		Synced groups will assault the module position
Garrison:		Synced groups will garrison within 200m of their start position
Long Patrol:	Synced groups will go on deep recon patrols starting at their start position
Move To:		Synced groups will move in a convoy to the module location
Patrol:			Synced groups will patrol around their start position
Road Patrol:	Groups will patrol from location to location, starting at their start position
Hunt:			Groups will find the closest group on an enemy side and move to it (updated every 120 seconds)
Parachute:		Groups will spawn parachute in at above the module location at the height specified, then execute an AI script upon landing
VBIED:			(SYNC TO DRIVER) The synced driver will operate his vehicle in the same fashion as units spawned by the [POP] VBIED module
Suicide Bomber:	(SYNC TO MAN) The synced man will act in the same fashion as units spawned by the [POP] Suicide Bomber module
Patrol Structures:	Synced groups will patrol from structure to structure within the specified radius of their start position

CUSTOM SOUNDS
The Mission Generator module has an option for custom sounds for mission start, win and loss. Use the class name of the sound. More info:

https://community.bistudio.com/wiki/Description.ext#CfgSounds


GO CODES
You can delay the start of the spawning from a Define Module by giving it a string as a go code. The spawning will wait until the desired go code is added to dmpGoCodes. For example, if you give a go code like MY_GOCODE:

dmpGoCodes pushBack"MY_GOCODE";
publicVariable"dmpGoCodes";

It is possible to use multiple gocodes. For example:

Mission 1: Go Code Out: cat
Mission 2: Go Code Out: dog
Mission 3: Go Code In: cat,dog

Mission 3 will not start until both Mission 1 and Mission 2 have been completed.


PARACHUTE MODULE
Sync an object to the module. This object will have an option for players to select a dropzone on the map and drop in. Once in the air, players will have an option to open their chute (and those of any AI dropping with them).


TRADERS MODULE
This requires the loot module to be present. The module can spawn traders as detailed in the module settings. In addition, any synced units will be designated as traders. Units that are not synced, but are near the module will be indexed as unit types traders can spawn as

The variable that controls how much money a player has is local to each client. The variable name is named dmpPlayerCash.


CACHES
This spawns boxes around the map that may be used for Find Cache missions


OTHER
There is an internal script to change any unit's clothing into random insurgent gear: this execVM"DMP\Scripts\Misc\Insurgent.sqf";


SAVING/LOADING MAP INDEX
Map index refers to the arrays of locations, remote areas, water areas and compounds. It is possible to save them for a given mission/map and load them instead of generating them at the start of each mission. This may dramatically reduce startup time.

Here are the steps:

1) Set up the mission as desired (Save and Load option must both be FALSE)
2) Start the mission once with Save set to TRUE
3) Once the mission has generated positions the message "DMP map index saved" will be displayed and the mission will end
4) Set Save to FALSE
5) Set Load to TRUE
6) From now on, the current mission will load the index at mission start instead of generating it

If at any time you wish to change the saved index, start over from step 1.

MISSION GO CODES
Mission modules have fields for Go Code IN and Go Code OUT. Go Code IN is a string that must be added to dmpGoCodes before the mission appears. Go Code OUT is the string that is added to dmpGoCodes when the mission is complete. For example:

Module A (Go)
IN:
OUT: MY_RANDOM_STRING

Module B (Demo)
IN: MY_RANDOM_STRING
OUT: MY_RANDOM_STRING_2

Module C (Hack)
IN: MY_RANDOM_STRING_2
OUT:

At mission start, only the Go mission will appear. Once it is complete, the Demo mission will appear. Once that mission is complete, the Hack mission will appear. Once the Hack mission is complete, the mission will end.


DYNAMIC FRONTLINE CAMPAIGN
This is a remake of my Random Displacements Campaign. Fight a series of missions across the map in conventional force-on-force battles.

Place a "* Dynamic Frontline Campaign *" module (do not place a Mission Generator module). The module must be placed at the starting position of friendly forces. AOs will be generated based upon this position. If a mission is won, the players will fight over the next AO in the next mission. If they lose, they will fight over a previous AO. If the players lost a battle on the first AO (closest to the module), the campaign will be lost. If the players win a battle on the final AO (furthest from the module) they will win the campaign. It is also possible to set a limit of battles that can we won/lost to end the campaign.

Each battle will have a number of randomly generated objectives to be captured (cleared of enemy forces and occupied by friendlies). It is also possible to generate side-missions (the same missions as generated by the Mission Generator module).

Posture is an indication of whether the player side is on the offensive or defensive. -1 or 0 means the players will have a defend mission, 1 or 2 means an attack mission. Winning a battle adds 1 point to posture, losing a battle deducts 1 point. The value can not go below -1 or above 2.

Multiple enemy factions can be generated, but only one will be used for each mission. So it is possible to make an infantry, armour, etc themed faction for a campaign, but only one will be randomly selected each mission. So the players might be fighting an infantry force in one mission and a mechanized force the next.

IMPORTANT: Each faction must have DFC in the go-code field.

If the news report option is turned on, at the end of each battle and an AAN news report describing the battle will be broadcast to each player. Mission creators can also set an array of pictures to be randomly selected for use in these reports. They can also set a single specific image for each campaign victory and campaign defeat.


INFOSHARE
Infoshare will share a group's targets with all other groups on its side. There are no special scripts for reacting to these targets, though default BIS behaviour or 3rd party AI scripts may benefit from this information. The "Aggressive AI" option will make AI more reactive, but may interfere with editor waypoints and AI scripts.

A group can be excluded with:

YOUR_GROUP_NAME setVariable["dmpInfoShareExclude",TRUE,TRUE];


RPG
DMP now includes a WIP RPG skill/needs system. See the RPG text file for more information.


LIMITING STATIC MISSIONS
As of version 0.469, there is a module to allow limiting static missions. This means a mission editor can set dozens of crafted custom missions using the [TASK] modules, and the desired number will be selected for use (all others will be deleted). This allows a balance between random and crafted tasks.

In addition, it is possible for players to select the number of static missions in the lobby by posting this code into description.ext:

class Params
{
	class dmpStaticMissionsParam
	{
		title="DMP Static Mission Count";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		default=0;
	};
};


STEALTH
As of version 0.47, there is a Stealth Area module (perhaps more accurately called "detection"). Groups in this area will follow their usual AI patterns (waypoints, AI scripts etc). However, when alerted (by spotting an enemy, going into combat mode (optional) or seeing a dead body) they will alert all other groups in the area. Alerted groups will go into COMBAT mode and (optionally) switch to Search And Destroy waypoints.

In daylight, bodies can be spotted at up to 100m, at night time up to 10 meters.

There is an option to have the alert end after a certain duration. However, 3rd party AI scripts and the engine may override this.

Note that the script option parses the position of the stealth area to the called script.

UNDERCOVER
Players synced to this module will be setCaptive TRUE, making them side CIVILIAN. If they get too close to an enemy they will be revealed. Wearing non-civilian gear, carrying weapons, wearing NVGs or wearing large backpacks (optional) will allow enemies to reveal them at longer distances. The prohibited items are:

Weapons that are not concealed (can be concealed in bags, uniforms or vests)
Vests with more than 0 armour
Military headgear (including caps etc)
Backpacks larger then assault packs
NVGs

Headgear, vests and uniforms can be custom defined by adding them to the array dmpUndercoverClothes. Alternatively, dummy men that are synced to the undercover module will have their headgear, vests and uniforms automatically added to the array (and the dummy deleted).

The distance at which detection occurs can be set in the module. Enemies must have line of site and a sufficient knowsAbout value to reveal the player. Once a player's cover is blown, it can not be recovered except by script.

The system can be called from a script on a player's client with:

[]execVM"DMP\Scripts\Stealth\Undercover.sqf";

or for custom values, use the following:

[
"FALSE", // debug
"FALSE", // civs can detect
"FALSE", // weapons are allowed
"FALSE", // large backpacks are allowed
5, // alert distance
300, // alert distance with a weapon,
200, // alert distance for clothes, gear, pack etc
3, // alert distance if in a vehicle (not a bike)
2, // knowsAbout threshold
1 // cycle length in seconds
]execVM"DMP\Scripts\Stealth\Undercover.sqf";


RESTRICTED AREAS
These modules create areas that require a pass card (dmpPassCard) to enter. The card must be in the vest or uniform of the player. If a player is spotted in one of these areas without a card, their cover will be blown.


SKIPTIME
Objects synced to this module will have an action attached the them. This action will display a dialog that allows players to skip time an number of hours (the skip time will happen on the server and all clients).


SUB AO
This module allows DMP to choose a location from the main AO and then resize the AO around that point. It randomly selects a town, compound or remote area from anywhere in the main AO and then resizes and recalculates the AO before spawning units or tasks.


EXTRA AO
This module adds an extra AO in another part of the map. The pool of locations and areas will be shared with the main AO. Groups may travel between AOs.


INTERACTION
This allows asking civilians and captives about civilian leaders, HVTs, troops, caches, captives and user-defined topics. Features:

Each side has a value between 0 and 100 defining their relationship.
This value is the % chance that a civilian will talk to players from that side.
Each civilian or captive has a chance of knowing about HVTs, caches etc.
Killing or detaining civilians will reduce the relationship.
If the language defined for each side is different, only players designated as interpreters can talk to civilians.
Players can be designated as interpreters with the Unit Attributes module.
Captives can be disarmed
Captives can be "dismissed" which deletes the unit

MORALE
Morale is checked under the following conditions:

The group leader is killed
The group takes its first casualty
The group takes 1/3 or 2/3 casualties

The base chance of passing a morale check will be reduced by casualties, losing a leader or a fleeing leader. Friendlies in the area will increase the chance. If morale breaks, the group may surrender if enemies are nearby. If the Interaction module is placed, surrendered units can be interrogated.

If the group does not surrender, the members will panic. Panic means some units may cower, all of them will have allowFleeing set to 1 and their skill set to 0.2.

Enemy soldiers can also be challenged to surrender with the DMP interact key. The target must be within 10 meters and under the cursor. The chance to surrender is based on if the target is armed or not, how many units remain in its group and whether the challenge comes from the front or behind.


HETMAN support
This module integrates DMP "Objective" and "Defend" sites into HETMAN (including those generated by DFC, [TASK] modules or the Mission Generator). It only works with HETMAN - Artificial Leader [NR6 Edition].


CACHING
Caching is an attempt to improve performance. It disables AI and simulation on certain units. Notes:

Group leaders will still be simulated and have full AI
Cached units can still take damage
Air groups do not cache
Player groups do not cache
Units will un-cache under the following conditions:
- the group takes casualties
- the group leader changes
- the group enters combat mode
- a player comes within range
- enemies come within range


TERMINALS
This module provides actions and dialogs on objects that can be used as terminals (useful for stealth missions). The security mode allows the user to disable and hack drones. The general mode allows user-specified custom scripted actions.

Setup:
Sync computer/terminal objects to a [VAR] Terminals module
Sync desired sub-system drones to the same [VAR] Terminals module (or place them in the set radius)
Set the password and radius in the module (an empty password means no password)
NOTE: If synced objects are given unique names in their attributes, they will display that name in the dialog (with underscores removed). For example, Main_Security_Terminal will be referred to as "Main Security Terminal" in the dialog.

The Actions field allows custom actions to be executed. The format is:

[[""Action name 1"",""Path\ScriptName1.sqf""],["",""]]

This can also be set by script:

_myArrayOfActions=[[""Action name 1"",""Path\ScriptName1.sqf""],[""Format HDD"",""Scripts\Format.sqf""]];
_object setVariable[_myArrayOfActions,TRUE];


INNAWOODS
This module spawns random people (campers, hunters, hikers), camps, stashes, weird sites and spooks in wooded areas. Synced units with rank PRIVATE will be used as neutral, other ranks will be used as killers. If Drongo's Spooks and Anomalies is installed, Wendigos and Snatchers may be spawned.


PERSISTENT TASKS (requires Mission Generator module)
These are tasks that persist between mission restarts. Once they are completed, they will no longer appear. Once all are completed, the "campaign" will be considered complete.

GO:		Go to this location
KILL:	Kill all synced units/objects
CLEAR:	Remove all enemy types from the area
DEMO:	Destroy the closest building
RESCUE:	Rescue the synced unit


PERSISTENT OBJECTS (WIP)
This module will save all vehicles and objects on a map (location, condition, non-human cargo). Objects can be excluded with this code:

_object setVariable["dmpDontSave",TRUE,TRUE];

Men/groups will not be saved.


KNOWN BUGS
Camps sometimes spawn close to roads
Garrison units and crates sometimes spawn under floors


HOW TO REPORT BUGS
If you encounter a problem, first try using the demo mission with no other mods loaded. If that works, then start adding mods until you find the conflict, then report the conflict. Vague reports such as "it doesn't work" or "I got a script error" are impossible for me to troubleshoot. Please provide specific information such as map and mods used, exact error messages, screenshots, etc.

If NATO units are spawning instead of the units you placed near the Define Faction module, please set the faction debug option to "Detailed". Take screenshots and paste the debug text to a .txt file and contact me at drongomods@gmail.com


LINUX USERS
Please read this if you are having issues:
https://community.bistudio.com/wiki/Arma_3:_Dedicated_Server#Case_sensitivity_.26_Mods


THEFT OF MY WORK
My artillery mod was stolen, edited and re-released in violation of the license by BlackAlpha of tier1ops.eu. Here is a video showing my original work and his stolen edit:

https://www.youtube.com/watch?v=Oe7G6WwxQVU

Please share this video and let the community know that BlackAlpha and tier1ops.eu are thieves.


CREDITS
Drongo69:		Concept and coding
Kokuroku:		Help fixing the NATO spawn bug
miaou:			Help fixing the NATO spawn bug
VedKay:			MP testing, RPG item icons, some IED scripting
George Floros:	Temperature script
EO:				Tent storage configs
Sly:			Camping concept (RPG)
heretyk:		Skill module fix

Special thanks to VedKay for all his work behind the scenes

A huge thanks to my Patrons and supporters:
Andreas Nilson
Ave Sum
Azza
B. Hinton
Beags and Jam
Ben_at_Arms
Berl Ancell
Bretto1945
Bruno Roberto Corrêa
Cedric Oliver
Chris Hall
David Catley
David Husa
Declan Emery
Desmond Abrams
Doctor
EO
Fearmonger
Fetus114
Ferdinand
Frédérick Milhomme
Gary Jackson
Gordon
gsg94490
Haakon Longbeard
Hogosha
Ian Schonely
James tribbles
Jason Dotson
Jason Kieft
Jayrad
JimmyJamJams
Jonathan Harris
Karol Zaczek
Kelvin P
Kenneth Kilvington
Kevin Kelly
Logan Scott
LONEWOLF352
Marshall Bouldin
Matt Henderson
Magoo
Nam
Nicholas Auger
Nicholas Odgers
Nick Gregory
Ole Petter Johnsen
Owen Siegfried
Paramarine Task Force
Paul T
Pernox
PHILLIP HARRIS
Proxno
Pusu npt
Ryan
Rolly uk
Sean Martin
sebastiaan reedijk
SETH BARCELLO
Sly
Slav_Man_Shae
Sonny Hermansen
Stuart Burling
swagggenius
Terrance
The One on the Rock
Timothy Hill
Tim O’Ceallaigh
Totem
tunou xiong
VedKay
ViperBAT46 DTF46
WW3andMe
YonV
Zakuaz


CONTACT
I put a lot of time and effort into my mods. I support single, coop and MP players with unique mods and new features. Please show your support, subscribe, follow and rate my mods. Please promote my work on social media and forums. If you have cash to spare, please consider chipping in to my Patreon https://www.patreon.com/DrongoMods

Most of my mods and missions are released on my Patreon page. You don't need to be a Patron to download them: https://www.patreon.com/DrongoMods

Check my YouTube channel for trailers, WIP etc:
https://www.youtube.com/channel/UCrZtKPYPS9iYzu1EAzTLYgg

I am not on the BIS forums. I can be emailed at drongomods@gmail.com.
I am not on social media, so I would appreciate it if those of you who are would help promote my mods.


LICENSE
Arma Public License No Derivatives (APL-ND)
https://www.bohemia.net/community/licenses/arma-public-license-nd
Brief summary of this Licence

PLEASE, NOTE THAT THIS SUMMARY HAS NO LEGAL EFFECT AND IS ONLY OF AN INFORMATORY NATURE DESIGNED FOR YOU TO GET THE BASIC INFORMATION ABOUT THE CONTENT OF THIS LICENCE. THE ONLY LEGALLY BINDING PROVISIONS ARE THOSE IN THE ORIGINAL AND FULL TEXT OF THIS LICENCE.

With this licence you are free to adapt (i.e. modify, rework or update) and share (i.e. copy, distribute or transmit) the material under the following conditions:

    Attribution - You must attribute the material in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the material).
    Noncommercial - You may not use this material for any commercial purposes.
    Arma Only - You may not convert or adapt this material to be used in other games than Arma.
    No Derivatives - If you remix, transform, or build upon the material, you may not distribute the modified material.

In addition to the above license, the following conditions apply:
This addon may not be used as a tool by any corporate, government, military, law enforcement or security groups/individuals.
This addon may not be used for any commercial purpose.
This addon may not be used for training purposes.

If you need an exception, please contact me.


CHANGELOG
0.6
Fixed:		Bug with Patrol Parameters
Fixed:		Fake news in DFC news reports
Fixed:		Bug with Set skill module (thank you heretyk)

0.59
Added:		Faction AO module (factions can now have their own sub-AO of the main AO)
Added:		Patrol Parameters module for spawned patrols (wander, perimeter, buildings)
Fixed:		Bug with Mission: Talk module

0.58
Added:		Persistent Objects module (WIP)
Added:		AAN News articles describing the battle at the end of every DFC mission
Added:		Types of objects that can supply water
Added:		EndMission module
Added:		Minimum enemy count to Objectives
Added:		Animals to editor
Fixed:		Sometimes Persistent Tasks did not save
Fixed:		Camping lamps did not work in MP

0.57
Fixed:		Ambient cars despawning near players
Fixed:		Drones crashing after spawn
Fixed:		Script error with Spawner module

0.56
Added:		Limit Static Missions module can now use type "ALL"
Added:		Support for Prairie Fire traps in the IED module
Changed:	Reverted Linux changes

0.55
Changed:	Removed capital letters for Linux servers
Fixed:		Sleeping would never remove exhaustion

0.544
Added:		Persistent tasks
Added:		Ambient civilian vehicles

0.543
Added:		Occupied area module
Fixed:		Task popups when notifications off
Fixed:		Losing tasks after respawn

0.542
Removed:	Persistence module (accidentally included again)

0.541
Fixed:		Bug with the Spawner module gocode

0.54
Added:		Optional limited pre-loading of compounds to speed indexing for certain maps
Added:		Option to include group leader in unit caching
Fixed:		Minor bugs

0.53
Added:		Innawoods module (WIP) to spawn random people, camps, stashes, weird sites and spooks in wooded areas
Fixed:		Various RPG and Trade issues

0.52
Added:		Time acceleration option to Weather
Added:		Control over RPG level requirements
Fixed:		Numerous RPG issues
Fixed:		Numerous loot issues
Changed:	Pilot, Crew and HeliCrew are no longer auto-detected by Define Faction (rank must be used)
Changed:	Defend missions now use the Task Notification option

0.51
Added:		Explosives category to Loot and Trade modules
Improved:	Trade prices
Improved:	Player persistence
Improved:	Loot and Trade modules
Removed:	Accidental inclusion of Persistence module

0.5
Added:		Player persistence module
Fixed:		Various trader and loot issues
Changed:	Abandoned cars are more likely to spawn in towns and compounds

0.49
Added:		Option to disable task markers on map
Added:		Natural text description of mission location to all tasks
Added:		HETMAN support for DMP objectives (requires HAL NR6 to be installed)
Added:		WIP Caching module
Added:		Option to make suicide bombers shout when attacking
Added:		New loot system with auto-generation based on loaded mods
Added:		Traders now use the new loot system
Added:		Food and medical section to traders
Added:		RPG support for ACE items
Added:		Module for computer terminals
Added:		Restricted areas and pass cards for Undercover
Added:		Optional alarm sound for stealth areas
Added:		"Fail if spotted" option for stealth areas
Added:		Clear Mines, Meet Leader and Find Cache mission types
Added:		Insurgent cache population module
Added:		Mission Types module as alternative for text editing the Mission Generator module
Added:		Infoshare option to share with other sides
Improved:	Spawning positions in buildings
Changed:	Major overhaul of Trader module
Changed:	DMP Items now listed under their own Editor Category
Fixed:		Numerous RPG and loot issues
Fixed:		Infoshare not working with civilians
Removed:	Old loot system

0.481
Fixed:		DFC locations not working properly
Fixed:		Various minor issues

0.48
Added:		Civilian/POW Interaction system
Added:		Morale module (panic/surrender)
Added:		Patrol Structures module (spawned patrols have a 50% to use this script instead of BIS patrol tasks)
Added:		Ambient Animals module
Added:		Ability to add headgear, vests and uniforms to work undercover
Added:		Ability to set detection distance when undercover in a vehicle

0.471
Added:		Sub AO module
Fixed:		Typo in the Pedestrian module
Fixed:		IEDs not being detectable

0.47
Added:		Stealth module (guards report enemies/dead bodies/gunshots and may hunt for intruders)
Added:		Undercover module (players can pass as civs until revealed by using military gear or getting too close to enemies)
Added:		Unit Attributes module
Added:		Skiptime dialog module
Added:		AO can now be a circle or square
Added:		Barrier to roadblocks
Added:		Civilian interaction can now be done through the action menu
Added:		Option to prevent ambient faction units from spawning in already-cleared buildings
Fixed:		Knockdown no longer affects spooks
Fixed:		Script error when no towns are in AO
Changed:	RPG saves are now local to each mission
Changed:	Pedestrians now have a chance of being given a "dismissed" waypoint
Changed:	Static missions can now be optional
Changed:	Garrison module can now be top down or bottom up

0.469
Added:		Module to limit static missions
Changed:	UAVs can no longer capture objectives
Fixed:		Persistent campaign progress was not saving

0.468
Added:		Modules to allow defining the units used in generated Demo and Rescue missions
Changed:	Destroy Structure missions renamed to Demo

0.467
Changed:	Defend modules will not set a task until after their delay
Changed:	Ambient module can exclude aircraft

0.466
Added:		[POP] Suicide Bomber module
Added:		[AI] Suicide Bomber module
Added:		[AI] VBIED module
Added:		Trigger distance option to VBIEDs

0.465
Added:		RPG "Instanced Campaign" (WIP, see RPG readme)
Added:		Missions can now grant cash and XP rewards
Added:		MRE item
Changed:	Blacklist modules can each have a different radius
Changed:	Improved performance with AI Hunt module
Changed:	Garrisons group leaders now patrol their building (thanks VedKay for the idea)

0.464
Added:		Simple admin menu
Added:		Ambient faction can now be civilian
Added:		Option for civilian group size
Changed:	DFC AO generation now takes blacklist modules into account
Fixed:		RPG should now work in MP

0.463
Added:		WIP RPG system with XP, levels, skills and survival aspects (food, weather, exposure, poison, infection, etc)
Added:		DFC: It is now possible to break enemy morale
Fixed:		Reduced men spawning in geometry
Changed:	Loot can now be static or dynamic

0.4622
Fixed:		Position bug with the Kill module
Fixed:		Various DFC bugs

0.4621
Fixed:		Civilian vehicle spawn bug

0.462
Added:		Proper Defend missions to DFC
Added:		Modules for manual placement of AOs in DFC
Added:		Many new options for DFC
Fixed:		Vehicles should less frequently explode on spawn

0.461
Added:		InfoShare module
Changed:	Rejected missions will usually not cause the mission count to decrease

0.46
Added:		Dynamic Frontline Campaign (DFC): A remake of my Random Displacements Campaign system
Added:		Hold static mission (have at least one friendly or no enemy present until time limit reached)
Changed:	Extract modules can now be named
Fixed:		AAA sites not spawning properly
Fixed:		Civilian helos not spawning
Fixed:		Parachute bugs in MP
Fixed:		Defend not ending after allotted time
Fixed:		Extract modules were not working

0.451
Changed:	Parachute commands now affect vehicles
Changed:	Parachute spacing
Fixed:		Bug with Defend spawn point generation
Fixed:		Empty parachute bug

0.45
Added:		Survive X minutes mission module
Added:		Wipe out side mission module
Added:		Parachute AI module
Changed:	Can now set parachute jump height
Changed:	Some boxes for loot
Fixed:		Floating tasks
Fixed:		Roadblocks not spawning

0.44
Added:		Option to make IEDs target men
Fixed:		Floating IEDs

0.439
Added:		Can now set distance for dynamic simulation in the Core module
Added:		Interdict missions now show a marker for the convoy start point
Added:		Planes, Helos and Drones to the Spawner module
Changed:	Destroy Structure now tries to select military and infrastructure as targets
Changed:	Tweaks to ship spawn locations
Changed:	Parachuting AI will now automatically deploy their chute if they get too low
Changed:	Map size is now determined by worldSize instead of BIS_fnc_mapSize

0.438
Added:		Hunt groups to the define faction module
Changed:	Vastly improved random mission generation (more variety, less rejected missions)
Changed:	Static modules now give the module position for the task instead of the target position
Changed:	Position of compounds in the faction module
Fixed:		Mission giver not issuing missions on dedicated servers
Fixed:		Random mission Clear always rejected
Fixed:		Random mission Interdict was broken
Fixed:		Some random missions almost always rejected
Fixed:		End campaign being triggered when campaign was not active
Fixed:		Force location modules always showed markers
Fixed:		Z axis of positions were often in the air or underground
Fixed:		Destroy vehicles sometimes selected a null vehicle
Fixed:		Reduced the number of civilian vehicles exploding
Fixed:		Random "script not found" error message

0.437
Added:		Option in mission generator to wait for a faction to finish spawning before issuing missions
Changed:	Player interaction key is now optional and can be turned on in the core module
Fixed:		Defend module didn't accept Go Codes

0.436
Added:		Chain Mission option to mission generator
Added:		Option to disable task notifications from the mission generator module
Added:		[AI] Hunt module (group will move to the closest enemy unit)
Added:		Locations and Remote Areas now use [_x,_y,_z] coordinates
Added:		Go Codes (allows chaining of mission modules)
Added:		Very low and very high AI skill modules
Changed:	Tweaked the existing AI skill modules to reduce AI laser accuracy

0.435
Fixed:		Script errors with knockdown and weather modules

0.434
Added:		"Delete object" option to interact module
Changed:	Module arrays can now accept [a,b] or a,b
Changed:	When a defence mission is won, the attacking squads will flee

0.433
Added:		Delete campaign option to the Core module
Added:		Aerial Recon mission
Added:		Module to disable LAMBS Danger by side
Changed:	Recon mission is now checked in 3D

0.432
Added:		Module to create locations at any point
Added:		Module to create remote or water locations at any point

0.431
Added:		Number of civilian casualties is recorded
Fixed:		Inaccurate reporting of campaign status
Fixed:		Bug that was causing campaigns to be lost when they should be won
Fixed:		Killing enemies reduced the campaign score instead of boosting it

0.43
Added:		Ability to save and load the index of a given island (ie. load all locations and areas instead of finding them each mission)
Added:		Campaign win/lose sound options
Added:		Module for displaying campaign progress
Changed:	Buffed VBIED indirect range and damage
Changed:	Killing civilians and civilian leaders reduces campaign victory points
Changed:	Attempt to speed up faction spawning

0.42
Added:		Ability to adjust size and spatial increment of remote areas in the core module

0.41
Fixed:		Mission information not showing at mission start
Improved:	Generated Destroy Structure mission targets

0.4
Added:		Semi-persistent dynamic campaign
Changed:	Adjusted mission startup text
Changed:	Adjusted mission startup time

0.39
Added:		Markers for water areas
Fixed:		Drones spawning on the ground or crashing after spawn
Fixed:		Dynamic simulation was not excluding drones
Improved:	Target selection in Destroy Structure missions

0.38
Fixed:		Dynamic simulation was not excluding aircraft
Fixed:		Bugs with Defend module
Fixed:		Groups not parachuting in MP
Changed:	Ships attached to other ships will not be detected by the Ships module
Changed:	Skill values in medium and low skill module

0.37
Added:		Traders module
Added:		Script for random insurgent clothing (DMP\Scripts\Misc\Insurgent.sqf)
Fixed:		Tasks now show for players after respawn or switching units
Changed:	Extraction modules can now auto-generate location based on players rather than use their own position

0.361
Fixed:		Bugs with ship population

0.36
Added:		Optional Knockdown module
Added:		Option to manually set spawnpoints for Defend mission
Fixed:		Various small bugs related to the mission system

0.351
Fixed:		Intro sound was using remoteExec instead of local execution
Changed:	Dynamic Simulation now excludes air units

0.35
Added:		Ship population module
Added:		Destroy Structure generated mission
Added:		Interdict generated mission
Added:		Destroy Ship generated mission
Added:		Destroy Aircraft generated mission
Added:		Deliver generated mission
Added:		dmpWaterAreas array of positions

0.34
Added:		Weather/skiptime module
Fixed:		Mission generator was sometimes not generating missions

0.33
Added:		Hack mission module
Added:		Interact mission module
Added:		Rescue mission module
Added:		Rescue generated mission
Added:		Prevent Arrival mission module
Added:		Option to run scripts upon completion to most mission modules
Added:		Exfiltrate AO optional requirement after mission complete
Added:		Parachute module

0.32
Added:		Kill Count mission module
Added:		Deliver mission module
Added:		AI modules for giving Assault, Garrison, Long Patrol, MoveTo, Patrol and RoadPatrol orders to editor-placed units
Added:		Custom delay for the delay between winning all missions and the entire mission closing
Added:		Custom sounds for mission start, mission won and mission lost
Added:		Go codes for Define Faction
Changed:	Objective modules now have a more flexible description field
Fixed:		Script error with Recon mission

0.31
Changed:	Hide unused areas is now off by default and has more sleep commands (was causing 1 FPS with some users)

0.3
Added:		VBIED module
Added:		Location Types module
Added:		Skill module
Added:		AAA/SAM sites module
Added:		SEAD mission
Added:		Defend module
Added:		Kill/destroy mission module
Added:		Recon mission module
Added:		Extract mission module
Added:		Demolition mission module
Added:		Spawner module
Added:		Markers for missions
Added:		Hide unused areas option (thanks VedKay)
Changed:	Naming conventions of modules

0.26
Added:		Occupied Town module
Added:		Objective module
Added:		Spawn Delay option to factions
Added:		Seconds Between Spawns option to factions
Changed:	If no locations or remote areas are created, one of each will be created at the position of the core module
Changed:	dmpLocations is now an array of location positions, not locations

0.25
Added:		Mission Generator module (Kill HVT, Clear Area, Recon, Destroy Squad, Destroy Vehicle)
Added:		"HVT hunt" open world mission
Added:		IED module
Added:		Option to use BIS simulation management for better performance
Added:		Civilian leaders in towns
Added:		Civilian approval rating
Added:		Interact key
Changed:	Module icons

0.24
Added:		Passenger options for faction vehicles
Added:		Compound detection code (small clusters of buildings away from towns)
Added:		Compound option for factions
Added:		Compound option for civilians
Fixed:		Modules were running on clients
Fixed:		Some AI scripts not executing
Changed:	Naming conventions to prioritize important modules
Changed:	GVAR dmpTowns changed to dmpLocations

0.23
Fixed:		Units not being detected by modules (bug with nearEntities command on some maps)
Added:		Blacklist Radius value to core module

0.22
Added:		Detailed debug messages and markers for the Define Faction module
Added:		Small delays to civ, vehicle and loot modules
Changed:	Air vehicles should now spawn in flight

0.21
Added:		Dedicated debug function for Factions
Changed:	Added a two second delay to allow modules more time to register units
Removed:	Detecting leaders by "officer" string

0.2
Fixed:		Civs not despawning
Fixed:		Abandoned vehicles not registering types properly
Added:		Option to add caches/loot to buildings, camps and abandoned vehicles
Added:		Option to spawn an ambient faction around the player (infantry only, spawns in buildings)
Added:		Option to control chance of civilian staying inside vs wandering around outside
Added:		Option to control spawn height of aircraft
Added:		Option to delay spawning by X amount of seconds
Added:		Option to delay spawning until dmpWaitForGo=TRUE is set on server

0.1
First release