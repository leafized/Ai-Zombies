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
    
    thread spawnWeaponBox((4081.45, 2755.1, 416.125) ,(0, 90, 180));
    thread spawnAmmoBox((4075.77, 2219.81, 416.125) , (0, 90, 180));
    thread spawnArmourBox((4154.96, 1840.82, 416.125) , (0, 90, 180));
    thread spawnPerkBox((3834.4, 1089.54, 384.125) ,(0, 0, 0),0,"specialty_fastreload", "Reload");
    level.playerSpawnPoint = [(4138.29, 1054.1, 416.125)];
    
    
    level.zmSpawnPoints    = [ (3392.38, 3128.73, 384.125),(3725.9, 2947.18, 384.125) ,(4022.97, 3000.37, 421.817),(4044.48, 3303.16, 416.125),(4291.72, 3486.83, 416.125),(3678.46, 3144.64, 384.125),(3375.36, 3245.04, 384.125),(3617.51, 2920.06, 384.125),(3861.57, 2488.19, 384.125)];
    level.zmModels         = ["mp_body_forest_tf141_smg"];
    level.zmHeads          = ["head_tf141_forest_b"] ;
    level.adPoint          = [ 0 ];
    IPrintLn( "UNDERPASS CREATED" );
    if(!level.hasBeenLoaded)
    {
        level.hasBeenLoaded = true;
        level.zmModelSize   = level.zmModels.size-1;
        level.zmHeadSize    = level.zmHeads.size-1;
        level.adPoint       = undefined;
    }
}
getSpawnPoints()
{
    map = getDvar("mapname");
    if(map == "mp_underpass") level.playerSpawnPoint = 0;
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
    
   /*
       
    GAME ENGINE NAMES = ["mp_afghan","mp_derail","mp_estate","mp_favela","mp_highrise","mp_invasion","mp_checkpoint","mp_quarry","mp_rundown","mp_rust","mp_boneyard","mp_nightshift","mp_subbase","mp_terminal","mp_underpass","mp_brecourt"  ];
    REAL NAMES= [ "Afghan", "Derail", "Estate", "Favela", "Highrise", "Invasion", "Karachi", "Quarry", "Rundown", "Rust", "Scrapyard", "Skidrow", "Sub Base", "Terminal", "Underpass", "Wasteland"];

    MAP:::: UNDERPASS      
   
        origin : (4138.29, 1054.1, 416.125) angles :(0, 123.168, 0) == SPAWN
        origin : (3834.4, 1089.54, 384.125) angles :(0, 14.1614, 0) == SPEED COLA
        origin : (4154.96, 1840.82, 416.125) angles :(0, 162.988, 0) == JUGG
        origin : (4081.45, 2755.1, 416.125) angles :(0, -92.3236, 0) == REFILL
        origin : (4075.77, 2219.81, 416.125) angles :(0, -89.9011, 0) == AMMO

        origin : (3392.38, 3128.73, 384.125) angles :(0, 114.027, 0)  Zombie SpawnPoint
        origin : (3725.9, 2947.18, 384.125) angles :(0, 14.2548, 0)   Zombie SpawnPoint
        origin : (4022.97, 3000.37, 421.817) angles :(0, 61.1169, 0)  Zombie SpawnPoint
        origin : (4044.48, 3303.16, 416.125) angles :(0, 82.5677, 0)  Zombie SpawnPoint
        origin : (4291.72, 3486.83, 416.125) angles :(0, 62.9846, 0)  Zombie SpawnPoint
        origin : (3678.46, 3144.64, 384.125) angles :(0, 111.165, 0)  Zombie SpawnPoint
        origin : (3375.36, 3245.04, 384.125) angles :(0, -160.724, 0) Zombie SpawnPoint
        origin : (3617.51, 2920.06, 384.125) angles :(0, -40.2759, 0) Zombie SpawnPoint
        origin : (3861.57, 2488.19, 384.125) angles :(0, -74.4818, 0) Zombie SpawnPoint
*/ 