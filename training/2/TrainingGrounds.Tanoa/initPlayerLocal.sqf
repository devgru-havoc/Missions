#include "script_component.hpp"
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};
 
if (isDedicated) exitWith {};
["HelicopterTaxing", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
["HelicopterTaxing", "onEachFrame", {
  params ["_Object"];
  if (
      (vehicle player != player) and
      (vehicle player isKindOf "helicopter") and
      {
       (isTouchingGround (vehicle player)) and
       isEngineOn (vehicle player) and
       (driver (vehicle player) == player) and
       (isLightOn (vehicle player))
      }
  ) then {
   private _vehicle = vehicle player;
   private _speed = 0;
   if (cameraOn == _vehicle and cameraView == "INTERNAL") then {
   _text = format ["<t size='1.5' color='#E3FF00'>Taxiing is </t><t size='1.5' color='#00B011'>ENABLED</t>
                <br/><t size='1.5' color='#E3FF00'>
                <t size='1.5' color='#E3FF00'>Press </t></t><t size='1.5' color='#007CE9'>%1<t size='1.5' color='#E3FF00'><t size='1.5' color='#E3FF00'> to go forward</t><br/>
                <t size='1.5' color='#E3FF00'>Press </t><t size='1.5' color='#007CE9'>%2<t size='1.5' color='#E3FF00'><t size='1.5' color='#E3FF00'> to reverse</t><br/>
                </t>
                ", (actionKeysImages ["HeliDown",10]), (actionKeysImages ["HeliWheelsBrake",10])];
                titleText [_text, "PLAIN DOWN", 0.05, true, true];
    };
   if ((abs(speed (vehicle player)) < +10) and (1 in [(inputAction "HeliDown"),(inputAction "HeliWheelsBrake")])) then {
   _input = "None";
   if ((inputAction "HeliDown") > 0.5) then {_input = "Forward"};
   if ((inputAction "HeliWheelsBrake") > 0.5) then {_input = "Backward"};
      switch (_input) do { 
        case "Forward": {_speed = +1.5; if (speed _vehicle < 1) then {_vehicle setVelocityModelSpace [0, 1, 0]}}; 
        case "Backward": {_speed = -1; if (speed _vehicle > -1) then {_vehicle setVelocityModelSpace [0, -1, 0]}}; 
        default {_speed = 0}; 
    };
    _speed = ((getmass _vehicle)* _speed / ((abs speed _vehicle) + 1) );
    _vehicle addForce [(_vehicle) vectorModelToWorld [0,_speed,-100],[0,-2,-1]];
   };
  };
}] call BIS_fnc_addStackedEventHandler;
 
player addEventHandler ["GetInMan", { 
 params ["_unit", "_role", "_vehicle", "_turret"];
if (_vehicle isKindOf "helicopter" and driver _vehicle == player) then {
systemChat "Turn on your lights to enable taxiing";
};
}];