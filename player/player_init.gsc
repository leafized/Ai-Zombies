init_spawned_player()
{
    self SetOrigin( level.playerSpawnPoint[0] );
    self FreezeControls( false );
    self TakeAllWeapons();
    if( level.zState != "intermission" && level.zState != "losted" )
    {
        self thread maps\mp\gametypes\_playerlogic::respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
        
        self allowSpectateTeam( "freelook", true );
        
        self.needsToSpawn = true;

        self setLower( "spawn_info", game["strings"]["spawn_next_round"] );
        
        self waittill("round_ended");
        
    }
    if(level.zState == "losted" )
    {
        centerHeight = self getFlyHeightOffset( level.mapCenter );
        
        foreach( player in level.players )
        {
            player clearLower("spawn_info");
            
            player hide();
            
            player SetOrigin( level.mapCenter + ( 0, 0, centerHeight ) );
            
            player disableWeapons(true);
            
            player freezeControls(true);
            
            player setLower( "spawn_info", @"All players have been eliminated. Match is ending..." );
            
        }
    }
    else
    {
        self.needsToSpawn = false;
        
        self thread pMain();
        
    }
    if(self.alreadySpawned == true)
    {
        self giveWeapon(map_gun);
    }
    
    self thread MysteryBox();
    self thread AmmoBoxMonitor();
    self thread ArmourBoxMonitor();
    self thread perkMonitor();
    self FreezeControls( false );
    self.score = level.player_starting_money;
    self.pers["score"] = level.player_starting_money;
    
    if(self getPlayerData("money") > 0) self iprintln( "High score is : ^2" + self getPlayerData("money") );
    
    self thread visionConstant();
    //self printLoc(self);
    self.isZombie = false;
    
    self setLower("intro", "The content in this video is in BETA and WILL change.", "objective", 1);//setLower(name,text,font,fontScale)
    
    //thread RedFadeToBlue(self.lowerMessage);
    
    wait 2; 
    
    self clearLower("intro");
    
}