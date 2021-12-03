#include "..\script_component.hpp"
/*
 * Author: JoramD
 * Vehicle spawner
 *
 * Arguments:
 * 0: Controller <OBJECT>
 * 1: Spawn Position <OBJECT>
 * 2: Type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, spawnPad, "ground"] call havoc_training_fnc_vehicleSpawner
 */

params ["_controller", "_spawnPos", "_type"];

private _groundVehicles = [
    // "classname"
    "rhsusf_m1165a1_gmv_m134d_m240_socom_d", 
    "rhsusf_m1165a1_gmv_m2_m240_socom_d", 
    "rhsusf_m1165a1_gmv_mk19_m240_socom_d", 
    "rhsusf_mrzr4_d", 
    "rhsusf_M1238A1_M2_socom_d", 
    "rhsusf_M1238A1_Mk19_socom_d", 
    "rhsusf_M1239_M2_socom_d", 
    "rhsusf_M1239_MK19_socom_d", 
    "rhsusf_M1239_M2_Deploy_socom_d", 
    "rhsusf_M1239_MK19_Deploy_socom_d", 
    "rhsusf_m1245_m2crows_socom_d", 
    "rhsusf_m1245_mk19crows_socom_d", 
    "rhsusf_m1245_m2crows_socom_deploy", 
    "rhsusf_m1245_mk19crows_socom_deploy"
];

private _airVehicles = [
    // "classname"
    "rhsusf_f22", 
    "RHS_C130J", 
    "RHS_C130J_Cargo", 
    "RHS_A10", 
    "DAO_Gunship_B", 
    "B_T_VTOL_01_vehicle_F", 
    "B_T_VTOL_01_infantry_F", 
    "B_T_VTOL_01_armed_F", 
    "VTX_KV44", 
    "B_Plane_Fighter_01_F", 
    "B_Plane_CAS_01_dynamicLoadout_F", 
    "B_Plane_Fighter_01_Stealth_F"
];
private _heliVehicles = [
    // "classname"
    "vtx_HH60", 
    "vtx_MH60M", 
    "vtx_MH60M_DAP", 
    "vtx_MH60S", 
    "vtx_MH60S_GAU21L", 
    "vtx_MH60S_Pylons", 
    "vtx_UH60M", 
    "vtx_UH60M_SLICK", 
    "RHS_MELB_AH6M", 
    "RHS_MELB_MH6M", 
    "RHS_MELB_H6M", 
    "RHS_AH1Z", 
    "rhsusf_CH53E_USMC_D", 
    "rhsusf_CH53E_USMC_GAU21_D", 
    "RHS_CH_47F", 
    "RHS_UH60M_MEV2"
];


private _seaVehicles = [
    // "classname"
    "rhsusf_mkvsoc", 
    "B_T_Boat_Transport_01_F", 
    "rhsgref_hidf_rhib", 
    "B_T_Boat_Armed_01_minigun_F", 
    "B_SDV_01_F",
    "UK3CB_TKA_B_RHIB_Gunboat"
];

private _allowedVehicles = [];
switch (_type) do {
    case "ground": { _allowedVehicles = _groundVehicles; };
    case "air": { _allowedVehicles = _airVehicles; };
    case "sea" : { _allowedVehicles = _seaVehicles; };
    case "heli" : { _allowedVehicles = _heliVehicles; };
    default { _allowedVehicles = _groundVehicles; };
};

