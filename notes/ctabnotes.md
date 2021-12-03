Class Names

ItemcTab // Commander Tablet
ItemAndroid // Android based Blue Force Tracker
ItemcTabHCam // Helmet Cam
ItemMicroDAGR ﻿// MicroDAGR GPS
Add items to a box

Place this in the initialisation of an Ammo box to add 10 of each item:

this addItemCargo ["ItemcTab",10];this addItemCargo ["ItemcTabHCam",10];this addItemCargo ["ItemAndroid",10];this addItemCargo ["ItemMicroDAGR",10];
Add item to a unit directly

Place this in the initialisation of a soldier:

this addItem "ItemcTab";
Note: This will add the item to the actual inventory, but not assign it to the GPS slot. The unit will have to have enough space in its inventory to fit the item, otherwise it won't be assigned. "addItem" assigns the item to the next best inventory container that fits the item, in the order of uniform, vest and backpack. The Tablet ("itemcTab") for example won't fit in most uniforms, so there has to be space in either the vest or backpack. Use "addItemToBackpack" to add the item directly to the unit's backpack and "addItemToVest" to directly assign it to the vest. To assign an item directly to the GPS slot (it has no space restrictions, but will still count towards the unit's total load), use Â´linkItemÂ´ instead.

This will for example assign the MicroDAGR to the GPS slot and place the Tablet into the unit's backpack:

this linkItem "ItemMicroDAGR";this addItemToBackpack "ItemcTab";
Set cTab side-specific encryption keys

If you wish multiple factions to share cTab data, you will have to set their encryption keys to be the same. These are the variables that hold the encryption keys with their default values:

cTab_encryptionKey_west = "b";
cTab_encryptionKey_east = "o";
cTab_encryptionKey_guer = "i";
cTab_encryptionKey_civ = "c";
Note: It is advised to keep the encryption keys as short as possible since some actions use them to exchange data across the network, so by keeping them short, there is less data exchanged.

So if you want to have for example OPFOR and GUER share cTab data, put this at the TOP of your "init.sqf":

// set GUER encryption key to be the same as the default BLUEFOR encryption key
cTab_encryptionKey_guer = "b";
Note: If "GUER" is set to be friendly with either "WEST" or "EAST", "GUER" will by default have the same encryption key as the friendly faction. Set "cTab_encryptionKey_guer = "i";" to override.

Override vehicle types that have FBCB2 or TAD available

If you wish to override the list of vehicles that have FBCB2 or TAD available, put this at the TOP of your "init.sqf":

// only make FBCB2 available to MRAPs, APCs and tanks
cTab_vehicleClass_has_FBCB2 = ["MRAP_01_base_F","MRAP_02_base_F","MRAP_03_base_F","Wheeled_APC_F","Tank"];


// make TAD available to all helicopters and planes with the exception of the MH-9 Hummingbird and AH-9 Pawnee
cTab_vehicleClass_has_TAD = ["Heli_Attack_01_base_F","Heli_Attack_02_base_F","Heli_Light_02_base_F","Heli_Transport_01_base_F","Heli_Transport_02_base_F","I_Heli_light_03_base_F","Plane"];
Override helmet classes with enabled helmet camera

// Only have BWmod helmets with a camera simulate a helmet camera
cTab_helmetClass_has_HCam = ["BWA3_OpsCore_Schwarz_Camera","BWA3_OpsCore_Tropen_Camera"];
Change display name of a group

Groups are displayed on cTab devices with their groupIDs. To define custom groupIDs, add the following code to the group leader's initialization:

// Change the unit's groupID to "Red Devils"
this setGroupId ["Red Devils"];
Change display name of a vehicle

By default all vehicles will be shown with their group names next to them. This can make it difficult to distinguish multiple vehicles of the same type when they are in the same group. To change that, use the following code in the vehicle's initialization:

// Change this vehicle's identification displayed on all cTab Blue Force Trackers to "Fox"
this setVariable ["cTab_groupId","Fox",true];