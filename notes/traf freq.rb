70.4


tf_freq_west  =   [0 ,7, ["123.2","137.5","111.6","100.8","158.1","196.5","171.5","121.1"],0, nil, -1, 0, getPlayerUID player, false];
tf_freq_west_lr = [0 ,7, ["50.6","71.3","48.3","70.5","35.1","37.2","46.7","42.8"],0, nil, -1, 0, false];



<br/><br/>
<font size='18'>ISSUES</font>
<br/>
<br/>
All side radio channels short range, long range, and vehicle should be synced, if issue occur look for map marker near spawn with sr ch1 and lr ch1.
<br/>

<br/>

<br/>
the ILBE packs have greater range and storage compared to vanilla long-range radios in ARMA, but changing antenna and setting satcom are broken due to ace3 bug

 <font size '18'Radio Frequencies</font>
<br/>
 <br/>
Short Range NATO
Ch1 123.2
CH2 437.5
CH3 511.6
CH4 500.8
CH5 458.1
CH6 96.5
CH7 271.5
<br/> CH8 121.1
<br/>

<br/>

<br/>
Long Range  NATO
Ch1 50.6
Ch2 71.3
Ch3 48.3
Ch4 70.5
Ch5 35.1
Ch6 37.2
Ch7 46.7
Ch8 42.8
<br/>
Communications

<br/>
<font size '18'>Short Range Radios</font>
<br/>
Short Range radios frequencies are unique per detachment
<br/>
CH1 Detachment Network
CH2 ODA Network
CH3 ODB Network
CH4-CH7 Leaders discretion
CH8 - Guard Common Across all radions
<br/>
<br/>
<br/>
<br/>
<font size '18'>Long Range Radios</font>
<br/>
Channel 	Frequency	Purpose
Channel: 1 - Frequency:31Mhz - C2
Channel: 2 - Frequency:40Mhz - CAS - Fires
Channel: 3 - Frequency:47Mhz - Detachment 990 Net
Channel: 4 - Frequency:54Mhz - Detachment 991 Net
Channel: 5 - Frequency:61Mhz - Detachment 992 Net
Channel: 6 - Frequency:65Mhz - Detachment 993 Net
Channel: 7 - Frequency:70Mhz - Detachment spare Net
Channel: 8 - Frequency:78Mhz - Flight Net all radios
Channel: 9 - Frequency:84Mhz - Air 2 Ground Net - Common on all radios



"31","40","47","54","61","65","70","78","84"


<br/>
<br/>
<br/>
<br/>
<font size '18'>The ILBE packs have greater range and storage compared to vanilla long-range radios in ARMA, Based on the Antenna</font>
<br/>
<br/>
Antenna ranges
<br/>
Whip: tf_range = 17000
Whip extended: tf_range = 25000
Blade: tf_range = 18000
DD: tf_range = 15000
<br/>
<br/>
<br/>
<br/>

<font size '18'>Smoke, handheld signal, ChemLight</font>
<br/>
Green - On guard Channel (ch9)
Red - MediVac (medic needed)
White - Cold LZ
Yellow - Hot LZ
all other colors are targets
<br/>
<br/>

 -ip=11.22.33.44 -port=2302 "-config=C:\arma\TADST\GhostB\TADST_config.cfg"  "-cfg=C:\arma\TADST\GhostB\TADST_basic.cfg" "-bepath=C:\arma\battleye" "-servermod=@aliveserver;@arametrics;" "-profiles=C:\arma\TADST\GhostB"  -noTexHeaders -name=GhostB_Pub -malloc=tbb4malloc_bi_x64 -hugepages -enableHT -filePatching -LoadMissionToMemory "-mod=;"



 "-bepath=C:\arma\battleye"

 -port=2302 "-config=C:\arma\TADST\dpso\TADST_config.cfg" "-cfg=C:\arma\TADST\dpso\TADST_basic.cfg" "-profiles=C:\arma\TADST\dpso" -name=dpso -filePatching "-mod=@450814997;@753621527;@620260972;@491016790;@579263829;@753249732;@825179978;@1185610553;@498740884;@620019431;@632435682;@713709341" -autoInit -enableHT -serverMod=@AliveServer;@arametrics;


  -port=2302 "-config=C:\arma\TADST\dpso\TADST_config.cfg" "-cfg=C:\arma\TADST\dpso\TADST_basic.cfg" "-profiles=C:\arma\TADST\dpso" -name=dpso -filePatching "-mod=@450814997;@753621527;@620260972;@491016790;@579263829;@753249732;@825179978;@1185610553;@498740884;@620019431;@632435682;@713709341" -autoInit -enableHT  "-serverMod=@AliveServer;@arametrics;"  "-bepath=C:\arma\battleye"



