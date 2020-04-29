IntermissionCountdown()
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
            if(p IsHost())
            p iprintlnBold( "We are now entering.....Round ^1" + (i + 2) );
            stat  = i + 2;
            score = p getPlayerData("money");
            if(i +2 > score)
            {
                p setPlayerData("money", i+2);
                p iprintln( "Highscore is :^2" + score );
            }
        }
    }
}

IntermissionTimer( time )
{
    
        Timer = NewHudElem();
        Timer.alignX = "right";
        Timer.alignY = "top";
        Timer.horzAlign = "right";
        Timer.vertAlign = "top";
        Timer.foreground = true;
        Timer.fontScale = 1;
        Timer.color = ( 175/255, 34/255, 34/255 );
        Timer.font = "hudbig";
        Timer.alpha = 1;
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
        //createText(font,fontScale,align,relative,x,y,sort,alpha,text,color);
        //createRectangle(align,relative,x,y,width,height,color,shader,sort,alpha);
    break;
    }

    else if( ( ZombieCount() <= 0 && level.Wave >= level.MaxWaves ) || ( !isAnyOneAlive() ))
    {
        centerHeight = self getFlyHeightOffset( level.mapCenter );
        
        foreach( player in level.players )
        {
            player hide();
            player freezeControls(true);
            player disableWeapons(true);
            if( !level.whowins ) player setLowerMessage( "spawn_info", &"PLAYERS_WON" );
            player _SetActionSlot( 1, "" );
            player SetOrigin( level.mapCenter + ( 0, 0, centerHeight ) );
        }
        
        wait 5;
        
        foreach( player in level.players )
        {
            player freezeControls(true);
            
            if(isDefined(player.healthword))
                player.healthword destroy();

            if(isDefined(player.healthnum))
                player.healthnum destroy();

            if(isDefined(player.healthbar))
                player.healthbar destroy();

            if(isDefined(player.healthbarback))
                player.healthbarback destroy();

            if(isDefined(player.healthwarning))
                player.healthwarning destroy();
            /*  
            if(isDefined(player.nvText))
                player.nvText destroy();
        
            if(isDefined(player.nvText2))
                player.nvText2 destroy();
            */
        }
        
        level thread maps\mp\killstreaks\_nuke::doNuke( 0 );
        
    break;
    }
    
wait 0.05;
}
}
