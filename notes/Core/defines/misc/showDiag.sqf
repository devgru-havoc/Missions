
   []spawn {
        waitUntil {uiSleep 1;
		if (missionNameSpace getVariable ["MMF_call_monitor", false]) then {
            		hintSilent (format ["%1, %2", (round diag_fps), diag_activeScripts ]);
			false
		}else{true}
        }
    };