51,52,53,54,55,56,57,58,59


123.2,125.7,122.4,196.6,163.0,151.4,108.6,58
123.2,135.2,127.5,135.4,131.2,167.7,139.4,58
123.2,148.4,200.4,163.7,156.7,139.1,130.9,58
123.2,182.2,201.7,179.1,179.3,169.9,199.2,58
123.2,189.8,186.9,145.4,150.4,142.0,174.3,58
123.2,185.4,204.8,185.7,133.4,150.9,196.5,58
123.2,119.8,132.0,168.1,122.6,151.1,163.4,58
123.2,126.9,166.9,183.0,187.0,141.4,155.1,58
123.2,150.6,186.6,141.7,168.2,131.8,159.4,58
123.2,108.9,163.2,176.8,125.6,191.0,128.9,58
123.2,107.8,200.0,167.1,192.1,201.6,167.4,58
123.2,165.8,205.1,107.7,153.6,148.7,149.0,58
//////////////////////////////////////////////////////////////////////////////////////////////
----------------------------------------------------------------------------------------------

40,50,51,52,53,59,60,69

101,102,103,104,105,106,99,69
111,112,113,114,115,116,99,69
121,122,123,124,125,126,99,69
131,132,133,134,135,136,99,69
151,152,153,154,155,156,99,69
191,192,193,194,195,196,99,69



990 - Channel: 1 - Frequency:91 Mhz
990 - Channel: 2 - Frequency:92 Mhz
990 - Channel: 3 - Frequency:93 Mhz
990 - Channel: 4 - Frequency:94 Mhz
990 - Channel: 5 - Frequency:95 Mhz
990 - Channel: 8 - Frequency:84 Mhz

991 - Channel: 1 - Frequency:101 Mhz
991 - Channel: 2 - Frequency:102 Mhz
991 - Channel: 3 - Frequency:103 Mhz
991 - Channel: 4 - Frequency:104 Mhz
991 - Channel: 5 - Frequency:105 Mhz
991 - Channel: 8 - Frequency:84 Mhz

992 - Channel: 1 - Frequency:201 Mhz
992 - Channel: 2 - Frequency:202 Mhz
992 - Channel: 3 - Frequency:203 Mhz
992 - Channel: 4 - Frequency:204 Mhz
992 - Channel: 5 - Frequency:205 Mhz
992 - Channel: 8 - Frequency:84 Mhz

993 - Channel: 1 - Frequency:301 Mhz
993 - Channel: 2 - Frequency:302 Mhz
993 - Channel: 3 - Frequency:303 Mhz
993 - Channel: 4 - Frequency:304 Mhz
993 - Channel: 5 - Frequency:305 Mhz
993 - Channel: 8 - Frequency:84 Mhz


995 - Channel: 1 - Frequency:501 Mhz
995 - Channel: 2 - Frequency:502 Mhz
995 - Channel: 3 - Frequency:503 Mhz
995 - Channel: 4 - Frequency:504 Mhz
995 - Channel: 5 - Frequency:505 Mhz
995 - Channel: 8 - Frequency:84 Mhz


999 - Channel: 1 - Frequency:191 Mhz
999 - Channel: 2 - Frequency:292 Mhz
999 - Channel: 3 - Frequency:393 Mhz
999 - Channel: 4 - Frequency:494 Mhz
999 - Channel: 5 - Frequency:595 Mhz
999 - Channel: 8 - Frequency:84 Mhz

 this setFlagTexture 'armamission.paa'; _halo_jump =[2000,100,this] execVM "halo.sqf";
this addAction["<t color='#551A8B'>Sanctuary</t>", {player setPos getMarkerPos("ALiVE_SUP_MULTISPAWN_RESPAWN_BLU_G_F")}];

this setFlagTexture 'armamission.paa'; this addAction["<t color='#551A8B'>Halo Insertion</t>", "scripts\HaloJump.sqf"];



