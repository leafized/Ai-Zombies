map_mp_rust()
{            
    loadUtilities();
    level thread FuncsMain();
    level thread IntermissionCountdown();
    level.prematchPeriod = 0;
    thread spawnWeaponBox((-330.5, 269.5, -247.875),0);
    thread spawnAmmoBox((197.785, 21.8476, -223.173),0);
    thread spawnArmourBox((-12.115,140.77,-250.617),0);
    thread spawnPerkBox((3.1907,690.739,-248.224),0,"specialty_fastreload","Reload");
    
    level.zmSpawnPoints = [(-3.38591,1233.07,-232.303),(-206.970,1266.41,-230.861),(124.183,1222.01,-232.581),(-438.971,917.465,-229.944),(212.131, 1402.55,-231.613)];
    level.zmModels      = ["mp_body_opforce_arab_shotgun_a"];
    level.zmHeads       = ["head_tf141_desert_d"];
    level.adPoint       = [(1283, 1336, -105)];
    IPrintLn( "RUST CREATED" );
    if(!level.hasBeenLoaded)
    {
        level.hasBeenLoaded = true;
        level.zmModelSize   = level.zmModels.size-1;
        level.zmHeadSize    = level.zmHeads.size-1;
        level.adPoint       = undefined;
    }
}
map_mp_underpass()
{
    loadUtilities();
    level thread FuncsMain();
    level thread IntermissionCountdown();
    level.prematchPeriod = 0;
    
    thread spawnWeaponBox((4081.45, 2755.1, 416.125) ,(0, 90, 0));
    thread spawnAmmoBox((4075.77, 2219.81, 416.125) , (0, 90, 0));
    thread spawnArmourBox((4154.96, 1840.82, 416.125) , (0, 90, 0));
    //thread spawnPerkBox((3834.4, 1089.54, 384.125) ,(0, 0, 0),0,"specialty_fastreload", "Reload");
    thread spawnpapmachine((3834.4, 1089.54, 384.125) ,(0, 0, 0));
    level.playerSpawnPoints = [(4138.29, 1054.1, 416.125),(4138.29, 1054.1, 416.125),(4138.29, 1054.1, 416.125),(4138.29, 1054.1, 416.125)];
    
    
    level.zmSpawnPoints = [ (3392.38, 3128.73, 384.125),(3725.9, 2947.18, 384.125) ,(4022.97, 3000.37, 421.817),(4044.48, 3303.16, 416.125),(4291.72, 3486.83, 416.125),(3678.46, 3144.64, 384.125),(3375.36, 3245.04, 384.125),(3617.51, 2920.06, 384.125),(3861.57, 2488.19, 384.125)];
    level.zmModels      = ["mp_body_forest_tf141_smg", "mp_body_ally_sniper_ghillie_forest", "mp_body_forest_tf141_assault_a" , "mp_body_forest_tf141_smg" , "mp_body_forest_tf141_shotgun"];
    level.zmHeads       = ["head_tf141_forest_b" , "head_allies_sniper_ghillie_forest", "head_tf141_forest_b", "head_tf141_forest_a" , "head_tf141_forest_d" ] ;
    level.adPoint       = [ 0 ];
    IPrintLn( "UNDERPASS CREATED" );
    if(!level.hasBeenLoaded)
    {
        level.hasBeenLoaded    = true;
        level.zmModelSize      = level.zmModels.size-1;
        level.zmHeadSize       = level.zmHeads.size-1;
        level.adPoint          = undefined;
        level.playerSpawnPoint = level.playerSpawnPoints.size-1;
    }
}

