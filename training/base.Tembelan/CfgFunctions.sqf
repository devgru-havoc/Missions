class CfgFunctions
{
    class PDT_MedicalSimulator // tag
    {
        class dialogs // all dialog functions
        {
            // adds items to listbox
            class lbAdd            {file = "dialogs\functions\fn_lbAdd.sqf";};

            // handles changing listbox selection
            class lbSelChanged     {file = "dialogs\functions\fn_lbSelChanged.sqf";};

            // updates the button states
            class updateButtons    {file = "dialogs\functions\fn_updateButtons.sqf";};
        };

        class medicalSimulator  // all the simulator functions
        {
            // spawns patient
            class spawnPatient         {file = "functions\medical_simulator\fn_spawnPatient.sqf";};

            // clears selected stretcher
            class clearStretcher       {file = "functions\medical_simulator\fn_clearStretcher.sqf";};

            // clears all stretchers
            class clearAllStretchers   {file = "functions\medical_simulator\fn_clearAllStretchers.sqf";};

            // create the view camera
            class createCamera         {file = "functions\medical_simulator\fn_createCamera.sqf";};

            // gets object from string
            class getObject            {file = "functions\medical_simulator\fn_getObject.sqf";};

            // damages patients
            class damagePatient        {file = "functions\medical_simulator\fn_damagePatient.sqf";};
        };
    };

    class INC_undercover
    {
        tag = "INCON_ucr";
        class undercoverRecruit
        {
            file = "INC_undercover\func";
            class addEH {description = "Handles enemy deaths including suspecting nearby undercover units and reprisals against civilians.";};
            class armedLoop  {description = "Contains functions for arming recruitable civilians.";};
            class compromised {description = "Sets the unit as compromised while it is know to enemy units and is doing something naughty.";};
            class cooldown {description = "Initiates a cooldown after the unit has done something naughty";};
            class gearHandler {description = "Contains functions for gear checks and actions.";};
            class getConfigInfo {description = "Gets config information on a given faction / unit.";};
            class groupsWithPID {description = "Gets the number of alive groups that have seen a given unit at a given time and saves them to a variable on the unit.";};
            class initUcrVars {description = "Sets variables for the mission based on setup.sqf.";};
            class isKnownToSide {description = "Returns whether there are alive groups of the given side who know about the unit.";};
            class isKnownExact {description = "Returns whether there are alive groups of the given side who know about the unit's location to a defined level of precision.";};
            class recruitHandler {description = "Handles all civilian recruitment.";};
            class suspiciousEny {description = "Suspicious enemy behaviour.";};
            class UCRhandler {description = "Gets detection scripts running on unit.";};
            class ucrMain {description = "Contains primary UCR functions.";};
        };
    };
};