tf_freq_west  =   [0 ,7, ["123.2","137.5","111.6","130.8","158.1","196.5","171.5","121.1"]

tf_freq_west  =   [0 ,7, ["223.2","237.5","211.6","230.8","258.1","296.5","271.5","221.1"]

tf_freq_west  =   [0 ,7, ["323.2","337.5","311.6","330.8","358.1","366.5","371.5","321.1"]

tf_freq_west  =   [0 ,7, ["423.2","437.5","411.6","430.8","458.1","466.5","471.5","421.1"]

 AN/PRC-152
(commander) | BLUFOR | 30–512 MHz
/5 km | | RF-7800S-TR
(squadmate) | BLUFOR | 30–512 MHz
/2 km | | RT-1523G (ASIP)
(manpack) | BLUFOR | 30–87 MHz
/20 km
(30 km for vehicle-mounted) | | AN/ARC-210
(airborne) | BLUFOR | 30–87 MHz
/40 km | | AN/PRC148-JEM
(commander) | Independent | 30–512 MHz
/5 km | | AN/PRC-154
(squadmate) | Independent | 30–512 MHz
/2 km | | AN/PRC-155
(manpack) | Independent | 30–87 MHz
/20 km
(30 km for vehicle-mounted) | | AN/ARC-164
(airborne) | Independent | 30–87 MHz
/40 km | | FADAK
(commander) | OPFOR | 30–512 MHz
/5 km | | PNR-1000A
(squadmate) | OPFOR | 30–512 MHz
/2 km | | MR3000
(manpack) | OPFOR | 30–87 MHz
/20 km
(30 km for vehicle-mounted) | | MR6000L
(airborne) | OPFOR | 30–87 MHz
/40 km | | Transceiver
(underwater) | All | 32–41 kHz
/70–300 m
(depending on waves) |




-port=2302 "-config=C:\arma\configs\server.cfg" "-profiles=C:\arma\serverprofile" "-bepath=C:\arma\battleye" "-servermod=@arametrics;" -loadMissionToMemory -autoInit -enableHT

-port=2302 "-config=C:\arma\configs\server.cfg" "-profiles=C:\arma\serverprofile" "-bepath=C:\arma\battleye" "-servermod=@arametrics;@aliveServer;" -loadMissionToMemory "-mod=@1210050323;@333310405;@1376867375;@1104460924;@825179978;@820924072;@801023307;@753249732;@713709341;@642457233;@800053817;@498740884;@579263829;@620019431;@773136286;@669962280;@620260972;@463939057;@450814997;"



 -port=2302 "-config=C:\arma\TADST\dpso\TADST_config.cfg" "-cfg=C:\arma\TADST\dpso\TADST_basic.cfg" "-bepath=C:\arma\battleye" "-servermod=@arametrics;@aliveServer;" "-profiles=C:\arma\TADST\dpso" -name=dpso -filePatching "-mod=@1210050323;@333310405;@1376867375;@1104460924;@825179978;@820924072;@801023307;@753249732;@713709341;@642457233;@800053817;@498740884;@579263829;@620019431;@773136286;@669962280;@620260972;@463939057;@450814997;" -autoInit -enableHT

-port=2302 "-config=C:\arma\configs\server.cfg" "-profiles=C:\arma\serverprofile" "-bepath=C:\arma\battleye" "-servermod=@arametrics;@aliveServer;" -loadMissionToMemory -autoInit -enableHT "-mod=@1210050323;@333310405;@1376867375;@1104460924;@825179978;@820924072;@801023307;@753249732;@713709341;@642457233;@800053817;@498740884;@579263829;@620019431;@773136286;@669962280;@620260972;@463939057;@450814997;"




-mod=@1291442929



["123.2","137.5","111.6","130.8","158.1","196.5","171.5","121.1","223.2","237.5","211.6","230.8","258.1","296.5","271.5","221.1","323.2","337.5","311.6","330.8","358.1","366.5","371.5","321.1","423.2","437.5","411.6","430.8","458.1","466.5","471.5","421.1"]


[123.2,137.5,111.6,130.8,158.1,196.5,171.5,121.1,223.2,237.5,211.6,230.8,258.1,296.5,271.5,221.1,323.2,337.5,311.6,330.8,358.1,366.5,371.5,321.1,423.2,437.5,411.6,430.8,458.1,466.5,471.5,421.1]


[50.6,71.3,48.3,70.5,35.1,37.2,46.7,42.8]


"51","52","53","54","55","56","57","58","59"

"100","110","120","130","140","150","160","200","80"

Channel 	Frequency	Purpose
1			123.2Mhz		C2
2			125.7Mhz		CAS - Fires
3			122.4Mhz		Detachment Alpha Net
4			196.6Mhz		Detachment Bravo Net
5			163.0Mhz		Detachment Delta Net
6			151.4Mhz		Detachment Charly Net
7			108.6Mhz		Detachment Echo Net
8			58Mhz		Guard Common Across all radios
9			59Mhz		Detachment HHC Net


Short Range Radios
Channel 	Frequency	Purpose
1			100Mhz		Group Net
2			110Mhz		Detachment Alpha Net
3			120Mhz		Detachment Bravo Net
4			130Mhz		Detachment Charly Net
5			140Mhz		Detachment Delta Net
6			150Mhz		Detachment Echo Net
7			160Mhz		Detachment HHC Net
8			58Mhz		Air to Ground Net
9			80Mhz		Avaiable to be reprogramed



Long Range Radios
Channel 	Frequency	Purpose
1			51Mhz		C2
2			52Mhz		CAS & Fires
3			53Mhz		Detachment Alpha Net
4			54Mhz		Detachment Bravo Net
5			55Mhz		Detachment Delta Net
6			56Mhz		Detachment Charly Net
7			57Mhz		Detachment Echo Net
8			58Mhz		Detachment HHC Net
9			59Mhz		Avaiable to be reprogramed


Frequencies Avaiable to use
Alpha 	310Mhz to 319Mhz
Bravo 	320Mhz to 329Mhz
Charly 	330Mhz to 339Mhz
Delta 	340Mhz to 349Mhz
Echo 	350Mhz to 359Mhz
HHC 	360Mhz to 369Mhz


[_object,_rangeInMeters] call TFAR_antennas_fnc_initRadioTower




<br/><br/>
<font size '18'>Short Range Radios</font>
<br/>
Short Range radios frequencies are unique per detachment
<br/>
CH1 Detachment Network
CH2 ODA Network
CH3 ODB Network
CH4-CH7 Leaders discretion
CH8 - Guard Common Across all radions
<br/>
<br/>
<br/>
<br/>
<font size '18'>Long Range Radios</font>
<br/>
Channel  Frequency Purpose
1   51Mhz  C2
2   52Mhz  CAS - Fires
3   53Mhz  Detachment Alpha Net
4   54Mhz  Detachment Bravo Net
5   55Mhz  Detachment Delta Net
6   56Mhz  Detachment Charly Net
7   57Mhz  Detachment Echo Net
8   58Mhz  Guard Common Across all radios
9   59Mhz  Detachment HHC Net
<br/>
<br/>
<br/>
<br/>
<font size '18'>The ILBE packs have greater range and storage compared to vanilla long-range radios in ARMA, Based on the Antenna</font>
<br/>
<br/>
Antenna ranges
<br/>
Whip: tf_range = 17000
Whip extended: tf_range = 25000
Blade: tf_range = 18000
DD: tf_range = 15000
<br/>
<br/>
<br/>
<br/>

<font size '18'>Smoke, handheld signal, ChemLight</font>
<br/>
Green - On guard Channel (ch9)
Red - MediVac (medic needed)
White - Cold LZ
Yellow - Hot LZ
all other colors are targets
<br/>
<br/>



"\A3\ui_f_orange\data\cfgmarkers\redcrystal_ca.paa"

[this,"\A3\ui_f_orange\data\cfgmarkers\redcrystal_ca.paa"] call BIS_fnc_setUnitInsignia;



class CfgUnitInsignia
{
	class redcrystal_ca
	{
		displayName = "redcrystal_ca";
		author = "Bohemia Interactive";
		texture = "\A3\ui_f_orange\data\cfgmarkers\redcrystal_ca.paa";
	};
};

class CfgVehicles
{
	class myVehicle
	{
		hiddenSelections[] = {"B_Heli_Transport_03_unarmed_F","redcrystal_ca"};
	};
};
