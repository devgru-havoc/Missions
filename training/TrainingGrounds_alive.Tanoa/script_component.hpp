#define PREFIX HAVOC
#define COMPONENT Training

// Version
#define MAJOR 1
#define MIONOR 0
#define PATCHLVL 0

// Map
#define MAP Tembelan

#define DEBUG_SYNCHRONOUS
// #define DEBUG_modE_FULL

#include "\x\cba\addons\main\script_macros_mission.hpp"
#define ADDON DOUBLES(PREFIX,COMPONENT)

#define TACGVAR(var1,var2) TRIPLES(tac,var1,var2)
#define QTACGVAR(var1,var2) QUOTE(TACGVAR(var1,var2))

// ACE3
#define ACEFUNC(var1,var2) TRIPLES(DOUBLES(ace,var1),fnc,var2)
