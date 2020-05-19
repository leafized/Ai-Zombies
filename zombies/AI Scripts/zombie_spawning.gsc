CreateBotWave( )
{
    level endon("game_ended");

    level.Wave++;
    //level.BotsForWave     = 1;
    level.BotsForWave     = (10 + (3*level.Wave));
    //level.RealSpawnedBots = 1;
    level.ZombieHealth += (5*level.Wave);
    level.zState = "playing";

    level thread ZombieMarkers();

    level notify("crate_gone");

    if(player isHost())
    {
        player iprintln("Total " + level.BotsForWave + " Zombies in Wave");
        player PlayLocalSound("flag_spawned");
    }
    for( i = 0; i < level.BotsForWave; i++ )
    {
        while(ZombieCount() >= level.zombies_max_spawn)
        if(level.RealSpawnedBots < level.BotsForWave)
            level.RealSpawnedBots++;
    
            level.zombies[i] = spawn("script_model", level.zmSpawnPoints[randomInt(4)]);
            level.zombies[i] setModel(level.zmModels[0]);
        level.zombies[i].head = spawn("script_model",level.zombies[i] getTagOrigin("j_spine4"));//getTag
        level.zombies[i].head setModel(level.zmHeads[0]);
        level.zombies[i].head.angles = (270,0,270);
        level.zombies[i].head LinkTo( level.zombies[i], "j_spine4" );
        level.zombies[i].isZombie = true;
        level.zombies[i].crate1 = spawn("script_model", level.zombies[i].origin + (0,0,30) ); 
        level.zombies[i].crate1 setModel("com_plasticcase_enemy");
        level.zombies[i].crate1 Solid();
        level.zombies[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        level.zombies[i].crate1.angles = (90,0,0);
        level.zombies[i].crate1 hide();
        level.zombies[i].crate1.team = "axis";
        level.zombies[i].crate1.name = "botCrate" + i;
        level.zombies[i].crate1 setCanDamage(true);
        level.zombies[i].crate1.maxhealth = level.ZombieHealth;
        level.zombies[i].crate1.health = level.ZombieHealth;
        level.zombies[i].crate1 linkto( level.zombies[i] );

        level.zombies[i].hasMarker = false;
        level.zombies[i].team = "axis";
        level.zombies[i].name = "bot" + i;
        level.zombies[i].targetname = "bot";
        level.zombies[i].classname = "bot";
        level.zombies[i].currentsurface = "default";
        level.zombies[i].kills = 0;
        
        level.zombies[i] thread MonitorAttackPlayers( );
        level.zombies[i] thread MonitorBotHealth(RandomInt( 50 ));
        level.zombies[i] thread KillIfUnderMap(i);
        level.zombies[i] thread ClampToGround();
        level.zombies[i] thread GetBestPlayerAndMoveTo();//VectorToAngles( <vector> )
        level.zombies[i] thread nuke_waittill(i);
        wait 0.6;
    }
    
    level thread MonitorFinish();
}
GetHeadModel()
{
    return "head_tf141_desert_d";
}