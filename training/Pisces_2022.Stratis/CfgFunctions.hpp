class CfgFunctions {
    class ADDON {
        tag = QUOTE(ADDON);
        class functions {
            file = "functions";
            class environmentControl;
            class initMOUT;
            class range40mmTargetGroups;
            class rangeMachineGunTargetGroups;
            class rangeMarksmanTargetGroups;
            class resetDamagedObjects;
        };
    };
    class DOUBLES(ADDON,Medical) {
        class functions {
            file = "functions\medical";
            class init;
            class createSubject;
            class removeSubject;
            class checkSubject;
            class specific_bodyPartActions;
            class specific_projectileTypeActions;
            class specific_severityActions;
            class applyRandomDamage;
            class instructorDisplay;
        };
    };
    class PDT_MedicalSimulator {
        class dialogs {
            // adds items to listbox
            class lbAdd            {file = "dialogs\functions\fn_lbAdd.sqf";};
            // handles changing listbox selection
            class lbSelChanged     {file = "dialogs\functions\fn_lbSelChanged.sqf";};
            // updates the button states
            class updateButtons    {file = "dialogs\functions\fn_updateButtons.sqf";};
        };

        class medicalSimulator {
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
};


