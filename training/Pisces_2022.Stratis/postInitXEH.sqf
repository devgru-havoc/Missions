/* ----------------------------------------------------------------------------
Name: postInitXEH

Description: Executes all CBA post-init extended eventhandler scripts on units of the given class. Must be defined in description.ext. 

Parameters:
0: Unit <OBJECT>

Returns: Nil

Examples:

class Extended_InitPost_EventHandlers {
     class CAManBase {
		init = "_this call (compile preprocessFileLineNumbers 'postInitXEH.sqf')";
	};
};

Author: Incontinentia
---------------------------------------------------------------------------- */

