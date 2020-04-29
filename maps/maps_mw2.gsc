map_mp_rust()
{            
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