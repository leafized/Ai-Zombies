IntermissionCountdown() // called in maps
{
    for(count = level.IntermissionTimeStart; count > -1; count--)
    {
        wait 1;
        level.IntermissionTime = count;
    }

    for(i=0; i < level.MaxWaves; i++)
    {
        level thread BotMain();

        level waittill("round_ended");

        level thread IntermissionTimer( level.timer_intermission );
        wait level.timer_intermission;
        foreach(p in level.players)
        {
            p thread doHudUpdate();
        }
    }
}

doHudUpdate()
{
    self.roundCounter _setText(level.wave + 1);
    self.roundCounter getBig();
    self.roundCounter getSmall();
}
IntermissionTimer( time )
{
    
        Timer            = NewHudElem();
        Timer.alignX     = "right";
        Timer.alignY     = "top";
        Timer.horzAlign  = "right";
        Timer.vertAlign  = "top";
        Timer.foreground = true;
        Timer.fontScale  = 1.5;
        Timer.color      = ( 1,1,1 );
        Timer.font       = "objective";
        Timer.glowColor  = (.1,.1,.1);
        Timer.glowAlpha  = 1;
        Timer.alpha      = 1;
        Timer SetTimer(time);
        clockObject = spawn( "script_origin", (0,0,0) );
        clockObject hide();
        for(i=0; i<=time; i++)
        {
                clockObject playSound( "ui_mp_suitcasebomb_timer" );
                wait 1;
        }
        Timer destroy();
}
    
MonitorFinish( )
{
    level endon("crate_gone");

    level.whowins = false;

    for(;;)
    {

        if(ZombieCount() <= 0 && level.Wave < level.MaxWaves )
        {
            level.zState = "intermission";
        
            wait 2;
        
            foreach( player in level.players )
                if(isDefined( player.needsToSpawn ) && player.needsToSpawn)
                {
                    player notify("respawn");

                    player thread [[level.SpawnClient]]();
                    player allowSpectateTeam( "freelook", false );
                    
                    player.pers["botKillstreak"] = 0;
                    player.pers["lastKillstreak"] = "";
                    
                    player clearLowerMessage("spawn_info");
                }
            
            level notify("round_ended");
        break;
        }

        else if( ( ZombieCount() <= 0 && level.Wave >= level.MaxWaves ) || ( !isAnyOneAlive() ))
        {
            foreach( player in level.players )
            {
                player hide();
                player freezeControls(false);
                player disableWeapons(true);
                if( !level.whowins ) player setLowerMessage( "spawn_info", &"PLAYERS_WON" );
                player _SetActionSlot( 1, "" );
                player SetOrigin( level.mapCenter + ( 0, 0, 1000 ) );
            }
            wait 5;
            foreach( player in level.players )
            {
                player freezeControls(true);
                
                if(isDefined(player.healthword))
                    player.healthword destroy();

                if(isDefined(player.healthnum))
                player.healthnum destroy();
            }
            
            level thread maps\mp\killstreaks\_nuke::doNuke( 0 );
            
            break;
        }
    
        wait 0.05;
    }
}
