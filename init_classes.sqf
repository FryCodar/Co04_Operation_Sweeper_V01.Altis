If(isMultiplayer)then{If(hasInterface)exitWith {};};

private ["_enemy_side"];

// UNIT_CLASS_NAMES
// Class_Names for Creating the Enemy-Soldiers
switch("play_faction" call BIS_fnc_getParamValue)do
{
 case 1:{
          //CSAT
          MSOT_MEN = ["O_Soldier_A_F","O_Soldier_AT_F","O_Soldier_AA_F","O_medic_F","O_engineer_F","O_soldier_exp_F","O_Soldier_AR_F","O_soldier_mine_F","O_soldier_repair_F","O_Soldier_GL_F",
                      "O_support_GMG_F","O_Soldier_SL_F","O_Soldier_F","O_officer_F","O_Soldier_lite_F","O_soldier_UAV_06_F","O_support_MG_F","O_Soldier_AAR_F","O_Soldier_TL_F",
                      "O_Soldier_LAT_F","O_support_Mort_F","O_support_AMG_F","O_HeavyGunner_F","O_soldier_UAV_F","O_soldier_UAV_06_medical_F","O_Soldier_AAA_F","O_support_AMort_F"
                     ];
          MSOT_SFMEN = ["O_recon_LAT_F","O_recon_JTAC_F","O_recon_medic_F","O_recon_exp_F","O_recon_F","O_recon_TL_F","O_Pathfinder_F"];

          MSOT_MENURBAN = ["O_soldierU_AR_F","O_engineer_U_F","O_SoldierU_GL_F","O_soldierU_AT_F","O_soldierU_AA_F","O_soldierU_medic_F","O_soldierU_repair_F","O_soldierU_LAT_F",
                           "O_soldierU_F","O_soldierU_exp_F","O_Urban_HeavyGunner_F","O_SoldierU_SL_F","O_soldierU_TL_F","O_soldierU_AAA_F","O_soldierU_AAR_F","O_soldierU_AAT_F"];

          MSOT_SNIPER = ["O_Sharpshooter_F","O_ghillie_lsh_F","O_soldier_M_F","O_ghillie_ard_F","O_ghillie_sard_F","O_spotter_F","O_sniper_F","O_Urban_Sharpshooter_F","O_soldierU_M_F"];

          MSOT_DIVER = ["O_diver_F","O_diver_exp_F","O_diver_TL_F"];

          MSOT_PILOT = ["O_helicrew_F","O_Fighter_Pilot_F","O_helipilot_F","O_Pilot_F"];

          MSOT_PARACHUT = ["O_soldier_PG_F"];

          MSOT_CARS = ["O_LSV_02_armed_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_MRAP_02_F"];

          MSOT_TANKS = ["O_MBT_02_cannon_F"];

          MSOT_ARTILLERY = ["O_MBT_02_arty_F"];

          MSOT_APC = ["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"];

          MSOT_TRANSPORT = ["O_Truck_02_covered_F","O_Truck_03_covered_F","O_Truck_03_transport_F","O_Truck_02_transport_F"];

          MSOT_BOATS = ["O_Boat_Armed_01_hmg_F"];

          MSOT_TRANSHELI = ["O_Heli_Light_02_dynamicLoadout_F","O_Heli_Transport_04_bench_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];

          MSOT_AIRFORCE = ["O_Heli_Attack_02_dynamicLoadout_F","O_Plane_Fighter_02_F","O_Plane_CAS_02_dynamicLoadout_F","O_Plane_Fighter_02_Stealth_F"];

          MSOT_DRONES = ["O_UGV_01_rcws_F","O_UAV_02_dynamicLoadout_F","O_UGV_01_F"];

          MSOT_STATICWEAPONS = ["O_GMG_01_A_F","O_HMG_01_F","O_GMG_01_high_F","O_HMG_01_A_F","O_HMG_01_high_F","O_GMG_01_F","O_static_AT_F","O_static_AA_F","O_Mortar_01_F"];

          MSOT_ANTIAIR = ["O_APC_Tracked_02_AA_F"];

          MSOT_ENEMY_SIDE = EAST;

        };
 case 2:{
          //CSAT -Pazifik
          MSOT_MEN = ["O_T_Soldier_AA_F","O_T_Soldier_Repair_F","O_T_Officer_F","O_T_Soldier_LAT_F","O_T_soldier_mine_F","O_T_Soldier_AAT_F","O_T_Soldier_AAA_F","O_T_Soldier_GL_F","O_T_Soldier_Exp_F","O_T_Soldier_AR_F","O_T_Soldier_SL_F","O_T_Support_AMG_F",
                      "O_T_soldier_UAV_06_medical_F","O_T_Medic_F","O_T_Soldier_AAR_F","O_T_soldier_UAV_06_F","O_T_Engineer_F","O_T_Soldier_SL_F","O_T_Soldier_TL_F","O_T_Soldier_A_F","O_T_Soldier_F","O_T_Support_GMG_F","O_T_Soldier_AT_F","O_T_Soldier_UAV_F","O_T_Support_MG_F","O_T_Support_Mort_F"];

          MSOT_SFMEN = ["O_T_Recon_Medic_F","O_T_Recon_TL_F","O_T_Recon_JTAC_F","O_T_Recon_LAT_F","O_T_Recon_F","O_T_Recon_Exp_F"];

          MSOT_MENURBAN = ["O_V_Soldier_JTAC_ghex_F","O_V_Soldier_ghex_F","O_V_Soldier_LAT_ghex_F","O_V_Soldier_Exp_ghex_F","O_V_Soldier_TL_ghex_F","O_V_Soldier_Medic_ghex_F","O_V_Soldier_M_ghex_F"];

          MSOT_SNIPER = ["O_T_Soldier_M_F","O_T_Sniper_F","O_T_ghillie_tna_F","O_T_Spotter_F"];

          MSOT_DIVER = ["O_T_Diver_F","O_T_Diver_Exp_F","O_T_Diver_TL_F"];

          MSOT_PILOT = ["O_T_Crew_F","O_T_Pilot_F","O_T_Helicrew_F","O_T_Helipilot_F"];

          MSOT_PARACHUT = ["O_T_Soldier_PG_F"];

          MSOT_CARS = ["O_T_LSV_02_armed_F","O_T_MRAP_02_hmg_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_ghex_F"],

          MSOT_TANKS = ["O_T_MBT_02_cannon_ghex_F"];

          MSOT_ARTILLERY = ["O_T_MBT_02_arty_ghex_F"];

          MSOT_APC = ["O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F"];

          MSOT_TRANSPORT = ["O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F"];

          MSOT_BOATS = ["O_T_Boat_Armed_01_hmg_F"];

          MSOT_TRANSHELI = ["O_T_VTOL_02_infantry_dynamicLoadout_F"];

          MSOT_AIRFORCE = [];

          MSOT_DRONES = ["O_T_UGV_01_rcws_ghex_F","O_T_UAV_04_CAS_F","O_T_UGV_01_ghex_F"];

          MSOT_STATICWEAPONS = ["O_static_AT_F","O_HMG_01_high_F","O_HMG_01_F","O_GMG_01_high_F","O_Mortar_01_F","O_static_AA_F","O_GMG_01_F"];

          MSOT_ANTIAIR = ["O_T_APC_Tracked_02_AA_ghex_F"];

          MSOT_ENEMY_SIDE = EAST;

        };

  case 3:{
           //FIA - RED

           MSOT_MEN = ["O_G_Soldier_GL_F","O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_LAT_F","O_G_Soldier_SL_F","O_G_Soldier_A_F","O_G_Soldier_GL_F","O_G_medic_F","O_G_engineer_F","O_G_Soldier_lite_F","O_G_officer_F","O_G_Soldier_F"];

           MSOT_SFMEN = [];

           MSOT_MENURBAN = [];

           MSOT_SNIPER = ["O_G_Sharpshooter_F","O_G_Soldier_M_F"];

           MSOT_DIVER = [];

           MSOT_PILOT = [];

           MSOT_PARACHUT = [];

           MSOT_CARS = ["O_G_Offroad_01_F","O_G_Offroad_01_armed_F"];

           MSOT_TANKS = [];

           MSOT_ARTILLERY = [];

           MSOT_APC = [];

           MSOT_TRANSPORT = ["O_G_Van_02_transport_F","O_G_Van_01_transport_F"];

           MSOT_BOATS = ["O_G_Boat_Transport_01_F"];

           MSOT_TRANSHELI = [];

           MSOT_AIRFORCE = [];

           MSOT_DRONES = [];

           MSOT_STATICWEAPONS = ["O_G_Mortar_01_F"];

           MSOT_ANTIAIR = [];

           MSOT_ENEMY_SIDE = EAST;

         };

  case 4:{
            //AAF

            MSOT_MEN = ["I_support_GMG_F","I_Soldier_lite_F","I_soldier_F","I_officer_F","I_Soldier_AR_F","I_Soldier_AA_F","I_medic_F","I_Soldier_AT_F","I_Soldier_A_F","I_Soldier_repair_F","I_engineer_F","I_Soldier_exp_F","I_soldier_mine_F",
                        "I_Soldier_GL_F","I_support_MG_F","I_support_Mort_F","I_Soldier_AAA_F","I_Soldier_TL_F","I_Soldier_AAR_F","I_Soldier_LAT_F","I_Soldier_SL_F","I_soldier_UAV_06_F","I_soldier_UAV_F","I_Soldier_AAT_F","I_soldier_UAV_06_medical_F","I_support_AMG_F","I_support_AMort_F"];

            MSOT_SFMEN = [];

            MSOT_MENURBAN = [];

            MSOT_SNIPER = ["I_ghillie_sard_F","I_Soldier_M_F","I_Sniper_F","I_ghillie_lsh_F","I_ghillie_ard_F","I_Spotter_F"];

            MSOT_DIVER = ["I_diver_F","I_diver_exp_F","I_diver_TL_F"];

            MSOT_PILOT = ["I_pilot_F","I_crew_F","I_helicrew_F","I_helipilot_F","I_Fighter_Pilot_F"];

            MSOT_PARACHUT = [];

            MSOT_CARS = ["I_MRAP_03_gmg_F","I_MRAP_03_F","I_MRAP_03_hmg_F"];

            MSOT_TANKS = ["I_MBT_03_cannon_F"];

            MSOT_ARTILLERY = [];

            MSOT_APC = ["I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F"];

            MSOT_TRANSPORT = ["I_Truck_02_covered_F","I_Truck_02_transport_F"];

            MSOT_BOATS = ["I_Boat_Armed_01_minigun_F"];

            MSOT_TRANSHELI = ["I_Heli_light_03_unarmed_F","I_Heli_Transport_02_F"];

            MSOT_AIRFORCE = ["I_Heli_light_03_dynamicLoadout_F"];

            MSOT_DRONES = ["I_UAV_02_dynamicLoadout_F","I_UGV_01_rcws_F","I_UGV_01_F"];

            MSOT_STATICWEAPONS = ["I_HMG_01_high_F","I_Mortar_01_F","I_GMG_01_high_F","I_static_AT_F","I_GMG_01_F","I_static_AA_F","I_HMG_01_F"];

            MSOT_ANTIAIR = [];

            MSOT_ENEMY_SIDE = independent;
            _enemy_side = sideEnemy;
            MSOT_ENEMY_SIDE setFriend [_enemy_side , 1];
            _enemy_side setFriend [MSOT_ENEMY_SIDE , 1];
            MSOT_ENEMY_SIDE setFriend [MSOT_OWN_SIDE,0];
         };

  case 5:{
            //FIA GREEN

            MSOT_MEN = ["I_G_Soldier_LAT_F","I_G_Soldier_exp_F","I_G_Soldier_AR_F","I_G_Soldier_TL_F","I_G_Soldier_SL_F","I_G_Soldier_GL_F","I_G_engineer_F","I_G_officer_F","I_G_Soldier_A_F","I_G_medic_F","I_G_Soldier_F","I_G_Soldier_lite_F"];

            MSOT_SFMEN = [];

            MSOT_MENURBAN = [];

            MSOT_SNIPER = ["I_G_Soldier_M_F","I_G_Sharpshooter_F"];

            MSOT_DIVER = [];

            MSOT_PILOT = [];

            MSOT_PARACHUT = [];

            MSOT_CARS = ["I_G_Offroad_01_F","I_G_Offroad_01_armed_F"];

            MSOT_TANKS = [];

            MSOT_ARTILLERY = [];

            MSOT_APC = [];

            MSOT_TRANSPORT = ["I_G_Van_01_transport_F","I_G_Van_02_transport_F"];

            MSOT_BOATS = ["I_G_Boat_Transport_01_F"];

            MSOT_TRANSHELI = [];

            MSOT_AIRFORCE = [];

            MSOT_DRONES = [];

            MSOT_STATICWEAPONS = ["I_G_Mortar_01_F"];

            MSOT_ANTIAIR = [];

            MSOT_ENEMY_SIDE = independent;
            _enemy_side = sideEnemy;
            MSOT_ENEMY_SIDE setFriend [_enemy_side , 1];
            _enemy_side setFriend [MSOT_ENEMY_SIDE , 1];
            MSOT_ENEMY_SIDE setFriend [MSOT_OWN_SIDE,0];
         };

  case 6:{
            //Syndicat

            MSOT_MEN = ["I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_3_F"];

            MSOT_SFMEN = ["I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_2_F"];

            MSOT_MENURBAN = [];

            MSOT_SNIPER = [];

            MSOT_DIVER = [];

            MSOT_PILOT = ["I_C_Pilot_F","I_C_Helipilot_F"];

            MSOT_PARACHUT = [];

            MSOT_CARS = ["I_C_Offroad_02_unarmed_F"];

            MSOT_TANKS = [];

            MSOT_ARTILLERY = [];

            MSOT_APC = [];

            MSOT_TRANSPORT = ["I_C_Van_01_transport_F","I_C_Van_02_transport_F"];

            MSOT_BOATS = ["I_C_Boat_Transport_02_F"];

            MSOT_TRANSHELI = ["I_C_Heli_Light_01_civil_F","I_C_Plane_Civil_01_F"];

            MSOT_AIRFORCE = [];

            MSOT_DRONES = [];

            MSOT_STATICWEAPONS = [];

            MSOT_ANTIAIR = [];


            MSOT_ENEMY_SIDE = independent;
            _enemy_side = sideEnemy;
            MSOT_ENEMY_SIDE setFriend [_enemy_side , 1];
            _enemy_side setFriend [MSOT_ENEMY_SIDE , 1];
            MSOT_ENEMY_SIDE setFriend [MSOT_OWN_SIDE,0];
         };

};

MSOT_CIVMEN = ["C_man_p_beggar_F_afro","C_man_p_fugitive_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro","C_man_shorts_4_F_afro","C_man_shorts_1_F_afro",
					     "C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro","C_man_p_fugitive_F_asia", "C_man_p_shorts_1_F_asia",
					     "C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia","C_man_shorts_1_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia","C_man_polo_4_F_asia",
					     "C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_w_worker_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_beggar_F","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_hunter_1_F",
					     "C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_1"];

MSOT_CIVCAR = [
                "C_Hatchback_01_F","C_Van_01_fuel_F","C_Hatchback_01_sport_F","C_Offroad_01_F","C_Quadbike_01_F","C_Van_01_fuel_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F"
              ];



//ALLOWED_C4_CLASSNAMES

MSOT_C4_CLASSES = [
                    "DemoCharge_Remote_Ammo",
                    "SatchelCharge_Remote_Ammo",
			              "SatchelCharge_Remote_Ammo_Scripted",
			              "DemoCharge_Remote_Ammo_Scripted",
			              "rhsusf_m112_ammo",
			              "rhsusf_m112x4_ammo"
                  ];

init_main_classes = true;