private _spawnAction = [
    QGVAR(SpawnVehicle),
    "Spawn Vehicle",
    "",
    {},
    {true},
    {
        (_this select 2) params ["_controller", "_spawnPos", "_allowedVehicles"];

        private _actions = [];
        {
            _x params ["_classname"];
            private _vehicleName = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");

            private _spawnAction = [
                format [QGVAR(spawnAction_%1), _classname],
                format ["Spawn %1", _vehicleName],
                "",
                {
                    (_this select 2) params ["_controller", "_spawnPos", "_classname"];

                    if (count (_spawnPos nearEntities 5) == 0) then {
                        private _spawnedVehicle = createVehicle [_classname, _spawnPos, [], 0, "CAN_COLLIDE"];
                        _spawnedVehicle setDir (getDir _spawnPos);
                        clearItemCargoGlobal _spawnedVehicle;
                        clearBackpackCargoGlobal _spawnedVehicle;
                        clearWeaponCargoGlobal _spawnedVehicle;
                        clearMagazineCargoGlobal _spawnedVehicle;
                        _spawnedVehicle addItemCargoGlobal ["ToolKit", 1];
                        if (_object isKindOf "LandVehicle") then {
                            ["ACE_Wheel", _spawnedVehicle] call ACEFUNC(cargo,loadItem);
                            ["ACE_Wheel", _spawnedVehicle] call ACEFUNC(cargo,loadItem);
                        };

                        private _spawnedVehicles = GVAR(spawnedVehiclesNamespace) getVariable [QGVAR(spawnedVehicles), []];
                        _spawnedVehicles pushBack [_spawnedVehicle, name player];
                        GVAR(spawnedVehiclesNamespace) setVariable [QGVAR(SpawnedVehicles), _spawnedVehicles, true];
                    } else {
                        ["Could not spawn vehicle, there is already a vehicle on the spawn position"] call CBA_fnc_notify;
                    };
                },
                {true},
                {},
                [_controller, _spawnPos, _classname, _vehicleName]
            ] call ACEFUNC(interact_menu,createAction);

            _actions pushBack [_spawnAction, [], _controller];
        } forEach _allowedVehicles;

        _actions
    },
    [_controller, _spawnPos, _allowedVehicles]
] call ACEFUNC(interact_menu,createAction);

[_controller, 0, ["ACE_MainActions"], _spawnAction] call ACEFUNC(interact_menu,addActionToObject);

private _removeAction = [
    QGVAR(RemoveVehicle),
    "Remove Vehicle",
    "",
    {},
    {
        (_this select 2) params ["_controller"];

        private _spawnedVehicles = GVAR(spawnedVehiclesNamespace) getVariable [QGVAR(spawnedVehicles), []];
        _spawnedVehicles = _spawnedVehicles select {!isNull (_x select 0)};
        GVAR(spawnedVehiclesNamespace) setVariable [QGVAR(spawnedVehicles), _spawnedvehicles, true];

        !(_spawnedVehicles isEqualTo [])
    },
    {
        (_this select 2) params ["_controller"];

        private _spawnedvehicles = GVAR(spawnedVehiclesNamespace) getVariable [QGVAR(spawnedVehicles), []];

        private _actions = [];
        {
            _x params ["_vehicle", "_playerName"];
            private _vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");

            private _removeAction = [
                format [QGVAR(removeAction_%1), _vehicle],
                format ["Remove %1 (%2)", _vehicleName, _playerName],
                "",
                {
                    (_this select 2) params ["_controller", "_vehicle", "_playerName"];

                    if ((fullCrew _vehicle) select {alive (_x select 0)} isEqualTo []) then {
                        deleteVehicle _vehicle;
                        private _spawnedvehicles = GVAR(spawnedVehiclesNamespace) getVariable [QGVAR(spawnedVehicles), []];
                        _spawnedvehicles deleteAt (_spawnedVehicles find [_vehicle, _playerName]);
                        GVAR(spawnedVehiclesNamespace) setVariable [QGVAR(spawnedVehicles), _spawnedvehicles, true];
                    } else {
                        ["Could not delete vehicle, there are still people in the vehicle"] call CBA_fnc_notify;
                    };
                },
                {true},
                {},
                [_controller, _vehicle, _playerName]
            ] call ACEFUNC(interact_menu,createAction);

            _actions pushBack [_removeAction, [], _controller];
        } forEach _spawnedVehicles;

        _actions
    },
    [_controller]
] call ACEFUNC(interact_menu,createAction);

[_controller, 0, ["ACE_MainActions"], _removeAction] call ACEFUNC(interact_menu,addActionToObject);
