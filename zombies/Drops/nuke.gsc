
nukeZombies(drop_to_destroy)
{
    level endon("stop_drop"+drop_to_destroy);
    level.dropped[drop_to_destroy] destroy();
    level.dropped[drop_to_destroy].headIcon destroy();
    IPrintLnBold( "ZOMBIES NUKED" );
    for(i = 0;i<level.BotsForWave;i++)
    {
        level.zombies[i] notify("destroy_self");

    }
    foreach(player in level.players)
    {
        player.score+= 400;
        player.pers["score"]+= 400;
        level thread maps\mp\killstreaks\_nuke::nukeEffects();
        nukeSoundExplosion();
    }
    level notify("stop_drop"+drop_to_destroy );
}
nuke_waittill()
{
    if(isPlayer(self))
    return;
    self waittill("destroy_self");
                self thread spawnDrop();
    self.crate1 Delete();
    self.head Delete();
    self Delete();
    self notify("bot_death");
}

nukeSoundExplosion()
{
    level endon ( "nuke_cancelled" );

    foreach( player in level.players )
    {
        player playlocalsound( "nuke_explosion" );
        player playlocalsound( "nuke_wave" );
    }
}
createFogFX()
{
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , -3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 3000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 3000 , 3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 3000 , -3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -3000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -3000 , 3000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -3000 , -3000 , 500 ));
}
/*
  PlayFXOnTagForClients( level._effect[ "nuke_flash" ], self, "tag_origin", player );  
    level._effect[ "nuke_player" ] = loadfx( "explosions/player_death_nuke" );
    level._effect[ "nuke_flash" ] = loadfx( "explosions/player_death_nuke_flash" );
    level._effect[ "nuke_aftermath" ] = loadfx( "dust/nuke_aftermath_mp" );    
*/