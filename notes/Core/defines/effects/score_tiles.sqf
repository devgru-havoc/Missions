/*======MMF_fnc_score_tiles======CALL======add mission EH to display kill score

_message	string		text displayed to player
_ratingScore	number		any number (default -1)

call is formatted in MMF_ST_reward, see below

*secondary function
display any text with effect
example: [(name player)] call MMF_ST_format

*/

MMF_ST_format = {	params [["_message", ""], ["_ratingScore", -1]];

	_messageContent = "<t align='right' size='1.25'>" + format ["<t font='PuristaSemibold'>%1</t>%2<br/>", _message] + "</t>";

	if (_ratingScore >= 0) then {
		_messageContent = _messageContent + (format ["<t align='right' color='#ffff00' font='PuristaBold' size='1.4'>+%1</t>", _ratingScore])
	} else {
		[parseText _messageContent, [safezoneX, safezoneY + safeZoneH * 0.55, safezoneW * 0.62, safeZoneH * 0.57], nil, 1, 0.7,0 ]spawn BIS_fnc_textTiles
	};
	_messageContent
};

MMF_ST_reward = {	params ["_unit", "_killer"];

	private _arr=[];
	if (_unit getHit "head" >0.9) then {	
		_killer addPlayerScores [1, 0, 0, 0, 0];
		_killer addRating 100;
		{_arr pushBack _x} forEach ["HEADSHOT", 300]
	};

	if (_unit distance _killer< 3) then {	
		_killer addPlayerScores [1, 0, 0, 0, 0];
		_killer addRating 100;
		{_arr pushBack _x} forEach ["POINT BLANK", 200]
	};

	if (_unit distance _killer> 200) then {	
		_killer addPlayerScores [1, 0, 0, 0, 0];
		_killer addRating 100;
		{_arr pushBack _x} forEach ["LONG DISTANCE KILL", 300]
	};

	if (_unit distance _killer> 100) then {	
		_killer addPlayerScores [1, 0, 0, 0, 0];
		_killer addRating 100;
		{_arr pushBack _x} forEach ["DISTANCE KILL", 250]
	};

	if (_unit distance _killer< 30) then {
		_killer addPlayerScores [1, 0, 0, 0, 0];
		_killer addRating 100;
		{_arr pushBack _x} forEach ["CQB", 200]
	};

	if (_unit distance _killer> 30) then {	
		_killer addPlayerScores [1, 0, 0, 0, 0];
		_killer addRating 100;
		{_arr pushBack _x} forEach ["CLEAN KILL", 220]
	};
	[_killer, (_arr select 1), 0] call MMF_fnc_account;
	private _score= _arr call MMF_ST_format;
	[parseText _score, [safezoneX, safezoneY + safeZoneH * 0.55, safezoneW * 0.62, safeZoneH * 0.57], nil, 1, 0.7,0 ]spawn BIS_fnc_textTiles
};

addMissionEventHandler["EntityKilled",{
	params ["_unit", "_killer"];
	if (!((faction _unit) == (faction _killer)) && !((faction _unit) == "CIV_f") && _unit isKindOf "MAN") exitWith {

		if (_killer in allPlayers && local _killer && isNull objectParent _unit) then {
			[_unit, _killer] call MMF_ST_reward
		};
		true
	}
}];
