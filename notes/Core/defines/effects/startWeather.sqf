//======mmf_fnc_startWeather======SPAWN======random weather
private _setRandom = [0,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0];


0 setOvercast selectRandom _setRandom;
sleep 0.1;
simulWeatherSync;

while {true } do
{
		300 setOvercast selectRandom _setRandom;
		sleep 0.1;
		//0 setFog 0;
};

sleep 900;
