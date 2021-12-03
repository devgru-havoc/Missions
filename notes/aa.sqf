this addEventHandler ["Fired",
{
 _this spawn
 {
  params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
  if (((magazinesAmmo _unit select 0) select 1) isEqualTo 1) then
  {
   sleep 60;
   waitUntil {magazinesAmmo _unit isEqualTo []};
   sleep 60;
   _unit addMagazineTurret ["magazine_Missile_mim145_x4", [0], 4];
  };
  };
}];



this addEventHandler ["Fired",
{
 _this spawn
 {
  params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
  if (((magazinesAmmo _unit select 0) select 1) isEqualTo 1) then
  {
   sleep 60;
   waitUntil {magazinesAmmo _unit isEqualTo []};
   sleep 60;
   _unit addMagazineTurret ["magazine_Missile_s750_x4", [0], 4];
  };
  };
}];

MRH_fnc_MilsimTools_ZeusModules_
Function name: MRH_fnc_MilsimTools_ZeusModules_

[this] call MRH_fnc_MilsimTools_ZeusModules_;
[this,"US"] call MRH_fnc_isRadioChatterSource;
[this,"DemoRussian"] call MRH_fnc_isRadioChatterSource;
[this,landVehSpawn,""Land""] call MRH_fnc_Spawner;
[this,heliSpawn,""Air""] call MRH_fnc_Spawner;
[this,10,true,true] call MRH_fnc_AmmoCrate;
[this] call MRH_fnc_SearchObject;
[this,WEST] call MRH_fnc_isAirInsertionPlanner;


_statement = {_box = [20,West,position cratespawn] call MRH_fnc_createAmmoBox;};" \n "[this, "I will get an ammo crate to you, no worries", _statement,"LOCAL",false] call MRH_fnc_simpleAceMessage;


[[[this,[1,.1,.25],300],"scripts\AL_ambient_light\al_ambient.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;
[this,"US"] call MRH_fnc_isRadioChatterSource;
[this,10,true,true] call MRH_fnc_AmmoCrate;



_statement = {_box = [20,West,position cratespawn] call MRH_fnc_createAmmoBox;};
[this, "I will get an ammo crate to you, no worries", _statement,"LOCAL",false] call MRH_fnc_simpleAceMessage;
[this,1] call BIS_fnc_dataTerminalAnimate;
[this,green,green,green] call BIS_fnc_DataTerminalColor;



this setObjectTexture [0, "textures\Heli_Transport_03_ext01_md.paa"];
this setObjectTexture [1, "textures\Heli_Transport_03_ext02_md.paa"];


ambiguous_snow_leopard_A_partridge_in_a_pear_tree.tem_ihantalaw\scripts\set_damage.sqf

 sleep 30; execVM "scripts\set_damage.sqf";

 null = [this] execVM "scripts\set_damage.sqf";