map_mp_terminal()
{
    loadUtilities();
    level thread FuncsMain();
    level thread IntermissionCountdown();
    level.prematchPeriod = 0;
    
    
    level.zmModels          = [ "mp_body_us_army_assault_c" , "mp_body_us_army_lmg_c" , "mp_body_us_army_smg_c" , "mp_body_ally_sniper_ghillie_urban"];
    level.zmHeads           = [ "head_us_army_b", "head_us_army_c", "head_us_army_d", "head_allies_sniper_ghillie_urban"];
    level.playerSpawnPoints = [(-1020.62, 4259.42, 216.125), (-958.656, 4252.9, 216.125), (-853.992, 4240.71, 216.125),(-782.469, 4232.86, 216.125),(-731.292, 4226.79, 216.125),(-993.42, 4231.35, 216.125),(-1105.08, 4211.38, 216.125),(-1220.47, 4198.07, 216.125)];
    
    thread spawnWeaponBox((-865.79, 4413.07, 216.125) ,(0, -91.159, 0));
    thread spawnAmmoBox((-1124.07, 4318.08, 216.125) ,(0, 178.341, 0));
    thread spawnArmourBox((-1149.26, 4582.7, 216.125) ,(0, 13.4528, 0));
    thread spawnPerkBox((-635.646, 4300.65, 216.125) ,(0, -176.265, 0),0,"specialty_fastreload","Reload");
    thread spawnPapMachine((-679.838, 4588.06, 216.125) ,(0, 7.95415, 0));

    level.zmSpawnPoints = [(-1274.54, 5378.03, 192.125) ,(-1160.76, 5387.6, 192.125) ,(-1001.61, 5400.14, 192.125) ,(-849.42, 5408.14, 192.125) ,(-696.458, 5411.56, 192.125) ,(-606.733, 5312.4, 192.125) ,(-732.593, 5200.15, 192.125) ,(-885.403, 5203.18, 192.125) ,(-1027.53, 5224.41, 192.125) ,(-1211.47, 5242.27, 192.125)];
    
    
    
    IPrintLn( "TERMINAL CREATED" );
    if(!level.hasBeenLoaded)
    {
        level.hasBeenLoaded    = true;
        level.zmModelSize      = level.zmModels.size-1;
        level.zmHeadSize       = level.zmHeads.size-1;
        level.adPoint          = undefined;
        level.playerSpawnPoint = level.playerSpawnPoints.size -1;
    }
}
map_mp_highrise()
{
    loadUtilities();
    level thread FuncsMain();
    level thread IntermissionCountdown();
    level.prematchPeriod = 0;
    level.zmModels          = [ "mp_body_us_army_assault_c" , "mp_body_us_army_lmg_c" , "mp_body_us_army_smg_c" , "mp_body_ally_sniper_ghillie_urban"];
    level.zmHeads           = [ "head_us_army_b", "head_us_army_c", "head_us_army_d", "head_allies_sniper_ghillie_urban"];
    
    level.playerSpawnPoints = [(-2011.47, 10092.9, 2264.13) , (-2075.99, 10141.4, 2264.13) , (-1959.32, 10194.1, 2264.13) , (-1906, 10072.3, 2264.13) , (-1837.71, 10196.9, 2264.13)];
    level.zmSpawnPoints     = [(-635.784, 9686.96, 2168.13),(-1028.94, 9692.28, 2168.13),(-730.586, 9878.32, 2168.13),(-699.299, 10126.5, 2168.13),(-616.766, 10332.5, 2168.13),(-1008.13, 10252.6, 2168.13),(-1054.1, 10635.7, 2168.13) ,(-875.721, 11196.2, 2168.13),(-645.888, 11362.1, 2168.13),(-1009.04, 11432.8, 2168.13),(-1103.31, 11180.4, 2168.13)];
    thread spawnWeaponBox((-1750.03, 10176.5, 2264.13) ,(0, -92.1588, 0) );
    thread spawnAmmoBox( (-1974.05, 9600.17, 2264.13) ,(0, 174.562, 0));
    thread spawnPapMachine((-1951.33, 10380.9, 2264.13),(0, 10.4755, 0));
    thread spawnArmourBox((-2741.9, 9823.04, 2264.13),(0, 87.4402, 0));
    iprintln("HIGHRISE CREATED");
    if(!level.hasBeenLoaded)
    {
        level.hasBeenLoaded = true;
        level.zmModelSize   = level.zmModels.size-1;
        level.zmHeadSize    = level.zmHeads.size-1;
        level.adPoint       = undefined;
        level.playerSpawnPoint = level.playerSpawnPoints.size -1;
    }
}
/*
  2:01 say;011000011a7b069d;2;Leafized;STORE LOCATION
  2:10 say;011000011a7b069d;2;Leafized;origin : (-1951.33, 10380.9, 2264.13) angles :(0, 10.4755, 0)
  2:15 say;011000011a7b069d;2;Leafized;origin : (-1750.03, 10176.5, 2264.13) angles :(0, -92.1588, 0)
  2:22 say;011000011a7b069d;2;Leafized;origin : (-1974.05, 9600.17, 2264.13) angles :(0, 174.562, 0)
  2:28 say;011000011a7b069d;2;Leafized;origin : (-2741.9, 9823.04, 2264.13) angles :(0, 87.4402, 0)
  2:34 say;011000011a7b069d;2;Leafized;SPAWN LOCATION
  2:36 say;011000011a7b069d;2;Leafized;origin : (-2011.47, 10092.9, 2264.13) angles :(0, 28.916, 0)
  2:37 say;011000011a7b069d;2;Leafized;origin : (-2075.99, 10141.4, 2264.13) angles :(0, 48.4937, 0)
  2:38 say;011000011a7b069d;2;Leafized;origin : (-1959.32, 10194.1, 2264.13) angles :(0, -5.40527, 0)
  2:39 say;011000011a7b069d;2;Leafized;origin : (-1906, 10072.3, 2264.13) angles :(0, 102.508, 0)
  2:41 say;011000011a7b069d;2;Leafized;origin : (-1837.71, 10196.9, 2264.13) angles :(0, 155.638, 0)
  3:06 say;011000011a7b069d;2;Leafized;ZOMBIE SPAWNS
  3:07 say;011000011a7b069d;2;Leafized;ZOMBIE SPAWNS
  3:10 say;011000011a7b069d;2;Leafized;origin : (-635.784, 9686.96, 2168.13) angles :(0, 175.995, 0)
  3:12 say;011000011a7b069d;2;Leafized;origin : (-1028.94, 9692.28, 2168.13) angles :(0, 147.728, 0)
  3:14 say;011000011a7b069d;2;Leafized;origin : (-730.586, 9878.32, 2168.13) angles :(0, 42.3468, 0)
  3:16 say;011000011a7b069d;2;Leafized;origin : (-699.299, 10126.5, 2168.13) angles :(0, 92.9498, 0)
  3:17 say;011000011a7b069d;2;Leafized;origin : (-616.766, 10332.5, 2168.13) angles :(0, 98.7781, 0)
  3:19 say;011000011a7b069d;2;Leafized;origin : (-1008.13, 10252.6, 2168.13) angles :(0, 132.88, 0)
  3:21 say;011000011a7b069d;2;Leafized;origin : (-1054.1, 10635.7, 2168.13) angles :(0, 81.8372, 0)
  3:23 say;011000011a7b069d;2;Leafized;origin : (-1053, 11038.8, 2168.13) angles :(0, 56.3159, 0)
  3:24 say;011000011a7b069d;2;Leafized;origin : (-875.721, 11196.2, 2168.13) angles :(0, 26.9495, 0)
  3:26 say;011000011a7b069d;2;Leafized;origin : (-645.888, 11362.1, 2168.13) angles :(0, 113.961, 0)
  3:27 say;011000011a7b069d;2;Leafized;origin : (-1009.04, 11432.8, 2168.13) angles :(0, -179.824, 0)
  3:30 say;011000011a7b069d;2;Leafized;origin : (-1103.31, 11180.4, 2168.13) angles :(0, -69.8236, 0)*/
getSpawnPoints()
{
    return level.playerSpawnPoints[RandomInt( level.playerSpawnPoint )];
}
onConnectMonitor()
{
    for(;;)
    {
        level waittill( "connected", player );
        if(isDefined(level.perkBox))
            player thread perkMonitor();
         if(isDefined(level.packRB))
            player thread MysteryBox();
    }
}
