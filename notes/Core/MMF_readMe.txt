Mission Maker Framework for ARMA III==============(2021)==============wogz187==============version 8

Welcome to the MISSION MAKER FRAMEWORK. Please read the instructions to use this library and the associated module(s).

=========================================Installation

1) Create a new mission in the editor, place a player and save
2) Copy the file MMF_v8_extract_to_mission_root.7z to your mission root folder
3) Right-click MMF_v8_extract_to_mission_root.7z and select "extract here..."

=========================================Design instructions

Use "mmf_core/defines/functions.h" as a quick directory for functions

Follow the instructions in initServer to configure mission startup

Follow the instructions in initPlayerLocal to configure player(s) startup

Function instructions are available inline (within the file) and in EDEN functions viewer (tools)*

Create custom definitions in MMF_fnc_start_sog

*if available

======================================================================version notes

Build Menu Control
D-PAD up (if no target)			= open menu
D-PAD up (if target is base object)	= grab object
D-PAD up (if holding object)		= place object

D-PAD down (if holding object)		= cancel move
D-PAD down (not holding object)		= remove object

D-PAD L/R  (if target is base object)	= rotate object

base services disabled in MP by default*
auto-population WIP

*units need variable "MMF_can_build" to enable building
EXAMPLE:
this setVariable ["MMF_can_build", true]

See discord #howTo for more information



LIVE readMe
https://docs.google.com/document/d/1h7FGe_AvN2ZzPImoMe16tsti9SFWruSRH1I4Ha9eNIs/edit?usp=sharing

forum
https://forums.bohemia.net/forums/topic/225826-pre-release-mission-maker-framework/

changeLog
https://docs.google.com/document/d/1JtU7mAgAtm5EkluwSjeOGvvJmgggtycfjVZwqpo9DZs/edit?usp=sharing

discord
https://discord.gg/SBebVRxbA8