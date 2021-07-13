CreateBotWave( )
{
    level endon("game_ended");

    level.Wave++;
    level.BotsForWave = (10 + (3*level.Wave));
    level.ZombieHealth += (5*level.Wave);
    level.zState = "playing";

    level notify("crate_gone");
    if(zm_no_spawn) return;
    else
    {
        for( i = 0; i < level.BotsForWave; i++ )
        {    
            level.zombies[i] = spawn("script_model", level.zmSpawnPoints[randomInt(level.zmSpawnPoints.size - 1)]);
            level.zombies[i] setModel(level.zmModels[ RandomIntRange( 0,  level.zmModels.size ) ] );
                
            level.zombies[i].head = spawn("script_model",level.zombies[i] getTagOrigin("j_spine4"));//getTag
            level.zombies[i].head setModel(level.zmHeads[ RandomIntRange(0,   level.zmHeads.size ) ] );
            level.zombies[i].head.angles = (270,0,270);
            level.zombies[i].head LinkTo( level.zombies[i], "j_spine4" );
            level.zombies[i].isZombie = true;
   
            level.zombies[i].crate1 = spawn("script_model", level.zombies[i].origin + (0,0,30) ); 
            level.zombies[i].crate1 setModel("com_plasticcase_enemy");
            level.zombies[i].crate1 Solid();
            level.zombies[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
            level.zombies[i].crate1.angles = (90,0,0);
            level.zombies[i].crate1 hide();
            level.zombies[i].crate1.team = "allies";
            level.zombies[i].crate1.name = "botCrate" + i;
            level.zombies[i].crate1 setCanDamage(true);
            level.zombies[i].crate1.maxhealth = level.ZombieHealth;
            level.zombies[i].crate1.health = level.ZombieHealth;
            level.zombies[i].crate1 linkto( level.zombies[i] );

            level.zombies[i].hasMarker = false;
            level.zombies[i].team = "allies";
            level.zombies[i].name = "bot" + i;
            level.zombies[i].targetname = "bot";
            level.zombies[i].classname = "bot";
            level.zombies[i].currentsurface = "default";
            level.zombies[i].kills = 0;
            

            level.zombies[i] thread MonitorBotHealth(level.zombies[i]);
            level.zombies[i] thread ClampToGround();
            if(zm_dont_track == false){
                level.zombies[i] thread GetBestPlayerAndMoveTo();
                level.zombies[i] thread MonitorAttackPlayers();
            }
            level.zombies[i] thread nuke_waittill(i);
            wait .8;
        }
    }
    level thread MonitorFinish();
}
GetHeadModel()
{
    return "head_tf141_desert_d";
}