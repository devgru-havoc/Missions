/*======MMF_fnc_conversation======CALL======Add dialog actions to NPCs

===================================instructions=============readme
	Configure and paste each variable into the speaker unit's init

===================Prompt variable: This determines the player's menu prompt and subtitle display text
[["string", "string"]] Array(s) containing 2 strings, a short menu prompt and a long subtitle prompt
EXAMPLE:
this setVariable ["you_prompt", [	["MENU Prompt One", "SUBTITLE Prompt One"],  ["MENU Prompt Two", "SUBTITLE Prompt Two"]  	]];

==================Dialog (response) variable: This determines the NPC response, delay to respond and spawned code
**NOTE: within spawned code "_this" is array with params [speaker, player]
[["string", number, {code}]] Array(s) containing 1 response string, delay number and code to spawn (optional)
EXAMPLE:
this setVariable ["you_dialog", [	["Response One", 5, {}], ["Response Two (with code)", 5, {systemChat str _this}]	]];

==================Spawn from unit init 
this call MMF_fnc_conversation;


==========================examples============================see bottom for supplemental dialog (multiple lines)

===================demo example (see NPC init field)
this setVariable ["you_prompt", [ ["Enemy?", "Seen any bad guys creepin' around?"],["Supplies?", "Where's all my shit?"],["More?", "Got anything else to say?"]  ]];
this setVariable ["you_dialog", [ ["None...", 5, {}], ["Not my business...", 5, {}], ["Nope...", 5, {systemChat str _this}]	]];
this call MMF_fnc_conversation;

==================simple example
this setVariable ["you_prompt", [	["Greet", "Hello! Nice to see you!"]	]];
this setVariable ["you_dialog", [	["Nope...", 5, {removeAllActions (_this select 0)}]	]];
this call MMF_fnc_conversation;


=========================extra=====================Add "Talk" action to initiate conversation and remove when distant (optional)
this addAction ["Talk", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target removeAction _actionID;
 	_target call MMF_fnc_conversation;
	[_target, _caller] spawn {
		waitUntil {sleep 1; if ((_this select 0) distance (_this select 1)>5) then {removeAllActions (_this select 0); true} else {false}}
	};
},[],0,false, true,"", "alive _target && {_this distance _target <4}"];


=============================================function============================================*/


	{
		_this addAction [(_x select 0), { 
			params ["_target", "_caller", "_actionId", "_arguments"];
			_target setFormDir (getDir _caller)-180;
 			private _prompt= _target getVariable ["you_prompt", [""]];
			[
				[name _caller, (_prompt select _actionID select 1)],
				[name _target, (_arguments select 0), (_arguments select 1)]
			] spawn BIS_fnc_EXP_camp_playSubtitles;

			[_target, _caller] spawn (_arguments select 2)
		},(_this getVariable ["you_dialog", []] select _forEachIndex),9,false, true,"", "alive _target && {_this distance _target <4}"]
	}forEach (_this getVariable ["you_prompt", []])


/*================================supplemental dialog

Spawn from the appropriate response field to initiate multi-line conversation on selected topic

dialog_1= {
private _caller= (_this select 1);
private _target= (_this select 0);
sleep 5;
[
[name _caller, "This is the player's first line after the initial response"],
[name _target, "I see. How about more responses?", 5],
[name _caller, "Techinically we could keep this up forever...", 10],
[name _target, "Great! Tell me more...", 15]
] spawn BIS_fnc_EXP_camp_playSubtitles;
};
======================================*/


